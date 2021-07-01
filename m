Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF66C11F66
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 00:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0782261221
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 00:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhGAAi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 20:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbhGAAi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 20:38:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE5C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 17:35:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e33so4466269pgm.3
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ARw2KqTRi9p5UsHZiFsUt1moE3KbUQpHQV9FBvgfUJs=;
        b=JTQoJjw45BNNiFXYLwFLDeMh2+6m+R+3xOH4AlmgIkd6ZPmbkNLioP7qQsaPJTKgEd
         RL649ioX/Oqtm664KNDblp4S8x66uFlfyzCi8OfL9KUgzFcRoU8pBFPHh+faUG54SUB/
         B1aqPYiC063j2gmzQeCSFjlktqGGFUer4B74Yds9S7O8TqkzKfvLwN0S+udPHUXsnMM/
         I5PY9yxMirkXQ5HVhAlAH3CjCywF+OOfrtsKaPSUMztBr69owtr0ZLQlMT6PsdrtAEg2
         bzlP09uZhAEjJRKWyz314UaK3O1zniFLj0wOqZTgQvOiXqdOBefhN5syQBBHbny4GV20
         mncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARw2KqTRi9p5UsHZiFsUt1moE3KbUQpHQV9FBvgfUJs=;
        b=VKCMP87kmhiexsXNxbq43/Zwcv60BEIK4yw7gS0he8XTJccM3c9yODWlFMiZRx+498
         I7e8aFXi0mM/sz3BVz/lKA1T4ktLDHTYTsvLbdJLBjVtUASp+T9tbQMB57W+fFfwstp/
         ujsOTPeMu/xw/pxz/Jfcyl/kFWqgyMZAsrRKYGraIXoDI/uiLFEqcr+fqt5wnuH3pIxy
         BW3Qp14J2W3eoXJFp4uMfaqlfjLlGmMlcYevdSdXO6+3oB5CLT0nqyH7wkHboZ3nhHJn
         MFngq+Mw+ImE4JZy36bKAKHgbpGqDuJ/0X8coOTjgbOd+P4l1WUbfaVCVvUDXQwDSMz0
         obDg==
X-Gm-Message-State: AOAM532c2d4G724XsCokyZRbUTd6mucTUT50JtOxmeEIEZE/7wGmrmec
        oieE7AWYmAwXH0OBfLW3oh1M+9R2na4=
X-Google-Smtp-Source: ABdhPJzUiYA4Jcykf65iGmWSVHflACtgjxAt7eXybSb6DoVzySJpQ3CputA9F00PL11pA/b9hY+w5w==
X-Received: by 2002:a65:6543:: with SMTP id a3mr36182894pgw.246.1625099757072;
        Wed, 30 Jun 2021 17:35:57 -0700 (PDT)
Received: from localhost ([2402:800:63b8:8e5c:5bd7:f8a:333f:cf5])
        by smtp.gmail.com with ESMTPSA id i18sm11157924pfa.37.2021.06.30.17.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 17:35:56 -0700 (PDT)
Date:   Thu, 1 Jul 2021 07:35:54 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Alan Blotz <work@blotz.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git difftool: No such file or directory
Message-ID: <YN0N6tUeSJM1EBHD@danh.dev>
References: <176caa21-0232-9f21-7a8d-af136754e354@blotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176caa21-0232-9f21-7a8d-af136754e354@blotz.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-30 11:38:21+0200, Alan Blotz <work@blotz.org> wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> mkdir broken-diff
> cd broken-diff
> git init
> mkdir dir1
> mkdir dir2
> touch dir1/orig
> cd dir2/
> ln -s ../dir1/orig sym
> cd ..
> git add dir*
> git ci -m "init"
> git checkout -b b
> git rm dir2/sym 
> git ci -m "remove"
> git difftool -d master HEAD
> 
> What did you expect to happen? (Expected behavior)
> 
> git difftool shall compare both branches.
> 
> What happened instead? (Actual behavior)
> 
> git difftool prints an error:
> 
> fatal: could not open '/tmp/git-difftool.l4UM7e/left/dir2/sym' for writing: No such file or directory

It looks like this behaviour was there from the time difftool was
re-written in C in 03831ef7b5, (difftool: implement the functionality
in the builtin, 2017-01-19). The perl version didn't have this
problem.

The perl version create a file in place of that symlink and write the
symlink's target into that file. The C version tries to write (and
follow?) the symlink.

This hack can fix the problem but I'm not sure it's correct:
----8<---

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 2115e548a5..737ebb5b1a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -492,12 +492,14 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (*entry->left) {
 			add_path(&ldir, ldir_len, entry->path);
 			ensure_leading_directories(ldir.buf);
-			write_file(ldir.buf, "%s", entry->left);
+			unlink(ldir.buf);
+			write_file_buf(ldir.buf, entry->left, strlen(entry->left));
 		}
 		if (*entry->right) {
 			add_path(&rdir, rdir_len, entry->path);
 			ensure_leading_directories(rdir.buf);
-			write_file(rdir.buf, "%s", entry->right);
+			unlink(rdir.buf);
+			write_file_buf(rdir.buf, entry->right, strlen(entry->right));
 		}
 	}
---->8----- 

+Cc: Dscho, who wrote the C version.

-- 
Danh
