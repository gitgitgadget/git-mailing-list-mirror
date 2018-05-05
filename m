Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DCB200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeEECnQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:43:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40102 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeEECnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:43:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id f189so18774000pfa.7
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQ8tXx1t/n2FoUtHBIj9WjJN0B9fT0lM/jZaDNdY0Ys=;
        b=S6mOSxneLPCTVgOKdrWj40nlqvdWaukUdFi5uUdT5ibaUV0i/fvDEvjx/qokjq0BKN
         F6jSicYkdfM65WvDzq5dixx8cMDQeCx/r2yxsvu8k7PNVvJWHBpZ202RSJdHtLyrsZ4u
         KSTdzu0IPQRgEurOYgrQadVqWDArSTn/aKbLcqKBCf+BPaNZ26PN5OJ728jUe4xtu9Em
         hg/xdFvGRu49a9/Ypu8CMdMXTKnALS3WhuMdQ2UGo1oU8ewTpmscG1na9t1kVS66s4rl
         bbplr8QX2hMal95EzagrDIm0kSx+VMJ5M7nEa+Bij0NVRlqm16SoJfYm3xHwgJNl2upE
         I5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQ8tXx1t/n2FoUtHBIj9WjJN0B9fT0lM/jZaDNdY0Ys=;
        b=CxXYQxL71giu4jJfmHpwrrQUHEu1A5IobvDN9KNiQTkedxJcuA8RZ1fotBu7i69KCT
         Z8XEQ9Ate5mDKc19ZBR88kbn5CyeqamDomJgfT30rHDFGUln6zbS7zLRzYXXdUcVLeis
         Z2yqJlsTW1Dv+oOGNszJeuMBrBdfa2/kxeGd4TBacZCKaV1mp75shQzVf3Oh9j2JRoD9
         /rQBA4vwiM5yJOhKapVJufUbqYRt9CzwLDYikjr4JMKAXp9u3qTn+AjjJOC+teL80Qkf
         M6nsiNXMvnBs5IvCp5fO4Fec1j27v59mrl1bRS5gKKhY4UUQYOBtLQVfCSTuIv1IZGHT
         47jw==
X-Gm-Message-State: ALQs6tBY0AT0yhb27nLj8bt7HM31PSpSToRunax/Wg+Ah+4w1ACTGlIC
        axlvcNcvWJTocpBRUj5GUYpmcu0lmGpOeQ==
X-Google-Smtp-Source: AB8JxZr6gGVbsd+gk57qb+ZIJw16WcXbMh8zloywQ+HA+AYzez8ai1gll+dVG/wX4J0gaPur2G+9jQ==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15-v6mr29177011plr.167.1525488189016;
        Fri, 04 May 2018 19:43:09 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id z83sm1995039pfd.103.2018.05.04.19.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:43:08 -0700 (PDT)
Date:   Fri, 4 May 2018 19:43:07 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 7/7] contrib/git-jump/git-jump: jump to match column in
 addition to line
Message-ID: <326d07b48654ab2a64d09eb17d995a26d06bcdb1.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
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
 contrib/git-jump/README   | 6 +++---
 contrib/git-jump/git-jump | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..7630e16854 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -35,7 +35,7 @@ Git-jump can generate four types of interesting lists:
 
   2. The beginning of any merge conflict markers.
 
-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a line.
 
   4. Any whitespace errors detected by `git diff --check`.
 
@@ -65,7 +65,7 @@ git jump grep foo_bar
 git jump grep -i foo_bar
 
 # use the silver searcher for git jump grep
-git config jump.grepCmd "ag --column"
+git config jump.grepCmd "ag"
 --------------------------------------------------
 
 
@@ -82,7 +82,7 @@ which does something similar to `git jump grep`. However, it is limited
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
2.17.0
