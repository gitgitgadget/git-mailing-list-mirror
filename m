From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Fri, 05 Feb 2010 20:53:36 -0800
Message-ID: <7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
 <20100206035143.GA31784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 05:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdcgM-0001mn-QE
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 05:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab0BFExq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 23:53:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab0BFExp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 23:53:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CBF997003;
	Fri,  5 Feb 2010 23:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t7IXBuSiVag7SWnR+FF8+T3qZVk=; b=XL4TPG
	8H5xXV6siZsWNpmK90cqPYqkCrNXn8oWFn2BmfQfc9jOlYQpJB+Qc9nRL7S3Fw8H
	FcY9oSkVygrvYSXZL55dzpu+ZrfXiwBgA9jN6t8uxHrjn/ZWcTRdld4yUz6hg7ED
	Dd2YCj2elmZtarVWSZGN49vW3WVDXWU06uWA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oxESGw5vBocXgB+dU0GxUWJbOWCcxe+U
	uSWDKy+xA18IvXOCRkUjOupHketvL/rtnFahqxzzqOQZJ9q/6L/H2L5R3LIGjUp0
	d94lperaHc85ItWpY+IZN5+50mwPrArHIdSOBQ9aBqxR9v6Uror8Q2VdS2PoRnxV
	PlJvIOkblLA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE6F97FFE;
	Fri,  5 Feb 2010 23:53:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1858297FFC; Fri,  5 Feb
 2010 23:53:37 -0500 (EST)
In-Reply-To: <20100206035143.GA31784@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 5 Feb 2010 22\:51\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9905F42A-12DB-11DF-9BED-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139144>

Jeff King <peff@peff.net> writes:

> The worst I could come up with is the
> double-double-dash case:
>
>   git grep -- pattern revision -- pathname
>
> It is perhaps not as pretty as
>
>   git grep -e pattern revision -- pathname
>
> but I don't think it is ambiguous.

I don't think if "ambiguous or not" is what we are after to begin with.

I have known GNU extended grep implementations long enough but never saw
that "--" used to quote a pattern.  Is it worth supporting to begin with?

> So actually my patch above is breaking somebody who truly wanted to grep
> for "--" by doing
>
>   git grep --
>
> but that is sufficiently insane that I'm not too worried about it.

I would say "git grep -- pattern" is sufficiently insane enough that
I'm not worried about it at all.  Interpreting "git grep --" as a request
to look for double-dash feels million times saner than that, actually.

Unless somebody comes up with example of that pattern's wide use.  Point
me to some well known open source software's source trees that use "--"
for such a purpose in one of its shell script or Makefile.
