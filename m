Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764332EBBA4
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830893; cv=none; b=U096vkDJsnJhktt966n0QeP5x4xlA6rmZcFavyim4qyn4qxZT58RqSBxfI2R6ODtWKZ4Qb4wi2Jmu0nu+x7rstCTnSaoScQcZAg3Dw8msrUb40rJ2MwiZ9xE7+9n8dOAovH772oOCn+am7c/OKt2ERhtvQrXGTwtDjKz6rnXbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830893; c=relaxed/simple;
	bh=4Tf4F+lYTjuXV9RLWnuhY9m1hXULai2LS1e50QPgQGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLrl2EjFTILWk8JnpWW48e7KFR0p61jeG/fPcqJdK82yJXrPBqa/O0Jis/JBI1zS502GMe/gUywKimFlhhbhH5SInPXNFGlkBZDaoRTUBnLwllvPhME1XwL1dTWn9LqYOndjdmi5/AaX5h/Gy2ppODOEnXzZ4gIC5Acvx/al2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FT25723Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3R2/Bm8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FT25723Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3R2/Bm8"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8EF014000CE;
	Fri,  6 Mar 2026 16:01:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 06 Mar 2026 16:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772830890; x=1772917290; bh=kMbnPp2P/N
	t/74N9GluvNXpttaYoIBf1KZfz/1ORTqs=; b=FT25723Y3pda9/sglftSXA2Ch5
	JQz5IN+ATCSB1TvZqXU6kTl4sVNxDwDTwDIVV2c0Z1m4ROSQSCMq/ftGKVX8g/Bw
	GC15LzqSxpxKSBphnuAo+ydR493nC9b6F9gURBf1L+ScMBzxXGKZz+ZmAuSXQ7x5
	ZJENdW5v3wlJoRLIGbvJai4zxVd23s72lYWh7EcadPq5MYhyq9XLNi57/Z2Ke7Z4
	HipMqdHiODOzp9+MarQf/0x3Ov9hSK43hTm1iAM8Me52Gu1gZjUejvsgq9qcnd5w
	mFIfdbS575sCqtYezRvcT22zwfTAu88d4qtItx73klw5rjNQ1hhGylo42WPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772830890; x=1772917290; bh=kMbnPp2P/Nt/74N9GluvNXpttaYoIBf1KZf
	z/1ORTqs=; b=V3R2/Bm8kCJAwHYv8USl/rdaIko3Vb55yD8eT8jnvmBIdrMNUvi
	erZGl4iy85gIohnodieKgQHnYmoQiFSdPNCOtoO8NrJZiV2KVhAdACHmi0QJW5fH
	kYoop6hs57JwRKq0D3IDGBuMRWcAFrlQRf2EaUWfID229RY+y908BRSl/O7UuYXv
	DektceY4okERb4LoKYH5dY031C4ccrQU+lZKf8nfgy9ZSYjAlKPDWdskueNdZEL6
	GxILq5mrMFEJXM+9I5Me9JPV57y09FAT7yZfW8Zx2ASXl5IbcH5fWeG7th+PF9QW
	P3uk+z5ocFVkcTbbIcaaotgRezKFeQ50Jwg==
X-ME-Sender: <xms:qkCraUCrhvW1mYkUq_45VCyGGcVWcGxYqzlNZHaXDQPyNklQ0Z5NJA>
    <xme:qkCradZQXwLTYIAWNQ9TsYDeyUh_taqCI7FebPKoNWy7em1cJ9TxqNAisEjIZXjx3
    lw_yhYIyKLJSx3pYRlS3JxfhhbqrEBjPEgmwd-NC9Kju7XgLBTCx2k>
X-ME-Received: <xmr:qkCraf5BkGHCYkjSjJJidBDgH6WD_jiT2mD5Pr6Hhst1SUadyTRlWjfUcZCK7NZ8dk16ahFbkNDsZp3amt67UuRylYLdj_R9FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohephihorghnnhdrvhgrlhgvrhhisegtvggrrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qkCraWZ3f8Uy36HgJmL_y8mYJ8NQNQp5y_03mUsDmdYnfVr6aJyAuA>
    <xmx:qkCraWg3qVd-qh_rDoCRnnDowDQGrhpScmk85QQQQhboyyyC17XZiQ>
    <xmx:qkCraf9gsKIOLa1PI75xfkvK-rhAjrfSJfygmQJE-HpxMbuGOd8rTA>
    <xmx:qkCraZqui59r4b-ClKicdNqEiuMRCdjyRm983ke9S3UkSuGW6ZYddw>
    <xmx:qkCrad27jFuNmPsk_FHifZoFs2ElCyJ4iiO_eCdfIHi-NnvREMj9Dpo6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:01:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>
Subject: Re: [PATCH v3 0/3] branch: add prefixes to new branch names
In-Reply-To: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com> (Yoann
	Valeri via GitGitGadget's message of "Fri, 06 Mar 2026 13:14:29
	+0000")
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
	<pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 13:01:28 -0800
Message-ID: <xmqqseaczn87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This PR adds a way to add prefixes to a new branch being created. The goal
> is mostly to ease the developer process of creating new branches by adding
> shortcuts that can be set either with a command-line option or with
> configuration parameter. This is useful especially when you have to do
> similar backports on multiple branches, removing a bit of the need for
> finding names or typing the names over and over again.
>
> Changes since v1:
>
>  * Added a '--no-prefix' option to git branch
>
> Changes since v2:
>
>  * Changed the PR structure, with 3 patches:
>    * first patch adds the '--name-prefix' option
>    * second adds the 'branch.namePrefix' configuration parameter
>    * third adds the '--no-name-prefix' option
>  * Those patches only target 'git branch' now

I haven't read the actual patches, but the first step that adds
"--name-prefix" should also support "--no-name-prefix" at the same
time, with or without patches 2 and 3.  Doing so would allow users
with an alias

    [alias] bn = branch --name-prefix=blah

, who want to almost always add "blah" to their branches, to defeat
the prefix in rare occasions with

    $ git bn --no-name-prefix foo

