Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA624C076
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878952; cv=none; b=FARJPzAXLtbfWpUcW+ymLw0WPL9wdj6fmgqU1Az1r2UmjKOczr7Z3/8v4dfBePujBKSyW0JUXrXfEB69p8CcIhbIvoHOMctnQMu6pniQarIT2DIQ4mIlexp+wPAOiKdDwnOI8S7aIeOfxtpqlNghMks0qwecolcMAcZGG0SIflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878952; c=relaxed/simple;
	bh=xJtucf3+/QU4xoM6d5Ve3Ac6OFXAPAxzuIV0PbKIGPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MRXcU5ivb74vBLYkllYhZfkOQRb2fe8S+tLfO8YWKa7GUuVg0RUVJ8a9x7Ja11JPIKT34gitP8KfYEeD8ow+kqbj6e2RIqYpwbWRr7H1ekRnS6xrtVF9jjWP/RACAoJB6ZOpsMbBN5N4Ma/s0Tqa0kJ5oK41O1UpJm+PAexlHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1NWurzEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpY4Xz7e; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1NWurzEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpY4Xz7e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09EF614001EA;
	Mon, 23 Feb 2026 15:35:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 15:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771878950; x=1771965350; bh=t9diJw2UdT
	1KHnsWSAEod+m2NAPYGprhy86PKbjGM7g=; b=1NWurzENH+AZuj+B1fIjbtlnFt
	T4edMyWBB9QPs0sXMf8AY6j9uIVpnevxNZQ87klHgcNkujWyPp2c1x3EnWKYZ0e5
	XzlShdhYMaLivX6yezt4vbcpdAfuxwbVYyTdd622YO6SfivjWOt0wDai9KC95vF5
	dhQbRo5LOlaW0sFng1yOEQ8aHtcti+dkEMppCpb5QpwK3CVQLmHZkG+XBf9CUt2p
	KsRhROC813rzqoQe/OAVaTxerqhjB5ENXbwFe7SFL1BE/ZQuzBlvLxr6U9J4c9aH
	VycQHGsWyjA+Fx5/M0+Jr1DJd71x0YxDT5YZnp3jyywmrGsWCDvr0TpGhaqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771878950; x=1771965350; bh=t9diJw2UdT1KHnsWSAEod+m2NAPYGprhy86
	PKbjGM7g=; b=VpY4Xz7eLYmITmk7rIG3QxklEUeNwE4JriLBAFBdGYzv5M3R3Lv
	NCRmCr9baCFgngnymR1O4M6onE601mfbXAAeiC1e20eDKrUk23mQIoV+ccY55gNd
	FEdOSBdUInPemrJjfZitCZl+rjaWtwyfc257PAZCbKrVGQcFRfATWag2HHpBBwPM
	dEYwg7f64P1BAh4JCrhBWXjSMhjUzQVeq4BjokhWBYnNbd7PxsHXgxW5V1576XOb
	RZaXEqcowWG4SIbIMwb2X44b6GljJuV4+BRLQ1gHEF1oHPtW5Xneop3QKyYG/TcL
	weFpU/2DV8WIZgQObx8oscs7yFiAcXIpxiw==
X-ME-Sender: <xms:JbqcaYdgo0dX1OMOXPb84LW5O0aUkR74g3elM_3OlHf02XQUBgdBCQ>
    <xme:JbqcaRFK6nI8ekK0Na8VkLzRI4-lg-faCgbHQlKwIf3sm1buX-Ocdir68TR1ewy4U
    cH_f_E4YWkjRcEbEmXmMH8TV_P84NCwG_wiYMB23A9-CCL7adegKNk>
X-ME-Received: <xmr:JbqcaR1iCxWzjPzRvxpp0ahltZB6irdivFfbiVXKi6i2K0wXhgenV8v_uVtiH7aiIh_BT4C3RbWgFxTz9WQQ1nFV7eVg1y3HpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JbqcaZn-W063rx6ua_xG3xVFeRbacqTNm-y6IUJmqxm7S9e9g_I8Ew>
    <xmx:JbqcaR-aCpwpghRMjJp2OA7JdzHN-OMyd4dMfcC525DdWKGkTSKxEQ>
    <xmx:JbqcaerSi_Ey2UwPDr7DIuv0OmqQZS-YPam1u4n8YrfQVV6pae85_g>
    <xmx:JbqcaalR-CnznLI9s8P1k5hdZJBXcNUDDF9iVp2SNB26G9RGFtelhA>
    <xmx:JrqcaaBH5lxu6OH-c8BmHK_UpGuPpAvBmhE1zHyqR8zioUP6hNmjy2zq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 15:35:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pack-check: fix verification of large objects
In-Reply-To: <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im> (Patrick
	Steinhardt's message of "Mon, 23 Feb 2026 10:50:43 +0100")
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
	<20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
Date: Mon, 23 Feb 2026 12:35:48 -0800
Message-ID: <xmqqsearkxjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> It was reported [1] that git-fsck(1) may sometimes run into an infinite
> loop when processing packfiles. This bug was bisected to c31bad4f7d
> (packfile: track packs via the MRU list exclusively, 2025-10-30), which
> refactored our lsit of packfiles to only be tracked via an MRU list,

"lsit of" -> "list of"

> exclusively. This isn't entirely surprising: any caller that iterates
> through the list of packfiles and then hits `find_pack_entry()`, for
> example because they read an object from it, may cause the MRU list to
> be updated. And if the caller is unlucky, this may cause the mentioned
> infinite loop.
>
> While this mechanism is somewhat fragile, it is still surprising that we
> encounter it when verifying the packfile. We iterate through objects in
> a given pack one by one and then read them via their offset, and doing
> this shouldn't ever end up in `find_pack_entry()`.
>
> But there is an edge case here: when the object in question is a blob
> bigger than "core.largeFileThreshold", then we will be careful to not
> read it into memory. Instead, we read it via an object stream by calling
> `odb_read_object_stream()`, and that function will perform an object
> lookup via `odb_read_object_info()`. So in the case where there are at
> least two blobs in two different packfiles, and both of these blobs
> exceed "core.largeFileThreshold", then we'll run into an infinite loop
> because we'll always update the MRU.

Good find, and it is not surprising.  What is surprising is that we
do not see this kind of breakage more often.  The mechanism does
sound fragile, not just "somewhat" X-<.

> We could fix this by improving `repo_for_each_pack()` to not update the
> MRU, and this would address the issue. But the fun part is that using
> `odb_read_object_stream()` is the wrong thing to do in the first place:
> it may open _any_ instance of this object, so we ultimately cannot be
> sure that we even verified the object in our given packfile.

Again, very good reasoning.

> Fix this bug by creating the object stream for the packed object
> directly via `packfile_read_object_stream()`. Add a test that would have
> caused the infinite loop.

Curious that we have a completely different test.  I've locally
applied (without committing or amending) t1050 update from brian's
patch and with this series, fsck there does not seem to get stuck.
Of course, the new test added here doesn't either ;-).

>
> [1]: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
>
> Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-check.c    |  2 +-
>  t/t1450-fsck.sh | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/pack-check.c b/pack-check.c
> index 46782a29d5..6149567060 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -155,7 +155,7 @@ static int verify_packfile(struct repository *r,
>  			err = error("packed %s from %s is corrupt",
>  				    oid_to_hex(&oid), p->pack_name);
>  		else if (!data &&
> -			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
> +			 (packfile_read_object_stream(&stream, p, entries[i].offset) < 0 ||
>  			  stream_object_signature(r, stream, &oid) < 0))
>  			err = error("packed %s from %s is corrupt",
>  				    oid_to_hex(&oid), p->pack_name);
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 8fb79b3e5d..ec68397ea3 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -852,6 +852,21 @@ test_expect_success 'fsck errors in packed objects' '
>  	! grep corrupt out
>  '
>  
> +test_expect_success 'fsck handles multiple packfiles with big blobs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		blob_one=$(test-tool genrandom one 200k | git hash-object -t blob -w --stdin) &&
> +		blob_two=$(test-tool genrandom two 200k | git hash-object -t blob -w --stdin) &&
> +		printf "%s\n" "$blob_one" | git pack-objects .git/objects/pack/pack &&
> +		printf "%s\n" "$blob_two" | git pack-objects .git/objects/pack/pack &&
> +		remove_object "$blob_one" &&
> +		remove_object "$blob_two" &&
> +		git -c core.bigFileThreshold=100k fsck
> +	)
> +'
> +
>  test_expect_success 'fsck fails on corrupt packfile' '
>  	hsh=$(git commit-tree -m mycommit HEAD^{tree}) &&
>  	pack=$(echo $hsh | git pack-objects .git/objects/pack/pack) &&
