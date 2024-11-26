Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174A1CCB50
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618670; cv=none; b=C/owCs2DE63UNAXEh2aKdYXeIzzWuPQxjVEu9/RSVUdcB2mD0UcaEPFTTV/5v3JMjGg9YS1vCREIe5zsrTdZMi2ZB2Rt0p9Zcf2xBkj5qUm9flGgeBnhDmgy8bYcF9ATx7Z+mG6z5tVgeNBFom6vZzO8pML18t9fl8BrOgQoGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618670; c=relaxed/simple;
	bh=qxp0Ozw+zCWuTQo007UtLe+1E8WpD5QWWMUEpKRGJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ9kJJEiNTh319FT3kHZNjB+uyczYd4gRLXdr4ZEEDBEI3UBO8EVMMwZuORNmMR7AlEMHIcm00y4k/6+nFho5lXkZum+vjrZmHxv7zC3b/0v2sibwoA4D1+UwLNR+oAiLwX7MMw3uJEdu8vGoYWt2oXKVYA665ZekBiSoMZf4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnPmz8pr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnPmz8pr"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso764788e87.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618666; x=1733223466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=MnPmz8pr86GYl0HTln6YLSULnaUwWRhvAGM/MDI49uwTcKkr+wv7ZOXMi+hsGWlQIn
         YdzdPEz+6PGo2z1tzrm+Vswyry4kuQ5yUyzais9wbLNx1Fc6T5y9kV0rw/FfDGVPU80Y
         0txMNZ3O0GOF12pqWULLRDn9tt9QoRWvQWwkBoQ531Jkpy8MsCsox+Bm7p7GRW/MlWeC
         CApDEU2plHWJe27/tUkXl85V6jcFS379adywEyagfRrT1fWH6SK42c3gf1ujBsEyaQZh
         D6bL2TTubLaBo4NFIH+keWlvtwzkeveM0e8N+YqNxZPFmXjdLJ+5LxpG+Kh0bIlQ+ZsX
         +h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618666; x=1733223466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=b3fnNek1Uk7IJ2TXrKZ2iIQf0VQBKNI3sYs7RiyTUIrrFAd3yTPVqE9m+xh3fi8Zgc
         bCfsfu5AMKtp7ZBy5zusdDn0/UTvKOQF8BjVA9r1PEtcLZUBt/I5OLw29OpvZloZjSrX
         Ty0SHS4mjlJCpLI+IwPfxe0TavDUkxOZpxb9CTdPLESHn6csj1s/fMaEqm/zAquhnfGp
         qnbjkZMzhkGw6HWfNn/yzY+6WuJmHjuzfMQ+i9PlQ6C9V9l8VHufJtBHu/u1pOwyAl6U
         /tEK9Io16Ozj66DI1iIJqaUis2hNafGT80szxoonPXztCAvjPCqFLD2VcOY1VJmt6UXx
         8L8w==
X-Gm-Message-State: AOJu0YwKH0O1o5HLqqPYRNEMgZZRkILpYVFaqOlD8mTBtVzwffbgo12m
	VVKPvdgK0jpM38Leyyf4AIrc9btu4HtqsXxpTcxW7KjHcBcv61Vz
X-Gm-Gg: ASbGncvunxbACVVZ6nZQDA6ER4o3YvFqee+p4be5AtXAo+sTjChNQ6CtPIhkyx79klC
	LkRhCVU/MRKdRtd0jRBZW3FGkJHJUOcHFiW5+eWY4VbqiArrgqjhe28JpgUmEvlLtky6OMP8Ah7
	+JQdn5b2yWngOKHr9kpGR/EIZPQVJTInCCUVSrOyBwEGXbqYMd+seQrBPfZ0rpoyqzGRAwZ/aTE
	ANS7UgYDkJbALn47HoRiCcpFbrtOFU8WaxnR6323wzLnDJ6q/ZBeb+dq0AvZbQ=
X-Google-Smtp-Source: AGHT+IGvMaS80tX3KuRGuK3VDWf4pvxg593CQBz/GxrwiTVV763rYCJddcNRPiBiJaiknjVOzisutQ==
X-Received: by 2002:a05:6512:a82:b0:53d:dd09:124a with SMTP id 2adb3069b0e04-53ddd0913a6mr5723559e87.8.1732618666045;
        Tue, 26 Nov 2024 02:57:46 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm587461366b.187.2024.11.26.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:57:45 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v9 03/10] packfile: pass `repository` to static function in the file
Date: Tue, 26 Nov 2024 11:57:34 +0100
Message-ID: <80632934d135bc1a5cc2fca1a69f398b692a38ce.1732618495.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
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

