Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F3DC433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0324E206D8
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAr+No3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgGaQwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgGaQwT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670EC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so9841544wmi.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+KO+D5p3YOmib6IviJGmS4ctI5tZIQ6SxGpPeB4buk=;
        b=pAr+No3SLxUxFtxeQuYhFQ0iyZRfEhO9j0Jidrmwkkd1iTekIvhFNZ2lK4hrHnTTo3
         0P5fyrPFbB+u9HAD2UR6ianWEUrdpzA2VyL3M7qKQf2lIXS1hnznWpL9nqqlAOkJq0xq
         u5+5OIPgndubGG3RpT2s4pI9vnnlGa/Kg67xiptiuiTEpZET5oTcvgiPzp+GeSg1MYi7
         erszyKVXMaQELjCGTFd0v++wqq+0U+IqsDGyR95ymly4PDxrDpxiACVHsdjZlbW08oxz
         fxyZwDJGf59g7hF0ABwU9/sqSSipPMuqoH9/fBcAkzwOPR+rB2zJq2i6C6LDOElnxtbQ
         UX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+KO+D5p3YOmib6IviJGmS4ctI5tZIQ6SxGpPeB4buk=;
        b=nUENf/+zqHW2YyvJotOaklsmsToH1RkpTzQ8xtXv1glH47bqoCRl5yDaEdwXypZbcm
         q0+dpzZPZeDx9Z0t+quVX5a+BumqFpdOdDy2+iwsqpRiIDs7ae/Ug8r35Wz3Kby+x6D/
         XrPnN3NylNGiLUqXEBDqbOnwW+mvGLhXQnj4oYZZlIuIJPDbGes16Gh1ZnX5djOx5Wmv
         zQj+wkWal922FVP+RmUEAWfn6dMiyhdyZHM0r7KOeYj67YIL80hTEBmJt+lnvHt++s92
         zTeLPD+sJ4UbEti1Z3axW+8bYhmNGq/8ZxU7NbPiU/LcrCYoRcag2zkBeVYLytsvc/9R
         7Dgg==
X-Gm-Message-State: AOAM530twLVK6wUmFkL77wfSghUusp58tc3ArYompP9N+9+/wZj78+xG
        ugX+BJ+pOJVR/VIsZLmf1WNzGfYd
X-Google-Smtp-Source: ABdhPJxKkez2HTYFzCXGI98ufhvRXd/sNBA9fetpmAk7/1XQuTa9hBGfGi0N+t+PFKmtdNhCm3+F9Q==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr4354029wmb.113.1596214337810;
        Fri, 31 Jul 2020 09:52:17 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 6/6] stash: remove `stash_index_path'
Date:   Fri, 31 Jul 2020 18:51:40 +0200
Message-Id: <20200731165140.29197-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731165140.29197-1-alban.gruin@gmail.com>
References: <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200731165140.29197-1-alban.gruin@gmail.com>
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

