Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FE30CB41
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211622; cv=none; b=iJ3DXjKbLd1hQMAb6IM9DHRj9pYMkAwCoBQpO7Bg0DVoxf4WmDDOSVrbVpTp44PTyTAsy+CtDyoUsorlSt9lzfzl5AmNNN8tdFHwjWD7AhUzAiVYjKZqIWMiw+cRFoR+CC7t/4Y5+hq07cjOB0qC3Ev3Bpt1WjLH7vCBQ1mHjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211622; c=relaxed/simple;
	bh=h8u/BX7B+alFZ+4B9HfsW8DN6EFikqHrCk20R8jMHu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EVUr82G26cKdndiu50PIxrXKCNwPFHafeOfe+/qg1hoE14E0/n13xDr6+dwdTEhnd67kVo7GJn1vaLtRwD+gzgSbpM6kolo5w4l6b8SZrBHx7t/+B+rr5daGMsj15DQj71+PseHOVR+T39l34lBO7awGg/tjLhdKis3MNHaacig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uxAl6UXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bu6Lrn1d; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uxAl6UXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bu6Lrn1d"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87D0E14001D0;
	Thu, 18 Sep 2025 12:06:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 12:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758211618; x=1758298018; bh=iz8LC3B83M
	NglqBHglor1PSrSSbuIXAbovwgEdUaZc8=; b=uxAl6UXeb8B5hZYLsMlVlXC0Fz
	QWXZGQ0YUSho4aROaI6U9D5P84W2+sDi52DjknKpP7Thg3RL9epc8ugwWalHvMSL
	gN7JGtLGQ5Des5TgXADQJZ+OliWWG7o1rOWvw8y49o4aKk/utLtx+sZ3cN4fxH/L
	4NsT2SanAiRLBgmDttbSnS3LbyZPXjsd/AulKyPXwwmc1b9SZj0dyZLLesbmhl6N
	ZGndfKuNo7lkFp8ubKTWDjmLLNMNjp8FwMfTHfxuYw5NubJGYgpYbk99RFh9lUN3
	LDtsAP07rtjPToW9Agk6MHdbtOdA8Cl8mckLcGvjjgJyA6I12LOTK/UNJPtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758211618; x=1758298018; bh=iz8LC3B83MNglqBHglor1PSrSSbuIXAbovw
	gEdUaZc8=; b=Bu6Lrn1dLfy0OLReIw2+DSo8xiGtVvSzt5XwsFgFLyA7leilZcz
	weo/ZYq/F6etmhbuVMfJDnVl8eh3fSuMYpYfSuvRQ0yufVyjR2ncqYgtlQJbXN88
	0oCEKlTqhI+svHIA/SGf0bCRhcksccLCY8IRQDUvdYYL3n/J8dpiShcVLqj7IB2K
	mkAwoysBHv4vuOLK9+snLFAvJ3efQkUBpu47SR4qDbOh6hKpusoudkdTEmfXke4Q
	hT82dFwuSYFe4+BVcZfnRlKx7iax4FYJ5y4DKsYInC9uvRGPrjbGxxrxBR80NAXU
	4x+oxKsUwKngqnmtYvP3+ekbMby4OxbrMZA==
X-ME-Sender: <xms:IS7MaFK48ZyZjY7elUlUpBWttpiWhy7jjwmKVIVjVOCTAMKT2Cbmew>
    <xme:IS7MaMq5L6nTfJotvSN4WtNjywJW34KCJ14Fr0w2wLrbSjBZ6rXGpvfoxbbor0AI2
    YNi6VcVTanV62QvQg>
X-ME-Received: <xmr:IS7MaELBFuKk_pkvSWz4XJTCMsghmCaijOin1oDghwJo8zClbjJY1f6HiaEpP9XGm2Q6oOATtBWFjFpWAXJ0XhpiCvJGeeZ-j_d5ecM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ii7MaBRSP0-Tp3fw_-dwlew3uK_JdCG6sQSbTqfnwoY8zp7cetlTLg>
    <xmx:Ii7MaDtEIKikNlKiwnnLZzhdmCqia6puNTTZTurjiG_LezvE_wGF5g>
    <xmx:Ii7MaCZXp_mOhPWvDVY9Tvvh0iwMt8SbztkEEEFsOj_DZVJ5_gcFeg>
    <xmx:Ii7MaJGABeepZ-OKZV49vsDm7TM0amxChxGywGnWQTR0BCnMix8RwA>
    <xmx:Ii7MaIp0jcE6fS2FG7uCbXTmlgd2rwiuyUjINmTTd2h2T2O0DSWb9Mdd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 12:06:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH v3 7/9] builtin/refs: add optimize subcommand
In-Reply-To: <20250918054704.544254-8-meetsoni3017@gmail.com> (Meet Soni's
	message of "Thu, 18 Sep 2025 11:17:02 +0530")
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
	<20250918054704.544254-1-meetsoni3017@gmail.com>
	<20250918054704.544254-8-meetsoni3017@gmail.com>
Date: Thu, 18 Sep 2025 09:06:56 -0700
Message-ID: <xmqqecs3923j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> diff --git a/builtin/refs.c b/builtin/refs.c
> index 76224feba4..ae395759bd 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> ...
> +#define REFS_OPTIMIZE_USAGE \
> +	N_("git refs optimize " PACK_REFS_OPTS)
> +
>  static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>  			    struct repository *repo UNUSED)
>  {
> @@ -113,6 +117,17 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
>  	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
>  }
>  
> +static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)

This line does not align; will locally fix (no need to resend only
to fix this).

> +{
> +	static char const * const refs_optimize_usage[] = {
> +		REFS_OPTIMIZE_USAGE,
> +		NULL
> +	};
> +
> +	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
> +}
> +
>  int cmd_refs(int argc,
>  	     const char **argv,
>  	     const char *prefix,
> @@ -122,6 +137,7 @@ int cmd_refs(int argc,
>  		REFS_MIGRATE_USAGE,
>  		REFS_VERIFY_USAGE,
>  		"git refs list " COMMON_USAGE_FOR_EACH_REF,
> +		REFS_OPTIMIZE_USAGE,
>  		NULL,
>  	};

We may want to clean this up outside this topic, perhaps a clean-up
patch after all the dust settles.  Lack of REFS_LIST_USAGE stands
out like a sore thumb.
