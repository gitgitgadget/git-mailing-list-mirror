Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E141F942
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015309; cv=none; b=b8G6Qk0HiiryPhG4sLZYiBtzR5UvjvHc3IgWNgkP2PbwTnWj8ein5bD+RR8wiFnXoeV5Ihry5fN5CDGvt1xCNvlBJX1A4BPnWrVU9HEgTHXpq7ACx4fPK/k54hJaxKUt80QS1V4DXkGfb9QvYg2rWS3sHt9mkkuUiO3Gd64tKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015309; c=relaxed/simple;
	bh=xa7Hrx6kw0C0gEc5DqVmMxIv6j5Wyr2xKsUMEVXlB9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lkk5MUmvh4S3+akGmB6BISKmWXdePgiIM3qB+eK9id2jVU2Ej/cOBglGuRhFau9Gq9LOUCBFfj3ML7LNi1UcSVD5TSJeXNStsS9CEIh1HeBOMKlxudK0bhYkaVZtuW/wgv/XgnULRtGqCNhiipV9kbT/+dMjP+cr5I3tocTO3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I8zOpHhu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkUIWv9k; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I8zOpHhu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RkUIWv9k"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7682EEC0433;
	Mon, 17 Aug 2026 21:08:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 17 Aug 2026 21:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787015306; x=1787101706; bh=vOSjuf3sd1
	59D+DKB9jutVxd+wAmVtLevl+sD1ZBWdQ=; b=I8zOpHhu9VgNL6qDIgFnh3NO59
	EosdJ+Rg5WNRWalIIdW9nutCg5zJKyRYKA7TTa7bXb0G2kK9zg8rFedehEIFak44
	DZ7XCEXo0fzEE9k6pLmK+pCGCxiNH8IWVeKlLpP1Us0bz03KhxXgmGjGXURtgfli
	LxLSGwdQgukJoEzhv2zKx5nXqk91bGa5fv9L63kT0Tn3GvCv8b4301uYNKY689aS
	Au4EzSNV8tanS0pIzhK08fW5WandM3LKEyMC1Y2NfKlbi8TzentXvpIFFDRwvsi4
	FOh7iMTATuriLgkqdCJpX6xgzLJsAdLxWYkriIVha8CK7m/VZ5R5U9tG4ooQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787015306; x=1787101706; bh=vOSjuf3sd159D+DKB9jutVxd+wAmVtLevl+
	sD1ZBWdQ=; b=RkUIWv9k+BBr9F7eYHB9V1vhyFTSKM2qyb02nO93Ft2Fl5s0ntI
	b5jb61ehmAY0kHgfZiKX9VGokC/qPPpfgFFcsNc4uALYKnmW9T5Ylf4lMO6jVVi3
	51dvDJzw+oNgwlbh9VL+hSaaW1C/WWMQcgy4O3bgUHjuco3vPeZuoi4+CSN/bZbN
	x/mP4VwYIsCLYIVJEZJOFtEjkw6EVtTkUFRpzsKiYpZLYBCa1ogPvReQ2CXHY0dP
	EQ60MhC74MzQyShXrhwFC8f443/89/mKbhEIGX5XFXtdQnmjoA4+toJPpxdIi0w5
	YP72IRr5VZH1zeC+C6a6LwgrEOH9gPvBL3g==
X-ME-Sender: <xms:irCDapelc5Vg4g0ls-OrGwcC9nkKUbTl7VGmPcF-Ts5x61oU37kMgQ>
    <xme:irCDauoiCdQk1gOcklR975RATfkf8g2yD_4c6L1aFuNP-9K_xiG6wAp93H1Vhk2OJ
    UfSTh7RAibfzPtCBA7uN6bFFyL0juxN0gRhezQogR2SYw07DNztdSc>
X-ME-Received: <xmr:irCDav4heM1ES-DjjOqH_0pml5INeLDici4iZWhICRW8P2qQUmRv8k3xcIba9bMXY8hGZPv6LOmP7sZgOs1Wfa8eq2FQSDyiEg>
X-ME-Proxy-Cause: dmFkZTEbh9RprT4FA8aC6Jxrnle/+9xtJjo3ncGH2oeC3/lou8+bBOYbrqV4BgV7fVe6QC
    r2omst6EQfWJttHRfXQpCU0UHoNs+Q8G8aSSWAWp4CMLwoPlhHT5MUAeTFuFOA+8VBlMOT
    9uWlYxdJCU0o/eMSBL7vTt9cnI9aEzLtfAAkKaaGbGeQO3grvgBMmU1nNoiLZwA+x9AMlJ
    TKqO6lc+sPW/Z2/OwwPy2p2+gVkP7BsI6TnSaFlOZRUcuJZMUhwyZ1/bE13pg1TvNNfpXx
    iz+1ZT7/KOepQb2zhHMnQgv6PHUBsdu5x+j+uyDKXbJ0yKDbjxDcON+635lZA8UdlTDpgv
    ptCnA5Zp1rAWCG1MRm8wbJcG00VYA4AJDONsi7gQjihFGdn6o6foHFOYIq3qFT+f+hMklV
    oq7ww/KM+PcjXQOwa+0+Aofih0mgjYA7Lrv2rrjwhND/IyXV84HPBUiM3Eh1TWDbuPLzo5
    QbmkK7D2vlTI5UDZhldn9gen7ydaL9wVMZaZsPQUQ88Q0FuVhvqiMVNyRpYxuGlC9UpJyF
    y0ltHlRrrxCuYwZn6mi1tT12YIw/NLgptYd3pM1/dFtWkpaUCEFCe+QC2Ut4z9y0e0vnjS
    fFvGFHlje3MqBWJMmrT6+DuBNlfp1L0bu1cZDgIcc3faFeP6XVnH8qNL7teA
X-ME-Proxy: <xmx:irCDasowo-0omHxcssz301XmFazk_qNrH3kzGiwq_mUX6bnQJBMWHw>
    <xmx:irCDapi96lz-H_geK5JfvyL0vcr_D97E0Gigqoia9TyKhFa-fkCADA>
    <xmx:irCDauLK-hj7AQlQp7LbDlq77GnrU9yoDRmGh6RlUM39Mbdp4vQRbQ>
    <xmx:irCDahB4Omfi8_bdfJ-am12EUNMHP3okujuG-xHZoGxJoYczJ-g7PQ>
    <xmx:irCDaqrVvRbLfH65YRfMTszZQT_YmtXvCzv-S7dmtxReYyS__wf9xZo9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 21:08:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: friel@openai.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: trace pack bytes written
In-Reply-To: <20260817233914.8740-2-friel@openai.com> (friel@openai.com's
	message of "Mon, 17 Aug 2026 16:39:15 -0700")
References: <20260817233914.8740-2-friel@openai.com>
Date: Mon, 17 Aug 2026 18:08:24 -0700
Message-ID: <xmqqo6f02q2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

friel@openai.com writes:

> From: Friel <friel@openai.com>
>
> We want to measure how compression settings affect push performance on
> the client. Different settings can produce different-sized packs from
> the same objects. Trace2 records the object count, but we also need the
> pack size to compare those settings.
>
> Add a write_pack_file/wrote_bytes Trace2 datum alongside
> write_pack_file/wrote. Count packs written to stdout or disk, including
> each pack's header and trailing checksum. When pack.packSizeLimit splits
> the output, report the sum of the pack sizes.
>
> Signed-off-by: Friel <friel@openai.com>
> ---
>  builtin/pack-objects.c |  7 +++++++
>  t/t5300-pack-object.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1ec5b6f206..bbf1adb437 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1337,6 +1337,7 @@ static void write_pack_file(void)
>  	uint32_t nr_remaining = nr_result;
>  	time_t last_mtime = 0;
>  	struct object_entry **write_order;
> +	off_t bytes_written = 0;
>  
>  	if (progress > pack_to_stdout)
>  		progress_state = start_progress(the_repository,
> @@ -1347,6 +1348,7 @@ static void write_pack_file(void)
>  	do {
>  		unsigned char hash[GIT_MAX_RAWSZ];
>  		char *pack_tmp_name = NULL;
> +		off_t pack_bytes;
>  
>  		if (pack_to_stdout) {
>  			/*
> @@ -1389,6 +1391,8 @@ static void write_pack_file(void)
>  			display_progress(progress_state, written);
>  		}
>  
> +		pack_bytes = hashfile_total(f) +
> +			the_repository->hash_algo->rawsz;
>  		if (pack_to_stdout) {
>  			/*
>  			 * We never fsync when writing to stdout since we may
> @@ -1419,6 +1423,7 @@ static void write_pack_file(void)
>  				write_bitmap_index = 0;
>  			}
>  		}
> +		bytes_written += pack_bytes;

I may very well be misreading the code, but it is unclear to me what
role pack_bytes is playing, why we want to compute it before the
finialization if/else cascade above, and increment bytes_written
after that finalization if/else cascade above.

IOW, wouldn't it be equivalent to get rid of hunks 1347 and 1419,
and in hunk 1389 to this instead?

		bytes_written += hashfile_total(f) + the_hash_algo->rawsz;

The numbers for non stdout case are not that interesting (we can see
how bit the on-disk files are very easily), but counting in the
common code path (i.e., hunk 1389) sounds like the cleanest
approach.  I just found that the code with two variables confusing.

Thanks.

