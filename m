Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC6C4332F
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 20:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiJFU7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiJFU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 16:59:05 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF43BBE12
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 13:59:04 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id l127so2238353iof.12
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 13:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUWF3fMD7uGQu4vIQZeUZtWjisxJHfY+GOqoT+UHQ18=;
        b=V4wl/Xb5jD5WRoXZwhlSiNI1tuosZXLvc+uNQN1I+HlLkk/tU24chLJXUBmgFC6Nna
         sE/z8lUdU/mXwnfBYQtQBUcSWuRz3Q41h7N6eRZVvknXbrwY5gVmtmsxtY2FTGr5euKR
         DkMRDLlJX3+3r7MuHkX+OnyYg/FAH+jUzl1hofCeEKb1q3YMemgp4EOHTAXZN2cNj0UU
         jL/JmrnjerZBG4qw6BIi23hpXSIrSA50eEAj3fHiDy8nO5vgP6HWD3Gqn5vJN8z6daz6
         EXro5ewzKiTfuG1oiggv4qTxlw/wBTDMgFDrN5+2Mys4/Ro1FODPutNGNg5tX1NDFbTd
         Gxqw==
X-Gm-Message-State: ACrzQf37eAxSWmJ3aWYuwHBpvnrNm2KTeI2Zu5AUKClq7bu1kyntMekl
        z8rHdwxSDToBEUvbzSEH1Z7j/vvpgQ42ycHLBG0=
X-Google-Smtp-Source: AMsMyM5gOFR/MrRmnkozjSo5HlGO5Gsjj7Dod9TZXYv3KyFt9+2mHAzSPargUgh4NwHj24fCEQHxetYj8wF6yY52ll4=
X-Received: by 2002:a05:6602:2c89:b0:67b:7e8c:11c1 with SMTP id
 i9-20020a0566022c8900b0067b7e8c11c1mr793006iow.101.1665089943950; Thu, 06 Oct
 2022 13:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com> <xmqqh70gk7qk.fsf@gitster.g>
In-Reply-To: <xmqqh70gk7qk.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Oct 2022 16:58:53 -0400
Message-ID: <CAPig+cRKwe-yEpYv=WAnwFBsBtTAkHuujvajokNZ0qm989LRdA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2022 at 4:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This patch series fixes three syntax errors that caused compiler errors with
> > clang 11.0.0 on MacOS. I've included the error/warning messages in the
> > commit messages. The offending statements did compile successfully under
> > clang 14.0.0 on MacOS, so I have to assume that this usage is newer than
> > what clang 11 supports.
>
> Ah, this looked familiar, and the last time we saw the one in
> builtin/unpack-objects.c
>
> https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/
>
> It seems that merge-file.c was OK back then but soon after we
> "broke" it with 480a0e30 (merge-file: refactor for subsequent memory
> leak fix, 2022-07-01).

For completeness, the merge-file.c instance also got reported:
https://lore.kernel.org/git/365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com/
