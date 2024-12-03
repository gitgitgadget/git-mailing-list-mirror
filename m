Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EC1F6692
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237052; cv=none; b=jFiBd8o/+FZV/M7qkbiJVBuSv4JTym2OXIikl7tqgDb7Jxr0Xb83jvJkCSvYUbwnygOAdNxOHjCJuChIOpB/AcIHEh8AlVpVz9CGDPs4vDLN8obEmBZr977G11WZO99RFmrbzkfdJ4JfjiSUZwgtupCcc5djKngMM3Cpk2orZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237052; c=relaxed/simple;
	bh=j86S/RLH+cWP4IGrSMNX054uSczgu7v+d8f1c78xHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtHeDCDTDAGM+d4ST8+ahqAbjKmCeG4XOf+b2R+OGwpHsVOZaCSMa3O3CwFdFMdW0Q3uePZoHwQU3F51Tu6VNiZAfGcUR+4Lr65kk4+Orbbd0nS5A/SVppFCJGGuva60N4SS9D8JFq0AwmkYQAKeSdQfejFJcZiK60alm5gVhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGTFyAEJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGTFyAEJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0e75dd846so3296667a12.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237050; x=1733841850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9p81dAvNuRPaeY2DxAmdIDNS+6HZWgFb5idSynAU6c=;
        b=lGTFyAEJeuz93p8KdWdvmoEImv8NYB1JjpvveLwOgXGvJeB4XygX7FOQS0M4v2ZMZe
         AdwH+ZCDSFBHsCcpYpSI136Hth6voj/PBv3lx6qJeSEpgWL1uDWKMo6sORwcEjpR4Q0j
         i7zOnHxFzgLlBXwIG+n5/B+G8S6Lt6f6ygKg0CYNkVuVChPgddJh0f+qIUQu7I6nOl5Q
         B+GBPP0gOgygOrTS4PAzVOInJ+CB/c1NQPyFOsLAVDe2HDC3dljWryERMos9ZGhomtu/
         EcGXyQvaxbIMgKwGfxVMyND5tnFiRMZKmmGlitvHQXTKvrflmcAtFcpjflAgXhDtL41l
         cfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237050; x=1733841850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9p81dAvNuRPaeY2DxAmdIDNS+6HZWgFb5idSynAU6c=;
        b=O3VurrRQIjbcz4h6CIMi0hH7GjrYPlLo7AEhf6sDlEcm6XTBePArRAjo8CdBBh3jxV
         adpdcHQ/4Jq0aqwo0L8KQcRLrXTuPpP1fIQqdp3CQu37NRHppzDU+o4EhUr4zOLmnXWj
         KwRYh/2OYJmvCH31c+zXw3V4UlgvZMnxD4AgKvJcWAOLaCKrJDyTWmJCctmAsqNt6l2q
         GRvbznVDZgsFWB7c99jwOKEpQNBC1UDs7kIAD0BE1ZOopbhlUmKFNW3Cdme76iRyFne1
         w3M+e12ISFddWX9N7rSxqM9VjjPp/JdHlHFHnRunjw1l9Uhp/dz44SvU4dZ3n7i/g5+a
         fTXw==
X-Gm-Message-State: AOJu0Yx60wCAozozhQNiBn6WX8vKVgUpSpXpzE8CA7TEb/Zum7J2FdAU
	lKLhqxGkEkQKxfMgLCXQGRkfGLe9TR6sWvxh+XUmVwKCXNqXaRqh
X-Gm-Gg: ASbGncvyeeA/gv3oUYas6RzJ+Ckp2P55MaYs9U8EopdGi2k1xADzWfCarFiVV6kOYVs
	vMI2b2ZszeBhLWkDQKQ9S/V8kHQRxcQnxx6sA5A6KjAe6fUkJuBf4LSF8F7czhBXI+LCmXNskXw
	/aZOXYvKf1HcFopjik+6VfCCNqWnzDJNwkajkid0N5O2gvNZYfghuFjPVIov7TcJMUQHd1Thcfs
	RH2kojsjT20+YwC/1Vej6v9/p1wl2SKxxpssK2O4dKI4CFkDxigIe98jw961Eut1ge+
X-Google-Smtp-Source: AGHT+IFgS3YvM6e1ttxfaJlN9Xoc6Zy9Fu47bU7Jbc0rmpC3xj8Nsi9dgnkCf+t50J2ZvHdx1xnRNg==
X-Received: by 2002:a17:906:18b1:b0:aa5:d1d:1e7 with SMTP id a640c23a62f3a-aa5f7f229d8mr226842566b.38.1733237049553;
        Tue, 03 Dec 2024 06:44:09 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v10 03/10] packfile: pass `repository` to static function in the file
Date: Tue,  3 Dec 2024 15:43:57 +0100
Message-ID: <c6acbece4624f6de4008903ff8ff69ee32c6c696.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the static functions in the `packfile.c` access global
variables, which can simply be avoided by passing the `repository`
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
2.47.1

