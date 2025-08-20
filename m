Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2C36CDEB
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716586; cv=none; b=tWeEq/Mz9++YVgqRbjO3x5/hsA8SnImFKe2R3yJFzVOPx4VvbvosOC9uXL78u27dTUUvz24Vcf3+jCRQyOJAZGLf7bDSpxbXra6e65qvQvmgmrH6T0G50AD1ju4g731fenkFJ4ld7+ydcN7YDXMoyXgI05+WpkMDOGLod+7SRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716586; c=relaxed/simple;
	bh=e7/Eo7xBfF5Alm8LNo0M+O780QO9TnF454iC/IR7fks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/NX11cXPWYePrkyjQFTrvnjReA7y/JNMBOpFyonCD0CeNo6LfI9sRE9jz8tldsUBD7p+kOEdPztM1HJY/z3zRJcN6B8qtMSn1pf0CE65bV0VNp2FXCguFqlcOmtEckwiH8syd7W82A0k0Uy+4OglN9FzAfo3zyAjE3UbGwSEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DS1h0TLi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QU0o9oZh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DS1h0TLi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QU0o9oZh"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 575A61D0009B;
	Wed, 20 Aug 2025 15:03:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 20 Aug 2025 15:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755716582; x=1755802982; bh=OnDUfFjwqR
	3wWMc5Z7eaLOqij546dRVvaE9wFmZTjlA=; b=DS1h0TLiDtNzJNoGAKN+bJVzTF
	USLiF97OZeT00MbQp3phEh06kGS8rBFvh3lPJxp40EJdlSGScXZ2LfHYjXsTvTuT
	+CMnpMhinogYn6QgX7WT1K7z+qnzBT0HQKkP7F/ZWu83plmct2Ab8aUDCdchACc5
	cSaB/hrBqjaGBbBiCT50rB+YSjmlYXSTqiMur7LiaMg9x9eFA4juW/VY3ICPbDeX
	aEOprovgUNsIXbZ/fxpIh+KzyRUIGFm9i/pPpghtcfDby1H61yrHRa6AE8afVWyk
	WMcfUbLaGGV6AXTsnlmY2b0Gt/GjIuxB45nix2J6hQGjKsXGcS6UIT0ldmLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755716582; x=1755802982; bh=OnDUfFjwqR3wWMc5Z7eaLOqij546dRVvaE9
	wFmZTjlA=; b=QU0o9oZh0R6WMIhQwq8L9WF9naXMAxSA7Su2jVsujr0jeSKy8zS
	CAvCQYUuLfoHz1FBlTRAWwAxQ0bc+Z/zP9MJHYB0unKC/lHBrwivrV/lc9v2cTEi
	aUYsB8VwyPWNx1/h/joh2aNpcwMwkD7OBzTBV7ZUUyRHdEUFhR5CK6Yna5iSS0Iv
	fGRV/BXn3KrglFkmSH96vGdeY404XlD3y2VLXob7ZpPHTXczRVNKpLTEVgIky3SF
	QyHjd7txubSapMNLvRcaLq/NuZnmsHM0vP+UZdR6Q9RlUikGFDgrwvshtcUi8b5m
	WiI875ztiRhajXIIGtoMzKY1xuoOgEmXaHA==
X-ME-Sender: <xms:5RumaHRoYIwzO4ALoRO_MR9FBqCYjwinjqt_lKBZwboGumHH-R7oGQ>
    <xme:5RumaAD_Sw278kCovXTyuu-ef1H58uEJInxAscoO538iBJbiKFv-TtCq1FHD1tPHx
    HupKPtDKxpdLlNHpA>
X-ME-Received: <xmr:5RumaHva9TSE4e1RmNLHqhserQnCqNVXCRUiVNMHxIZQE3GwZB3U_eHK1axbjDMySAStkXQKzhSl_pZ3USmatNm6XuVFkQfIohlCyqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnh
    htrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomh
X-ME-Proxy: <xmx:5RumaG8Qx6HPsMk1gkShm6Q485I9_F-S7erBLKbcLQI_tCa58114-A>
    <xmx:5RumaGT498BZcP1KKoPGzwQXZ6zlxvqxqu7CVaV82OkjSuSuuxG10Q>
    <xmx:5RumaAUuaonLwTzGcbI2tNSuAf8IytiOdFYDkhXYmAgOm1X9x99n3A>
    <xmx:5RumaA-WCuuunXN44SvHKOwntuyj-w-cmzrg98dKXX6R57fjAFaASA>
    <xmx:5humaHULiTDIv3FRMk5b7n36bJi8pZacqEVD8d5loZWnssC785As6Sag>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 15:03:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  newren@gmail.com,
  peff@peff.net,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
In-Reply-To: <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 20 Aug 2025
	18:39:55 +0000")
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
	<0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 12:02:59 -0700
Message-ID: <xmqqh5y1ak9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The core problem here is that the "maybe_interesting" member of 'struct
> type_and_oid_list' is not initialized to '1'. This member was added in
> 6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
> 2024-12-20) in a way to help when creating packfiles for a small commit
> range using the sparse path algorithm (enabled by pack.useSparse=true).

OK, in other words, the bug is fairly contained within the path-walk
traversal.  We treat things as reachable not just from ref tips and
reflogs (where path-walk code can use the tree object to compute on
what pathname each blob comes from) and the main index array (that
has paths, even though it needs separate way to compute than those
for trees), but also from places like REUC and TREE extensions that
make associations between pathnames and objects.  Are they also OK?

> To help avoid this from happening in the future, a follow-up change will
> make initializing lists use a shared method instead of allowing for an
> update to this initialization process to miss some existing copies.

Great.  Future-proofing is 100 times better than just a bugfix.

>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  path-walk.c       | 2 ++
>  t/t7700-repack.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/path-walk.c b/path-walk.c
> index 2d4ddbadd50f..1215ed398f4f 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -385,6 +385,7 @@ static int setup_pending_objects(struct path_walk_info *info,
>  					list->type = OBJ_TREE;
>  					strmap_put(&ctx->paths_to_lists, path, list);
>  				}
> +				list->maybe_interesting = 1;
>  				oid_array_append(&list->oids, &obj->oid);
>  				free(path);
>  			} else {
> @@ -404,6 +405,7 @@ static int setup_pending_objects(struct path_walk_info *info,
>  					list->type = OBJ_BLOB;
>  					strmap_put(&ctx->paths_to_lists, path, list);
>  				}
> +				list->maybe_interesting = 1;
>  				oid_array_append(&list->oids, &obj->oid);
>  			} else {
>  				/* assume a root tree, such as a lightweight tag. */
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 1998d9bf291c..030e9e5b2dc7 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -838,7 +838,7 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
>  	test_server_info_missing
>  '
>  
> -test_expect_failure 'pending objects are repacked appropriately' '
> +test_expect_success 'pending objects are repacked appropriately' '
>  	git init pending &&
>  
>  	(
