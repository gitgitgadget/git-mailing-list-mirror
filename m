Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E8274FE3
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188126; cv=none; b=hPEcus0l7il3staeG+ZfKUMANGp4jhfxreESb0OZitatDMFAiyqz27KHhbFFqFZBN30dVl+RTBSujjHoRBAZK93wJqrQJNhQ0pLZnvqoZ0KJU6OT58hUQwxWTr3FP7NB7227fcy3iJt/Ds7bEbe/SCADN42FeH1ZPaEhb0h6xJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188126; c=relaxed/simple;
	bh=YUTGb+ZQPq3wPHC+KDlJIsGtsDNntWvO3/7o0bE1NeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwMd5rpYK4/FeXwkMctllQI+WdO30RpHePfcOTl99yl+veFgsfzq34BFLzYvEuNPEMVR07nCUz4fPOEPteNHuwvEsKTaZWNb+XQjtrNCr5ApRKCU3V+PmdRdMwrH8Z+voBMPcThyDijUarL8S7GgpELTRy+P8hZ3Ex6oR5x9h4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CueXcwqZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyRq+qff; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CueXcwqZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyRq+qff"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D0A2EC0196;
	Mon, 29 Sep 2025 19:22:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Sep 2025 19:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188124; x=1759274524; bh=sah7eUX33t
	MLFlKemFe8C0EH35Jeve+5WOeHaBfJHuU=; b=CueXcwqZ6uru/9plSCBkHgaO33
	9pm4H7w6JZ4qgXiMaFAJX3eOInMSQSf8qM6DUEMjsnBQtezXltnHcOmgFH2BWG4+
	IQ4rFhOp0XPlZXMJL2XHXh4PWDFaEo5UEl5cyaUm6YCQYgcgfJa5KMif8VZcwQN9
	Ep2woV6Bw66n4H8aeSjarbO9qbLRA9h15kTgdAV5SyALf9eVKcf9ZX3o+sbdZMZD
	xa6dTc4Kew7azSCdmu5jmuNclN5823pTt5k73tvazL2BUKpsdCqpLjUFmzBKALpQ
	zT1UCVRCZ9F1SXCi53npmHPk09HaFeaRdcsQD63K23Ey5qXoRqQlTg8CXDpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188124; x=1759274524; bh=sah7eUX33tMLFlKemFe8C0EH35Jeve+5WOe
	HaBfJHuU=; b=FyRq+qfffrCv17feRFQg9Be0Ws5cmFnChPdst4P+0Pb3IXyi9Xk
	DP8r9ewXdKfc70mqK2tBbMNcZwt3xKZVHhLfZded1G11MTWdQAZ//umcopPb05q+
	c+rbXrEEXW5yl0/gGi5ESIU3K67NLHHwgqV3Tx5PKJ2h9XqfR8WvC1IPVftqwFv9
	SkCejn4/BSb0Qyuozd4kXsJy51PKhECXj/RhDqC2t9glmCmiTrLs0VLq3ssyN5lC
	Ilfi66c1r2rwrU9tDGk4k6fmJv012FSJdb56Dpkj6arM2AcmmGu9uI//e+3xHXvH
	81zVTrkn0nD7aX+yVcGFQL9lmKFrlOxvZBg==
X-ME-Sender: <xms:mxTbaF7zlGvvmPn4zbFzPsDyh_R4mE0RMLSo-gSIvbxQv8xxzS-DLA>
    <xme:mxTbaGlUK3e1gsDlJb8-5B1XwguOSq-Qwk-Yyth-5GaeoemKs1CotT1DpcrV1L-lD
    NJnWp_9eamPMjx_hv8ZYYfOMXDn2Gapprqy6tYTBgi2d6q1Bhu1>
X-ME-Received: <xmr:mxTbaGSh2NJvy6b1B5fUu43dv1225IkEZyoCwg-WomgdSn792bXuKUDs8FEOryxtueGeJvfL_lEInxX8sSYR6kb3Ok5SeOEjygHTdq47cxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mxTbaFH_Wcv1lee1k_JMh2QpWRef4YL8eGvsretQHq2DcA1N31oe1Q>
    <xmx:mxTbaLFK1nNtu64VSE8FaTwSa49GY0tk3MX38wnrBM6vBxIN7yw10w>
    <xmx:mxTbaDTytMF2UPw9oCR2iF65Xpz0ERdlMGi1obFNheK-5kmyYo-2rw>
    <xmx:mxTbaMJOnnkf3wGRik2xY3qAtpd0GJ3GAM_C_zQdQMbVGEAO7SFbnw>
    <xmx:nBTbaJVGeaxeZhSwwJaHoMNCPTcSA5C96OYrbFUdyAUM_P-aUSRNZg5m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:22:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1b2eb16 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:22:02 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 26/49] builtin/repack.c: remove
 "repack_promisor_objects()" from the builtin
Message-ID: <aNsUl2afoigZZiLm@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <3ba6e86f6116cc42fc8f7d31707dd514f4bc16a4.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba6e86f6116cc42fc8f7d31707dd514f4bc16a4.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:51PM -0400, Taylor Blau wrote:
> Now that we have properly factored the portion of the builtin which is
> responsible for repacking promisor objects, we can move that function
> (and associated dependencies) out of the builtin entirely.
> 
> Similar to previous extractions, this function is declared in repack.h,
> but implemented in a separate repack-promisor.c file. This is done to
> separate promisor-specific repacking functionality from generic repack
> utilities (like "existing_packs", and "generated_pack" APIs).

Feels sensible.

> diff --git a/repack-promisor.c b/repack-promisor.c
> new file mode 100644
> index 0000000000..8bf42fc715
> --- /dev/null
> +++ b/repack-promisor.c
> @@ -0,0 +1,102 @@
> +#include "git-compat-util.h"
> +#include "repack.h"
> +#include "run-command.h"
> +#include "hex.h"
> +#include "repository.h"
> +#include "packfile.h"
> +#include "path.h"
> +#include "pack.h"

Nit: these headers should probably be sorted lexicographically?

> diff --git a/repack.h b/repack.h
> index f37eb49524..19dc4fd738 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -74,4 +74,8 @@ int generated_pack_has_ext(const struct generated_pack *pack, const char *ext);
>  void generated_pack_install(struct generated_pack *pack, const char *name,
>  			    const char *packdir, const char *packtmp);
>  
> +void repack_promisor_objects(struct repository *repo,
> +			     const struct pack_objects_args *args,
> +			     struct string_list *names, const char *packtmp);
> +
>  #endif /* REPACK_H */

I'm not a huge fan of the code bein gin "repack-promisor.c" while the
declarations are in "repack.h", as it makes things harder to find from
my point of view. But I don't feel too strongly about this.

Patrick
