Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337826A0A7
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424567; cv=none; b=pkh0Wozu4UMNg5yqDZpZDOt9XkyEHApHUmNHFwWnzCVxe1waPJ70TGM12l8qwGQIWaNsVOM12HPj7aT2f44qddl4WTeDSV4LtFiyNYBm4e/aoskefoI6MJ0BdY4tqbLIK5IZ6TVqDcswpL5DpjKrf6xU2gWbCP54gpAwUFvMyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424567; c=relaxed/simple;
	bh=3f+lMJq04aQowP2jsq4kGAR6660OLPj9y2J5B4tgtgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A701qcOkrBpGgi+59UU6gPDz/DRofV5ehLJSAYsGTOhGrOZrNYQvBbvy+xwYbCnTLfKayvsiIjnwLaMFhzFgOlOlz0Hh+LVEO/MulsWYf9xR9nYfw9gRUPDmO0Dl2pM5kpuMfbteceT9IZEYb+gmkOWAHMI8NzsJLYPNtG49P0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNyQgzom; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNyQgzom"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso24899595e9.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424564; x=1770029364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DoF7zxfE4Nmmrbryc5YIeiOe0jqMQZPvi1DCXb69S1A=;
        b=JNyQgzomkliwRFEdmszRIUzoBjgnLUQk6FKsJ9zoXIZve77evbOJcgCVw2rgvVS5+y
         /Smc6+zWNg9RPzDnwj2mxX5zUKVn/oPqxrtmYA/yqcVmILbUNLpOl79T4zWwPmyne84I
         1KDgUIFPmdTryOh7Wcj0yLfzegSwlY83JTk4L0A2s8q3zlLfYqB70ZXH59HzJorI57XC
         EHyJzhNBOQjwv7Ld4t6qNHMyG9lUvjAh/L87f5x6RGss9AhfqNRTkEVM0p51g/eA/EFD
         wQvOpLVcS9VmzDvqnFxjf+oMBQRnhtaFMNrOSIeAf7SnZ8cmFfqvDB0eC8A3EBJMHfhq
         zreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424564; x=1770029364;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoF7zxfE4Nmmrbryc5YIeiOe0jqMQZPvi1DCXb69S1A=;
        b=swdIhq6zcNTmiQ6f2kj+1jcFv9dgLfgePiWS4RKESnofQ5zfLmKmhIFH9hc/jkcpxG
         1VCOOh4SU9b1OnqG0DPyeDXCTzvyeZkgGUjFVJwglkXlKc4DSXhge3h3Pha+KReYG/Vi
         pLQ6UmmrswMv24IwviIGzaywxTfRUrWEVgaaa3Kw88aL+IWZFgKQGVaVCb93LVRdPPwN
         CZERjWho3Xt5LeHKBHy0Fa+vjTrmIg8klUfUi7NaL1sCCGs9lFzQT+zJSGWMueHYi6nh
         OCBYAsjHJ3xZf5pPvbsbJn57bnaPqoo7lZ3kzgV7cjKdX65yGc9sdtAo6Ni8LM7h/JmQ
         20XA==
X-Gm-Message-State: AOJu0YyA+EA9/xqN99yNjM2jXz7f1K/HVwo/ei+n5I2OYN25aNiaNnJJ
	7pKKZsJlkRlERLrQMD8stv4z4OFkmqf2gsxL+vq2iSucLZBzq60Dp+5Jpm/lkoj1
X-Gm-Gg: AZuq6aJaIM7JHapRdgzgA3lVs4hjR1QfW41NJqeYSh4dvJHQqiiLs8I4IB3WoAU7qyn
	D0F+asnuhOwy5BOsxUW2uNJC/BtjGsi2m5aXTivyGj+xVaQglXNHwe+IwM8gEAVQi31t4I4OcmI
	O4IO7+tyrr6hY4E4LcfrdEF8+Q+SWhgSlf9SemBvwh215uX8mAnEo/hzjsNNFlJ7Np+RJtfzH9a
	7/E6KaNsA1CT7T/J71bnB/xCCdCkdhHjeabFo1vHycjnvbgrIfLlcC0Vw47GwT7T8uNlEVgLIJd
	QAKIS/RybMtFkbt/XvN+CW2Xi6Sj7D304UV4FYsGdDsGV6Fvs26+Eab6G+BwYfFC8zQyb4a29lQ
	YcsbxjBN+T3TFa8uJiJcmZ4PQWsghRIjDiJcLtiRkUAdNFpwE6kH3ukYyUb/PkxfDxDKfiwwc+s
	59yRSPHH5mtDYYzvE=
X-Received: by 2002:a05:600c:19cb:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-4805cf67342mr63488805e9.21.1769424564398;
        Mon, 26 Jan 2026 02:49:24 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm30063907f8f.20.2026.01.26.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:49:24 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] xdiff: remove "line_hash" field from xrecord_t
Date: Mon, 26 Jan 2026 10:48:51 +0000
Message-ID: <24a662ac0a939d284cb2370509327a2a81535247.1769424529.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
References: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Prior to commit 6a26019c81 (xdiff: split xrecord_t.ha into line_hash
and minimal_perfect_hash, 2025-11-18) the "ha" field of xrecord_t
initially held the "line_hash" value and once the line had been
interned that field was updated to hold the "minimal_perfect_hash". The
"line_hash" is only used to intern the line so there is no point in
storing it after all the input lines have been interned.

Removing the "line_hash" field from xrecord_t and storing it in
xdlclass_t where it is actually used makes it clearer that it is a
temporary value and it should not be used once we're calculated the
"minimal_perfect_hash". This also reduces the size of xrecord_t by 25%
on 64-bit platforms and 40% on 32-bit platforms. While the struct is
small we create one instance per input line so any saving is welcome.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 12 +++++++-----
 xdiff/xtypes.h   |  1 -
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 34c82e4f8e1..08e5d3f4dfa 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -34,6 +34,7 @@
 #define INVESTIGATE 2
 
 typedef struct s_xdlclass {
+	uint64_t line_hash;
 	struct s_xdlclass *next;
 	xrecord_t rec;
 	long idx;
@@ -92,13 +93,14 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec,
+			       uint64_t line_hash) {
 	size_t hi;
 	xdlclass_t *rcrec;
 
-	hi = XDL_HASHLONG(rec->line_hash, cf->hbits);
+	hi = XDL_HASHLONG(line_hash, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->rec.line_hash == rec->line_hash &&
+		if (rcrec->line_hash == line_hash &&
 				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
 					(const char *)rec->ptr, (long)rec->size, cf->flags))
 			break;
@@ -112,6 +114,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
+		rcrec->line_hash = line_hash;
 		rcrec->rec = *rec;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
@@ -158,8 +161,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
 			crec->size = cur - prev;
-			crec->line_hash = hav;
-			if (xdl_classify_record(pass, cf, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec, hav) < 0)
 				goto abort;
 		}
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 979586f20a6..50aee779be3 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -41,7 +41,6 @@ typedef struct s_chastore {
 typedef struct s_xrecord {
 	uint8_t const *ptr;
 	size_t size;
-	uint64_t line_hash;
 	size_t minimal_perfect_hash;
 } xrecord_t;
 
-- 
2.52.0.362.g884e03848a9

