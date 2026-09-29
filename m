Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2B3CAA55
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712427; cv=none; b=gHX8VMOVZbzdWyA24V3uBaGGuFqsSBTJnXZDr/w1jR9cxJCFL5w+1HVyIo5hfLiPSLkgXw/WON7dMNUUlh4JJU7//z+zuOzWVB6wgNkZFAxJ5zhGCn920hyWAficzTYLROF+PPxC9eAKZtTy6c4Txj5cY9Ow+FA8Z/Cf9Goo5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712427; c=relaxed/simple;
	bh=ogJAtHh3C33N5zdS6OWelCRKkaK/7nzGwudbWKIvE+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxAWoLtoFOZS8UDmO4C3zGParzHsq+G28LrV1Q7duOSXiOf0DPlsJyO6m0mKJezP5/DIpd1t3IB2KihScor9GaBTQXn4xYRCbnB45kl4VJiDFg97iOr0KqQ1pSo7D1jm4cc41vgtd9r6Q5LeJuKaJw2du22Pbu4ADa3skBdFL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XB8QE6S0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhwxoRAM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XB8QE6S0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhwxoRAM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C6EC7A076B;
	Tue, 29 Sep 2026 16:07:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 16:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790712425; x=1790798825; bh=cNTpmkw0xs
	ySu4WEKeCd/joFir+OK+NDN4Srlve/aDQ=; b=XB8QE6S0DR5dFgndpdWPbCwI1P
	bMplS2AgkrEGacXUZU3fAWbl7A647PcQYNwoG2bEojfcaklieL4R9v4Z6qlcuUnI
	4h8W6LrvV8xOv0HNeXeyQUTac52v99/hL5GZ0vMkN71ZG9sbwNov9A8O/aFZFoO1
	sIkaPi5kmfYytTJG/c9pta+beMMFnOyYGvmBjaXUI9y+tTYjD0CIeCQgfoOCFtvD
	eCVFbhpNKBpATtUOzRCR4Tp93mmUWVnaPbmiQl7Tk7zD2MWQiybByP6QPQhdsENV
	HdAFHNo4Y/Dfat4broJCGY5BcW/L5CiHZC/SNhTBLkT48kr/Ux43/POd+qQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790712425; x=1790798825; bh=cNTpmkw0xsySu4WEKeCd/joFir+OK+NDN4S
	rlve/aDQ=; b=vhwxoRAMI9INQBLQPnIlmuJXOFetw8J58q+6MAEaAVwXRnEhDtU
	ND8Y4BaSOEbf6HrwM1MlymXymNNPahNA6e45Y9CHJH/88hhcUyiwbeOdrR9GWnsU
	DpbGgEjF1so1anPF9ZsjZuCnHNZMeclZFmsy/iAvIZOBgZgksw65XeDpJu301Z52
	3doM/R+RI+OwTjEU25EQYtTILNWwziUYYEycL4Xcs+7oY/nGFF+PLSI0MsCEdhZP
	Z1hwJ9vQFXTA89s6tgo8jloy0wUvIgHCjLzHomKdRka4OVlje4GT9sAkWTMujijw
	8/PmCTYOCTRQL8YOROoK4LnlLSR3N7HCHaA==
X-ME-Sender: <xms:aBq8arI8D-3GrH4ID8yoZ9pMrb0r4plYdf3EXGtVMib3_Suh2kwPjQ>
    <xme:aBq8atZJlVKT5gXkVH2YsfUF2zn_-lbduhRo8xGJSyJCACBMwevTztKXFWcvVKJPW
    mFom3gLu_NT38bXY3Ch0VCOH6dT5nNFYtPnHABLKokoUw_5sufXqfU>
X-ME-Received: <xmr:aBq8atD3fOYm9EGWkLKO_3ERknrBJSVuU_f1ic4J18Q-cH0-YNMLw8tGYn9GGqu6roL15hnLt7g_A-GscjHVL39-k_4ZkK1SfIGV>
X-ME-Proxy-Cause: dmFkZTGfJ/pqAiLyD6uYGJYXrqC9LTp4ZCBANdUOaBCaLqXhqwZb9wyBJpvrimzypcc1/X
    zFAd5fe/LP/eZH0aMRl/WdMVXjbZ5JDN4tivIN22UFL0s/UsX4aLv/X+xtIBrPmnPh4hql
    nDOoJvhPpeCOomQV+GrlhYONd9EE9eCWZ7HH+DYaEhW0kKdNEu16/RnCME9KQj1K3t24gz
    0jqFUfL3nHDTWXyTRskrriCVDqyOJXGDGwzYfj/19+lDq0QB/h1dvEJQKwxbYyZ/pOEXTu
    Lu01l4Z2CwAhVXIxoJPNxtsxUgeN3mNsZ27Wv5Zc0Y8GQcZ5VQl3zTfXvGKUFzJ9utUgLa
    Mr9UMhegyaWZ3ipIj7dvLYwbi+ndEZxfTeFQKq4YzRfOWjbTkQ6vYWkyI44AaQfAPZ7GGE
    ltAq3NS9JHa3j7yMOzmu0NpNFLnGxmqgBZQLL1I/9UUXiIkQp1GVNsoQqaPuPUyprXOkHj
    2uHUZ8ptMyR56pVzWrCADGD5p2sS0lrJlUVpJWKTx9ygdXPFFhc/YIVzaFiy12ctuIGIq+
    5uA6yS6m5zbQRBLItQA568zWdkNRN2NKiGEq9m4wgIFnCcv6DRA/5cCenKHC+ImEswlo0o
    o0+dCNjjIIgLm+98g3S+LtX02ynxYeVLW66akHt5kmZBdy6qcFofQXsOGUVA
X-ME-Proxy: <xmx:aBq8anY2fzQ2f6P3k1jl8K50wt9mW11NnyRE5yG9y7-R3Vfr6w_0jQ>
    <xmx:aBq8allPq_0b06eJSNgL5UAK7x4RGkynJoPOGibeaIIeMfYIHKllAQ>
    <xmx:aBq8asopePwT7FmYXnGDbmI-LRCpK__R7QSFIzb-qNeGKk0FIQxOSw>
    <xmx:aBq8anCAPu_mN37zVuOY9eCa6l2IhNi9MXXOo95sMOYhFG2x1feCwQ>
    <xmx:aRq8amDb1CPCZ-cRGjT9_zWYiTZHjfRYePh1dCcZTdS7tcJfBUEYuoqw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 16:07:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Elijah
 Newren <newren@gmail.com>,
  Jeff King <peff@peff.net>,  Victoria Dye <vdye@github.com>,  Adam Johnson
 <me@adamj.eu>
Subject: Re: [PATCH v4 5/5] builtin/stash: merge index in-core
In-Reply-To: <e21b832a6e1d99416a220bb5ca1f008777ef4e7d.1790684309.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Tue, 29 Sep 2026 08:18:31 -0400")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<cover.1790684309.git.ben.knoble@gmail.com>
	<e21b832a6e1d99416a220bb5ca1f008777ef4e7d.1790684309.git.ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 13:07:02 -0700
Message-ID: <xmqq4if7g6u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> +			merge_incore_nonrecursive(&o, merge_base, head, merge,
> +						  &result);

In a hard error from merge_incore_nonrecursive(), result->clean is
set to -1, which means that ...

> +			if (!result.clean) {

... "result.clean is false" is not true here, so we will ...

> +				merge_finalize(&o, &result);
>  				return error(_("conflicts in index. "
>  					       "Try without --index."));
> +			} else {

... come here to access result.tree member, no?

> +				oidcpy(&index_tree, &result.tree->object.oid);
> +				merge_finalize(&o, &result);
> +			}

IOW, shouldn't it be more like three-way check,

			if (result.clean < 0) {
				merge_finalize(&o, &result);
                                return error(_("index merge failed."));
			} else if (!result.clean) {
				merge_finalize(&o, &result);
                                return error(_("conflict in index merge."));
			} else {
				... happy path ...
			}

or something like that?
