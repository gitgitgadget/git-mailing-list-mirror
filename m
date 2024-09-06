Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E21D554
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651995; cv=none; b=GKdpgKrBfG5XxRHZPDrX2sWvxveExiE/iE9NWBU+V5S6gUl9zPjZa+JddVHPhO6hd/G9EYb/QA3BE53lHacmTev3186Ug717kFWmlD56ancpz/5wDU/y/vR5nzj7MNl5Hs9W0B0MFuGPXV127rPv9GhcPJa35IpyYA+tV1agM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651995; c=relaxed/simple;
	bh=52xnQ0mERdPyf52nWx8znCGGXcH1VWXywgo0DOYbK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js1Lx82dt530Yj2FrPTkZfM3dTnrQWwlKzGVaY8xveepfEYG1xsaYMKgCILAGzwlxG1SXAaCzkYwfBdcwqhvsb3fliLtjEBai2kyt2YocCs/M8x10DdU77mpmXH/rXEP03VMrkR2fFVJF3/QZPsraMgv2z7D9gq0TA8I7SjgZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QsKHeTGk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QsKHeTGk"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso2848908276.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651993; x=1726256793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1t1A0Fv5jfIbdu5SYL/DVcAH9CI/7kXlCBnYJscFfnY=;
        b=QsKHeTGkHseksV0noiQqeq6lKcka/eJuRbsKd7j5ezTxG4yGO4K+wfxald2nlpJR2n
         h0Yp1AcrNL1C2yrcFGgC19dVB0sM9hMlVkbQHjSOva5KqyQZRvE2A9c+Losw34UxDQ61
         RdpT52/pn7wdW8oE5da9IX5V2gFDh/0X7YCzXNdKAXH4TDqrtai9bAGCRnLD/kClZ5Ws
         7fBL/g987HJV6KhryJxmHQl3WeZoFXR5s9X9MuwLVTxJe9FdJ16VMBZa3+bWjmyCeRoh
         TrejG7qxTfPmGQ0AVLVxgrCaOMPa3H4eJPaX85WbH74+zMn37sihSgUAl+3mzr7Ogkt0
         Q5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651993; x=1726256793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t1A0Fv5jfIbdu5SYL/DVcAH9CI/7kXlCBnYJscFfnY=;
        b=h5MWTcLQk5SN1kp4732fcLwf6533i/Q5rXO9VstpZBqWr4ack2tIxzgyMWTJVwcQBs
         4gpT4tnLqBtLsx6XKhKYrak7WI3Lt9VgsG/QqeLUaYM1JYaSj3ERgDTONQRM+eb9eKtK
         YJLn+TK2vNpeTfjjleaHTOHtrHqaupDlKi0ldoaxzmTFFDKlZZDPYfmjTLWnM8fZMpjl
         UOZFTZRN2h4zBywc7F0+fmw2lip5EvYEHeeH+nHmUwmFsiKKa2tIxS8om2UZAx3QJqjo
         wIQxS0yQ25/Rr1/mCI09J8Q1+AKivj29VKEYMpCUx1XpamLTUqjf0xm9Di/PQ6bVyAf5
         +LYA==
X-Gm-Message-State: AOJu0YyQpV6bmwgVx1p2PAu+BnkZyMu/YIXzhpqzd+jFWqL8QWYW+vjk
	XpjC8UN6XiitEuZB6oQ29OEXhIMYpZA0A55i17dljtmr8eNvrqqad81PUAvI6iWHOAwdDG8n7yP
	s2jE=
X-Google-Smtp-Source: AGHT+IH1HxdMko5kRgIbHRnLJ4XxDLy09W2exZKnOAeufhVxb4iOi0TRAWkuOkhcgL+mcp6mFmrfhw==
X-Received: by 2002:a05:690c:760a:b0:6b7:f467:e0f5 with SMTP id 00721157ae682-6db442bb283mr29950557b3.9.1725651992796;
        Fri, 06 Sep 2024 12:46:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db5631a093sm1154197b3.22.2024.09.06.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:32 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 9/9] csum-file.c: use fast SHA-1 implementation when
 available
Message-ID: <4018261366fe2de2def2ec6093ccfb51ef768a7b.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

Update hashwrite() and friends to use the fast_-variants of hashing
functions, calling for e.g., "the_hash_algo->fast_update_fn()" instead
of "the_hash_algo->update_fn()".

These callers only use the_hash_algo to produce a checksum, which we
depend on for data integrity, but not for cryptographic purposes, so
these callers are safe to use the fast (and potentially non-collision
detecting) SHA-1 implementation.

To time this, I took a freshly packed copy of linux.git, and ran the
following with and without the OPENSSL_SHA1_FAST=1 build-knob. Both
versions were compiled with -O3:

    $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
    $ valgrind --tool=callgrind ~/src/git/git-pack-objects \
        --revs --stdout --all-progress --use-bitmap-index <in >/dev/null

Without OPENSSL_SHA1_FAST=1 (that is, using the collision-detecting
SHA-1 implementation for both cryptographic and non-cryptographic
purposes), we spend a significant amount of our instruction count in
hashwrite():

    $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
    159,998,868,413 (79.42%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]

, and the resulting "clone" takes 19.219 seconds of wall clock time,
18.94 seconds of user time and 0.28 seconds of system time.

Compiling with OPENSSL_SHA1_FAST=1, we spend ~60% fewer instructions in
hashwrite():

    $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
     59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]

, and generate the resulting "clone" much faster, in only 11.597 seconds
of wall time, 11.37 seconds of user time, and 0.23 seconds of system
time, for a ~40% speed-up.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index bf82ad8f9f5..cb8c39ecf3a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
+			the_hash_algo->fast_update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, the_repository->hash_algo);
 	else
-		the_hash_algo->final_fn(f->buffer, &f->ctx);
+		the_hash_algo->fast_final_fn(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, the_repository->hash_algo);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				the_hash_algo->update_fn(&f->ctx, buf, nr);
+				the_hash_algo->fast_update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -174,7 +174,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->name = name;
 	f->do_crc = 0;
 	f->skip_hash = 0;
-	the_hash_algo->init_fn(&f->ctx);
+	the_hash_algo->fast_init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -208,7 +208,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	the_hash_algo->clone_fn(&checkpoint->ctx, &f->ctx);
+	the_hash_algo->fast_clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -219,7 +219,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
+	the_hash_algo->fast_clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -245,9 +245,9 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 	if (total_len < the_hash_algo->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, data, data_len);
-	the_hash_algo->final_fn(got, &ctx);
+	the_hash_algo->fast_init_fn(&ctx);
+	the_hash_algo->fast_update_fn(&ctx, data, data_len);
+	the_hash_algo->fast_final_fn(got, &ctx);
 
 	return hasheq(got, data + data_len, the_repository->hash_algo);
 }
-- 
2.46.0.430.gca674632b70
