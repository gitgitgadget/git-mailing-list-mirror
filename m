From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with
 GIT_ASKPASS
Date: Thu, 25 Feb 2010 23:50:12 -0800
Message-ID: <7vr5o84erv.fsf@alter.siamese.dyndns.org>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
 <4B87797D.7030905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:50:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkuxy-0005DC-5y
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 08:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935477Ab0BZHuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 02:50:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935446Ab0BZHuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 02:50:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E8769DB7D;
	Fri, 26 Feb 2010 02:50:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2OsLzBHZUiptb91VgwZeei/Ys5g=; b=m/40JT
	dnHIss8DAhOqCuhs8xx/T+PxgoMVKjcRCL/Yd9DEPimMwh8NK2f47MYupLVqgrL9
	tlxsX0xmlsxi82gRKuph3IURYm0j4vpknM+zwD5kMs4Y5Jl9bMqtmvXOYNY0iZPQ
	hTZ7iDWxQuvWos0USdz8kRaPuUWGijCDGKgz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EH0V067VhZPkxbO/m5H88YDtiOzgrEkq
	8VSIV5424QoJpxOVjwE6NyjrcGrLAdMOwmVRxd/dtByO6umHwahjmHTT9EEVo0KW
	3+l7/Fq4tvlP3/I4VyaAQX702+LcEx2lon3GYXo4Fq8w3eX0nIb3HTJLiAItuuON
	Ai085HqFfXA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D97D89DB7C;
	Fri, 26 Feb 2010 02:50:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E00929DB76; Fri, 26 Feb
 2010 02:50:13 -0500 (EST)
In-Reply-To: <4B87797D.7030905@viscovery.net> (Johannes Sixt's message of
 "Fri\, 26 Feb 2010 08\:34\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95923F12-22AB-11DF-A064-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141112>

Johannes Sixt <j.sixt@viscovery.net> writes:

> BTW, to save a level of indentation, you could handle the "trivial" case
> early like this:
>
> 	if (!askpass || !*askpass)
> 		return get_pass(prompt);
>
> and continue without an 'else' branch.

That is a good advice in general.

Also, when you have a way unbalanced if ... else ... where else clause is
very small, it usually is much easier to read if you invert the logic to
make if part smaller.

> OTOH, it may be worthwhile to set
>
> 		pass.use_shell = 1;
>
> to allow commands that are not just a single plain word. But perhaps this
> has security implications - I don't know.

How does SSH_ASKPASS gets interpreted by other programs?  I think we
should follow that example.

Other than that, I agree with everything you said in your review.  Thanks.
