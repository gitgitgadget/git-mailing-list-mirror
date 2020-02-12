Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95928C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5D2206D7
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 03:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmR0sSFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgBLDwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:52:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgBLDwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 22:52:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so3693157wmc.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 19:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eu8heWqF9b/d11bKOBt7HGJz7F9HO3Q/AQH77Fl2PO4=;
        b=AmR0sSFk3+1o4YCtGB2k2dVpjrTX3/o0X/j7fi9BuFRR6mG9vO2j7YD2uouPJHqjlc
         YJgdDGehSVpEQNBwIA+uZgepJZCJstXTSsy7NzjmUx5YbW0UaBkUr594L5MJrxE5CDkq
         ngE4j0E5ezxdrTCRyBaNLGHJKSFy9HN+mkp1FKMj0nW69vHs9o6XVMSo+9ZkYZtpiqnr
         A6mNfrvUyYiYSlfrkTbdql3er1PtXUip6hBxToATogv9LiWUxCJSJrtfwCs/IYfKo7AN
         dzALgaRG6cSZMlYfk/0PXdprAa5X1OhoW7hn3EC5b/tQ5+IfuCD7D+RveqHv+whudQ3E
         OO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eu8heWqF9b/d11bKOBt7HGJz7F9HO3Q/AQH77Fl2PO4=;
        b=LiwBclEpiimhHezKVtEJz8xxrmLRMTixmuCKHt73Jbst2nBahBP2tudJr48gmzEIgY
         T8F9CWc77yyiLEjbhtU4x4t5+LhxFHjCxcm6dEZqeAlsN0L9RLNknWa1fE7UkOGJ4yiX
         RVR8UHWVNzpiVWASHkarQTg3nKxu9L9gtmCI9KB1FuyUqZyYDkKi4SLmcQ+lZiZgXQZo
         eFA/1kedYA61t7Onope8mfDVpRLEDB46VjBes101DBCcGIW0XC8CAAm2THyBnXhCI4t7
         OaXloA8WrbyYynKWhLYNQQQxpgvUuDEV0l+4oSIlCsG+70bKyERblNcWogBN9LhyN525
         xv+g==
X-Gm-Message-State: APjAAAXphMTuVlp8k/Q5V2o1BpMKYcZk7wIBg5DwmjHbA4GGZ22HSid1
        IZiufeaU+cge4LvuFmUhxBYR6w2+
X-Google-Smtp-Source: APXvYqzy9cfolE6zb4l+mgaAOK+5TVNjAuK5A8OkFx+bQWVaC9Ltud8QMNcpvtIEJXl9MjnkgjyuOg==
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr9942337wml.180.1581479551184;
        Tue, 11 Feb 2020 19:52:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm6385060wmd.30.2020.02.11.19.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 19:52:30 -0800 (PST)
Message-Id: <pull.546.git.git.1581479550353.gitgitgadget@gmail.com>
From:   "Glenn Strauss via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 03:52:30 +0000
Subject: [PATCH] update git-http-backend doc for lighttpd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glenn Strauss <gstrauss@gluelogic.com>,
        Glenn Strauss <gstrauss@gluelogic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glenn Strauss <gstrauss@gluelogic.com>

git-http-backend may be found at /usr/libexec/git-core/git-http-backend

scope lighttpd config directives for git-http-backend under "^/git"

Note:
lighttpd 1.4.51 setenv.add-environment does not add vars with empty value.
so use "GIT_HTTP_EXPORT_ALL" => "1" (with a value) in lighttpd 1.4.51.
lighttpd setenv.set-environment does, but was only introduced in 1.4.46
lighttpd 1.4.52 setenv.add-environment restores prior lighttpd 1.4.50
behavior.

Signed-off-by: Glenn Strauss <gstrauss@gluelogic.com>
---
    update git-http-backend doc for lighttpd
    
     update git-http-backend doc for lighttpd:
    
    git-http-backend may be found at /usr/libexec/git-core/git-http-backend
    
    scope lighttpd config directives for git-http-backend under "^/git"
    
    Note: lighttpd 1.4.51 setenv.add-environment does not add vars with
    empty value. so use "GIT_HTTP_EXPORT_ALL" => "1" (with a value) in
    lighttpd 1.4.51. lighttpd setenv.set-environment does, but was only
    introduced in 1.4.46 lighttpd 1.4.52 setenv.add-environment restores
    prior lighttpd 1.4.50 behavior.
    
    Signed-off-by: Glenn Strauss gstrauss@gluelogic.com
    [gstrauss@gluelogic.com]
    
    [Edited to reflect refined commit. v1 and v2 were originally submitted
    via submitGit]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-546%2Fgstrauss%2Flighttpd-git-http-backend-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-546/gstrauss/lighttpd-git-http-backend-v1
Pull-Request: https://github.com/git/git/pull/546

 Documentation/git-http-backend.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 558966aa83..9e8d7083be 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -191,13 +191,13 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
 Lighttpd::
-	Ensure that `mod_cgi`, `mod_alias`, `mod_auth`, `mod_setenv` are
-	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
-	all requests to the CGI:
+	Ensure `mod_auth`, `mod_alias`, `mod_cgi`, `mod_setenv` are loaded,
+	then set path to git-http-backend in `alias.url`, redirect all `/git`
+	requests to CGI, and set `GIT_PROJECT_ROOT` path to git project root.
 +
 ----------------------------------------------------------------
-alias.url += ( "/git" => "/usr/lib/git-core/git-http-backend" )
 $HTTP["url"] =~ "^/git" {
+	alias.url += ("/git" => "/usr/libexec/git-core/git-http-backend")
 	cgi.assign = ("" => "")
 	setenv.add-environment = (
 		"GIT_PROJECT_ROOT" => "/var/www/git",

base-commit: 0ad714499976290d9a0229230cbe4efae930b8dc
-- 
gitgitgadget
