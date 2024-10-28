Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D91DDC19
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123036; cv=none; b=ZTowrXZk+Qq8NA4MZ9CjGlcpkeBNGgk9G7aCu52FTWOOLW7Sf8bMs3TPdOMBLSzsG7ZCzttT2qs8T6wIiiuyEs87gqCrToFrmz/XkNl+0f4cv7NvhDmqoi62ANTJQ/caybjOk3rLBnqvnukV9JTxo+DTIUu3Bz8S/Juz6ZFyvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123036; c=relaxed/simple;
	bh=0G5luLv3bh0IMXQILYSNwCvRzAdZi2qi/ZjIXvHHdwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpBHkWns7NA4x+APl9xbTp0BbzYfw16CIuYR3yydWwSbW3JaZqHXcva0YDR/XECnNK+SBgIV6SaJGv+sPgMmk8lBoMM8+GQpgn1/mBfNqYG65egWpgNLjmVHUD2rpdFWEvDeyFHbQGiF0ua8QPOZisi1/la0SWKDkpd97NtvavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmn1zA6E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmn1zA6E"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fb49c64aso7112509e87.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123033; x=1730727833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W25BJHhYpzR0se69lc4edDADkzL8AzcOYDQHN+H7t0w=;
        b=Nmn1zA6E2WJEuDJkysJ+tIEP0gMsMs3RkK7OAMVuD/0cv/eKkKpAtRLNEHOf/nzKra
         VrBcDPWxcHaJoL55+UPsUOHQz9AvRnaidOVpR9f7RDHaL/vFwlUoUc6cWpTcEn8xGHyt
         Gfw9P7dh7VIkow54PppfFvV/wjmPutPa4B9rucWINygS3SwoiZnRzesyXasaAXGd6dQN
         C6qwxJfq2y+H3TlLjrwAWeFOmJQEajXP6fIJP4L7Dtcg2GgYbmbtMz/wIFZLk3sUVJpx
         0IAIPm8WWcJLtJR2gZ3Vp88T4BgWqoW4iWJkXRMF/Psh8/87NZ5QKuaXMOs9W3zd8Xlo
         6lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123033; x=1730727833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W25BJHhYpzR0se69lc4edDADkzL8AzcOYDQHN+H7t0w=;
        b=vISv6uOLzJxTFlnV97Q8RVa0/rD+4VmF4R2b8NGztnFPxzpMAplw2bnDCV2/J1yKdV
         BZdgK4DgIE7+r9pMM45qjqc2W95YGVhyN75z3sALkikzD0Pay0qX+Kimf4zy4WPkOULR
         WhlN1OZE0+KgxDOXNht36kr22h0CecUdtdClSThMcYVgvIiViQqt0dY1YyLk7UVjF1mv
         EtLPO9TfeqoLQYw0mYU9K7tm5jXggJJZMqQ5vSsQ+EoXQcoeFpmNA8dVCjldIZa3Xddv
         XBCxqtKUl4yuNvlqSVPxI0TO4zJUFXCYdHDUT5eFeyMyP0dqfp1BiP9Qp8knZw/iqIwa
         u7Zg==
X-Gm-Message-State: AOJu0YzAnSwzo6Q3N2jBgPPY3T2QlNgqYQvZUx/zHyrpsehp0wz8Drt2
	FmhRxwhE97O/sSS2ncOvIPUwzkXUAoV2Dq9FCd1x37E5J5Gi0MQh9u9inCM9
X-Google-Smtp-Source: AGHT+IGFrSFu72ZhR4irWBUqhxj9k9hCkqhtFBvGrjvGOgkI0Na3Zcgk39Z2gxRGwZ6BpMAWdQJtIA==
X-Received: by 2002:a05:6512:6c5:b0:533:4785:82ab with SMTP id 2adb3069b0e04-53b348ba0e0mr5345483e87.1.1730123032471;
        Mon, 28 Oct 2024 06:43:52 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 3/8] packfile: pass `repository` to static function in the file
Date: Mon, 28 Oct 2024 14:43:41 +0100
Message-ID: <1f8ef580e5a62ac145501c124407f9bf399b5da2.1730122499.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730122499.git.karthik.188@gmail.com>
References: <cover.1730122499.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the static functions in the `packfile.c` access global
variables, which can simply be avoiding by passing the `repository`
struct down to them. Let's do that.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 packfile.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index 9b353db331..cc558f06cc 100644
--- a/packfile.c
+++ b/packfile.c
@@ -460,13 +460,13 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 	*accept_windows_inuse = has_windows_inuse;
 }
 
-static int close_one_pack(void)
+static int close_one_pack(struct repository *repo)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next) {
+	for (p = repo->objects->packed_git; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -555,7 +555,7 @@ static int open_packed_git_1(struct packed_git *p)
 			pack_max_fds = 1;
 	}
 
-	while (pack_max_fds <= pack_open_fds && close_one_pack())
+	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))
 		; /* nothing */
 
 	p->pack_fd = git_open(p->pack_name);
@@ -610,7 +610,8 @@ static int open_packed_git(struct packed_git *p)
 	return -1;
 }
 
-static int in_window(struct pack_window *win, off_t offset)
+static int in_window(struct repository *repo, struct pack_window *win,
+		     off_t offset)
 {
 	/* We must promise at least one full hash after the
 	 * offset is available from this window, otherwise the offset
@@ -620,7 +621,7 @@ static int in_window(struct pack_window *win, off_t offset)
 	 */
 	off_t win_off = win->offset;
 	return win_off <= offset
-		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
+		&& (offset + repo->hash_algo->rawsz) <= (win_off + win->len);
 }
 
 unsigned char *use_pack(struct packed_git *p,
@@ -642,11 +643,11 @@ unsigned char *use_pack(struct packed_git *p,
 	if (offset < 0)
 		die(_("offset before end of packfile (broken .idx?)"));
 
-	if (!win || !in_window(win, offset)) {
+	if (!win || !in_window(p->repo, win, offset)) {
 		if (win)
 			win->inuse_cnt--;
 		for (win = p->windows; win; win = win->next) {
-			if (in_window(win, offset))
+			if (in_window(p->repo, win, offset))
 				break;
 		}
 		if (!win) {
-- 
2.47.0

