Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94787BA34
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581600; cv=none; b=B0y4xKCsiPNe6FP5BTohreeBD6jM/cQF3eQGIw4GA712q+d25YUYttKAVjavM746qgeFCKtP5gPRwTv8PBUbWYWPqmmIkbqltoAN5sYOUVIDcuzTDJY4SZB61eh3RsHB+7usmlXyX4b2YsPVnPdNNIuG/1XVvKIpAe1QazRBolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581600; c=relaxed/simple;
	bh=b3ku0FssrZneNxjjNuRNxoIoIlDkyTjBdTsaQp7gkJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/TA9r7krbaiI448dHBHgmGZUVXic0eh1UbhO/DIHJrvxTEfPBooQbYg1/4mdagqA0zhzaOZzaWqVSKi4SfkFeDipo+RkOxCS+yXFHPt7m0lOE+zglH0dIXpg0WdiLIP4Tv5z0OnY328C78zI7W0lLuSOinXGSlaSnG09+fe+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JRz2gBjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nocJL28Z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JRz2gBjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nocJL28Z"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B66D61D001B9;
	Thu,  7 Aug 2025 11:46:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 11:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754581597; x=1754667997; bh=IHOpkLo6et
	W++rhzBypj7AdrT43Jcc84/gBtiQKUfH0=; b=JRz2gBjRUegem0qGa3Iq1+W4CX
	PX8d/LO07KJPJq4U1uK+xCqV55HdawoVnUg4W/0d0fKWqF130enpMmTtutC6YHpW
	RbGNFQrZWobd8UbPqa8pThh9ugFSN807ZExwQMrVJUO3tdj3iTZdi/HLD+I6He5f
	XVeRlm3OIJS8BQEeMp0pZ33+rVybuWJxwcpwoFDDk58oy+9y3eG5TNHOJfsUgU/H
	Xg2cJ5YF5JAmKBAwmXX8BwBn9K4pH3mmJ5t7r6cD+jMz+RdeK5uf1z218qakfvrC
	JKwtSx669BDW+fRYwNPexvsxYGgti50iVwdaZ2rNR1QtgydsalvVV9BjxiHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754581597; x=1754667997; bh=IHOpkLo6etW++rhzBypj7AdrT43Jcc84/gB
	tiQKUfH0=; b=nocJL28ZDdGc/0CMoBYGpseW/FNt2RzgWSjdR9qmbjnBcKlfE6p
	MixNS1wCFbNkCnIwRShMqV/QzlRM0Ac/5xQoabePXq15SyAqrbTy23nC/6Ws7aM+
	mNULMRxnoW0zHHzvhT2cLhv52G10AwuHaEa+S9QXNXgP3YY3EPCx376rnjEVyyal
	xf+LP3UsqBmaHB9kpiW/0TD7iQR1KyFsl/GGEEX3C4Y1VNmmTgzJgHWrFdkYvnvp
	wuJjo2Khl06NihTgFg8sovMHZyMuWOIZPa5l7VNIEsAxzagDOTcC1rPTAQqH4sS5
	gkEw94nluFCQjshjBnRgzsQu0a71/Fv38kQ==
X-ME-Sender: <xms:XcqUaCl5r94ScUOJtaCzodSn8kjEhSATOL7DLasDlpz1_dvRtYK7mg>
    <xme:XcqUaNF02-uIYRFWqw4b-4zNYOUWQaK_byDnCw_PN1kSTWI_CekFv4_onk2YkM4XF
    1QlwoOKu2MxU1VoZw>
X-ME-Received: <xmr:XcqUaKEG2240yuUb0MI1JTunly5FTZertL2EMtlS0uSGqYmmx8m8q_O7cs5pl_7YnnsO_hX-lC_o9i9aIkg2Pj-uxvbK1B3pCfMSA-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:XcqUaCP0AyBz-hiHw3vWgJpcvCw2ZSFrAcfihHAOr3Prp3Xyu5MZRg>
    <xmx:XcqUaBHm26M6IVvFjb88eGu1dSfDgxiTyLLrDghNC4DOPew8F-lUVw>
    <xmx:XcqUaBNF05hF3LcExUsX98cO80ebLX05D2YW652X8pLZpr-i9vrH6A>
    <xmx:XcqUaK87tmyIrSYlhUTy0cdRr-_pHSTrlc5CmlCcalFihn_9ePhA4g>
    <xmx:XcqUaEr8Fw2gczDc3a7Q1fzNJ2NH_mUKXrjQhzy5XbPI9wHjmLISUTh3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 11:46:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes/2.51.0: improve wording for a
 couple entries
In-Reply-To: <20250807-pks-relnotes-2-51-fixes-v1-1-507fd15b28f4@pks.im>
	(Patrick Steinhardt's message of "Thu, 07 Aug 2025 07:09:25 +0200")
References: <20250807-pks-relnotes-2-51-fixes-v1-1-507fd15b28f4@pks.im>
Date: Thu, 07 Aug 2025 08:46:35 -0700
Message-ID: <xmqqfre3rv6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Improve wording and fix typos for a couple entries part of the Git 2.51
> release notes.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

Thanks.

>  Documentation/RelNotes/2.51.0.adoc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.51.0.adoc b/Documentation/RelNotes/2.51.0.adoc
> index f8adc2c5cf..e2cd673f43 100644
> --- a/Documentation/RelNotes/2.51.0.adoc
> +++ b/Documentation/RelNotes/2.51.0.adoc
> @@ -97,8 +97,8 @@ Performance, Internal Implementation, Development Support etc.
>   * "git push" and "git fetch" are taught to update refs in batches to
>     gain performance.
>  
> - * Some code paths in the "git prune" used to ignore passed in
> -   repository object and used the_repository singleton instance
> + * Some code paths in "git prune" used to ignore the passed-in
> +   repository object and used the `the_repository` singleton instance
>     instead, which has been corrected.
>  
>   * Update ".clang-format" and ".editorconfig" to match our style guide
> @@ -139,7 +139,7 @@ Performance, Internal Implementation, Development Support etc.
>   * Redefine where the multi-pack-index sits in the object subsystem,
>     which recently was restructured to allow multiple backends that
>     support a single object source that belongs to one repository.  A
> -   midx does span mulitple "object sources".
> +   MIDX does span multiple "object sources".
>  
>   * Reduce implicit assumption and dependence on the_repository in the
>     object-file subsystem.
> @@ -292,8 +292,8 @@ including security updates, are included in this release.
>     and also they learn to honor the -U<n> command-line option.
>     (merge 2b3ae04011 lm/add-p-context later to maint).
>  
> - * The case where a new submodule takes a path where used to be a
> -   completely different subproject is now dealt a bit better than
> + * The case where a new submodule takes a path where there used to be a
> +   completely different subproject is now dealt with a bit better than
>     before.
>     (merge 5ed8c5b465 kj/renamed-submodule later to maint).
>  
>
> ---
> base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
> change-id: 20250807-pks-relnotes-2-51-fixes-0e72ed15c5bf
