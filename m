Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E368156228
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653667; cv=none; b=VC+fvyPyzmQr8w+1X1KSBPM6IgWf6WM7fdW9N2/wMm3MT2BlKPoQDicLidRgdW51TAmE55I5Kb6a3wHFPzGRwJ941u15Z8TRMHkiex0x/qF+W9xYCSKeSdSU+rjMPcnuTRj+4b++w46LJ9vi/C9D1E2zE2qdHdaMEYnuXyae2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653667; c=relaxed/simple;
	bh=UQ83yp+q3k6rgPWWWwZQz6/MGKIShYG7JE9HOegkIHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVSSofEnqyVvdG9u67ClVm1rHXXf/RjjT0Wfso9yA+d+flyFhjEFOQWaC8WsuHV8Ye7WxbV2N5npaEICARFXnMcqeNX1GbqPy/WZCIa5ITlwaq5dX1aZduV5PJIweEUdmqgcv0FGB1x15m+FuWLji/2XQYBMW6idT2qYxnA/Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DJvXW+M1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DJvXW+M1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so2001270276.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653665; x=1738258465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSIVIjVOLWmCFq1Gaxvc2NuA2Lkh9yI4zKMvBPhFhFI=;
        b=DJvXW+M15Wg7inaCTMsG4Nf/ul4R8Z85XNbKrJNFp4KMXAuZ3/dKAZ/Plt/2VIXeUk
         GgGzQEQoFFICHOq2479craFrmpiSktJXAPLLoQ2JiugURij0WYCSzbJEwvfOxPS7grfQ
         Y4ZIevN8Fri9CjC+RpCETkuJ4Hf8xXoaDIGf9500hUWTnqVzxv4VQl7wu5APuaWHtPFS
         WNCKOqZ7zf2KeTQ+hV/8joAx4lA3Pr6+ilRw26AgcUl4dKCCOgHMHyzuJZiExXQ1Ht/0
         zyNL8RbrvemAWFoTMdweooQMiyHk1xgxVLnlbKxntdLgl7d2aSx4KjcIENG3+n809ItD
         Lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653665; x=1738258465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSIVIjVOLWmCFq1Gaxvc2NuA2Lkh9yI4zKMvBPhFhFI=;
        b=XZcB/fCjcxH8L5JlwdfGuASCiokzhRxy9oSAoFTyaS1fdRDXmHgiaMppOlUC9oUmuU
         OuTTfY7fvp8cB0V+KiQMNzgG2eSnxvV/zcIL4Lp9PsSOjMZhhNYsEQgb7ugBKnh5tuj2
         26JeN2mCD7xcOW/kDzXGdZCO3QoCsvp57meEDgeRxOaQEWvAXe85A/R8ybHnQpz/b6ru
         4aeeu8i+nCUx5ib9HMDEpYJQtb7qiWMVbZgLWEfVFa/3ngXku39zmlco+4TnkrmOC+Hp
         7UmrFo5yj/AK8twmR5JpCWvxWMlxiLsnIa1HRecJ0H/0R/3GXV6CJRwCBfrO14y5CtDd
         GH+w==
X-Gm-Message-State: AOJu0YzjlbXeBD0ipo6Okmt/jvkvqNrdu8SflBWvs3RvZX3HXz21uJ8J
	hLQZlNuQ8HXepzCzhvD0uXUZQTZyYB9/QrQkmFpzeU6ZpCK5+uRrZccsjoocuJK8cf5OV5Oxu0B
	/EcQ=
X-Gm-Gg: ASbGncvVKpwZvKTCSbh3XV1SPwBV9TDHoZ6T+bllrhUlNVWj8an4MJUnVaDkLgS7znG
	72x4D9NBITc6pjL4Rl7Mn4FQn5VuG/VVEWQE3MZfl2xIsnxHwoLYaEIgFUJOMQjyzLJHIWpJCm8
	aPKqp71ezl8Ng8bHyiwa6nq/XncVJ7pu7forYWw7iuz71hGoWeUt5ScTTKy7+VCMO5Dafr8wHdc
	3a5IfPEl/ytjc7t/ZL/GRObZBoSmZp38dD/DgSBb51x0B+SASkrJEwfrlcLd0ms/Aycfibw3AZ0
	0D0fqSM8bhKfHhHarnmtDS2hCF9eYLPvVucY8Mz+qL/XsrGcOTyP
X-Google-Smtp-Source: AGHT+IH3i4n3dMuIm1W2rBn5X1cS1l3y/17HJaIIVWm25Z9tZ+JjWduDLx4VrmdNNkBCR2Jcq26cuQ==
X-Received: by 2002:a05:690c:2506:b0:6f7:5868:86ea with SMTP id 00721157ae682-6f758688a75mr1967467b3.8.1737653664787;
        Thu, 23 Jan 2025 09:34:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f7578a1cdasm477557b3.53.2025.01.23.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:24 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/8] csum-file: store the hash algorithm as a struct field
Message-ID: <d03f503682f017eefcf8d296cb09da2ef4f7200b.1737653640.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737653640.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737653640.git.me@ttaylorr.com>

Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
and call its _unsafe function variants directly.

Prepare for a future change where we may use a different 'git_hash_algo'
pointer (instead of just relying on 'the_hash_algo' throughout) by
making the 'git_hash_algo' pointer a member of the 'hashfile' structure
itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 20 +++++++++++---------
 csum-file.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 5716016e12e..b28cd047e3f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			the_hash_algo->unsafe_update_fn(&f->ctx, f->buffer, offset);
+			f->algop->unsafe_update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -71,14 +71,14 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	hashflush(f);
 
 	if (f->skip_hash)
-		hashclr(f->buffer, the_repository->hash_algo);
+		hashclr(f->buffer, f->algop);
 	else
-		the_hash_algo->unsafe_final_fn(f->buffer, &f->ctx);
+		f->algop->unsafe_final_fn(f->buffer, &f->ctx);
 
 	if (result)
-		hashcpy(result, f->buffer, the_repository->hash_algo);
+		hashcpy(result, f->buffer, f->algop);
 	if (flags & CSUM_HASH_IN_STREAM)
-		flush(f, f->buffer, the_hash_algo->rawsz);
+		flush(f, f->buffer, f->algop->rawsz);
 	if (flags & CSUM_FSYNC)
 		fsync_component_or_die(component, f->fd, f->name);
 	if (flags & CSUM_CLOSE) {
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				the_hash_algo->unsafe_update_fn(&f->ctx, buf, nr);
+				f->algop->unsafe_update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -174,7 +174,9 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->name = name;
 	f->do_crc = 0;
 	f->skip_hash = 0;
-	the_hash_algo->unsafe_init_fn(&f->ctx);
+
+	f->algop = the_hash_algo;
+	f->algop->unsafe_init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -208,7 +210,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	the_hash_algo->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
+	f->algop->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -219,7 +221,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	the_hash_algo->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
+	f->algop->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
diff --git a/csum-file.h b/csum-file.h
index 7c73da0a40a..2b45f4673a2 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -20,6 +20,7 @@ struct hashfile {
 	size_t buffer_len;
 	unsigned char *buffer;
 	unsigned char *check_buffer;
+	const struct git_hash_algo *algop;
 
 	/**
 	 * If non-zero, skip_hash indicates that we should
-- 
2.48.0.rc2.35.gd215225db14

