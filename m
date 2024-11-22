Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB31DE8A7
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270118; cv=none; b=ceheItrMQ0iwRUCZL7JH8N11QIIj5kI9IxOpHRNKRYNgZbvOvcpxnhl0/Hdab3cHos3Qw+9OgtsUhQjwvop4YMOhND83nIkFT1SVLQdsSueRZF7hVGlorkOjPP3FvkwaRyt56Jsl+g0WUz3AppCqA5epYJJHG6fPhx0k5qsMGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270118; c=relaxed/simple;
	bh=qxp0Ozw+zCWuTQo007UtLe+1E8WpD5QWWMUEpKRGJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEnR1nDWCx+LhTU939fIDGccLB3U0CrF1q6VZUOjAhZ2c9Q0GKByAh+b6Svax9Gqfaq8KrDqtXCQRom4ab1GRF3/s5eandF3b4mDcLeuKqpauHHRtUI4WpSc2PsoplzK9Nhw5u9AqEnTRIFbOj+RNlBAZJY1mHO1bSk42mMoEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvMpgUON; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvMpgUON"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so2121539a12.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270115; x=1732874915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=DvMpgUONuhKOXH47QXgMVafX9WaD8r5Fzf4i/dvXTSLIMBGtlZUi4RKPKBFI5FJ0Tj
         JQ7S/wGkSmA/HVe++AWn4SuQjHB/+NX+c7BzYqGy29GlNQTz6GmOvmbQOefosd6Ov5w1
         tImpp1xtPSf3goGNLTdFGkmkOEv7Xb2rw6h7R/qnww13mQbA4C8JLzB8qG1l4c/J4ZQX
         +39tq//n7agiZDqE8lVVGp4sSYEJMDDuu4BBtETkwwPQ5stqK4tKBDN9h34allkmKqYd
         Q812mh6BglSwBsmC0ue8P8xNzQICOyLBw+mVGzbAtwYpHsamK7mdjx2Uu8IfJtngrFa+
         rd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270115; x=1732874915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYwIcge5SJJbrF270tR/At3Pl0zP9dh3BUyu3jDlrIg=;
        b=PbPPnPL4tYMVsvoq7D5VJaNrD1IA4T72iiogTh88aLdGPbN5RUVu4ygEdXIVyd7Qeb
         Lmd2oI/o2v/UUTKOwKMWcUO6hgtApeM6y97eGEnh9007RlppJ92gLcPhkwV6TSt6UO1I
         3WAA9M9qJer8esBb5U1XouNzYE4zTMFn/1X82I8wOJSsk7tI/7T7rA0HNEekbT6hZ/bU
         XaDm782KXwjZMewREwuzkOG65BGFw/m4udTB+5yvNcWDf5on4L4pHz/wcUSlYxLdsDru
         JzBuT5kbVylGp7Phuv6WQvtRnB3TmwxtnTc8x+lkC2OJXSxZCAwiHZfL3H3WF4+Ppn7s
         V0zw==
X-Gm-Message-State: AOJu0YwBQI0sq+ikbcc5bPwmAvaQBVKJxajmPySnc92/P8CaX7sfrsAM
	Vv1QajCeBV9qYsJLhwyN6SfPK1tBC0seDaROy94LPLNd5tqfA9fR
X-Gm-Gg: ASbGncswzpfvH+qC2mFNCfM1fPiywnteZkC0Atnytk9vvaEutQ8vrZ43xGrFPO7x5ti
	Zxd3vR+2UlLzph/0JukIkEr4Z0WZf1TWRpBY7AvOKMRPsapsmodm3D839yc/wYQTgbjVtwdngfy
	BwwGgBGwcBrx7Q3vFE0agXCUVgny/PN2ocjE4V22jBCsT5OhD3jlEY/BXD0dW7bWYguKwqHwsIq
	+7UftHAF8V9itoc8TOppgiXoxbn0ecbvMBOKDfGjByu70uKdtKRzAwJtzs+xOA=
X-Google-Smtp-Source: AGHT+IFSLQozMTPUjv/bA1YJgBygk0P4hWC12UJmwlq6luG8/EE2Uq5/MZVwlgse0Qnk0ZACHX/LmQ==
X-Received: by 2002:a05:6402:1d50:b0:5cf:d3b0:c4a0 with SMTP id 4fb4d7f45d1cf-5d020792b79mr1515760a12.25.1732270114993;
        Fri, 22 Nov 2024 02:08:34 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:34 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 03/10] packfile: pass `repository` to static function in the file
Date: Fri, 22 Nov 2024 11:08:22 +0100
Message-ID: <80632934d135bc1a5cc2fca1a69f398b692a38ce.1732269840.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732269840.git.karthik.188@gmail.com>
References: <cover.1732269840.git.karthik.188@gmail.com>
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

