Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7022040AB
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228742; cv=none; b=McLI4yX3bV+LLxU+wGyClNtOgEKCJ15IEU7JCzX6RIf2vsem8rfUzFMgSPC1ULs/ZohW18fNBAI9GNDd+RQPnFOOZUL7fHrI1yyn1Ryj+Nn/RJg58DNpSpGpC3DlQGp/rtroi80rRR7nf9/9CGtAKwKNbt7gsW9iyjUigk2wqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228742; c=relaxed/simple;
	bh=QEUIBpP8oczJj7yHJBmPC6Piqk+o3LBclAxXpLIH7bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECl0Bj9aWQHvT5BHjWjoA3cG1GE9V1Qm0RWOkWHJTj5s2dQd2itAtErbWcJfR1a7w7gTbLjizQf/MxSwe4cftTPSQefeCySgqZG42l9xlXwX5hBFGKtomUTOquRFUjZ+DxKIXmeQWJS5Nm4NpQRp5UrKVVcyFn/PkkzK2JNSuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M01m4leV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XdWDZfRY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M01m4leV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdWDZfRY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE041114011A;
	Wed, 14 May 2025 09:18:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 May 2025 09:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747228739; x=1747315139; bh=fN0Z3caMlD
	/V8TklWUx4dAkDg8W2ozK2XE8lpK7frYg=; b=M01m4leVWDlaUrYv+4JA0BZMfN
	u9BTN7AaMxA433wz0Tn/FhIk1rzCZOi/I2kG5/8SsRR7UcKdl9qj2J1MLkJfS1P9
	frnZkydswlpjarTs0jAdmvb+pFBGyHGrwkbj8Mj02j2dIUbiuySoCXoNU6nBF8UD
	2l4eXSjYmNT6G76fyc7LRd7BewXgdA1gSrVplcP6Sxx9nadp5OaWRIN4a8ScqTr/
	SMOMfgkTdhfWp54WNPtBiXzB2fPsYgaYZ1bSLht8IXkjupwAUYBpL7rXL5JGbPra
	ztUY+3XyxMs4y/EraWF2ZkV4fMGXxD89iHsx+jlEqGqEsDt1kxpfhfHk5Apw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747228739; x=1747315139; bh=fN0Z3caMlD/V8TklWUx4dAkDg8W2ozK2XE8
	lpK7frYg=; b=XdWDZfRYHG7pl1Y596DuYGZH/+oeWm0Boxd560k23K6SXpZcXjy
	y8aCyvwtFg8G/+EhRYCbrkHnm2TCTs2pCfB7/1AQyKl6kea8PC70nrDsEa9OB5aX
	DvbqlW47ufRkBZ5qRM+PTd0h/EjTDgXqqobq+YEmTFbzsVtTuaDlU3KlekSm0JML
	k2WFeZo1vBbRqd07H+lyu39GQtzuLHDYWYuFVTzdc5beEbU09VEbeYhCHSoM2dZJ
	mb7rx4TijXH2kPDdRt+BV+I8y6QDclepxy8eRy9L2J5H5/W6AB6PExLiHaPoHG1n
	3OXt+ce8rIVLKFR/2auDRJCh9xwjjFIYZ8g==
X-ME-Sender: <xms:QpgkaJ0gGZzLAoSHgtccYW947sHOJ3JxUj9wYyA2MaHe3K1ExKpPrA>
    <xme:QpgkaAENsoj2hTqCk5b4x-wAnGDJGkJCeS9OG86D3pRHz3H2wYU5p2ef37ccKkg_g
    d4JByA14UZD3sQKHQ>
X-ME-Received: <xmr:QpgkaJ7Hyv1FA5ZDwX5JiEq1ofE7sdQB-By5AqDjECm56oCG6NlJdNZiOlaBgNpfqKRJMP0fVfJYiECwbwCkOMqnX_hqbSS2KRP42bc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdeh
    ieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:QpgkaG1eOo3aCrpUw4qfSzZX4fhPkUW6C5YWoLNktyrPjQIV67ddTA>
    <xmx:QpgkaMHmb2HFxJ0vHhCNMImXuu0VdRUmfxV3rmRuNS3bCpr2eSugoA>
    <xmx:QpgkaH9CyZ4aNjxO1yWqJh98Zg45-23E0o-L_HaVmDiej24OnzP88g>
    <xmx:QpgkaJn7IE9LzLaHXvyH1wxe30sQ16nPxTi4oaKtAliJXY_E_A751A>
    <xmx:Q5gkaLfkSsDTo8qV_Y90hi4F_nPz1jN-NhHIaCAVVSD_BtWb0LV4J5nC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 09:18:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Lidong Yan via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
In-Reply-To: <aCOFqYdnPp1Lne4Y@nand.local> (Taylor Blau's message of "Tue, 13
	May 2025 13:47:21 -0400")
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
	<20250512131315.GD1191360@coredump.intra.peff.net>
	<aCOFqYdnPp1Lne4Y@nand.local>
Date: Wed, 14 May 2025 06:18:56 -0700
Message-ID: <xmqqcycbcou7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> After going through the "failed" label, load_bitmap() will return -1,
> and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
> will then call free_bitmap_index().
>
> That function would have done:
>
>     struct stored_bitmap *sb;
>     kh_foreach_value(b->bitmaps, sb {
>       ewah_pool_free(sb->root);
>       free(sb);
>     });
>
> , but won't since load_bitmap() already called kh_destroy_oid_map() and
> NULL'd the "bitmaps" pointer from within its "failed" label.

Yikes.

> So I think if you got part of the way through loading bitmap entries and
> then failed, you would leak all of the previous entries that you were
> able to load successfully.
>
> I suspect the fix looks something like:
> ...
> --- 8< ---
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 5299f49d59..7f28532a69 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -631,41 +631,28 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
>  	bitmap_git->ext_index.positions = kh_init_oid_pos();
>
>  	if (load_reverse_index(r, bitmap_git))
> -		goto failed;
> +		return -1;

(a lot of changes that simplifies the code snipped)

> -failed:
> -	munmap(bitmap_git->map, bitmap_git->map_size);
> -	bitmap_git->map = NULL;
> -	bitmap_git->map_size = 0;
> -
> -	kh_destroy_oid_map(bitmap_git->bitmaps);
> -	bitmap_git->bitmaps = NULL;
> -
> -	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
> -	bitmap_git->ext_index.positions = NULL;
> -
> -	return -1;
>  }
>
>  static int open_pack_bitmap(struct repository *r,
> --- >8 ---
>
> , since all callers of load_bitmap() will themselves call
> free_bitmap_index(), so there is no need for us to open-code a portion
> of that function's implementation ourselves.

It is rare for a fix to be removing and simplifying this much code
;-)
