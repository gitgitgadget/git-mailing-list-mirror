Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743DFC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 21:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCC62072C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=barzilay-org.20150623.gappssmtp.com header.i=@barzilay-org.20150623.gappssmtp.com header.b="O/BPs+4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKBVGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBVGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 16:06:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4985C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 13:06:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k9so15801578edo.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 13:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e3tYKmBwpm4YobrTew4PIA6vVlqjp1s03Ajtlu0GHAU=;
        b=O/BPs+4FxYi5OyKN8TSR95ZR6TOmq4yHMf8Kt047jrHNKCw4jQJvVFrS8IFyqgIGA1
         DtkyOEP6VjLhqiab6l0YdevGfmML+vqWJcLTtVQwLw1iMU3q0pe1WE3vqREU3IU5H0MM
         64E3aJUZrNmNzenK4als7K+VJ2NAhZC20oYawichJCYRyU0SBameBftK9z9y0wSHtxc/
         abm062RyiCYpLp8XVtbcY3bSKDdQ03DEwXH6yaWswj90O1dQ/a0SN00J1JH40vVt8/pk
         sFF60emy3QsW/zDWJOSwfcVKAjNTE7EJ5/r8PlhCJpS6DM3abG2yWJfwxjvlbVrLB4QF
         Ty5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e3tYKmBwpm4YobrTew4PIA6vVlqjp1s03Ajtlu0GHAU=;
        b=AkvgCUcwo/EhdQqDqwz6eIZsCaHg00q1EQ+iwO/cFuafj3zl+lpZpuB0HgLhtR9Mcv
         BDr9PFdZfPcQURjbVIFd2skB/87TOGBoYfhi7QQ+p2LzWPb+34ObJ2RwILVI1JDIGr8s
         4Hka5Z/XOCdK+mNGXhBP+LxOqFAiK9JVZBXkTSHj/OeXSsAl8LtaUVDW9Dfb/SRlJ+xn
         zq9n1rHCCZL7BOUPcnNlVQXtDwim1dc3CsFWo0zIg1guLyERKPpoUIMSJlzxE2nGRMQF
         nsGuAbwQa6lNFQ8scjJ1fopvKOutUQZyI1jJTLEZpj8dc29OLp9uhY/8XvrTjF2m7N1G
         XWBg==
X-Gm-Message-State: AOAM533yJ/v3qiY/sWX74ZagqOSji1B0Sf+H6XvKiCOA2MA0Zef/HVbS
        exc5rBcVJg2/thNSf2jrYgQEjjHzvGnoBUQDXK3ulWPibFFITA==
X-Google-Smtp-Source: ABdhPJwFUCQh1agRTgnxeW7JIK94FbslUxZMZF6UBG1XZqVlRfUVd//UqWmIbrbFXuGE2czwQo7pCjwzUG+YPGESoD4=
X-Received: by 2002:aa7:da0a:: with SMTP id r10mr3461670eds.102.1604351203140;
 Mon, 02 Nov 2020 13:06:43 -0800 (PST)
MIME-Version: 1.0
References: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
 <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de>
In-Reply-To: <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de>
From:   Eli Barzilay <eli@barzilay.org>
Date:   Mon, 2 Nov 2020 16:06:49 -0500
Message-ID: <CALO-gusRt4J5ar45mo7un-EENyt5cX2SQvcXgyMmaHNZg5bFUg@mail.gmail.com>
Subject: Re: git-diff bug?
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 12:45 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
>     $ printf "aaa\nbbb\nccc\n\n" > 1
>     $ printf "aaa\nbbb\n\nccc\n" > 2
>
>     $ diff --ignore-blank-lines -u 1 2
>     --- 1       2020-11-02 18:11:04.618133008 +0100
>     +++ 2       2020-11-02 18:11:04.618133008 +0100
>     @@ -1,4 +1,4 @@
>      aaa
>      bbb
>     -ccc
>
>     +ccc
>     $ diff --ignore-blank-lines -u 2 1

Yes, this is what I'm getting, also without a -u.  (Also on 2.29.2)


> This matches your results.  That the order makes a difference is a bit
> odd.  Both are valid diffs of the inputs and neither one changes blank
> lines, though, so it doesn't look like a bug.

How is it valid?  Isn't the whole point of `--ignore-blank-lines` to
do the same thing as comparing a version of the files that drops all
empty lines?

>
>     $ git diff --ignore-blank-lines 1 2
>     $ git diff --ignore-blank-lines 2 1
>     $ git --version
>     git version 2.29.2
>
> This matches your expectation, but not your results.  Which version do
> you use?

$ git diff --ignore-blank-lines 1 2
diff --git a/1 b/2
index fc13a35..bd05737 100644
--- a/1
+++ b/2
@@ -1,4 +1,4 @@
 aaa
 bbb
-ccc

+ccc
$ git --version
git version 2.29.2


--=20
                   ((x=3D>x(x))(x=3D>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
