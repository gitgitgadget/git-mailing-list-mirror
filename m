Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EDF1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933400AbeBLJui (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:38 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:47047 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933377AbeBLJud (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:33 -0500
Received: by mail-io0-f194.google.com with SMTP id k80so5265093ioe.13
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szJDvLAmdbpl6KxkX3KFBHIbVlHuu8EsXhO3lv9krHw=;
        b=bBsvRokW3pbUwYyWwyRGlV5XwhJXpLb/m178bAPmynA69aqvsXfAGswvh4+6vkjf0G
         zr9OfA1eUkpsU5iSHPiW+Xtz6553i3tIOhv+e3O0fP5y4dHxNKQiddsmq7o5XTNvWTgI
         /43DgbOjAjpre/kIBcX3qql19piRZoWCRFtHzt57O4C1eEij0IS+d7S03vXPEdodu3oL
         kKoPcIlK23uTqTOCD39shsAXYONrKqoPspbLwiRiCb+/o3FIVrezWvzXe//yI1elpatn
         nimHypd+L3++xzPB5qjJ5WaRHu2WtM78Bd7+MpZzkuhU3fXEScpKAMKJh0ZfZA9tzZxA
         qmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szJDvLAmdbpl6KxkX3KFBHIbVlHuu8EsXhO3lv9krHw=;
        b=LfuSVRN7Wr5xQxoJ1nlKlOvlvBck2LSw7s8Go7ZQcGJjC8cAaK6VeAji85og3x6UX8
         MbhyrPcWHqpXUNF80i41I187HuCnFEtmNgVIydXkc/dK+P+kuL/J1/xjAUGqygGsFB15
         QsOcu78r6+yaw3bHWGxkIP/CN4k40YpyvGNygFJaoJDE7TT7sIVtswISakbtg+23syO8
         73rTsu+Wi7eOBOrsCxOiSQt5+9C44EzHPBEMl4CjxrIS2ZI5zp3XFV0OPs7AjLBFFuc9
         sK2fMjGbrqNfdswuwveu2FpcOYGlIz6ugchPDwl+0ixi/HHlUJlui4Q7MoV5jO+Hlx9h
         GkUg==
X-Gm-Message-State: APf1xPBmiakolDM+bw/wYuj3mXqRQYI1JYjDvZjXtzdvOQIfO6ax0dJ9
        +cSK0Y8ggm1N63DF7gsSpbYu/Q==
X-Google-Smtp-Source: AH8x2248fmC+OJ7NQreb0FercbJIrJN+Ja+65rumnRWXhrz+leYdw7mloHCamiyXEoTfljCz65RCGw==
X-Received: by 10.107.28.201 with SMTP id c192mr11915357ioc.26.1518429032959;
        Mon, 12 Feb 2018 01:50:32 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id y91sm10171336ioi.62.2018.02.12.01.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:50:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 5/7] worktree move: refuse to move worktrees with submodules
Date:   Mon, 12 Feb 2018 16:49:38 +0700
Message-Id: <20180212094940.23834-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180212094940.23834-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules contains .git files with relative paths. After a worktree
move, these files need to be updated or they may point to nowhere.

This is a bandage patch to make sure "worktree move" don't break
people's worktrees by accident. When .git file update code is in
place, this validate_no_submodules() could be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt |  2 +-
 builtin/worktree.c             | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 4fa1dd3a48..e6764ee8e0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -79,7 +79,7 @@ with `--reason`.
 move::
 
 Move a working tree to a new location. Note that the main working tree
-cannot be moved.
+or linked working trees containing submodules cannot be moved.
 
 prune::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6fe41313c9..4789cebe11 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -606,6 +606,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = { NULL };
+	int i, found_submodules = 0;
+
+	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
+		for (i = 0; i < istate.cache_nr; i++) {
+			struct cache_entry *ce = istate.cache[i];
+
+			if (S_ISGITLINK(ce->ce_mode)) {
+				found_submodules = 1;
+				break;
+			}
+		}
+	}
+	discard_index(&istate);
+
+	if (found_submodules)
+		die(_("working trees containing submodules cannot be moved"));
+}
+
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -643,6 +664,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), dst.buf);
 
+	validate_no_submodules(wt);
+
 	reason = is_worktree_locked(wt);
 	if (reason) {
 		if (*reason)
-- 
2.16.1.399.g632f88eed1

