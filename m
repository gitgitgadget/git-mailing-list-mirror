Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC8C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A2A206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN5qTR43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLIUry (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43256 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLIUrx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so17664294wre.10
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=nN5qTR43O7A7ycMNH5oaxA34tkT+OMiWWawKvzV2eesD+QSJtR4D6R28iA+Og6rB/v
         MrdJbsN7kT+Fn1IlGb/NA7YtIXLF96IwX4qpEd+/XcLnZpELJtcxWjKJK8swqhjatTZr
         DMcaHZjuKXsa9vhLjrjWsqcREOIS3ZkkrcehQhmDtoFrtpTCE2L4djBAelv9sNXxuijA
         xn59cXPPlWcSrHopj6uw+0eCVpKnAq2BsUuoKAAnNAOqhYXWe/XoiKuU+ycz6NqdsD0y
         ImkzzRQrxiBf9vGM/k/UPT1mSlfNKzhQJ1VEvSRmYR2kB22FT65Aaaqs8vaOfKho9jc6
         d7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=DzyAQIIWHQEu47kH+4PW45RP/rYrcvQHoaeuYKlwsN7ahDZ9daqVd50TM74wFWHl06
         Z5fwj0yTV0HF0gCZpqFrgt3NGZwBI5YIi6lQ9ohqof3EjJZOaczhm+PM67ghKwYufWpN
         NMytDnll8+S01uiMQzazr1F8OkbAj+mtf3/kbLsqXDKHllEWPIUuMM1zXTUA1x6rO6vB
         nISIKhJjpikUGlajTbEFEn1Uy9Z80ShfeKDpJAVwQBTTbiwIojGAwAabb/j7QIfRZD2S
         I4EtrcvMbdT2LPmuM1lSIfCTzvqfH5M965BgYYSt0STedO1BDWOSquBlqgJcUxBv/Yly
         +viA==
X-Gm-Message-State: APjAAAUGp6nYJGwh0buxWZcvMyBIsuw9MFYv312+TzRZp1dpeNa9xXdf
        KChuuq0E+BPAZV+G70ADWGKSxpDl
X-Google-Smtp-Source: APXvYqxToTJ2VS/lekdhYsFU1qmA1Lr7UJvj41s/16M6BIUevit0K7MA7whQEh2b0KEP1sSWqB2eYw==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr4206882wrs.113.1575924470458;
        Mon, 09 Dec 2019 12:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s65sm566690wmf.48.2019.12.09.12.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:50 -0800 (PST)
Message-Id: <738d9ae4c9ca0e54502b9ef606e2fc8dba9a94e1.1575924465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:42 +0000
Subject: [PATCH 5/8] dir: break part of read_directory_recursive() out for
 reuse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Create an add_path_to_appropriate_result_list() function from the code
at the end of read_directory_recursive() so we can use it elsewhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 60 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index 517a569e10..645b44ea64 100644
--- a/dir.c
+++ b/dir.c
@@ -1932,6 +1932,40 @@ static void close_cached_dir(struct cached_dir *cdir)
 	}
 }
 
+static void add_path_to_appropriate_result_list(struct dir_struct *dir,
+	struct untracked_cache_dir *untracked,
+	struct cached_dir *cdir,
+	struct index_state *istate,
+	struct strbuf *path,
+	int baselen,
+	const struct pathspec *pathspec,
+	enum path_treatment state)
+{
+	/* add the path to the appropriate result list */
+	switch (state) {
+	case path_excluded:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			dir_add_name(dir, istate, path->buf, path->len);
+		else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			((dir->flags & DIR_COLLECT_IGNORED) &&
+			exclude_matches_pathspec(path->buf, path->len,
+						 pathspec)))
+			dir_add_ignored(dir, istate, path->buf, path->len);
+		break;
+
+	case path_untracked:
+		if (dir->flags & DIR_SHOW_IGNORED)
+			break;
+		dir_add_name(dir, istate, path->buf, path->len);
+		if (cdir->fdir)
+			add_untracked(untracked, path->buf + baselen);
+		break;
+
+	default:
+		break;
+	}
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -2035,29 +2069,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			continue;
 		}
 
-		/* add the path to the appropriate result list */
-		switch (state) {
-		case path_excluded:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				dir_add_name(dir, istate, path.buf, path.len);
-			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
-				((dir->flags & DIR_COLLECT_IGNORED) &&
-				exclude_matches_pathspec(path.buf, path.len,
-							 pathspec)))
-				dir_add_ignored(dir, istate, path.buf, path.len);
-			break;
-
-		case path_untracked:
-			if (dir->flags & DIR_SHOW_IGNORED)
-				break;
-			dir_add_name(dir, istate, path.buf, path.len);
-			if (cdir.fdir)
-				add_untracked(untracked, path.buf + baselen);
-			break;
-
-		default:
-			break;
-		}
+		add_path_to_appropriate_result_list(dir, untracked, &cdir,
+						    istate, &path, baselen,
+						    pathspec, state);
 	}
 	close_cached_dir(&cdir);
  out:
-- 
gitgitgadget

