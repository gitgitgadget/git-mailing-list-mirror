Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26B47772
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958688; cv=none; b=eEOv4JlMQKIZLpTTEweA07DQKtrHIrI2fgCueSyF8Vt8SFqQk6iG4xYGr13pJ43iH92X/lm2846ZQ3dLM5iYIFJ0YKs5IcuE+P6hGTTWKl2hnXYV0zdQ3Ltm4ss1tXMHT+JvNZuGUGeui0ooaFDC1ZJof7Pd3zo+a9ns+bQv80w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958688; c=relaxed/simple;
	bh=7mA99otX3YxgIkm1b3cVceWLhaUOEfbg+9q+Yo9BPX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9cvfB7GBWYccxEmDBenTUiZDHARy2ISuzcEvY5OPxA2lzs0Rlz6LsArRHLoDaTfLRjpnzxXi2eU6uLatf4ZAY2o1Xphuuw6R/4LPD8kGBqL2ivQtDpomUEGC7qCUWPTNK13H4iPYFi8KIujWoYhzSd7RS+I7qCPPkcyywiFKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Hvsp3wqd; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Hvsp3wqd"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66ca536621cso8865837b3.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958685; x=1723563485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXxwZuCPkk2zaVNnmidTRz6Z3l8hHv1xLJRhIL0foJI=;
        b=Hvsp3wqdxVoQV1qjEtPI/b3ckCYQbRFUhvqm3hzm37qwGLz/C2i/pSyesWKsCAWOlk
         iOxjjGFbrW4NO9bfxOmOrR1u9TyGWDkJaGxSbj41mVgE9hoT2HR06G/jxmBkd6JApoG/
         LdvKk2zEzR2+Xz7WmlwCY9d8arWJ8IzqhTtYDec144GEPkBslbQ5bNk6Do7iHj8m1F1t
         rlw6KONSZoxl+019zVxydk0Avxsz0FAL72RWx6u+qiLocJD/FX12PgAo4M84YI1KFcLl
         wg0DoC+YIfg4NRhuyp3knFn6lVSI6QEATcDY+mj0f0PKYATsc505XXDHZ0Rpbxl5xM64
         KMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958685; x=1723563485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXxwZuCPkk2zaVNnmidTRz6Z3l8hHv1xLJRhIL0foJI=;
        b=a0XNDQiZ0OvQMNcTlTp6/6uThoN+9iYjv0Hn0bD56ZPgRkdwGqtmzglXYTz2WJJ13P
         CF0MN6FC6HFVcgGU8Mk30t9gE/a8cd2RUR+tcQUXFoKjbzBpeLNCf0TSAvRNYyYURu29
         /Vp1CKhMa8LzOgAxpfIrCXZj5lwvt7rZN8S1IeEN0SwLeqrNnRJ9riyqs6K5HqH+OFwP
         s+7j3ctwbUJG2Bksa4tVeyI2UJBUdgmNwMPdetGFofUxmGRoughIYGZAp9L/31kwueN4
         8xOB4jRgYBbPXcUIW6+JgNMRWuUNLrxj4Zl7ZkbnFTFmtqe/eyeueZb86JITc5aP4ST9
         nlbQ==
X-Gm-Message-State: AOJu0YyPJvv1oRQq9oalfamaiQvp8pN/SAy9ebJh2VPhblPOoKu8BY1f
	dXww6odccQe3Cw7WzggHuykXcbXO/rNjOBJUB4V+y/wgWMtokDyyX7xMHZm/XAu87g25TRyZ3Ri
	s
X-Google-Smtp-Source: AGHT+IF5yRpZybwCKNx555lfdvlHJkojfN3tadsyOOXBiWfLcmORein8qQDsKH0cJPdrCo1J+Y3xxA==
X-Received: by 2002:a81:a508:0:b0:647:e079:da73 with SMTP id 00721157ae682-6896058a01dmr144995277b3.10.1722958685697;
        Tue, 06 Aug 2024 08:38:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b58c9sm15990047b3.118.2024.08.06.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:38:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:38:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/19] t/t5313-pack-bounds-checks.sh: prepare for
 sub-directories
Message-ID: <09d74f89423e1a3b5486aa9691ffdb8dea2600f6.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Prepare for sub-directories to appear in $GIT_DIR/objects/pack by
adjusting the copy, remove, and chmod invocations to perform their
behavior recursively.

This prepares us for the new $GIT_DIR/objects/pack/multi-pack-index.d
directory which will be added in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5313-pack-bounds-checks.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index ceaa6700a2..86fc73f9fb 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -7,11 +7,11 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 clear_base () {
 	test_when_finished 'restore_base' &&
-	rm -f $base
+	rm -r -f $base
 }
 
 restore_base () {
-	cp base-backup/* .git/objects/pack/
+	cp -r base-backup/* .git/objects/pack/
 }
 
 do_pack () {
@@ -64,9 +64,9 @@ test_expect_success 'set up base packfile and variables' '
 	git commit -m base &&
 	git repack -ad &&
 	base=$(echo .git/objects/pack/*) &&
-	chmod +w $base &&
+	chmod -R +w $base &&
 	mkdir base-backup &&
-	cp $base base-backup/ &&
+	cp -r $base base-backup/ &&
 	object=$(git rev-parse HEAD:file)
 '
 
-- 
2.46.0.46.g406f326d27.dirty

