From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Run the perf test suite for profile feedback too
Date: Mon, 07 Jul 2014 14:06:57 -0700
Message-ID: <xmqq1ttwdgjy.fsf@gitster.dls.corp.google.com>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
	<1404517432-25185-4-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 23:07:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4G80-0007h0-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 23:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbaGGVHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 17:07:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59654 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbaGGVHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 17:07:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFD9C26AB6;
	Mon,  7 Jul 2014 17:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AuBjf2g21q89M+8nJOTkrnFPByA=; b=C08KNb
	Z2FoOreIU6egjxeeu3S563pjKO/WNQ5UekyvNO+x0XSVgMRpzDaf3nGJGX+x6vQ4
	3C6GUX659Q9+5evdCkJuv9m5I+PfwFH9Vp5RESH2LYd36eoXz/bYI2CgHdSu18nG
	SLxOkFWDb9y5HwmmPHnZVkUa3/rlvMxKfPHq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUy/JvxStkDPlNXC55J1jYDNWD604KXT
	bCgC55tI8lCAqp6LFt9paObmRI+YcJ2hjn6NNKAWIDbpnDCHJawr5dtZnoVBnzPY
	JA0Min+923n/j4gcrRK0fL071iaVNonn7OlPEWLvYKsJz5xCOnnFcI8Nqr1V1P3H
	151+q44aiK0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3E2626AB5;
	Mon,  7 Jul 2014 17:06:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A47B526AAD;
	Mon,  7 Jul 2014 17:06:45 -0400 (EDT)
In-Reply-To: <1404517432-25185-4-git-send-email-andi@firstfloor.org> (Andi
	Kleen's message of "Fri, 4 Jul 2014 16:43:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9A5FAC76-061A-11E4-A4DB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252986>

Andi Kleen <andi@firstfloor.org> writes:

> From: Andi Kleen <ak@linux.intel.com>
>
> Open: If the perf test suite is representative enough it may
> be reasonable to only run that and skip the much longer full
> test suite. Thoughts?

I do not think it right now is representative, nor it was meant to
become so.  The operations are those that people cared about and
tuned, and hopefully it would cover stuff actual end users care
about in the real life, though.

>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index a9770ac..ba64be9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1647,6 +1647,7 @@ ifeq ($(filter all,$(MAKECMDGOALS)),all)
>  all:: profile-clean
>  	$(MAKE) PROFILE=GEN all
>  	$(MAKE) PROFILE=GEN -j1 test
> +	$(MAKE) PROFILE=GEN -j1 perf
>  endif
>  endif
