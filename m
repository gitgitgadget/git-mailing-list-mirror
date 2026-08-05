Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125053D411A
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954674; cv=none; b=rAR1zQdR8LbDdAu8WgvrgVybRfwx87tfNLoN3Wx7HkjxQY5pIDPbJ15t/m1Bwn6fM/3uUOF/ioRSTKA3An8tDQnVLBHXoN+eZZguJUnbf2/7pQYlvwWVXSqcKmaySTq4ihXlZ4smT5gf8Fufmh4W7wFUcXuRwYuKQu4OtDPN3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954674; c=relaxed/simple;
	bh=9p1d/2ZxlkVC6Ot/WuXtaSnMCGa4vkRpA7CvJs0SmKM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ofasZCtDkKVTO4adbgHe6ZpFSGnYQ7hL9xQ7cLxZDgD5G1rN8Djmik/S0LVmCpgnajyMRWWVrhHz17nd8v4ICzPK4gsXplK1a/YrqWvd1j7rXTmb0K24YZZkZiGw+zOup8CRdAzs7GNwvJfJJdOcJusIX2QZrixhuoUcaRxSScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV717/nW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV717/nW"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so1503464b3a.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954671; x=1786559471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xd/A+hmKtkRs01f13DH9aAmHgIzByKpFOtQFV3wiz/s=;
        b=cV717/nWfpw2nmcE5Kki22fEtgzcdjjl/PPCC+I+Hr+2VB7WuE6BZMOArCJ60QsMi9
         TPYZFYpwf97GO+732apv9OCzeB5/88HRkJOXJgNvjYBaB6PwbCFyi5n5+BYVF83et3db
         2hO5uSJNAcA/BCt2Xhs0o+OOIgNTPchHi7sCbr1SVzj1yr+feNSMNQUndgTBJa3Nb836
         mo/GlLH8OFHVc4DgRiKSqYVhDbvmys5Mu9bL5ClHgdWH8knrq+XO4cofC9t2BPH+YHl7
         TPlLK8U1NNkSEA3ZIgQEPB0AL/c2V8jJQ7TuHrDGGj+kQivaoGmJm7D26V3vkfZjQHFq
         qxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954671; x=1786559471;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xd/A+hmKtkRs01f13DH9aAmHgIzByKpFOtQFV3wiz/s=;
        b=SACYsgM27wjd1nSMmrq7BPmFTPvBUnMm6T8hY4irFC1XJyd39lCx4XJl+yClm5sk54
         Tg7tg2DfyBVd5MdAXRYF69Ul075RdHrUcIlAeB2byF2OjXPhdqJeMHY5Ze6ofNeTgksx
         z0bRyi0tsaWebtQPeV6GLZbkHzuPv2unkuZUAr4xOQSkJDmHsAr8VrbbmbMWYb6CEiol
         +k6k0y82tBP7zLRbczoC6aUMM8Tg0es++d/qUYZGHcklz9Jajtcff/Jv+ydUqxL0qBMa
         zrftZDI8YXdTSRDYD/rOFF/PnSihDYCd3NcT24SY7AOC+NP+NV9B8JwuCyAGCQcSRA/b
         r4Eg==
X-Gm-Message-State: AOJu0Yz/sTzS+DDEURkSfAJLaF9+Bh7hCcYJH/zMUdFc8fzy2n8mHSj1
	kLze5dHX1fdBcaF2yYr2e4E40CkEpA2j3tl67ayRkC4wNp1RvuCyv3NfeDOefA==
X-Gm-Gg: AR+sD11iQVt10RNj+49XjxpHqR1NbjCAWe63OvIo1LRiu7HF8OSVG4X6S6RCdVgsZI3
	+5FrwG0Q1boxXreHd+ggIQTtYIarT5KJ9+4vD4oTvfmjZdPd06fYy/BUdVp4er8tmPjSMdl92+l
	skJj3RU7jWQtFasIdvbnNQ5j2Ltt3h5V6Xb6yMbI4chmUwsis8EP2Nmk/CYNn/CAyWeAEGj5ZGk
	oaQ/29Ai6nD5G/seeaE5G4ymd1rqlFWXuhegtoR5LkavGBJxAFs9hxjTTMDuPOy8nh2ZlZ/+Fqx
	eSFUp4uiH4i6mFYscLUsj1yScuDu/HKZY4YSAPIFB87qsGUeSStuw2nmsRVcoay5M/1Q9+C57VU
	w42KQvBE9FI68dc4zSYjmVub60tUf///Qr9zQQLNv+lCFky7d+WLdc3bbHdxSjdGChIj3ZX4diV
	RZGUDU8RBzaCRUmZq1Acv93BGG0akzzTJyDkgOlhguFQmeLaatkx3X+sVbMJZa1nVzCfzztfvgi
	dx3
X-Received: by 2002:a05:6a00:12d6:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-84f2e031769mr9088760b3a.9.1785954671076;
        Wed, 05 Aug 2026 11:31:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e509866sm1278166b3a.41.2026.08.05.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:10 -0700 (PDT)
Message-Id: <72a74c76bec96812bd7017cb7e8c7bb82132a2a9.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:54 +0000
Subject: [PATCH v2 05/11] last-modified: handle repo_parse_commit() failures
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

last_modified_run() and process_parent() call repo_parse_commit()
without checking the return value at three sites. When a commit
object is corrupt or unavailable (e.g., a shallow clone boundary
or a missing object in a partial clone), the parse fails and the
commit's internal fields (parents, tree, date) are not populated.

The consequences depend on which call site fails:

At line 417 (the main walk loop), c->parents stays NULL after a
failed parse. The parent-walking loop at line 440 simply does not
execute, silently treating the unparsable commit as a root commit.
This produces incorrect "last modified" results: paths changed in
ancestors beyond the corrupt commit are attributed to the wrong
commit or not reported at all.

At line 423 (the --not exclusion walk), n->parents stays NULL,
causing the exclusion walk to stop prematurely. Commits that
should be excluded from the output may be incorrectly included.

At line 293 (process_parent), the parent's tree and parents are
unavailable, so diff operations against it produce wrong results
and the parent's own ancestors are never enqueued for walking.

Skip unparsable commits by checking the return value and
continuing to the next iteration (or returning early in
process_parent). This matches the defensive pattern used in other
revision walkers such as limit_list() and get_revision_internal().

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/last-modified.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 5478182f2e..3846244dfc 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -290,7 +290,8 @@ static void process_parent(struct last_modified *lm,
 {
 	struct bitmap *active_p;
 
-	repo_parse_commit(lm->rev.repo, parent);
+	if (repo_parse_commit(lm->rev.repo, parent))
+		return;
 	active_p = active_paths_for(lm, parent);
 
 	/*
@@ -414,12 +415,14 @@ static int last_modified_run(struct last_modified *lm)
 		 * Otherwise, make sure that 'c' isn't reachable from anything
 		 * in the '--not' queue.
 		 */
-		repo_parse_commit(lm->rev.repo, c);
+		if (repo_parse_commit(lm->rev.repo, c))
+			goto cleanup;
 
 		while ((n = prio_queue_get(&not_queue))) {
 			struct commit_list *np;
 
-			repo_parse_commit(lm->rev.repo, n);
+			if (repo_parse_commit(lm->rev.repo, n))
+				continue;
 
 			for (np = n->parents; np; np = np->next) {
 				if (!(np->item->object.flags & PARENT2)) {
-- 
gitgitgadget

