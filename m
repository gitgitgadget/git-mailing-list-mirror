Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F3DC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E565F2467F
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNABYYbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLSV2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:28:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36302 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfLSV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 16:28:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so6311975edp.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 13:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=nNABYYbE3+GPc7LyEEx8auhXBi5tEhWgGacE85cvuUVvSOD6z7cSVNBydsAC9Y2eyT
         87RdCwjH3IoXO0DzwZTFpiUleCLrF9JMtyVKAJKaNNxZvUQPBQqpbLeXdnTd6uT3qARm
         FMV479Sy7ec3qazzLGoFLIpzSbd+GHCzA2BjvUTF84PXg7fP5jlHvaLXATBth40Xae5A
         x5uX4ZBz+GkbbONy5FWebRjOJj8fSXRbOEoOQuEJ3qmTHMuUdBNc2JJCoGVdifQby9PZ
         1kVAkAFZFIUyANZ/dsT5G+6TUT0KdzanjxEleS2bCwChNURFWwlGWBv+hKeERTsyUYaP
         gIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+CgvyKrM09apU1qkOsJft1P4o4wqjmDRS+ywvTmG7xU=;
        b=Qzdtr7ZoTT/vHd8tx/XnrlCt2ggv4LW7Ir1gZpG6BtP8DxUvizPbH3RLHck1q/E0SM
         sRFrLvsCbFqk+fj9Dz5yBrrTtn+WU39D2nH+KvKIS2PPxpBiq0QI0CHoDuafGjHIE3BM
         3L4M28zh6anTkytPrj4IncCu4jjDd8YYgyXjnsQasY7WGTcBO65wM9ptmqCg8dMOsX9o
         8QBh8INeVK6IDTAoscmgi8wsdueocp8iTUrPhHXzePdp6Xa+/QWv9heOL5p7M8W6FyDw
         iNHoY6HIFg5scFL3Wm/GZ1PR9+vLc25g8MrfkumWc2cvlrpz/WuTuIqr1s8sIxcFLqtW
         T4hg==
X-Gm-Message-State: APjAAAUB2qpVjoxNtdiRBDRFZdk69qwvGGCYBWN4ndHZ9dPsputKOxju
        UuGQAUWrJ+Ckw26DNk85xBhfvgIQ
X-Google-Smtp-Source: APXvYqyJH/bzIs9V9huzy1fioUZ9do4wXP0hBemQENpbXP9a2xYYBOad5r0ySHvxL+2N0ptJyOVWhQ==
X-Received: by 2002:a17:906:4749:: with SMTP id j9mr12274487ejs.132.1576790912464;
        Thu, 19 Dec 2019 13:28:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm763440ejc.35.2019.12.19.13.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 13:28:32 -0800 (PST)
Message-Id: <d2f5623bd71352f3adbf12f211dbae5820b33666.1576790906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
References: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <pull.676.v5.git.git.1576790906.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 21:28:23 +0000
Subject: [PATCH v5 5/8] dir: break part of read_directory_recursive() out for
 reuse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
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

