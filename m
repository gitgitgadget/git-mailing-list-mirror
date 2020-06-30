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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24300C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11F920675
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzyDpelu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgF3PDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgF3PDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA9C03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:30 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c139so18829080qkg.12
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qSDefz+bSUh6eorg/Tb0dLtP1P2UtpxQubXdHLv8sAA=;
        b=pzyDpeluK772xwi1C5uhl2yMJ9E+GkCzibig5Mxqfe56lwDeskQF4Fiw8GScKdc8Lr
         uEbKdCOM+kwl9qX7XRMkViP2r2JpS9SUZiVjKQqfalSLuodsvNV3FMHM4Ho27AFq9OWW
         C6DqAvKkC+fiksSMkP08T9D9m+Q0l4z8qQ3WQgMmPzXes7NpQ//8pbGJsO34grua3+wr
         OKPvyzsExnd7B5p/8PqXd1QyZeisN1nQqFLR88nsmQh/FMP+sP6RvaXiFAqk5vsXiCAn
         K9JCBvPy6mrVX5EDRp7FD6XEjaMdxHzvC0huS0bxRMWuQ0GaxXTThca7ylMmAgMG11Rb
         pelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSDefz+bSUh6eorg/Tb0dLtP1P2UtpxQubXdHLv8sAA=;
        b=Wr3/dlkdx91W7FIPjDRNF7GTJI8ka+kgKTIC8RkmZC0gImlemwByxUuarBNBX3wHMl
         2hy2hHddXUpfdySlfSpIOCI6cCI8weER7xdPp8e0MytdAeNn7T8b23Ax8+EZBkUMTW4T
         bccM33C2V1cWsE4Ci4coYHvlbFX/0cO4wz/pIp0GxQ5wAVLr3fItJ20R4ueqrcVxR35Y
         5ZwLZHhGkJJFqtcK2MTFWzHtTmBoYngxt6gPqGqJG553S4XOKkxWm4aqxh24eb3O1bKk
         ItqQriQWyLFcodjvWRYNBtonEfApgzEsKBdd6keykyUuBG6TYOcwRsh/MRIAj3GedD0i
         SOdA==
X-Gm-Message-State: AOAM530+5LusuvFfo23SecT+1j9frhretgavskh/a7pgrZEko4U/9iRx
        FwHXxagDoTpSIUm5QGvdJy/QBaw7vD4=
X-Google-Smtp-Source: ABdhPJyAKguVYfjMbHE22F3OIYLca0w4HR/+K8goTpsexTNjg/0yNC1oCaxFpLGZZu4qxc0feuvDTw==
X-Received: by 2002:a37:6643:: with SMTP id a64mr20117604qkc.397.1593529409658;
        Tue, 30 Jun 2020 08:03:29 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p66sm3209626qkf.58.2020.06.30.08.03.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:03:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/5] t3701: stop using `env` in force_color()
Date:   Tue, 30 Jun 2020 11:03:15 -0400
Message-Id: <67d5b93fdaab7f73f352293372ee3d71fb7c1409.1593529394.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593529394.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on making the test_must_fail()-family of
functions accept only git commands. Even though force_color() wraps an
invocation of `env git`, test_must_fail() will not be able to figure
this out since it will assume that force_color() is just some random
function which is disallowed.

Instead of using `env` in force_color() (which does not support shell
functions), export the environment variables in a subshell. Write the
invocation as `force_color test_must_fail git ...` since shell functions
are now supported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3701-add-interactive.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 49decbac71..c4c1e9b603 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -31,7 +31,13 @@ diff_cmp () {
 # indicates a dumb terminal, so we set that variable, too.
 
 force_color () {
-	env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
+	(
+		GIT_PAGER_IN_USE=true &&
+		export GIT_PAGER_IN_USE &&
+		TERM=vt100 &&
+		export TERM &&
+		"$@"
+	)
 }
 
 test_expect_success 'setup (initial)' '
@@ -604,7 +610,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	echo content >test &&
 	test_config interactive.diffFilter "sed 1d" &&
 	printf y >y &&
-	test_must_fail force_color git add -p <y
+	force_color test_must_fail git add -p <y
 '
 
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
-- 
2.27.0.383.g050319c2ae

