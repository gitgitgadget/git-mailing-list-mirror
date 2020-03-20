Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D2C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A152070A
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE+ygB4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCTPqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:46:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46560 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTPqI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:46:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id d23so6859140ljg.13
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AqMi3hXC44RxHM5spVgQkQyUyF+btDoCw12MgBz8Rdc=;
        b=KE+ygB4HBFm7eXPAOeK/tSaS7APM++DmuwIO6FKCn+ea+ScpTpK6CS0FmtodYl8F76
         4RsahyfjavsENyT7VTsc+wMa8NCUnYHGK2pdyAcx0nJtLMH5j+BTQxgTtm2GQ+Y+2Y/A
         vqMYGcZYgVElh1ORpToE/pylA4hBEoSWOXfk9Fh+fXG0fBCHvuL5PGv/dHAtoODmL0a8
         SgnX7teFfukj+6F8RgjBcduN8QmwSukTXeAJ1i0TG1oo/02ywrTPLwG9K8Ie0hCYiNmo
         haG2IPSH+/uw/WIdMErjLSLOLcPzM2+fykLXykVKGaexhbdAV53ptNtAO1MzWWrqC2Hf
         5Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AqMi3hXC44RxHM5spVgQkQyUyF+btDoCw12MgBz8Rdc=;
        b=NO9VDIXyd5Im0dBUSRlcUi8A8WOHHqOJvOK31pSEWVNn43ZyM8e3EcSnk6+EJ+WQw8
         QKvJLwk1cgpjf1o4j8NELyXd57m4MXk9D6WpsGIXQvI4jCumtQ1YkIGRqUEXc5R8u2NQ
         m2uv9+cKSHQ1SieEnqxEa4Qno6rUt4otouQMSEk77aqmmCfILUwWb69K95NgtCqWwpc2
         Buw08tWxpYYFVcbVVlvX8iuuhaIFc4pG2AyfaVYN+JYBKcuvgpysXQXWKBNiu5Z2SUfs
         0avX8yJEy1zfX51wSW4vEq7FzFzEEgb3lLNTo4pnOlx+j/aL1548V8yA8mRWfz0iE30z
         tugg==
X-Gm-Message-State: ANhLgQ2p8TfYOhy7No8w7DmsC+sQy5lGuSP8GZPZ4pDQD6zoHWA3AKHv
        cDF2YSHXWK8Q9Sb3P8flfRXHz/Val3gZb9LJgYC8wPgMG6PrQw==
X-Google-Smtp-Source: ADFU+vuHANd6wpI01xVysz4L2tW4SHgUA6bvTpZMFEtZE87lQ1WBZFVAXmnrONQXm6Mi0IFxuVRPw4xEyw2AjhChBq8=
X-Received: by 2002:a05:651c:1047:: with SMTP id x7mr5777860ljm.246.1584719165429;
 Fri, 20 Mar 2020 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200319234723.6504-1-adrianwijaya100@gmail.com>
In-Reply-To: <20200319234723.6504-1-adrianwijaya100@gmail.com>
From:   adrian wijaya <adrianwijaya100@gmail.com>
Date:   Fri, 20 Mar 2020 22:45:53 +0700
Message-ID: <CA+0Uiy-gtdn07=QOx3JcOH-zhMz5yAKOW6=9mNc8Zi+RdfWGyQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH 1/2] t1300: replace "test -f" into "test_path_is_file"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 5fb689207ebe06b5f4c506b0b184c95a8a2e529d Mon Sep 17 00:00:00 2001
From: Adrian Wijaya <adrianwijaya100@gmail.com>
Date: Thu, 19 Mar 2020 21:13:44 +0700
Subject: [GSOC][PATCH v2] t1300: convert "test -f" with "test_path_is_file"

Convert "test -f" with "test_path_is_file" to give more verbose
test output on failure.

Signed-off-by: Adrian Wijaya <adrianwijaya100@gmail.com>
---
 t/t1300-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..d74554fc09 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1020,11 +1020,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
     ln -s notyet myconfig &&
     git config --file=myconfig test.frotz nitfol &&
     test -h myconfig &&
-    test -f notyet &&
+    test_path_is_file notyet &&
     test "z$(git config --file=notyet test.frotz)" = znitfol &&
     git config --file=myconfig test.xyzzy rezrov &&
     test -h myconfig &&
-    test -f notyet &&
+    test_path_is_file notyet &&
     cat >expect <<-\EOF &&
     nitfol
     rezrov
-- 
2.26.0.rc1.11.g30e9940356

On Fri, Mar 20, 2020 at 6:47 AM Adrian Wijaya <adrianwijaya100@gmail.com> wrote:
>
> Dear all,
>
> In this year, I intend to apply in git for GSoC 2020. This is actually my
> first contribution to the git community. I am a sophomore Computer Science
> student at University of Indonesia.
>
> In this patch, I have replaced 'test -f' into 'test_path_is_file' function
> (can be found in test-lib-functions).
>
> Suggestions and advice are very welcome.
>
> Regards,
> Adrian Wijaya
