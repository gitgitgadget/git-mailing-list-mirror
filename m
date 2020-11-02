Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EBDC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBE021556
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnrBVmS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKBTMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:33 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D295C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 11:12:33 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id a20so13924198ilk.13
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=f/VSQJK2QyK8jMdUVMF73HnJ7EG6vy29OL5elX34mnw=;
        b=mnrBVmS79y3ac6fwJfOXEeMG5X+7llYLCRv9Fb2oeAYvnAfTO+8AUm7GcGxG6FOUeF
         OeAnmW2yisStK/dDzA8f+AAqh7A1vGsqrppOcmq7jLV20/LuJbm3vRlqjeTWRgwmXOyv
         H5n1DyvN+6VVMpboMnsw6qeXZIyrtwpN/U23V50/GfZS92qgjDkHgUiGYPaFvtuOQQzI
         V9qxiXCHm9Y9fxaKlR4UMDBmgnOmiqxZJn6gqk2RscCDrr9DqJuOixP4+jhAWmYu+oAz
         5+Zx+MmgiiKtutQ5nOTX2pfgxSufODhJpGitTzkInhehdCxdFq5cyL1tZKuAMpifoaOJ
         oTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=f/VSQJK2QyK8jMdUVMF73HnJ7EG6vy29OL5elX34mnw=;
        b=Ojl3ODTIVMsYvZSp55DEdD0q9bj/5vE/8l6GtzhPyk9siMgdOqqxoUf6rW9W71StDs
         3RQS4GtrCMsF3bwWyEFq28J5LogQXsuGhQ1KM80ne7eRQQ+0Yy34tqZjihk92jY/mgC/
         z5UAuLnWhfACuWD5zkG+IW4fcdI0LgbtS8su2PJ3LbE2WF/jlv1DvOslnL4vbIE+VAbL
         dVPAIGdzeYSCvz3W6DcV4BUlGRSJJgwnf5PDgcxRKtqqbwDh6KK6HBAYRj6Mp44x/7mm
         X6tjJr7jdOcHjTcNYF/tRWjfLrcUrB3YLUM7mQVHhCe/3AwJ09ACOBc6t5np5WcBtwf1
         M+xg==
X-Gm-Message-State: AOAM530xI96t852Fhi0Slc0NlbAJnkxksp8Mq/Rh9epdozXOONzzrZc+
        ff8BjUf3/SS5qPmnDluy9ayNohS/3/oeF4o3kwyqTV/rKVdZl75L
X-Google-Smtp-Source: ABdhPJyKvpPoz/lhf1MQBsTU3wxif6ca7RpCEluOAy2qxr6YkeTCFN+P6ajt8V+e1D1d3B4q1GDAh/rPrdCgZK3bzmQ=
X-Received: by 2002:a05:6e02:4ad:: with SMTP id e13mr10942143ils.59.1604344352138;
 Mon, 02 Nov 2020 11:12:32 -0800 (PST)
MIME-Version: 1.0
References: <CAFzd1+7xQHgaOYKW7WZaWCPdp85Pfk8k_M-gVtBq6Wf7bbJTzg@mail.gmail.com>
In-Reply-To: <CAFzd1+7xQHgaOYKW7WZaWCPdp85Pfk8k_M-gVtBq6Wf7bbJTzg@mail.gmail.com>
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Mon, 2 Nov 2020 20:12:07 +0100
Message-ID: <CAFzd1+7VxaGGMVKicuy8KnWdZoBxEHY8xS9kK1VF0Tgai=Kcxg@mail.gmail.com>
Subject: Re: BUG: commit-graph.c:1068 when doing `git pull`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A

    $ git commit-graph write

did the trick.

Let me know if you think there could be something useful to reproduce,
somewhere.

Regards
Caspar Duregger

Am Mo., 2. Nov. 2020 um 19:30 Uhr schrieb herr.kaste <herr.kaste@gmail.com>:
>
> Hi all!
>
> I'm stuck with this error message
>
>     $ git pull
>     BUG: commit-graph.c:1068: missing parent
> 104f5eb377763b2ed9663e8949aed265b69f000f for commit
> c59ed9b7b6d4268ae6cb1069a9b51e02ad9aa1d8
>
> This happens since the last `fetch --prune origin`.
>
> If I do it again, I get
>
>     $ git pull
>     fatal: Unable to create 'C:/Users/c-flo/AppData/Roaming/Sublime
> Text 3/Packages/GitSavvy/.git/objects/info/commit-graphs/commit-graph-chain.lock':
> File exists.
>     ...
>
> And upon removing that file, I get the first error message again.
>
> I actually don't know yet how to move on from here.  I'm stuck, so I
> appreciate any help.
>
>     $ git --version
>     git version 2.29.2.windows.1
>
>
> Regards
> Caspar Duregger
