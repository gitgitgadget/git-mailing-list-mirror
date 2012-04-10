From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Tue, 10 Apr 2012 09:10:22 -0700
Message-ID: <7vhawrqzue.fsf@alter.siamese.dyndns.org>
References: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org>
 <1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vwr5os9zr.fsf@alter.siamese.dyndns.org>
 <1334018233-sup-7389@pinkfloyd.chass.utoronto.ca>
 <7vobr0s8ej.fsf@alter.siamese.dyndns.org> <m262d8j8dv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeYT-00086a-PD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab2DJRI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:08:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913Ab2DJRI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:08:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F9BB7009;
	Tue, 10 Apr 2012 13:08:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=gVE1zlvjMm/r4Ec+jHErVFGP+4s=; b=n2hbC2owcIyHeIblSgUj
	+W8M4AbZwUQveF1WiUwjmlj3I2Dc6NFSsYQZFW5+/ccdf/xeb6lHCYPqAQwfKod3
	YgZLAh1x6Sb/wfGYld/zRPdibQBHtPL73a3rDE6KrmQj+kx1N2pl/OaWYLQT/RCo
	gSCBbLLDrda8D8OVcEK5TEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RIdbOyJSis95Jmn/SJfk+2mmNNbUcKpwFiULt2PvOPnqlZ
	EBL+eRyhLalFwxf/npea1fpK+tOxRzwMHBNc1LHV9vpVAD6UiSfpKVVyS8mXvxfe
	MfXngCGtA+j/R0V2BPwMBMk32aOwtRK/3GmBq4NuWdQVs5ch6n2m0EVjh8QzE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 577777008;
	Tue, 10 Apr 2012 13:08:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB2026FFB; Tue, 10 Apr 2012
 13:08:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9B238BA-832F-11E1-B687-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195102>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> FWIW, it bothers me a lot more that expression does not anchor
>> matches against path elements with explicit '/' than the issue your patch
>> addresses, i.e.
>>
>> 	sed -e 's|[^/][^/]*/|../|g'
>
> Note that this requires readding a trailing slash to the path, which
> complicates the whole thing a bit.

Or simply swapping order of the stripping and sed invocation, which is not
a big deal.  I personally find the pattern with trailing '/' easier to grok
but it is also not a big deal.
