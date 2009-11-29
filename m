From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to
 installed bindir
Date: Sat, 28 Nov 2009 18:32:33 -0800
Message-ID: <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
 <7vtywefn88.fsf@alter.siamese.dyndns.org>
 <20091128194910.GA17605@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 03:32:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEZam-0004Zs-N1
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 03:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbZK2Cci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 21:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZK2Cci
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 21:32:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZK2Cci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 21:32:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A729F838C2;
	Sat, 28 Nov 2009 21:32:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAQYim5Q4iNnWqFai6Qr+LrLTmg=; b=kXZw4R
	zKbWLQtKGWEVkI3op/YxJv7HBrcGDqDU95zULZG/zhVmQL5pORb3Sg65bs/O0OAB
	62bRCLQxR/bRg5LNo1T3WRbmVTATn2xOIT/5t/oK+N7AQH+cYskqz38E8khFB2ks
	MN2B35c9bFT2SUFyfTAFRAbo1kO4oq5QqQS3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LkY/jYvuVm3xhB85udGYsMmkuq69TJNZ
	feL1TSWX3ydkNwj+s+qrGYlNMP83cPAh6ZBKB6W9nF3S2us7uyHPthVVfY0rGVj+
	WNSxgbLUfU3AAIGGUnTcQW+9ZpgfccwBTmiuuLQsJtPI05bmm2kiyVGi44PPBxCZ
	/nu3HSiVV9Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 774C7838C1;
	Sat, 28 Nov 2009 21:32:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A13AC838C0; Sat, 28 Nov
 2009 21:32:35 -0500 (EST)
In-Reply-To: <20091128194910.GA17605@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 28 Nov 2009 14\:49\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 771E24CC-DC8F-11DE-BD35-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133984>

Jeff King <peff@peff.net> writes:

> On Sat, Nov 28, 2009 at 11:44:39AM -0800, Junio C Hamano wrote:
>
>>    . Advertising this forces the Makefile build test-bin/ contents from
>>      "all" target.  I think test-bin/ should only depend on "test" (iow,
>>      after "make all && make install" there shouldn't have to be "test-bin"
>>      directory.
>
> Would implementing it that way mean that:
>
>   make && cd t && make
>
> does not work (or worse, might silently use stale information in
> test-bin)?

Why can't t/Makefile have a dependency on its 'default' target that goes
up and prepares test-bin/, i.e. "cd .. && make test-bin-stuff"?
