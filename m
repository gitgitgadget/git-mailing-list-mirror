Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4CC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343CA23131
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbhASHsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbhASHp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D9C0613D6
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kx7so1993595pjb.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v06s6aZ+KsNyeYsi4lspk3/ZKiIaKcsSjXUrM9gZ5v8=;
        b=D5TPk44OUbeWFTrTMNXonRZ8+Jtt3l8we9NpaCe7xNJKHFt9qxNGLGRHwj8NuM2kMO
         H+RdJr8OYtgT5c/sfINaC4iqI5PHztMWwIT3ZnNa5SAz4XhL9j3pNqNUeJvWYUzbtUdd
         i+3p0bq0EtgHCBiSIHWM2uhATD6iIugi4WPwxpYDFxyIyqW+fCjmaeU7k9LEW5n3v2Dt
         SvvtzXGKZMGUptuZRg19zSVqh31x57U5glJTB89SHJQd/0eLRS+HfFRDgTcD4ZOKtjHs
         dn7ctbj3TC72EsSH9AWEAcmw0jD7vxeyjXknI/9rZFZeb/++VJzMEqEX5FvPmTUvPgRX
         9/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v06s6aZ+KsNyeYsi4lspk3/ZKiIaKcsSjXUrM9gZ5v8=;
        b=at5oPMLlMianOp7pjMlgTFS/cC1e2yX7i9NeBJdyd7rVRtq7HvwVsG+XM0pghN1mIF
         sUJrhqBchiEYf5S+d7v4gc8WOaYmdV55ztiGZsTrQDWBNtVIItcGktUtrOWqgOFoQaiL
         cxhQJrWvUFc24DBBK7HTUx18GeWya1e9YfTwWMOJPusV5rcYpuD5ngRaPkEEvIYgt+At
         nR8nUvrqQloH+i6qAYZMOmLPM2bxW/TTaVUBLU0hiaXo1wO6hZSXT95tscT48GN0D3hz
         FlBQbF/Q2pwaf1mRWkF+JTt44Uj8R4KVVyiNEczZMtxk6M0IZEIhuOzz8aPMoO+HNgDh
         +Q3A==
X-Gm-Message-State: AOAM530Di+odVw4+WUTf52RTUnEQgWl9Bd98Uy9MwSowpTEa2lDnEthi
        gXrMvVmG+U5b47njvOQnqHySPnOPvssLKg==
X-Google-Smtp-Source: ABdhPJzS3oSUdUfFy3WTbmpH1ye86Rk22E+JlyjOWOnKwIEJSHGpFKIQHWzdxmRWWsMLdDn+rghoIg==
X-Received: by 2002:a17:90a:be05:: with SMTP id a5mr3987101pjs.142.1611042288103;
        Mon, 18 Jan 2021 23:44:48 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:47 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup [-C|-c] options
Date:   Tue, 19 Jan 2021 13:11:04 +0530
Message-Id: <20210119074102.21598-10-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a0487b5cc5..776507e0cc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -887,9 +887,15 @@ If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
 attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the commit
-messages of the first commit and of those with the "squash" command,
-but omits the commit messages of commits with the "fixup" command.
+message for the folded commit is created as follows:
+
+ - It is made using the commit message of a commit with the "fixup -C"
+   or "fixup -c" command. In the later case an editor is opened to edit
+   the commit message.
+ - Otherwise it's the concatenation of the commit messages of the first
+   commit and of those with the "squash" command.
+ - It omits the commit messages of commits with the "fixup"
+   (without -C or -c) command.
 
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.29.0.rc1

