Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52243C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2C20724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u776vIAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbgF3PQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbgF3PQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A949C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so19191149wmg.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+KO+D5p3YOmib6IviJGmS4ctI5tZIQ6SxGpPeB4buk=;
        b=u776vIASLkcy5StlCWwRKEx9m9ydby1y0DGf4rZTKRzV96glZrhrHXw6rro0Ir5Ruy
         atR7tfk25bBtDPne+o+bBEqVfkgSmHINWdWMfy18fYyFdcNrfHa1Rj9Az6pEHvG5Kbjm
         ZZTSFXGYRu9LIuOKsPXVceWJd2V7lMgthbvrON/T57Amjj5h31NZ7RbTzAoyGdcKf9vu
         Mtmv79RQ0xUl/OlmXAX+v9TDXIS7Tgv22mwtkfDdf0MLuuy2KQNL/RvCqkZUB9GOqVch
         1MooX+iPqYbR0ciCco4LTimiipI/IJaJ1DacEPSVHs8rQYLf6J9m0NIUyGfooZOdZoLZ
         qC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+KO+D5p3YOmib6IviJGmS4ctI5tZIQ6SxGpPeB4buk=;
        b=eC8+yaBMQ6Y615v+lL7nIs2kU0urnIuyxyUaaZ2tRJvDnKwIVHAK167Ze6caEumFwP
         V4utwCFh5FDp6seTslaoEF/YS4Ul8Mwfez2y/44CQnOwq47LG0GcLwqz7PIe05fRYIiX
         L+mFJspvK1X+2vIWLdcgB0rxREUNVTCoOxLYYEGXQ7YvZJ9pAP5AoBlhPdDNeTZiYzb2
         SroBaqYrsT7/94LHxE4MHuQsQBnv3iorLKJUdSohz5RkNbq6+jkonigQMt5HkKiF5s4z
         Z+hdeEXCKMyGfdirm30jma41MJeyE2otH2yh6eceOj4Xq5d21P7X6XYCZrbMiMwFDKXX
         oiUw==
X-Gm-Message-State: AOAM531706VMcudEa1s2ynks0eupGw0IDLnOA8KlfAQGuLklm02p7/vU
        //03od1oLvzltlSIs/7WVocJM5fP
X-Google-Smtp-Source: ABdhPJwvYLWf/btQ3PCXnQBJXYt2hZE42PlzDrJwp3JSYe2zj36KQmsOP1cFL8rPpmTWTpQqJZONyw==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr21646249wme.186.1593530192467;
        Tue, 30 Jun 2020 08:16:32 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:31 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 6/6] stash: remove `stash_index_path'
Date:   Tue, 30 Jun 2020 17:15:58 +0200
Message-Id: <20200630151558.20975-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200630151558.20975-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since stash no longer uses a second index, `stash_index_path' is now
unused, and can be dropped.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d5077a27d9..f1b3c0d2f8 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -88,7 +88,6 @@ static const char * const git_stash_save_usage[] = {
 };
 
 static const char *ref_stash = "refs/stash";
-static struct strbuf stash_index_path = STRBUF_INIT;
 
 /*
  * w_commit is set to the commit containing the working tree
@@ -1505,8 +1504,6 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
-	pid_t pid = getpid();
-	const char *index_file;
 	struct argv_array args = ARGV_ARRAY_INIT;
 
 	struct option options[] = {
@@ -1523,10 +1520,6 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
-	index_file = get_index_file();
-	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
-		    (uintmax_t)pid);
-
 	if (!argc)
 		return !!push_stash(0, NULL, prefix, 0);
 	else if (!strcmp(argv[0], "apply"))
-- 
2.20.1

