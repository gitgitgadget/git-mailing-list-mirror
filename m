Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EA1AAE06
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231950; cv=none; b=jMtYzB2tqSvrkoMADKntPFczTvj4WIBdNb1GbyTXn/PDVVMNKyXXILTRV3Mz2rupIzrPLPtLYVxgPQZDp+gZc7zOIkAQuQgyd0GdWeHnGtVOq2M3wTeWXAw2awkGCGdLjFBSfOTb93nndwgejRcYRY+tn7qnSSZYWLSuUtBftjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231950; c=relaxed/simple;
	bh=yORrjPu+I28u+pBZl5BH+Tn//qFY4xIHhDbtCbdHtOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDApCBt/wWcSGKBvixPtdox4c4IfUckQwr25jfyfX/BJ59vzRng0y81bk9XCYRB//HyQ4BAC79iBS9myqXlaQrq9CD6j+YblgmrBbNP/MQoR0LRwu5RT2tkJ5ApYwA59YaDS+tBWC9KUynEbeIkPA13Yyz29G/t9kD//7DG+TB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAEVgFeG; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAEVgFeG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id EDDC0114018C;
	Thu, 21 Nov 2024 18:32:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 21 Nov 2024 18:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732231944; x=1732318344; bh=KLhFZP0GfpakI4zBRYLZiQM+FqYIzMdcGV9
	SUvj6URU=; b=iAEVgFeGaUuOIt6+ju9nES73kEpeejxLPopp5p3bXAYMjlPPE58
	FsNwDECAqWFb2kHrXKzcmUm9dNXuVdO6I9/zkv7TwC//4hBHgbr3NAvNcandDggQ
	5ULkKHej3Q25dw4QLGNh2UzcKKRs7hsVz1XEFePGwN0GleVj3YpuA2Q/Mj6kVC4M
	kmfBDUy1AkmJfVICiSN6R1E1c4IR4mruQv6XuOx6h7RNVuVdgteJmtwRLTPEvDsM
	4Se93pICYeYQZT+G61g/h3527C1HUjqRz8glDbkzWGsSUBfMwFZ3M3SRiMzTcZb1
	LHLpF/rahUy/uuIpT8/j+NBAmMkrCB+JBgQ==
X-ME-Sender: <xms:CMM_ZzKH4g9HpN-k-aeyE6uePs8reXetvihmBTYWkKCoYO_R2yYaMQ>
    <xme:CMM_Z3KY-I43-FsrCu_TMWfUgclN9EypIumdi369-iKQqGMjP3gWyIw75x1ITlK3H
    mX8okw86j_c6bJErw>
X-ME-Received: <xmr:CMM_Z7usR5WrdgHeX4J39yYX_Vlz5vwyfUrC1ozQ0gpn-pyN1wG2T9g-dTJrVbptbY3plgemPo3iBf87qV-_s7p-6AINx5IiS3K0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpefgteejgeduveeuteeiudfhhfeguddtjefhjedv
    ffelteelhfdtveejueehudffueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CMM_Z8b5-59K2_Aq5vDRlo0sHeuuvzmLoz9JyxXhWbnBQKm0PEHS1A>
    <xmx:CMM_Z6YBfbNa-rAUvwc1KuJEwnWFl3BB7MFoZjDoqpf8zRTxUJGEBg>
    <xmx:CMM_ZwB0o7UWOd5_r4FDjklyRYiefunBm5X-2G5AibunZJ0Nf2YVFw>
    <xmx:CMM_Z4b1bZNOyEXJit43F0RqYiy4JV3g0iCgOEFZBIMHuxVC8O0Yow>
    <xmx:CMM_Z3RJXxyfbj4_LSVvEZDCqCAeZEIpPc5ZEYOoeH7Hmig-fgOyPjpE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 18:32:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  johncai86@gmail.com,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 1/7] pack-objects: add --full-name-hash option
In-Reply-To: <Zz+nk4w+y63vCupK@nand.local> (Taylor Blau's message of "Thu, 21
	Nov 2024 16:35:19 -0500")
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
	<Zz+TKS2O/ij6GZ1f@nand.local> <Zz+nk4w+y63vCupK@nand.local>
Date: Fri, 22 Nov 2024 08:32:22 +0900
Message-ID: <xmqqmshsduyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Nov 21, 2024 at 03:08:09PM -0500, Taylor Blau wrote:
>> The remaining parts of this change look good to me.
>
> Oops, one thing I forgot (which reading Peff's message in [1] reminded
> me of) is that I think we need to disable full-name hashing when we're
> reusing existing packfiles as is the case with try_partial_reuse().
>
> There we're always looking at classic name hash values, so mixing the
> two would be a mistake. I think that amounts to:
>
> --- 8< ---
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 762949e4c8..7e370bcfc9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4070,6 +4070,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
>  	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
>  		return -1;
>
> +	use_full_name_hash = 0;

Hmph, is this early enough, or has some other code path already
computed the name hashes for the paths for the files to be packed?

    ... Goes and looks ...

This is called from get_object_list() which

 - is not called under --stdin-packs,
 - is not called in cruft mode,
 - is not called when reading object list from --stdin

so we are looking at the bog-standard "objects to be packed are
given in the form of rev-list command line options from our command
line".  And in the function, we walk the history near the end, which
makes show_object calls that adds object-entry with the name-hash.
So the call to get_object_list_from_bitmap() happens way before the
first use of the name-hash function, so this is probably safe.

And obviously get_object_list_from_bitmap() is the only place we
select objects to be packed from an existing pack and a bitmap file,
so even if we gain new callers in the future, it is very likely that
the new callers would benefit from this change.

OK.  Nicely done.

>  	if (pack_options_allow_reuse())
>  		reuse_partial_packfile_from_bitmap(bitmap_git,
>  						   &reuse_packfiles,
> --- >8 ---
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/20241104172533.GA2985568@coredump.intra.peff.net/
