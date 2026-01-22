Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47728364E93
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101385; cv=none; b=qOwslFfwuMPuhmY6Rg3i/XbBoEJNGV3Lj6NAYpIHXiC3uQ/jujurrIVH94NeuYwbeZRfydAL4bKiaN3RwbfCW5PhCyH4zSdzRlQl68yfZ65KMYQqTiJcLkdGzkv5bZ1sEMciX+OodWE4qoX9Maij1TaLrotfg3RqEkPYXzIW3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101385; c=relaxed/simple;
	bh=qMvu6wHRMNPSVkc/BFNl0PGRrJjNiYXzlvJvxyKGfFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2rsdMcV/xE9FDA7ef/gTRnceH0U0WicF5xw3CNNzHH34637uyveH2c0lzZ/t2/nGeEKeYyIsLPEH6Ncwlg2YthNzIcU82yvh7iguXQ2NWavfcT8q7ng32fcdmtFC3pQ2IEhpJooqBgiypa0L1Ct/t5esKAXIxbr3/lSDUI0gIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jSNoX7HU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfL9Euok; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jSNoX7HU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfL9Euok"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3A57140009D;
	Thu, 22 Jan 2026 12:02:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 22 Jan 2026 12:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769101373; x=1769187773; bh=VnAAdko4lc
	I1o+uct/wUMKhZq3LJzcB6DNbwEzseF4A=; b=jSNoX7HU8lrnpb9F8BYpyEccTC
	hbPB9R78978SPV45bSiE8WLzvDQ/J9s86xs6kN0nc7F8taRVccFDJMOoJLKc9a1o
	sCTaLQDen1lAjNfDW7uubDPYmyTwmLprI6ZyBYKJMbAVewPqt/11i5N/tYdWwOu0
	pxBHB8LjxPf81yYitvtPunSJOp1Suk9zFR7x9e522QU72p5onkwNGTKU9UKcdps6
	P4eeiUzJDdj3Vhg7hQwwtydTrOsBIhV4UO5IMcdSa6bBYcbfanTdYrwsD445Pjda
	mdKvydG24KGqonYFPVyxgltD5qBA5WPxuESkWVaCvKFH44IIX6Rf+cqBYVLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769101373; x=1769187773; bh=VnAAdko4lcI1o+uct/wUMKhZq3LJzcB6DNb
	wEzseF4A=; b=qfL9Euok4Q4cgZxNWrpjMWCVmeT8XkYalxOSmYOL7ssHZwGJPtC
	N+kC4hzK9MiBLWyKCY5mymsGe3BZXjVuBmnRmqlxrYMtNuMwBtopEtpEDuMk/H4e
	mx1SedkDxsMRtO5+2csSTMUkM0HfAv6DI3uTLaG7kK+7AdNZnUhzmANGAT1D2sFp
	vd3s2raZquBu4ccpTfQGD7IoP3/zvDvRoIOMhxE4Rv1jF7CXgYSFQdlKjKyR7Sbe
	yL/Z93HfM34B679+oQWardg1FqbIRWOR2oBdMcWzQrSW4nTFuLlf1HWtR5BFTGC0
	RSNovyR1awYp28ZzCuME0oqaOEBHVFHt73g==
X-ME-Sender: <xms:PVhyaUqDo4CpIUAtS5l5xjM46yDr8DLttnQ50aytHrr2qFcqAsDkBA>
    <xme:PVhyaeWjPNnCx3nK26kPLM5fGWzcXY8kXkzGpyhfzuUkAf4WthYXHHvUvh1BK9_oK
    lsqpKiPjHZRLfNIItb9MPAHk6PO74crLpGCDsUTJHPNuYc7YbL82g>
X-ME-Received: <xmr:PVhyaTDh8O9mSMYHBgFBOpapLOe6zT7s7r_9uddFG6KHbI8AB5aX6UcKGyEbGSU0KGalkS3ltH-JD24Lz3mvZA9NvG65EmJkjZLGxvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeijeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeevteekuddtfeevieefkeeikeeiffejtdehhfelvddvjeelveekveeuledt
    feegnecuffhomhgrihhnpehmrghsthgvrhdrrdhpshdpphgrtghkvggurdhishdpghhith
    hlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PVhyaS1xDrBI2mARwpXdz_n8X8BGX4z0aPsqabnafggNMo8m4yv0QQ>
    <xmx:PVhyaV1txrFsFQnXsWPrQoLj4Pd1puFJhHOuwbGNlA29qAYU2yUXWw>
    <xmx:PVhyaXA9qv74fEmN7Y5J47HWOY1sQeDhsIBwEA2gFUa4mwf4RU1HjA>
    <xmx:PVhyaU4_9zLhkLV7BkPJfWHTnv0PW9PVLe66yYnL-dbLN-BMRypeXg>
    <xmx:PVhyadnV1-loj_qvOygRoyCpVw6H9aVtfWIRWGTIKNl8WRNg5B-cgQOJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 12:02:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/14] odb: introduce `odb_for_each_object()`
In-Reply-To: <aXF+fMQKry71Gh0w@nand.local> (Taylor Blau's message of "Wed, 21
	Jan 2026 20:33:48 -0500")
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
	<20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
	<aXF+fMQKry71Gh0w@nand.local>
Date: Thu, 22 Jan 2026 09:02:51 -0800
Message-ID: <xmqq8qdppolg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jan 21, 2026 at 01:50:16PM +0100, Patrick Steinhardt wrote:
>> The patch series is built on top of 8745eae506 (The 17th batch,
>> 2026-01-11) with the following two series merged into it:
>>
>>   - ps/read-object-info-improvements at a282a8f163 (packfile: move MIDX
>>     into packfile store, 2026-01-09).
>>
>>   - ps/packfile-store-in-odb-source at 12d3b58b55 (packfile: drop
>>     repository parameter from `packed_object_info()`, 2026-01-12) .
>
> I was having a little bit of trouble constructing a base to apply these
> patches. a282a8f163 merges cleanly into 8745eae506, but 12d3b58b55 does
> not merge cleanly into that, nor do they apply as a single octopus
> merge.
>
> Looking at the base-commit identified below from your fork[1], there is
> some conflict resolution required to merge in the latter series. I'm
> including the --remerge-diff results below in case others are interested
> in applying this locally.

Thanks for independently validating the conflict resolution I did.
A quick glance of your remerge-diff matches what I had been using
for the past week:

$ git log --oneline --first-parent master..ps/odb-for-each-object
...
ec16dde5c8 Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
c8e1706e8d Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object

$ git log -2 --oneline --remerge-diff -p ec16dde5c8
ec16dde5c8 Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
diff --git a/packfile.c b/packfile.c
remerge CONFLICT (content): Merge conflict in packfile.c
index d951de73d1..402c3b5dc7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2164,16 +2164,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;
 
-<<<<<<< c8e1706e8d (Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object)
 	ret = packed_object_info(e.p, e.offset, oi);
 	if (ret < 0) {
-||||||| merged common ancestors
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
-=======
-	rtype = packed_object_info(store->source->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
->>>>>>> a282a8f163 (packfile: move MIDX into packfile store)
 		mark_bad_packed_object(e.p, oid);
 		return -1;
 	}
@@ -2574,17 +2566,9 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	oi.sizep = &size;
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-<<<<<<< c8e1706e8d (Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object)
 	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
 	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
-	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
-||||||| merged common ancestors
-	    oi.u.packed.is_delta ||
-	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
-=======
-	    oi.u.packed.is_delta ||
 	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
->>>>>>> a282a8f163 (packfile: move MIDX into packfile store)
 		return -1;
 
 	in_pack_type = unpack_object_header(oi.u.packed.pack,
c8e1706e8d Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object





>
> --- 8< ---
> diff --git a/packfile.c b/packfile.c
> remerge CONFLICT (content): Merge conflict in packfile.c
> index 4cc9d8c07e6..402c3b5dc73 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2164,16 +2164,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
>  	if (!oi)
>  		return 0;
>
> -<<<<<<< b7f649ca936 (Merge remote-tracking branch 'junio/ps/read-object-info-improvements' into HEAD)
>  	ret = packed_object_info(e.p, e.offset, oi);
>  	if (ret < 0) {
> -||||||| merged common ancestors
> -	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
> -	if (rtype < 0) {
> -=======
> -	rtype = packed_object_info(store->source->odb->repo, e.p, e.offset, oi);
> -	if (rtype < 0) {
> ->>>>>>> a282a8f163f (packfile: move MIDX into packfile store)
>  		mark_bad_packed_object(e.p, oid);
>  		return -1;
>  	}
> @@ -2574,17 +2566,9 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
>  	oi.sizep = &size;
>
>  	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
> -<<<<<<< b7f649ca936 (Merge remote-tracking branch 'junio/ps/read-object-info-improvements' into HEAD)
>  	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
>  	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
> -	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
> -||||||| merged common ancestors
> -	    oi.u.packed.is_delta ||
> -	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
> -=======
> -	    oi.u.packed.is_delta ||
>  	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
> ->>>>>>> a282a8f163f (packfile: move MIDX into packfile store)
>  		return -1;
>
>  	in_pack_type = unpack_object_header(oi.u.packed.pack,
> --- >8 ---
>
> Thanks,
> Taylor
>
> [1]: https://gitlab.com/pks-gitlab/git.git/
