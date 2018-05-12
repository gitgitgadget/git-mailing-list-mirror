Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29001F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeELDLY (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43381 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id a39-v6so4263809pla.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vM8W9Z3ylReMAR36L0Q4pJAo89yjCrrgm0kOBm/eRkI=;
        b=Rx8Wy/O2ITqhcEVs1cod58bP/pBjCphbbov0FP6B2Z7lfCyEG2KXiPwnckHNBJ/jfZ
         ij90MchEtK+W7DV7soWgzN87eh1cSEfUCkuN8kiwniF55B9dN0VQ7Rao+IV4aSDQZvCS
         vUCasUM5b7wtme2C7K88L96W61a7837kqYCgJPHmShLHgIH1cs7+/i7y2Z5MR2DTy4Yg
         ksp+seT0ZgMJ9zlmgi+6aFL++zO1LbbVVYgZ1zGdmR6mFt9KZhGx8PfWjUCNJfsfoP8E
         CeOPJD0yPqsdpqy/89P7ZvMm+rywwXtf/J7atAiw25DhyHE22LKUsx2eNHCedx0GKu1s
         ngEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vM8W9Z3ylReMAR36L0Q4pJAo89yjCrrgm0kOBm/eRkI=;
        b=dDKzp5l1iDdePzj9KtsvKyMbLzMaANel3ek2GSxrQt4+Hrw+L9MUZ248mgydXJMgM3
         Jas/Xgo3V+/xQUpJ2MhhjI0Wd5Lt2kTVCs3MhdnN53R9rZ8AfIb0u0buwdE9Tf69ywJI
         1LgJ+gNPd+IRH9Uu8b/H4XIr0NKTVbaYi0RExEBkl478+hsnDG968jg9Q8faNJp8aJdb
         cKOTGn20BjRNpV6AFanPg/RfWqBo2nzqmQYtwztJZS7cq/K36TYvJ1uBSSAgUp+oiuF4
         m1cT+nQvSDObrp4SufJEdut2qIFbGberj6eMCMzLyY/fRtJiiIkEbiiXN5tqQVSY9IUk
         7VCg==
X-Gm-Message-State: ALKqPwdHOhFhrRbTiO15aJNHUEsow/fC0OuWtL46JpiMD0vjhUaRD8t6
        QC4w2f8uz1CHuygzmtIgJhGb9DlyW5s=
X-Google-Smtp-Source: AB8JxZppq4X9A8FK50NobfXzfJp2hvAeJ4IKNPpg8/24sVXEa2UN5PQ5NylMFOqJ9cfSHndJRx2iOQ==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7-v6mr723349plq.360.1526094681361;
        Fri, 11 May 2018 20:11:21 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4517583pgi.4.2018.05.11.20.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:19 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:18 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 7/7] contrib/git-jump/git-jump: jump to match column in
 addition to line
Message-ID: <12381a35b2332950a098b077c312bf587b3db230.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1526094383.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094383.git.me@ttaylorr.com>
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
2.17.0
