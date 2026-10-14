Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9555C30C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992445; cv=none; b=NOQa4rQYbMW+fAFmVWOpn2Ah1jnhJ5vMOIwkleF5fnErtj+qi83/+chOqcgNU7c7qtKBHJtD53LK7TkkvXx8UGXp9kNpnjuIlO9w5HCDUM1SBRMfLdEyPHwUt5tHvH2Agx106YNLEX1dsnm4cihkmwUAhH/6ja6doeIBTr9YE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992445; c=relaxed/simple;
	bh=lk9qXvv4PT819OuBV0eqh3antDrodxoQ5SIXNS56WbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZVbYwrBrPLNE2zf6YWk02MVJk7ZZ+8v19geN161sOinQPiDcVtmmqmH7tuIx3HnNBkHIwi2osFX9cn2L1ISd+aLQ125qv9nNOz6vp87RDgDIZgj4PRUSZvZqY3AOb8ABsMuhrinOEFLF6qo38bPSQX8rbZqcA597XqavNejfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPASd4OJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPASd4OJ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48afe75f055so595600f8f.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992440; x=1792597240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pvNHNdRI5EkmShU7D+RsThJy8kIg3Q2XYYL/WAWTiDk=;
        b=qPASd4OJDTWgGpWsViizuNcBj0fjsuwsM46q/GIRzENp76Yjqoqaup8KqUNailrHMx
         1d7ji/BSTRfdpm1VDA46LAUByi/1WmiNz/kktTRxZC3vC0h9N5+CdWv3HAk1dw74BbYg
         ycCTqYohVQ0NZjj8hkO91cNGQC9QqW5vygbg2Taoca44jmQKURR+InnYpxj3riQeqPMq
         wocRlx6MiRHBSbyEEieeevjHbSs2BVkyKAltlDwqqHBdZKg5Vq48G6enq8a4vqoMprw5
         /4gsgGtSp9taZuSTg7yVIpiiPkdQltq3LySJXR4aGt0TeqpSBhlq6s5jDmRvnXXMMckV
         5nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992440; x=1792597240;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvNHNdRI5EkmShU7D+RsThJy8kIg3Q2XYYL/WAWTiDk=;
        b=vwKijf7Z/VIwMsW6hC0LZKtXDNCOp8UB/j4ffH/MDAdIEyn9HIS3WQhoawfToy20JY
         aZVuQmgRJY3TvEQNbGuCd8bq83Keyrep/ANrOadulxe3OBv9aO2GIDA2RkAiWH6zftU0
         jJK13o/Yh5GtcEdxhxfuyX6NqSHarkAfA0gSaUXop5CU5jWDPqGTv6hXbxyg1g9lkLRl
         NhkizNcyvJ0hYL4XnKqFUJFITi1C+SYPnnyYxNSPx3IcFl5YvgLRe2Ey+ZgSHxVz6/8l
         EV2SH4QFibwkc9/K5D/KQl8by7Ze85RRb9k8W5Y6+hWrguLtoNCkrefPveIzNAaJKC3O
         OXvw==
X-Gm-Message-State: AFq9FYKVjA8Y1gV0F99mOwCcZbI+trnjncRaxjxLkCVhrJlpjs/yxAIQ
	vuOIRCX8qeCN+Au29b4e+NRMxO6rWuVUC4g/bk7jgU2TiD3AlgvCnAqZOWUjvg==
X-Gm-Gg: AYBFou2X2HpqhSMJ7c/e/QCwbNobdquSt4fo070WW+Vdm3HtrDCuTrlfFglS6xnM6+R
	chelP0XH+rhFfzBb/4TVmN0TE3nL47sPVlSOVZsz211suhkLIXcmOZYoYPqfpecewsOyIrVE+oD
	QzdEzWCqkxN1h2SyvrQX2tm4oRRKi47T7nAgSQGqo27RKoHTwWwZ+qbpEHcxYnTYxFFd0Dq+9yV
	GRuAKW8bwy5PjwDslc4ds2Hk7S/xRF3Q1kpcUGOWRUotQsq3PqvfL0ALDJNcglqfdmNFWiSaKC5
	6HRvphydwQqzS4Tfsjm+/h1hwDsAFNB7YiEKSMe2Xol9tLUu1P/8OPm+AWiPxDIE/RScrdVCT+0
	mb7kcIHp+kQWyNmu81y1BJgzSIejcG3XKSNIq3LvjT/qr873K4RLE02+hD65Poi4I1HLhjB9DNA
	jYmUgrM011zDuvXHm2Rybf6F39DWOrccuKS7pMQUlYwDRhjC5I2Z4DnN5OVYLwLosby47lO4vk5
	Hu4N69FAwlZ
X-Received: by 2002:a05:6000:248a:b0:48a:f354:aefe with SMTP id ffacd0b85a97d-48dbacdef01mr34195927f8f.39.1791992439732;
        Wed, 14 Oct 2026 08:40:39 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:39 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/7] stash push: avoid duplicate calls to preload_index()
Date: Wed, 14 Oct 2026 16:40:16 +0100
Message-ID: <6ca7e1c567a9e31d6668e59df81cd793e2b3411e.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

do_stash_push() needs to load the index so it can check that any
pathspec argument refers to tracked files. To do that it calls
repo_read_index_preload() which does not just load the index, it also
calls preload_index() which lstat()s all the files to see which ones
are up-to-date. do_create_stash() then calls repo_read_index_preload()
for a second time which lstat()s all the changed paths again and then
calls repo_refresh_and_write_index() which invokes preload_index() for a
third time. So we're preloading the index three times when we only need
to do it once. Avoid this by making the callers of do_create_stash()
responsible for reading the index and use repo_read_index() rather
than repo_read_index_preload(). This saves two lstat() calls per
changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index aec79ed473..b4fe7465e4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1526,7 +1526,6 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 
 	prepare_fallback_ident("git stash", "git@stash");
 
-	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL) < 0) {
 		ret = error(_("could not write index"));
@@ -1662,6 +1661,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 
 	memset(&ps, 0, sizeof(ps));
 
+	repo_read_index(the_repository);
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
 	if (ret == CREATE_SUCCESS)
@@ -1707,7 +1707,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
-	repo_read_index_preload(the_repository, NULL, 0);
+	repo_read_index(the_repository);
 	if (!include_untracked && ps->nr) {
 		char *ps_matched = xcalloc(ps->nr, 1);
 
-- 
2.56.0.134.g299a3c16181

