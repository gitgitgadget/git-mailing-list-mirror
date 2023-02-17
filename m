Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A76C61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 03:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBQDPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQDPS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 22:15:18 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2C5455A
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 19:15:17 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17068acb0c2so63158fac.6
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LZdWkawhb+YpYfzodDHUnRiOPHZJjHI1ZacIDD8OLU=;
        b=AZXRfWDVFfuMmD73I7wOVzi//pmZM/fNxQM708fsZFQlwrCBgbOchUzqzKsVcGv5tX
         adzNqHWdCqCEGA3EKSU2f/ojUNpilOROvNh+7hgIC0xjcotAmOZIBLVxAfKJ0AegERw0
         QguG4Wfi62nQY2CoNJhDMmuTJgH1nqouI+WSCKKtAMt7t4j+M1HDodMyczAVauzYQuzJ
         HClNvb5ehZtuc/b+5aTp+P2HhcATvhohAL9nE/hkbFG0znEehPnjlHgJlOdlZSQCp6Wb
         egZ24DZPIi357R3Dwr9usZh9+yIK6v7QUbiJqRBMnq0N/hKMvl5Z9hl/Qo6IGI9NZWez
         TUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LZdWkawhb+YpYfzodDHUnRiOPHZJjHI1ZacIDD8OLU=;
        b=xLklTGmdT7aEfdiRA2jDvE+HpZB1DA8EYwHRLwaJXoGyauTpNW2akHfJeHxNzFWaj2
         l03I2dDD6eKuZBaXYAoMdIbwgMq8VTf5Fc9A1YBvJmm6VgOc9LK2hkNGyuVivIMSlJJs
         /cUzB65yFtd5h2l0bpRmyZ37AILvDPa2Uhc26j5ImzWdlGr9ShrjsgzKmAMpAwKB3cTA
         CKxNwPcfiHg5giX8sQwiU8zejYGCvbbeNbOM1CC8ISJ88zJRuk9kODkVnEsg7FRPBSBb
         emcHb91sqQgT0nk04gtM2DpRms9TCaYNlLaoltC9Xo/Q+/FgOg4KkxKLi3cSXPBy5v3P
         GQ1w==
X-Gm-Message-State: AO0yUKXeo/Z41NTxikku1NPb4O28JkeciUUY5EwWn+CLE/7rttRYkd3e
        L4xkzJXYS9uhNMWZx2W5TDq/SpQjHYWPBTwnIJ7+d5RM
X-Google-Smtp-Source: AK7set+JQ1dVtrHeRrwG3/n1E2vmLJTSCP4VkLgqb2R5hzLavFlUbY1TsE51x8ph11GEjRWbiNfz/OwRqyOYa7ipCY4=
X-Received: by 2002:a05:6870:5d06:b0:16e:4b62:df20 with SMTP id
 fv6-20020a0568705d0600b0016e4b62df20mr301272oab.141.1676603716745; Thu, 16
 Feb 2023 19:15:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com> <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
In-Reply-To: <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 16 Feb 2023 20:15:05 -0700
Message-ID: <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 5:31 AM Tao Klerks <tao@klerks.biz> wrote:
>
> If there's an appetite for it, I would love to contribute to a
> multi-year adventure to change git's behavior, little by little, until
> the behavior of "rebase=merges" is the default, and the old behavior
> becomes a different option like
> "rebase=copy-merged-commits-to-flatten"

I know you had a lot to say in your last email, but I'd like to focus
on this point. I would be OK with the proposed patch if it were part
of a larger effort to make --rebase-merges the default behavior of
`git rebase`. That seems like an achievable goal, and I don't think it
would take multiple years, maybe one year at the most. The process
would look something like this:

1. Add a --no-rebase-merges option to `git rebase`.

2. Add a rebase.merges config option.

3. Add a warning to `git rebase` that appears if rebase.merges is
unset and neither --rebase-merges nor --no-rebase-merges is given. The
warning would advise the user that the default behavior of `git
rebase` will change in a future release and suggest setting
rebase.merges=no-rebase-cousins to get the new behavior now.

4. Change the `git pull` advice to recommend --rebase=merges and
pull.rebase=merges.

5. Wait a couple of releases.

6. Change the default behavior of `git rebase` to `git rebase
--rebase-merges` and the default behavior of `git pull --rebase` to
`git pull --rebase=merges`. At the same time, remove the warning from
`git rebase`. The old `git pull` behavior would still be available as
`git pull --rebase=true`.

7. Change the `git pull` advice to recommend the short and simple
--rebase option again (leaving the recommendation of
pull.rebase=merges for the config option).

Does that sound reasonable? I think I could lend a hand with steps 1-3.

-Alex
