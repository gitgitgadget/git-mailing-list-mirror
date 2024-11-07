Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796A212654
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988646; cv=none; b=JRhBbaeZ/aaicmgrxsMsXFT7M6Ht+nBecOm1lKX0mPT1tcE0tlALqGGLXLdd/6Y5TQJxwJwAlnQPFezb9sVJWLpaiBKKeGjLtoOZaoxBNh6GCwn7O/tTkbBIAgDH1GFnk0vXSrvPzSBhtcxlj9nJouEbgI4z3We/Wo5KAMS5rBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988646; c=relaxed/simple;
	bh=qxp0Ozw+zCWuTQo007UtLe+1E8WpD5QWWMUEpKRGJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzP26Wai3FKSNb/VrEJhMMfEKpiP2zy/QH2xfrysk3yT8l02mNGC4H2pNjFqWSSqXCXtUtsxGHewZxrGC4hnTsQx92IHvN7UZkFGqYJaDb9jB8Dv4+GLM7SPFOtGthYCDGz8NvV6fdobPEgENuxwwm7ci2dhjryxVh/WZ5sHSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bqc/bDeo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqc/bDeo"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so1198390a12.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988643; x=1731593443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=Bqc/bDeoJjJpp6OGUXlw38XQ4wqiAfk4joqLMNLL3YHxJWREhOUaW49blm205+/77y
         dkCVRz4XLj8G9amLffMBjm5zKkxsRqHoEES2HHWfTDPgNXF877Zygv5UhjCyij/XjNlX
         +Fcp6d04FL6Siy2iCrFEb6Bal6s+fY8lSdieMhu4NkZQuFRwuj8IE6bnFo4b61QQx8XW
         uLT8f5ZzKLu3PXEI3KrwiScZEbW+Ww5ydYxTrzeXf4yvMmqnjCl2P9uCwzt6sbWg4eBN
         n7bZ3UHZgGM+/AZ013WIacb+7uMlSXuVC2bxW5brZPZe3Cr/tBSlwkh0d0xoeLdMEOPD
         S0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988643; x=1731593443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=OpBXYZ4bMLWqe6fDQnfmB5jk9anBGMwgIwbDuT4p2yZvJZSpsAGl/cYp6nVzGWjQzo
         w07v/xZgzSleVDL9hclYWAxfPmpWJ/n3rKl9dTiRx/IvgzuNcughRFROg53KuuXW45Iw
         b4atYKSCSPKVv8JQJOMmC5w+UeFHZ0PpOJrqHSp9HxrZNO40gXLC3Zsi96lFscx6cc2a
         jmPB2uNMJCGQHz5FDjJnkOgL6muorc5rmYsv1GhbkeMHmvx/qaV6WposbArp4MxQDhIX
         n3QhNdxKRGj/HjHM9cWZpxnyUy9/tnEwdMgOVWFX7+gA5PCLu5ynJM7j6RamF5tuhg3R
         jsJA==
X-Gm-Message-State: AOJu0Yy3Hss6DC4/SVKQjSpCWckpLu2muhLHXOOfgxiF7+CgTKfrrplh
	V/rL766Jq+EI4DGsyD/nN8b2HjY/TOL2hjiaLNgk62p0UFNOj5PlxfMcpY+s
X-Google-Smtp-Source: AGHT+IEelvGRofOSObdjJetdPOlgMFsugGAZUFTihwp7c0J+XDdxOthhIS0r6t3BWKsKPhSmvTu8cw==
X-Received: by 2002:a05:6402:524c:b0:5ce:d438:1e6 with SMTP id 4fb4d7f45d1cf-5ced43802d4mr12637039a12.18.1730988642514;
        Thu, 07 Nov 2024 06:10:42 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ec90sm815424a12.58.2024.11.07.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:10:42 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v6 3/9] packfile: pass `repository` to static function in the file
Date: Thu,  7 Nov 2024 15:10:30 +0100
Message-ID: <167a1f3a111958df7e1841aeae37addcdf04c411.1730976185.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730976185.git.karthik.188@gmail.com>
References: <cover.1730976185.git.karthik.188@gmail.com>
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
index 5bfa1e17c2..c96ebc4c69 100644
--- a/packfile.c
+++ b/packfile.c
@@ -460,13 +460,13 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 	*accept_windows_inuse = has_windows_inuse;
 }
 
-static int close_one_pack(void)
+static int close_one_pack(struct repository *r)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next) {
+	for (p = r->objects->packed_git; p; p = p->next) {
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
+static int in_window(struct repository *r, struct pack_window *win,
+		     off_t offset)
 {
 	/* We must promise at least one full hash after the
 	 * offset is available from this window, otherwise the offset
@@ -620,7 +621,7 @@ static int in_window(struct pack_window *win, off_t offset)
 	 */
 	off_t win_off = win->offset;
 	return win_off <= offset
-		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
+		&& (offset + r->hash_algo->rawsz) <= (win_off + win->len);
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

