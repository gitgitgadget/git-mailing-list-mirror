Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69ACC433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 04:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8049961359
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 04:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhDDEJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 00:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhDDEJv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 00:09:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73425C061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 21:09:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so4073842wmf.5
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 21:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luHG4OPjOLQ4mf8tuoqOCWWUS5Ds+g3ywPgDjTK8FNg=;
        b=ZBRRho4YIQJ47WbeNKkcAUAntmmf6LpVWBJ3Xx7FHPi7bpVNglX3uRKHeZjGHhYEig
         mlAgoaeNuDalNUtsPfkDgAHab+N8FVqYofq4PMHT9WIq7qwnlAXSqM3fI9aNUsKv27Mm
         QuDGjO3tja8de/mQO8DjRVotpBn7hS8JFU6xc90MOUC9QnyM4+z61mr8tYtZCiY+9FlC
         ZgWH21loqrVEvqgr5oe2ZsdOPRnTyETF43vuMzTveS9dqr027yynzWnzb1rA41VUHB0Z
         NLi9VXK+KPJUfv3DmjomZhjePwuKXPTk0YYRVrRjFTOLRhNT3BiMjymz5RZgGNGwAxsA
         r+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luHG4OPjOLQ4mf8tuoqOCWWUS5Ds+g3ywPgDjTK8FNg=;
        b=eqo4Q0tQWPHmbcf2SecYqegu9i6lxRJvDs2E4gZnrKiV3BZ8Zd3UZVO92dnV3OQst5
         Y7ZfLKF1fJV9ZwydfOTzubDNY24YquRpHgVAxFe2QzROWZi8fQk6Ugu6XSVRWpxDk+GQ
         JzF3sQJ9djUmNOgo6DepnuquK/T+WeQe81aNqQuPRXB1W+MThx4gC97xQpZhDAAzvI5C
         H6+0gyKsxFRlRcf7mOeepj+fP7FRESYGxCVfzs/LKwusvWGKD+Dcy44c++TcdvkJiI6Q
         GJrMMSXqumFtBMjIfsWQCLRT1xauH1GBCfkqCB/XLPQ50aJ2ynAqCYxbEXlQzg9zVcYt
         WDDw==
X-Gm-Message-State: AOAM533boeib/Y8/s/tOwvc/6h7fWyckglLgSoAgfNXWao9NasqJRU83
        2rPjWzWWwLoEU6mLJT0UznE=
X-Google-Smtp-Source: ABdhPJykMzjtxPVxn/fe+JTkzyPmbChvQnSfFa20WWtIifBTrzkVhpLmdIRWjrNJj4OW5eOfNR+E4A==
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr841149wmh.117.1617509385242;
        Sat, 03 Apr 2021 21:09:45 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c4200d5df61eebbad8b22.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:d5df:61ee:bbad:8b22])
        by smtp.gmail.com with ESMTPSA id x6sm18050938wmj.32.2021.04.03.21.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 21:09:44 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 1/1] user-manual.txt: assign preface an id and a title
Date:   Sun,  4 Apr 2021 06:07:39 +0200
Message-Id: <20210404040739.2671960-2-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210404040739.2671960-1-firminmartin24@gmail.com>
References: <20210402121303.344914-1-firminmartin24@gmail.com>
 <20210404040739.2671960-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two among the three warnings raised by "make git.info" are related to the fact
that the preface has not id in user-manual.txt.

    user-manual.texi:15: warning: empty menu entry name in `* : idm4.'
    user-manual.texi:141: warning: @unnumbered missing argument

This causes asciidoc creating an empty preface and an empty title tag in
user-manual.xml which turns to be an empty node in user-manual.texi and
git.info. Consequently, one can notice in user-manual.texi and git.info
a node named "idm4" in the menu and the navigation bar. In emacs, the
first entry of the menu in the git info page is even displayed as empty.

This fix will name "Introduction" the preface and assign it an id.
The result can be seen in the files: user-manual.{xml, texi, html, pdf}
and git.info.

For future reference, the diff between old and new user-manual.xml,
user-manual.texi, git.info, user-manual.html (converted through
html2markdown) and user-manual.pdf (converted through pdftotext) are
attached.

    --- before/user-manual.xml	2021-04-04 03:58:47.758008722 +0200
    +++ after/user-manual.xml	2021-04-04 03:56:40.520551163 +0200
    @@ -7,8 +7,8 @@
     <bookinfo>
         <title>Git User Manual</title>
     </bookinfo>
    -<preface>
    -<title></title>
    +<preface id="_introduction">
    +<title>Introduction</title>
     <simpara>Git is a fast distributed revision control system.</simpara>
     <simpara>This manual is designed to be readable by someone with basic UNIX
     command-line skills, but no previous knowledge of Git.</simpara>

    --- before/user-manual.texi	2021-04-04 03:58:47.490005652 +0200
    +++ after/user-manual.texi	2021-04-04 03:56:40.520551163 +0200
    @@ -7,12 +7,12 @@
     * Git: (git).           A fast distributed revision control system
     @end direntry
     
    -@node Top, idm4, , (dir)
    +@node Top, Introduction, , (dir)
     @documentlanguage en
     @top Git User Manual
     
     @menu
    -* : idm4.
    +* Introduction::
     * Repositories and Branches::
     * Exploring Git history::
     * Developing with Git::
    @@ -137,8 +137,8 @@
     @end detailmenu
     @end menu
     
    -@node idm4, Repositories and Branches, Top, Top
    -@unnumbered 
    +@node Introduction, Repositories and Branches, Top, Top
    +@unnumbered Introduction
     
     Git is a fast distributed revision control system.
     
    @@ -178,7 +178,7 @@
     Finally, see @ref{Notes and todo list for this manual} for ways that you can help make this manual more
     complete.
     
    -@node Repositories and Branches, Exploring Git history, idm4, Top
    +@node Repositories and Branches, Exploring Git history, Introduction, Top
     @chapter Repositories and Branches
     
     @menu
    
    --- before/git.info	2021-04-04 03:58:46.557994966 +0200
    +++ after/git.info	2021-04-04 03:56:40.520551163 +0200
    @@ -7,14 +7,14 @@
     END-INFO-DIR-ENTRY
     
    -File: git.info,  Node: Top,  Next: idm4,  Up: (dir)
    +File: git.info,  Node: Top,  Next: Introduction,  Up: (dir)
     
     Git User Manual
     ***************
     
     * Menu:
     
    -* : idm4.
    +* Introduction::
     * Repositories and Branches::
     * Exploring Git history::
     * Developing with Git::
    @@ -137,7 +137,10 @@
     
     
    -File: git.info,  Node: idm4,  Next: Repositories and Branches,  Prev: Top,  Up: Top
    +File: git.info,  Node: Introduction,  Next: Repositories and Branches,  Prev: Top,  Up: Top
    +
    +Introduction
    +************
     
     Git is a fast distributed revision control system.
     
    @@ -174,7 +177,7 @@
     that you can help make this manual more complete.
     
    -File: git.info,  Node: Repositories and Branches,  Next: Exploring Git history,  Prev: idm4,  Up: Top
    +File: git.info,  Node: Repositories and Branches,  Next: Exploring Git history,  Prev: Introduction,  Up: Top
     
     1 Repositories and Branches
     ***************************
    @@ -5471,207 +5474,207 @@
    ...
     Tag Table:
     Node: Top212
    -Node: idm43164
    -Node: Repositories and Branches4465
    ...
    +Node: Introduction3179
    +Node: Repositories and Branches4515
    +Node: How to get a Git repository5128
    ...
    End Tag Table
    
    --- before/user-manual.html.md	2021-04-04 05:20:55.378695854 +0200
    +++ after/user-manual.html.md	2021-04-04 05:21:11.282850802 +0200
    @@ -4,6 +4,8 @@
     
      **Table of Contents**
     
    +Introduction
    +
     1\. Repositories and Branches
     
         
    @@ -278,7 +280,7 @@
     
     Todo list
     
    -#
    +# Introduction
     
     Git is a fast distributed revision control system.
     
    --- before/user-manual.pdf.txt	2021-04-04 05:28:20.367036836 +0200
    +++ after/user-manual.pdf.txt	2021-04-04 05:30:01.680026312 +0200
    @@ -487,6 +487,7 @@
     
     vii
     
    +Introduction
     Git is a fast distributed revision control system.
     This manual is designed to be readable by someone with basic UNIX command-line skills, but no previous knowledge of Git.
     Chapter 1 and Chapter 2 explain how to fetch and study a project using git—read these chapters to learn how to build and test a

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/user-manual.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fd480b8645..f9e54b8674 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,5 +1,8 @@
 = Git User Manual
 
+[preface]
+== Introduction
+
 Git is a fast distributed revision control system.
 
 This manual is designed to be readable by someone with basic UNIX
-- 
2.31.1.133.g84d06cdc06

