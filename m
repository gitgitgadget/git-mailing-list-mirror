Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E536897C
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048292; cv=none; b=JPSFXAvHKT9aLh1OMSCys39bXxvhqe40jHuYkXrXB4JKUgxSDyt0T72FpYEixt53qaOf2XaNh0vCUZv9V1IK+INJ3lb/o9VKhtvUDksVNXBKWLoJStQPTa2c7mm/Ny1yOJoFcbivUoZlrX+kZfURWxxU+tkTC4NYEJhRHEm4GbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048292; c=relaxed/simple;
	bh=hu+Uv7GvEjvdQFhZsmeTKVbLSmW9wTiWsNqQiepB6Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL/YsNi8/BO6AuLEFIgAx0fDk//g2hQf3RxOyZjN+AmWLeF0QYxuyRqeRps4LyqJ8XV4dvGi5jdjszmYs2p/1vd9noTeomA3u4EmgmslsFsHT2lsRJ5EuAIPTFkF3qFHFSsDnr9pO14VWwp1TnIkF3NDYF9qqrrWUAcWozs02AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PWRIE9xc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PWRIE9xc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceeee8c46bso5643335ad.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785048290; x=1785653090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWzDIo2/47l5rnn/nIWygtDz+woy9LxQrLbammbNd2s=;
        b=PWRIE9xcaLi2twUxmNL8RNg+In++s3sgJu7QpFc/81T6jauSjnkVfRrPt5edOJsZYB
         QOsoC0QK0BHxwTIq4CFWoDpD6H448blctWuQMVmJnsNwVoz+ISHTBz07iG3Y7cyPgWqk
         ZCrEEPXv3+RW//c1QkH23NRjq2NDCInXARnwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048290; x=1785653090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWzDIo2/47l5rnn/nIWygtDz+woy9LxQrLbammbNd2s=;
        b=Kkgn+eABP/bSPaHleSiW1wwFXQjK464o7Sth2zSbY1F+rqCydsNHnip1aC6KlsO5v8
         RoHqqZ70qW10+pZfP38GPctbv1NWLqQBSvK3g+Alj3cw8OClELPltd9vDUwTj9NeRhoQ
         +dKPMe8myJhthwJcGCGeNjWVTnTi3ekg35QkkT5MiF29IB2XUKrqcVJUNddQr284tiAv
         pQ7Y5oZFwCmHulvETV5EEGMGSBHms2dvKc4l8Ccqy4KGISpf3i5DoTREPBg24vOJ34vg
         d9buxf30/qnTSAO0AY4HwjIfEIdHbeXxlPkLzhxRZnK30NzAt5K2hxRsLJDiPBXDfOp+
         o8vg==
X-Gm-Message-State: AOJu0YxPK1KCngpnJEyM0gOpK2esJUVs5fDIA1GloBZgKxH/ovkkK/CG
	LyUTc3VB9WSl0VK9uCIryiof09ldBfDPCpga/da7cyzKAFyFxyusgTjmZ98TkjwS1TYwXM5Stwu
	6SYVFI6M=
X-Gm-Gg: AR+sD11PF3HIskLrl39OQND1DW5A9HUCqR0+OYByVB7rr6FAY2img8406AUoPVNdyyw
	6ujUg84Wad36kERu38EOHhKjFUuQKSZ6MY7uwMF/8SN6GKkewcq1900+GTabc+qOTPnTUwzrax3
	PoFgFGel5twzDTv2uKtxlD+o3w99FRVfujntZtBJedSXbs22nlxjleYA5lnCOjVlL+ZKJ85BqKV
	FfkImRMrwZvf0g3cWzwROYB6PclOJK/+fNRw25XHhbilAPL+2+KAzFKdZ2ymqBnYsNC9mdTFhYl
	huSC2Ge5freIVrsdaOPiGIxU2HTB+/0EY0bryiZij7kbA8KkudfxFb6AoNeAvNl/8DIS7NJ8gmG
	xe3ynj0P+TyCP8eU5qXMhiz+imRYnoRT8n3L3atThJSscLCirZe6zzcgloNxeZq951VsealsZuq
	9QPOwLBi376bkdfzIrqll4P4StDSHlBZThcnrI0YBO4gYqShQlErLpMvgI2/orJMtegHFHqxrIp
	wpJcy0Vb2FYlYs5VDbP/d47Ig==
X-Received: by 2002:a17:903:2f84:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2cfde689443mr35342145ad.1.1785048290386;
        Sat, 25 Jul 2026 23:44:50 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm18622982eec.18.2026.07.25.23.44.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:44:49 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v5 0/3] packfile URIs: support concurrent downloads
Date: Sat, 25 Jul 2026 23:44:45 -0700
Message-ID: <cover.1785047139.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784874850.git.tnyman@openai.com>
References: <cover.1784874850.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packfile URI and dumb HTTP downloads stage packs at
objects/pack/pack-<hash>.pack.temp so an interrupted transfer can
resume. Opening that file in append mode forces every write to its
current end. Two Git processes fetching the same pack into one object
database can therefore append duplicate data and corrupt the pack.

The first patch separates the unrelated --index-pack-arg documentation
and error-message correction requested during review.

The second patch keeps the predictable staging name but removes append
mode. Each downloader seeks once to the current end, requests the
corresponding Range, and writes using its own descriptor offset. Since
the staging key must identify immutable pack contents, overlapping
responses write identical bytes at identical offsets. There is no need
for pwrite(2) or cross-process coordination, and resumption continues to
work for both packfile URI and ordinary dumb HTTP downloads.

A downloader can also find that the partial pack has completed and
request a range starting at EOF. Servers may respond with HTTP 416 in
that case. Treat the response as a completed download and let
index-pack validate the pack.

On MinGW, the non-append O_RDWR open grants FILE_SHARE_DELETE only for an
existing file. Create a missing staging file exclusively, close it, and
reopen it without O_CREAT so every retained descriptor permits another
downloader to unlink the path. Keep the open descriptor for index-pack;
it installs its own pack, so the shared staging file is only unlinked,
never renamed.

The third patch handles the related .keep race. When another process has
already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process. Read only the prefix and
hash so any following fsck output remains available to fetch-pack.

The tests cover resumption, a completed partial returning 416,
overlapping downloads, unlinking the staging path while index-pack holds
its descriptor, and a pre-existing .keep file. The unlink test does not
require FIFOs, so it can exercise MinGW's sharing behavior even though
the concurrent-download tests are skipped there.

Changes since v4:

  * Clarify that the first --index-pack-arg specifies the command and
    subsequent instances specify its arguments.
  * Drop assumptions about which concurrent response reaches the
    staging file first. Either write order exercises the same
    overlapping-download behavior.
  * No production code changes.

The overlapping-download test passes 240 runs with 12 parallel stress
jobs.

The v4 discussion is at:

  https://lore.kernel.org/git/cover.1784874850.git.tnyman@openai.com/

Ted Nyman (3):
  http-fetch: correct --index-pack-arg documentation
  http: avoid concurrent appends to partial packs
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  14 +-
 fetch-pack.c                      |  33 ++--
 http-fetch.c                      |   7 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  56 ++++---
 t/t5550-http-fetch-dumb.sh        | 246 ++++++++++++++++++++++++++++++
 t/t5702-protocol-v2.sh            |  31 ++++
 8 files changed, 347 insertions(+), 46 deletions(-)

Range-diff against v4:
1:  a6a40b8046 ! 1:  a79af009ea http-fetch: correct --index-pack-arg documentation
    @@ Documentation/git-http-fetch.adoc: commit-id::
     -	For internal use only. The command to run on the contents of the
     -	downloaded pack. Arguments are URL-encoded separated by spaces.
     +--index-pack-arg=<arg>::
    -+	For internal use only. An argument to the command run on the contents
    -+	of the downloaded pack. This option can be specified multiple times.
    ++	For internal use only. The first instance specifies the command run on
    ++	the contents of the downloaded pack. Subsequent instances specify its
    ++	arguments.
      
      --recover::
      	Verify that everything reachable from target is fetched.  Used after
2:  144c98cdfa ! 2:  d9667c93b0 http: avoid concurrent appends to partial packs
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	read ready <&8 &&
     +	test "$ready" = ready &&
     +	test_path_is_file "$tmpfile" &&
    -+	test -s "$tmpfile" &&
     +	{
     +		GIT_TRACE_CURL="$TRASH_DIRECTORY/overlap-second.trace" \
     +		GIT_TRACE_CURL_NO_DATA=1 \
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	wait "$second_pid" &&
     +	wait "$first_pid" &&
     +	wait "$server_pid" &&
    -+	test_grep "HTTP/[0-9.]* 200" overlap-first.trace &&
    -+	test_grep "Range: bytes=[1-9][0-9]*-" overlap-second.trace &&
    -+	test_grep "HTTP/[0-9.]* 206" overlap-second.trace &&
     +	printf "keep\t%s\npack\t%s\n" "$packhash" "$packhash" | sort >expect &&
     +	sort first.out second.out >actual &&
     +	test_cmp expect actual &&
3:  d9063deb60 = 3:  fee6f292cb fetch-pack: accept "pack" output for packfile URIs

base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
-- 
2.55.0.openai.131.g83a728de1eb6
