Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B14C001DF
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 07:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjGYHKa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 Jul 2023 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGYHK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 03:10:28 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88DDBD
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 00:10:27 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63ce8bea776so16867386d6.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 00:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269027; x=1690873827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEGbdlFuet5ATfcjXFDVB0l4+Pt4aN4RrZby15x1Jbo=;
        b=bejJE29x9YiojYfJDEJVeLtEdq9gRN16S5Zi9JbgMXmG095rqzpQBvvLOvWhn7YK7N
         Dl6mt9RteML0lcGmWTJHgco5pA1gCoEGkxZt3aIhDBQjBDpw7qN0uoK+ngWQ/ZjTC85a
         UgHc/mpqxgGTzakJW851W22+UW8SaYq3jPO2VlVeG63fb8yXQg2ar0UMP8yRXhlOs6TO
         b1jdy+1VKaTtQ/ZIxfCRAvAOSIyStWkc6ZSsUmlOwEOVr91NtYjbWUK3A1/TeuP7qlNW
         jAx7b6Zwp49cktw1rD6iYtEcHbkH32JydMpR+gkpXlcjcfgswsfIuSUl39IJTcb0Dh+Y
         34aQ==
X-Gm-Message-State: ABy/qLZZrN6ZMILatN1prhXubGv5hAJ9yMRBZwOzJWmbUCJJKxUmwWEz
        08SFo4/FSsoJvX78F5dygbcVGYpiSRSxtcO6Png=
X-Google-Smtp-Source: APBJJlHkbEp+DoBiKjoSW10vwzc4jZKsAbDFDxCrFPCxcpxAZZdCiQkYVnJFBoQfPqzET7e9+zXXIOwUlZLX99gMwEs=
X-Received: by 2002:a0c:e60e:0:b0:63d:669:6455 with SMTP id
 z14-20020a0ce60e000000b0063d06696455mr1820212qvm.50.1690269026687; Tue, 25
 Jul 2023 00:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230725063516.27242-1-aherrmann@suse.de>
In-Reply-To: <20230725063516.27242-1-aherrmann@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Jul 2023 03:10:15 -0400
Message-ID: <CAPig+cS8=iJD4fwvSacvWTK0WUH_DyjkQuMVP00aV+e4Q4TL3g@mail.gmail.com>
Subject: Re: [PATCH] t4002: fix test #63 (missing whitespace)
To:     Andreas Herrmann <aherrmann@suse.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 2:48 AM Andreas Herrmann <aherrmann@suse.de> wrote:
> Add missing whitespace between 'test_expect_success' and test case
> description for last test. Without this, we get:
>
> t4002-diff-basic.sh: line 412: test_expect_successdiff can read from stdin: command not found
>
> Signed-off-by: Andreas Herrmann <aherrmann@suse.de>

Thanks for finding this problem and submitting a fix. You're the
second person to do so[1].

[1]: https://lore.kernel.org/git/pull.1545.git.git.1689341410476.gitgitgadget@gmail.com/

> diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
> @@ -401,9 +401,10 @@ test_expect_success 'diff-tree B A == diff-tree -R A B' '
>  test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
>         git diff-tree -r $tree_B $tree_A >.test-a &&
>         git diff-tree -r -R $tree_A $tree_B >.test-b &&
> -       cmp -s .test-a .test-b'
> +       cmp -s .test-a .test-b
> +'

This minor style fixup could be resubmitted as a standalone patch,
though it might be too minor to worry about.

> -test_expect_success'diff can read from stdin' '
> +test_expect_success 'diff can read from stdin' '
>         test_must_fail git diff --no-index -- MN - < NN |
>                 grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
>         test_must_fail git diff --no-index -- MN NN |
