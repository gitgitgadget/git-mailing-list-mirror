Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5BC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7011661026
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbhIAVnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhIAVnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 17:43:25 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C4DC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 14:42:28 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso1542622ota.8
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+JmOP+y7eJP8yvCpqC2Tk1tMOHD5o5diHtOa+1QCBo=;
        b=Ou9e49FYHUH1SJ64wRM/4oWn4zOjvuUIHuc5d7eV8SFnAPgGT81feFfUs3sg98dLrY
         bSNjzebAbsZ09ZZQY6TLm65ur9x0jEfMsgH99ydBJPUbruHKRcrv7eSX/PzcwpD43nvu
         e5IURSY9Tz5ZpmUO5ZEmpiizcqg8MQCFpf6cLp2va27BrykK5n2USvE4jqERQMsd8/xd
         lH3L08P6nMSNeiAUGUP4QmeMN0KHTewAx+KgUMuqdfrD5CZHskOiXeh2kSbtlhis1eSK
         bnrzUH12SdHz3w8lUcqw9s8h3O7lIigVOOsV/XvsTP5FuS7+8/DFuM3wdPcU9eWGIS7V
         Wu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+JmOP+y7eJP8yvCpqC2Tk1tMOHD5o5diHtOa+1QCBo=;
        b=ZFyXhXZz5g4X5plRBSPiHTZuNyC/PpdrqrUbergz4hWKUVIO5/cPqwOVJ2eCdCNpsA
         PKQbA/8r8FYjRvuLwrgNH7O3PZ2u15naUIlxKoG0YJnEpRBvbaOoXx71+7JiqTqLJxb9
         0OsLLV2G+U4ze0jUfjhRrSv2TLwKOQZe342JTfApYUBah+H7ZsHecxC9n+tmqJ+ndZQM
         LBqqKFZ0CAV6Q75raPZlIJfiqVFaAMgcW+3k+Cy49H03v4m5K9HkMyD7E21L0qyB0qBA
         726DKWvVAZ69NvthiytSrVVM7YsenYeSxffXerZAddArNhnaXFzDU39lUmeH6kOnRY8p
         chTg==
X-Gm-Message-State: AOAM532229bsFXnUnqfS3K6By0LhXan3hTKfc1jlt/ajQQ1NIPSZBAVJ
        30GZ1sqwRQXAiIdhPXs3JUa7i2Lj/+lWtspkTMgv29MneCA=
X-Google-Smtp-Source: ABdhPJywVI+ARbSgfME7T60dxrNKJPuQsaJ4f+19/Og5NhjLVEZ5EOiKZHYMHAgWFwaDLHCckpSdqHQ1Z31wVo8efAA=
X-Received: by 2002:a05:6830:b8e:: with SMTP id a14mr1342644otv.162.1630532547349;
 Wed, 01 Sep 2021 14:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com> <xmqqy28gngwj.fsf@gitster.g>
In-Reply-To: <xmqqy28gngwj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Sep 2021 14:42:16 -0700
Message-ID: <CABPp-BENXw11v3KxkFL+NsF5Qo7Pff1QdyxG2YxQB+SV6Or-Hg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 1, 2021 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Here are some patches to add a --remerge-diff capability to show & log,
>
> One sad omission from the maintainer usecase is that we do not seem
> to know "git diff --remerge-diff" yet during a conflicted merge.
>
> "git diff [-- <path>]" before recording the resolution for the path
> with "git add <path>" shows combined patch to give a final sanity
> check before committing it to the rerere database.  I am wondering
> if viewing it in the --remrege-diff format instead would help this
> step even more.

We do have `git diff AUTO_MERGE`, though.  It's not quite the same as
it doesn't include all the "CONFLICT" messages shown in the terminal
like --remerge-diff does with log/show, but otherwise it's the same.
Perhaps we could even alias `git diff --remerge-diff` to `git diff
AUTO_MERGE`?

See commit 5291828df838 (merge-ort: write $GIT_DIR/AUTO_MERGE whenever
we hit a conflict, 2021-03-20) for more details.
