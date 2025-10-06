Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC984EEDE
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759721582; cv=none; b=DuX6nTjZC6XgTfb/r8OeeHoZLlEe5IJ7PhwT70ky+1FiX28/Oor6kJP/z5ZnpEnuyrIy//xDCP9+6JRGcpnDc/eEgoespmH1yD9lmJbmGAjzNOHRe0emHLlrCYfSu/fwiDMlHzNLQ3fH5pnyHL788aaVQGft7DdFcI6RjyHMzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759721582; c=relaxed/simple;
	bh=HFu10VlFiBEV6EzK9D/Ge1FeT1rvzH9P3jOTgDV1hNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HGt1S0iSsnZYFzlTCSOP/OUH0idKaXTOLfE4B31Hy0MO+eynL9AgBXcVl+J/K3b5vyYF/1XleDK//6o8Y12gS4TJHbDvIRNLx0akg8cDFi6BESsm5s3KBSw3jqNFX146nIfvukRmdqj4dSC/yPmldUXbGUybsSKb+CVZomgUg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BDTVXzgA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzPTAIH7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BDTVXzgA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzPTAIH7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BEB961D0007B;
	Sun,  5 Oct 2025 23:32:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 05 Oct 2025 23:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759721578; x=1759807978; bh=+T3b2XEcPp
	TZ5hE6qlmZFM5R32TLd+L90Phf8vn0v3c=; b=BDTVXzgA0WSGMMfHfX9X+eGQNy
	uJJiYrEc15d+Tr9851TGgeF2fhHQwOs4yXeF+CbD5iNll+HO5fBxqX21g/tf9i6y
	wc4hjh95zO7il4c/5aNqFyeynRlPcbNuxkIBVLsHX0rgmhCUQn6rpfh40F4e2P/P
	fQq78v7XoeDbHBS8vcjl18zWQu4JXTQjXi3Kw6i8wDX293xpzM/LcgRMU0sHVe8/
	13YiIeZVuFHH+1V50DtVyKZU3JOXAzriEo88IZHFcH9QKHNoOlcwIuQvqrTKHmXM
	l3Qlvmd1Y2S2/xFl60krrwlT3KOe5wGdabP90u+7y8IFKOILGnYIO/g7O+1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759721578; x=1759807978; bh=+T3b2XEcPpTZ5hE6qlmZFM5R32TLd+L90Ph
	f8vn0v3c=; b=UzPTAIH7oh8mMcAmr+JePbWo/j1x6foSOlM7+l17JV/5zOK6ATc
	vM6UteU/HoEktyCTWpSCRBKcbP1gv72xJ7ylc31F+7wN1HTN4FQgKD41wc27akii
	vSuMcmvCmqeI7Dud3bRimhKM5+VIqNLUtPJJiPKATurMed97XIMKb69GeDiJxvT5
	CYGjsZEAVsC426/6RUn8XYM/aJbX6X26h5jLG25ZRQwhGOsTCUluxKeRXldX0zLE
	mqtKPXRxG0l+EUeLdU6cehmw+/wWFTeH/3hcMtgNbg3SynkWPc/6gstBXxNxG9wg
	R7p1n2vi00f0jTbP2gV8m7LmqvyQqMkDSog==
X-ME-Sender: <xms:ajjjaJr8FJ9-qwh_nQkfeIta8Q4uTyGcSwgF0V9JDk80niOFDf0L2w>
    <xme:ajjjaCqqCGRwsmFY4y7Xjv35MjKoLE4KzvLBSCJFciPNGY88hgPWJlM-j7r0TrpsI
    0AG1TWzfU1zBk5uL7tK4oD_ono5aeUPdaI4dTezNSNS2Pc-sTJ-mw>
X-ME-Received: <xmr:ajjjaLM9NBlx0Rb63X7DhTcyR4lG3mFI4qgTFrSvKp0E_z2Cx4zoiiT4x-RxZb1OScsPlEtgjdsEFQ0eEu8NlGN6VCXdu3iIR89i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelieegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehtdeggeejffeuieegheethefhieevteekffefgfekkeelgfduudeigfegheeu
    hfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdegleekrdgsuhhilhgunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrse
    hjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ajjjaDwl0Z5l_lEA2kUx1zVuLhEvFTlqkgbdO2FBlsVIz0SB704i5w>
    <xmx:ajjjaEv4EY8_CEg_9cPvCVLo36bNYqMKSP_Vdvfcxq8mEMTC6-F91w>
    <xmx:ajjjaM5ndE16VtjyULu34lzGgViViTiDIe2hAigFMgi3QmYOxcd00A>
    <xmx:ajjjaDRapm0y5OaEB83GU-bGIraYWwGa-wueDpSpHYEtIt0akU4r-g>
    <xmx:ajjjaKth1xTFx8DEsdKw2NNc9E8dIwwl724DkM9CVNjVGbeKwj-lZzmQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 23:32:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
In-Reply-To: <pull.1981.git.1759512876284.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Fri, 03 Oct 2025 17:34:36 +0000")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
Date: Sun, 05 Oct 2025 20:32:56 -0700
Message-ID: <xmqqy0por9g7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +MAN7_TXT += gitdatamodel.adoc
>  MAN7_TXT += gitdiffcore.adoc
> ...
> +gitdatamodel(7)
> +===============
> +
> +NAME
> +----
> +gitdatamodel - Git's core data model
> +
> +DESCRIPTION
> +-----------

The above causes doc-lint to barf.

https://github.com/git/git/actions/runs/18265502271/job/51999236907#step:4:655

gitdatamodel.adoc:226: has no required 'SYNOPSIS' section!
    LINT MAN SEC giteveryday.adoc
make[1]: *** [Makefile:498: .build/lint-docs/man-section-order/gitdatamodel.ok] Error 1


You can check locally with "make check-docs" without waiting for my
integration cycle to push to GitHub CI.

Thanks.
