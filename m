Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A7A1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeFTUFy (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:54 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46344 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932958AbeFTUFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:53 -0400
Received: by mail-ot0-f194.google.com with SMTP id v24-v6so900084otk.13
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VfwsGRM8TRKo+qIHKBeAd53krkytiNc+gdRqvXTlLo=;
        b=NbZ/ENUcDRM9eZVAxEUMKmITRBKabdP54OETiGbDlRv9AWzgV1dsxJnBuYGVXv1Kbc
         eAm3sentzKKx5U1F6MguZRc1/PMNeMCmvC1TqCAxjx1O8q9KJ+5v7jg4hoWgae2ph6kd
         MRdPD8ObamAgjxqYzxG+s+0MtkxUanI48uY4mlC86Xpu2lZSKI4MgqT3QdlHfTEb0p9H
         nwEW5/Vf8dodIw7He8tZKmCplyR/93iMH8L8bBKhqsgAWGf2/MMzke8L/C4xo5rLqOnB
         47bGx4OIy7rw8y+SeRtLmybNS2A4f68mZZyNA2kmHJsJk/jTZgV0U/ezC4U0KHX+vkyc
         UUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VfwsGRM8TRKo+qIHKBeAd53krkytiNc+gdRqvXTlLo=;
        b=WUM5DGuQ/PxcjMWYpunLdtEfKHeGVPXbgJJhNdzszxkpkuYxQX+QaBwBYlcDpV5ViE
         ZR5f/5c6xxYB+dYPe1AWswMEgiHNEjvfv3lf/T17eefKiARpo/xNQIaB/49YeBxolhZA
         UXTVB7nQNW+96yKzoJkErbTQtetnI3AWJT5q7stCRTyG4L8yYscPofVGGtML12Fzaobm
         FeagM8Q/bFawJSIB3S9VErLP+yomDhsvDpqXQunh70T2ySRDJwKUpBRv1cm05sJqX7bi
         IfiBO3LYTwmRr+2ZuBTlwk9Ho46IkiQQvOt3jr+t4cq6i6BWBrtCPaGZ/tKtkAKQ75fR
         rHlA==
X-Gm-Message-State: APt69E2nRswuNYr2Fa9Pjgt68dpEaAlHOftdNN9FoBL5rTS1LJ/+23HM
        /bBZcLt6l+B3lWbEkoCxz7t9oHOUWkA=
X-Google-Smtp-Source: ADUXVKK4RulZ69JCdP2jRpNoL6rqzmXZx0B6BOz9VLzXiUekVxHx8JNlXmfdFS3gDEiTNfphEnrrZg==
X-Received: by 2002:a9d:2b32:: with SMTP id o47-v6mr14826120otb.346.1529525152255;
        Wed, 20 Jun 2018 13:05:52 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id l7-v6sm1362727oii.29.2018.06.20.13.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:51 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 7/7] contrib/git-jump/git-jump: jump to exact location
Message-ID: <7e2cbeeccacd8462a4128830927dae15895c4e1b.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of 'git-grep(1)''s new option, '--column' in order to
teach Peff's 'git-jump' script how to jump to the correct column for any
given match.

'git-grep(1)''s output is in the correct format for Vim's jump list, so
no additional cleanup is necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/README   | 12 ++++++++++--
 contrib/git-jump/git-jump |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..2f618a7f97 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -25,6 +25,13 @@ git-jump will feed this to the editor:
 foo.c:2: printf("hello word!\n");
 -----------------------------------
 
+Or, when running 'git jump grep', column numbers will also be emitted,
+e.g. `git jump grep "hello"` would return:
+
+-----------------------------------
+foo.c:2:9: printf("hello word!\n");
+-----------------------------------
+
 Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.
@@ -35,7 +42,8 @@ Git-jump can generate four types of interesting lists:
 
   2. The beginning of any merge conflict markers.
 
-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a
+     line.
 
   4. Any whitespace errors detected by `git diff --check`.
 
@@ -82,7 +90,7 @@ which does something similar to `git jump grep`. However, it is limited
 to positioning the cursor to the correct line in only the first file,
 leaving you to locate subsequent hits in that file or other files using
 the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
+complete list of files, lines, and a column number for each match.
 
 
 Limitations
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..931b0fe3a9 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n --column"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.17.0.582.gccdcbd54c
