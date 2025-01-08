Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E38202C51
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363689; cv=none; b=Oj4lbJzzmubL8DkxRGWuVbZSXAzWea70k3YNnMuRh62ojdOvmIsVay7RS5SN6VKLlsyMHTUo+fO7Rn7rY2P1G336WgmClam7Fm4Oywd9MtZiGh27pbEFXPsjYbFCUeNHxfG/dRN77r24jwFrHxW3q3bVR+gLwamPe5VXGd3yrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363689; c=relaxed/simple;
	bh=tOa+WdgCtIkciRv1obBIhUD2Qovp2K+ZJmUkBPOtpGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS7Qsvo/hohVHJXLOi0223w6/L3mfHOobMPsC8ZFE/mvAFCch94I+LZvXSjNN4PJwhNmGtLzpPnu6swfwL4y2cQJeuV5c3qi+bKwv2cYfQHn5s8i91k4t1DhVaTzP/j59feCch2ePWJ134L+07nzXrzBi8ZZAIAPosCLchdP+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HPHo7/zg; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HPHo7/zg"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso95309276.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363687; x=1736968487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOhIYN5HqyIukCSx0+tJxmlft7yPAcOE9uzVrjzlCIY=;
        b=HPHo7/zghscGZuVUoItuSM+KFGZIXurS3ok9rUK0cE53mV1QpyM0kvCwfzCbNxJURd
         MuW/Ra8I16SxWxAQzzCMR2MO7XXjvzT0IZM0JKusJypqXfKCyaUYcvMAbb/pCGzwkImd
         nThg+XnRiAul163H1kB26WRnpIhql/0G+z5aBdknrvFyhPCpblI+B4gCJncqxrmlkITV
         7qsvIh+1rlDlkqlsndRzp/DZj/YQVWFtywnmnB9O8hK8h1AcAHR4qVUVHMhxn8nh7oAF
         13raCg52YQL53pEkMrfzQE/Hsss1+5tosFS6Vr021PZsLqayrwwQUcNtTfHh/ON8FkbK
         RiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363687; x=1736968487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOhIYN5HqyIukCSx0+tJxmlft7yPAcOE9uzVrjzlCIY=;
        b=CWzKvaRds8xCqEAQrfG33e0cnakXW51C2rLazUUEot62pwlmRv9C26BZeOwyFmhryM
         RDSjt2ltcZiHPFVuWQ0jnCaNDqgwPJ/dAcVDxAx/r+UagatdjGmPk+7VdkTlMgsW5HC3
         grcnzWzoJ8Lk11cANH/3NaR6J6zDYtgqFBQO9EJNyfSlg+yxKUBsPlAl2DgoKoqR75ZY
         QI1O7LNJjfq9LrGxOqLRFxiC1AEZmHlt8W6l7SmZIlHOwACsKESfaUWv+/eOZlxyIch5
         7INmQUyTERvSzZvOi7s99nE866s8npRByvRXqZPuL7xkWLMCFyeiW5ra/zyTqkNVynfJ
         Nj2A==
X-Gm-Message-State: AOJu0YwQJDHUtNUGAfW/CRAJz5xezxLpO2qf72xhCuFQ16UNQCG9ZgKl
	eJ4N6ioXT3CiizVOupTte6CfnACzBRmCiXPRxmajqGn3vduiP38DA+kj4o+AIqt6J+h1RpYP8tl
	UUEs=
X-Gm-Gg: ASbGncsh50h258cazc8D0OGFi4nHuqpSkQ5bDgH39VNA8tW+DWDAtHPvVQpdFgIF8He
	fnaW4SZpPkC/MbVflBoaZZsImNY4IKekpDyW9GxJyFNOpA0wObr0IP7Y/qjVFTew2rnmGoFLmeD
	pu/PYffXtyVzDWgGdo2w+X4NU11Z4dFesW85oWZ68z7AsH1w2ELvtGhN6uMjpvCj0WjeST0Sntc
	+joGMZzXhbd0G1Ljho6PfI1za6+HXqNfeLMk41jhE5uG5whPsmkztKNRmoqy/8o3dbrune7ZbHt
	HUOVCLpafsByr3UF0IKG7u/hMoAB
X-Google-Smtp-Source: AGHT+IETTZ71r3nf3Hx7GRjUhxcq0fsmR+8vB1hVKTp9Uki4zS1V6/Da5tLZKrvx8Tpar2v6yFL7vQ==
X-Received: by 2002:a05:690c:74c3:b0:6ef:4e42:64d0 with SMTP id 00721157ae682-6f531222ad4mr29783457b3.11.1736363686803;
        Wed, 08 Jan 2025 11:14:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7883a20sm91161747b3.131.2025.01.08.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:46 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/8] csum-file.c: use unsafe_hash_algo()
Message-ID: <2dcc2aa6803cdaad762ec82cd31fc14dd6aca414.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

Instead of calling the unsafe_ hash function variants directly, make use
of the shared 'algop' pointer by initializing it to:

    f->algop = unsafe_hash_algo(the_hash_algo);

, thus making all calls use the unsafe variants directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7a71121e340..ebffc80ef71 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			f->algop->unsafe_update_fn(&f->ctx, f->buffer, offset);
+			f->algop->update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, f->algop);
 	else
-		f->algop->unsafe_final_fn(f->buffer, &f->ctx);
+		f->algop->final_fn(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, f->algop);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				f->algop->unsafe_update_fn(&f->ctx, buf, nr);
+				f->algop->update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -175,8 +175,8 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->do_crc = 0;
 	f->skip_hash = 0;
 
-	f->algop = the_hash_algo;
-	f->algop->unsafe_init_fn(&f->ctx);
+	f->algop = unsafe_hash_algo(the_hash_algo);
+	f->algop->init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -210,7 +210,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	f->algop->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
+	f->algop->clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -221,7 +221,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	f->algop->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
+	f->algop->clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -242,15 +242,15 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	git_hash_ctx ctx;
-	const struct git_hash_algo *algop = the_hash_algo;
+	const struct git_hash_algo *algop = unsafe_hash_algo(the_hash_algo);
 	size_t data_len = total_len - algop->rawsz;
 
 	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	algop->unsafe_init_fn(&ctx);
-	algop->unsafe_update_fn(&ctx, data, data_len);
-	algop->unsafe_final_fn(got, &ctx);
+	algop->init_fn(&ctx);
+	algop->update_fn(&ctx, data, data_len);
+	algop->final_fn(got, &ctx);
 
 	return hasheq(got, data + data_len, algop);
 }
-- 
2.48.0.rc2.33.gaab3d23ed4c

