Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3853C1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdJEUzO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38179 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbdJEUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:03 -0400
Received: by mail-qk0-f194.google.com with SMTP id 17so3799766qkq.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CUvb7zB9ahV7o+Znzv1HYfKDWI9TT4ekRx8TQywKnD8=;
        b=bgv78qjDlE+rVjExjkIxSWPxfeTSApOEeduLG8K8FF/JxwaXKRQNDGUE3gM2wKkN/j
         0X62Efp7rg0nXXZ0oSP2Kisr+6WmF2zq9VYFOwkJWHPV/IIAMzx7UvrCfA2O4/7KZc0x
         o6/VO07+pGm24tfg+jBp6THwlHVsfj1v0FDhnt4Z9v6lKODNItMQYYhvWSqTa8+/L67M
         pLaeT1EAgaeUwdEcDmYst2YtzJ7tw3NS2i0kvUXqBZCfWS6VxW/TVunQr/GU3VkhMXq5
         iSpYD4DTLMgv2eWfMnLl5AiIzh8J3oCW4sei6J228cK/qVlJ3pawd9mH/w1UTnwNgpGV
         pqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CUvb7zB9ahV7o+Znzv1HYfKDWI9TT4ekRx8TQywKnD8=;
        b=M+5zlGL+03BodqY6MlROI0Nkm3kwdTuDgDD1U1tL/UerM2vM1PdW3qA8Jt5uixbEbu
         IMBij/jMPduGY+op/TrGue9nGjxyjVjovcnH2u8YAD0ZvTsD4qKQzCyoFigdqvebGgTn
         MaymFvmM+eJQ2a2pbYPkoLRbP+lGOEhbOCNu+ws4t7P52TFvt73doDLZ+rX/KzU8jlhN
         STwuzkrjELn/kk0NijJHGdHKvSQjVlvsZ4xpYP6UMqq+i730KBKtJBvdWflXktJqZuPD
         YqOBRtuHmzBqlT0cFbWrXjFdCARHaJX+bfhqANLDzhurulqDGdOjmukaYbJDecAld7ww
         PcIA==
X-Gm-Message-State: AMCzsaWm8Ozer4kCRmfGkwrpvJKsIDtsrRrdvu1E4gSx9w7TxCgYyFDY
        /Ybr3hmjuKoq1HXobrH6oMESUYkogVA=
X-Google-Smtp-Source: AOwi7QDjaY0MdMpVLUSWd7AiLWGFiADG1dricMWi1fwv9FYWI1o0rLf5xROVBW5Dgo7GgqsOclnShw==
X-Received: by 10.55.79.68 with SMTP id d65mr33322734qkb.110.1507236903174;
        Thu, 05 Oct 2017 13:55:03 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:55:02 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 4/6] Expand support for ignored arguments on status
Date:   Thu,  5 Oct 2017 16:54:41 -0400
Message-Id: <20171005205443.206900-5-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Teach status command to handle matching ignored mode when showing
untracked files with the normal option.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 dir.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index b9af87eca9..8636d080b2 100644
--- a/dir.c
+++ b/dir.c
@@ -1585,6 +1585,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude;
 	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
+	enum path_treatment path_treatment;
 
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, istate, path->buf, path->len);
@@ -1631,8 +1632,23 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, istate, untracked, path->buf, path->len,
-				       baselen, exclude, pathspec);
+		path_treatment = treat_directory(dir, istate, untracked,
+						 path->buf, path->len,
+						 baselen, exclude, pathspec);
+		/*
+		 * If we are only want to return directories that
+		 * match an exclude pattern, and this directories does
+		 * not match an exclude pattern but all contents are
+		 * excluded, then indicate that we should recurse into
+		 * this directory (instead of marking the directory
+		 * itself as an ignored path)
+		 */
+		if (!exclude &&
+		    path_treatment == path_excluded &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
+			return path_recurse;
+		return path_treatment;
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
-- 
2.13.6

