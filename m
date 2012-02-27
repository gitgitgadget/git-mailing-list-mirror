From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] parse-options: remove PARSE_OPT_NEGHELP
Date: Mon, 27 Feb 2012 10:58:40 -0800
Message-ID: <7vpqd085nj.fsf@alter.siamese.dyndns.org>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49336C.3000303@lsrfire.ath.cx>
 <20120227182504.GA1600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25mc-0001Ex-Do
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab2B0S6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:58:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab2B0S6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:58:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 746466631;
	Mon, 27 Feb 2012 13:58:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XbW7gyjgEfQQSQA5OR8aYZsqL6A=; b=TD0GSs
	nAKrXG1wIs5ZbGP/eQuSHeH/hpfSnVzha6CZ9ABraHZ7Tw/n3DAuF9Cz5OQqFwEz
	W9JSKbYK50XAnQFlhUjWKoDjr3fQW+FfgmxVKwFRi+d7j6mzOzatv/ArGpuABaZe
	QSIbKXu2zHjUWEBNeOSRTAFSPw97BQw8t4WE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mmXOvh4mE2+bf2SZ4rrOnJHuB+P3Y61h
	KnGmREHzKipHEiqiZp297pAXIxeZ2OIu4e7gaBOTiBNmD5+M1aCDT/pqduLWF914
	90lrYSxJZGVVC2AJ5Rqp3Bh9hLULuxIB8AWniS6JRLEMl9c6TGyTTIkvUYVpiYVd
	4AG39TD+vIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A50662F;
	Mon, 27 Feb 2012 13:58:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67E2C6623; Mon, 27 Feb 2012
 13:58:41 -0500 (EST)
In-Reply-To: <20120227182504.GA1600@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 27 Feb 2012 13:25:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 108A2DBA-6175-11E1-9BF9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191652>

Jeff King <peff@peff.net> writes:

> ... Would it be
> better to simply be explicit that an option is a reversed boolean (i.e.,
> what the user specifies on the command line and what is in the code are
> naturally opposites). Like:
>
>  OPT_REVERSE_BOOL(0, "no-index", &use_index,
>              "finds in contents not managed by git"),

You said it much better than my attempt ;-).

> Using NEGHELP, the "reverse" is between the option name and the
> description, which is very subtle. Here it is between the option name
> and the variable, which is hopefully a little more explicit (especially
> with the big REVERSE in the macro name).
>
> I dunno. Given that there are only two uses of NEGHELP, and that they
> don't come out too badly, I don't care _too_ much. But I have seen some
> really tortured logic with double-negations like this, and I'm concerned
> that a few months down the road somebody is going to want NEGHELP (or
> something similar) in a case where it actually does really impact
> readability.

Yeah, I share a similar minor and iffy feeling about the result.
