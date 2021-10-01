Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C3C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5FB61A63
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354113AbhJALjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354080AbhJALjt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 07:39:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B856C06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 04:38:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s16so7693959pfk.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EsMMi/Et/Yd8XJn/weGmcYT2mkTJLmVkD5h5PNodhSU=;
        b=JMfjPestcAEbcJEEQ7uxr52+ksJx/5eiOuJPtVo2oGGvKgpv8+FRy7defGBy5Wr4kS
         xARjHtaEbpdUG/jx9NBfWbjW1arBKOUzmsi0bMz9SPeCHysF9exDIowsog1kyaEJGfHM
         pVmuyPobH3nRG0o4k5rw2p1NaReji5hxjo4FIjUlnqe9mQ4Op4ALNQFEhvztZBNUkgcl
         CHFHINY6pUYpbd25xqB4ODehrhTkIA60oGBfbj2uCpfPYeDh40hfJ7tUbgB2lMZ2J9rE
         j23oLPQpiTbBnNhvlGr5v46ztrE9RTCD9eQIXu7UhsFEasLFF1FjCidIOw0XVTVb5Ojd
         pNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsMMi/Et/Yd8XJn/weGmcYT2mkTJLmVkD5h5PNodhSU=;
        b=V7U2zU5fp9sdFoBMhVOASG5hIfwDkTbxDjszx8OJxDLlMW57Ru07x0zy48l7frVfb3
         BeH4dJLKsL482r8GIynv+aOv5+ZoWDIdizJp9LjHzCnUrXFVHOuW1HGf/Sv3dEggLEMw
         G2pwe58o/oGWFZmDXZ0ztmqnAhRd3brSijYq6adbUPyUnZUJ0LLzVd1Xwm6yOd3YI+Rr
         CiaNnz2QHZgiHMq7pyLhBo2JIJdCZah9OM0/K61cqJqrbTJHXuUEdeOF9m55DFsYKZeA
         JnQYYkVrw9TY1topeyiMYYb6hUSRDhH0RUylLSdfgxLykKZPKQ5TRBTUVlgWpMESs8iX
         0rAg==
X-Gm-Message-State: AOAM5307PXguXHJxGyf8oNtLzaLwl968ELn1ZFSO2tTPx+tIsKCrWV9a
        B4pP3vXPw5AtVxY7lT79UC9lHzM32m+s0g==
X-Google-Smtp-Source: ABdhPJx80M8oMDI17zBV0q9HsU1ExtcTVsEspJO7+pim4MJxM8iU9C2qaa8x9OYxpXcr5bQ8BcTC6A==
X-Received: by 2002:a63:c10b:: with SMTP id w11mr9442788pgf.228.1633088284888;
        Fri, 01 Oct 2021 04:38:04 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id e7sm6066461pfc.114.2021.10.01.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:38:04 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3 2/2] blame: document --color-* options
Date:   Fri,  1 Oct 2021 18:37:26 +0700
Message-Id: <20211001113725.13354-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001113725.13354-1-bagasdotme@gmail.com>
References: <20211001113725.13354-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
lines, 2018-04-23) introduce --color-lines and --color-by-age options to
git blame, respectively. While both options are mentioned in usage help,
they aren't documented in git-blame(1). Document them.

Co-authored-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
Signed-off-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/blame-options.txt | 12 ++++++++++++
 Documentation/config/color.txt  | 12 ++++++------
 Documentation/git-blame.txt     |  4 ++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..9f82936bf1 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -136,5 +136,17 @@ take effect.
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
+--color-lines::
+	Color lines differently, if they come from the same commit as the preceding line.
+	This facilitates distinguishing code blocks introduced by different commits.
+	The color defaults to cyan and be adjusted using the `color.blame.repeatedLines`
+	config option. Only the line annotation (see "The Default Format" section)
+	is colored.
+
+--color-by-age::
+	Color lines depending on the age of the line. The `color.blame.highlightRecent`
+	config option controls what color is used for which range of age. Only the
+	line annotation (see "The Default Format" section) is colored.
+
 -h::
 	Show help message.
diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index e05d520a86..5634f5b800 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -9,8 +9,8 @@ color.advice.hint::
 	Use customized color for hints.
 
 color.blame.highlightRecent::
-	This can be used to color the metadata of a blame line depending
-	on age of the line.
+	Used to color line annotations differently depending on the age of the commit
+	(`git blame --color-by-age`).
 +
 This setting should be set to a comma-separated list of color and date settings,
 starting and ending with a color, the dates should be set from oldest to newest.
@@ -20,15 +20,15 @@ before the given timestamp, overwriting older timestamped colors.
 Instead of an absolute timestamp relative timestamps work as well, e.g.
 2.weeks.ago is valid to address anything older than 2 weeks.
 +
-It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
+It defaults to `blue,12 month ago,white,1 month ago,red`, which colors
 everything older than one year blue, recent changes between one month and
 one year old are kept white, and lines introduced within the last month are
 colored red.
 
 color.blame.repeatedLines::
-	Use the customized color for the part of git-blame output that
-	is repeated meta information per line (such as commit id,
-	author name, date and timezone). Defaults to cyan.
+	Use the specified color to colorize line annotations, if they come from the
+	same commit as the preceding line (`git blame --color-lines`). Defaults to
+	cyan.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 683f8ab0b0..9d7b6003cd 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
-	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
-	    [--] <file>
+	    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
+	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
 -----------
-- 
An old man doll... just what I always wanted! - Clara

