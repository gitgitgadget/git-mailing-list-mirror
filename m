Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544067C42
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442958; cv=none; b=SMzpSlRPDBefpU4UwiLUOUsaBykfd4ZFrns8ol7kBXGOsU9YW0HXJr4TVdPkGz4sbBgeF6wVxe6BJu87dqq4wEFs5ZD5ON4bbozaj9h0XsnvM172iPeKxDCu7gwMfDvYKYS9cPzMMKTcLQnrMN07g6tra8iiniJIPkgWJEXDJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442958; c=relaxed/simple;
	bh=3Tl3R7I4iT7YRgoWU8U8MZLak8vDstJFK1tsm2QyinA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K0epHixRJJa7Z6AfxCh97dJ4B8DpntCspR2iw2xTZDW2kHucKxFz8xp8XPlE0T4a4RLpMp0nFSeHYZ226W3fVkXcG9LiqFsT0mcCA9+0Wnw59xYy4S6Ecvle2xuPIoRT+I1/v0i/iWp+of3DSRa6JHCKLtee+B8W0Q0ZyzWjs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=3PqfulWH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3PqfulWH"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a0b1353adso3148451cf.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442955; x=1706047755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsxRs5wDbOrFFOE8V+8nbOEqjxePqs48kZcrUQVgITo=;
        b=3PqfulWHXylrI+NO6ElHPa3+mX7XUfNlSa+9i2UMw6zqUshsmhCMeDIc+QFhUAZ8hh
         jgdLKp1jsWzu6SsIbRQp19sg4odbNTu9TQ+Gfwv86et6QZ5VyAFmBb2FzPml5jhw7ZQg
         907ixfMI+9FPgqwLHxaKH7mjeENhLBgDUSXR3MAnYzBdgrHN6qIs2qFqQox9CTPslr9N
         swtmlKjczwn1rrtMekjgHdqqSiGJPvs2Dioj13lWAA9KtCkYMsRqfKPG4jMA5P3/Heas
         lVhq3EbQcYz0UJmkICQRm1xUrElD8hiM9c3fcjZRShzWgeX8dcpxxoXnI3Bc8vQsEYzI
         GYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442955; x=1706047755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsxRs5wDbOrFFOE8V+8nbOEqjxePqs48kZcrUQVgITo=;
        b=iU9nrLr1YsY3697Hh9LZHAR/Kx5++J/mfPxwSasC7hy6ge3d0vVfXSZ89vI9cNWjCp
         XRUZnrciHEklITvu/X7CLlx0mopPfvUSq6nPmHcc72sVVLKqVYXoTxuh4tOb+IcP5pln
         ++lYjxfR/iLCqhKQqFDaeU22Snhl33zFY15qy9oAtdt18zFOP44z/YhYFtNAuE9cKBpz
         4BlIM9SvkGzJdaun/bX+hxy8S9NFqG9RSTXb483XTQ5+vBu5e9LN4JD0DxxrwjtTqDIv
         CoqAf2ef83fgFYgXY1BnLTiNdrQLZli3yVOVAvrMKx0V45MAjqEXreM2ilnKZ4p7pOLw
         q9Ng==
X-Gm-Message-State: AOJu0YyJ7TqYF+n/xxKTcfQd8k+a72hlyqfPCXTpxPrbo/ZNee7AqJiv
	TAqMoU3ZPgi5AzRxOdp8J67umAlvARkio3qxMD7QTJgEQyjYuA==
X-Google-Smtp-Source: AGHT+IEQ6RdBNKEIwzl+dp3COE+KGupuPh6ohazNLQ200d9EuUl6UtkVo3YniQ+K9SfHMOC5i2yu7A==
X-Received: by 2002:ac8:5806:0:b0:42a:7e0:35dd with SMTP id g6-20020ac85806000000b0042a07e035ddmr1218856qtg.129.1705442955541;
        Tue, 16 Jan 2024 14:09:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gd19-20020a05622a5c1300b004282dc56470sm5207799qtb.15.2024.01.16.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:15 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 04/17] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <0cee8078d42ffccc410588a14ff184edbe07b7d9.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

From: Jonathan Tan <jonathantanmy@google.com>

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.43.0.334.gd4dbce1db5.dirty

