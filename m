Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8641BDA9A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130038; cv=none; b=cbT/eErYrXA9gx9vTov0RtMYmFv/+FTNEV07zaNOHQc+9JjGdBiYPg4BiLvJ4OYr5s6jCPtFP55xLdzbCWDtzlCGZOvlaAoVtyXpsA21HmLzictQFy8an/0wOcQSYXW4KUQnwyQ4r8IPiqiUhxzQBRPnY7h8mi7SQr+W9q9VBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130038; c=relaxed/simple;
	bh=nTqCG5I2Kxuz9wXTLfKstNvFr2xli3WzyjqEAPCyJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA2/xXtoA/PahCVKt9dGHkub5DaTXPQVmM7c37ExkN+Ne3EFtxhEu9XaVwppUQaQkeXaUKPdCHy+DX+8jQO4hRF1VvTPMsB7xTuxwwlVpssBgciiyfcy9Qu0MBxrtYtV+2bT/Elhmnm7Q9PWPyObQQVtSew1VaYXt2ZzvlN4DAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fWl+jZBd; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fWl+jZBd"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e387afcb162so41987276.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130035; x=1732734835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZtRvh6sEUDE5sp6mm/ozTAlC4pHkNdLqHxtn/vgvEI=;
        b=fWl+jZBdRpaW0n3LE9/1V6xmKg76WClT5DVN3aq4xbEubuGg3cTJJJCok9wIWv9mB0
         XbmavjagL7O81tJgKA/Xvk4n0Rskk9ZZrA4+N3ApfGKa2VSRTV37GWNqxyCprTT3xyOc
         c6EOrlrbQizjaTF9HzpE2CsrPC8WgSmlaFl8dSlOJ8uxyGCREjaD337nKQj3pzyUIZlE
         GR8wkBQMO1iB41LSfemWz4jfGo3eUj1mUwd9vluFgN1veft4+jSEJQ5D7+fP3nOBl73v
         qzHGgFBSQjTkQ+wG83ijCDSGKViyt7vdM7yEm7WJsLr7Kq9hmR1wt/OUqdpRyGQmY7FU
         VAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130035; x=1732734835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZtRvh6sEUDE5sp6mm/ozTAlC4pHkNdLqHxtn/vgvEI=;
        b=S4vCE3PTwHEqh30LqSqF+/J00wnzyogeDZy3JdPayOrDRwhlmUlWFPuDADQa/fewpg
         CuLe2V6CeMh3WXSS51yJT3k3p70TZ0ttmyaiu0QkYSHFwCyqac9xz9HQr+iTVtLS9uLX
         0Y6Tb+c+eyWeEMvbYLEiN2ghTePt8dwv/cVDMZmE19ENpIf7FdTWGeKNmTbqYqK/JybM
         q+r5Ry4EluaZHL7DvypVN16HYaXec22niusrjD1N3VsvfA9oHlY7ifjOkUgn2ItMBat7
         /64lM8y3hCr4eObVkmwEAftATezNvHwZuxdoVijd3MhjL1+82kQ/aezym9KYQHvV2uZa
         iXjg==
X-Gm-Message-State: AOJu0YxmPO93BSSOD8CxWfulX4UJqFuOKXa131hojnZTxL08DTvr0K59
	GyWAEmz69O46iHlf3SBZCFj2/loVMW49tP7CF+CMyWMNYKYoW3SOS6p8XvSIrT40fyBvfAqscL2
	p
X-Gm-Gg: ASbGncvcxOT0tPflFjtGurE/XFSDxmqBw/EU1Lc5AVa95NZhXe6I9NmE6XlArahIo/1
	8i9oB8KRgcaLbtkf0pLekQWbTwSvqYpljrrIfbKZ7JdjgGVdfD8OkeELzhLrwkSlYNT3I1SDG+6
	u8Kb4z5AXa05KTKInT7/obydUJaAQvsgjdoIOmVzz6hadQxIAJcbKCF76GjFe+JO0nnoHg2Sicc
	KeLspwNiMaqiEyO8fjLlbIf2zriVLjgRr/AkIx4BL1IP1tgWoJPwbyCuLEivYM11kAbBeu+5Z25
	qdwMSiFrw3FQEpR8GXo4rw==
X-Google-Smtp-Source: AGHT+IHxLGiRAv5zUl3xsQpZ55kK4UWOW2Smy8KiqEKryMPxvkB8pzDq8A2EQFQ0F5F/+yTdBp24TQ==
X-Received: by 2002:a05:6902:18c2:b0:e30:e1f3:2a9c with SMTP id 3f1490d57ef6-e38cb3cfc5fmr4608063276.0.1732130035198;
        Wed, 20 Nov 2024 11:13:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e7e700csm3302253276.45.2024.11.20.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:13:54 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/6] csum-file.c: use unsafe_hash_algo()
Message-ID: <0d8e12599e2e20ee9b5d1065856a6ddf7aa5f14a.1732130001.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732130001.git.me@ttaylorr.com>

Instead of calling the unsafe_ hash function variants directly, make use
of the shared 'algop' pointer by initializing it to:

    f->algop = unsafe_hash_algo(the_hash_algo);

, thus making all calls use the unsafe variants directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 107bc4c96f9..fd51f5e432e 100644
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
2.47.0.237.gc601277f4c4

