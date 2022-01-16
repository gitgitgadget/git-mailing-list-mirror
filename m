Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF9C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 04:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiAPE0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiAPE0G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 23:26:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07668C061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 20:26:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c71so50536768edf.6
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 20:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWOvg/qVrXEvu3k4hkKpCEA5dOcKq8wFurftz6AYIZE=;
        b=O7SQBSSH30BnC3EZ0h+3jjMAI2g+vussv4OUTIL8MDlwvYdI1h54G3UFRAlqIqTUJU
         lh50lftm92Y72tYd6inASL6JopHfCcLX3g7S76a9w8c7j5Cgcc8TgtoukFEicsZqB6jK
         0sLGRpoT/OvsLZSbSkGeQ6SwsMGk7vhs3QTENzOtvPUt8nzTI+WFXMBfS2rASrIrwLzW
         OlF2nOb4V/UdWWP7khDE3LQwUQeIfWjsbXJVsdWvreFfnNZvqAoIh2BDB/uSVz8HW6s7
         GPJvJDAaB2lXbu/tN2cuQmwnVYTIMxTsZpnfF6GhDdqQJqOhrmXBfKMWWA5fIPSP4KAS
         xC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWOvg/qVrXEvu3k4hkKpCEA5dOcKq8wFurftz6AYIZE=;
        b=ObSUFX2WjcvEhCN06RupSCeg4mz0hq1cawz2oUEj9sbMelLUBLCQfb0EWoXKsfHyE3
         hOpSzERdY/phJEtd4lT8idJsxcYfACkZJYF8QHPKnzSpTp9qECsQiYzUS/06V96zhfGM
         IT1YDPUpqw4cZUEIqWnLJdZHQOlwuB9ALb0PcN/xzocT5Q0fr0fJ5x2Tg8LWQxfMokm4
         3OepGiFD4nuWenBQM5Wek2WXALR21CDdvCGDIK5Dc0StBwm8rMk6k+IM0AipHUO+Hs0V
         hGfgjXEHxe8cR8L+61X1XbUGIC8SzAfS7Xf1V53gvDUUF5FZBC9sALqvtJJQSjdNRtQt
         CPLw==
X-Gm-Message-State: AOAM533BnkLe0zQpzGoXj07RWxQu1CfT2DK3YHYoXCGuyMEzvxLqYFwn
        SAK6xUelOKMYnEgvTItyBneIXLGKXzZUPzangQk=
X-Google-Smtp-Source: ABdhPJzMByyyHiiG4mChpbfqKU8tZEqOHdg5CMGF4E0Ph5fdrgGmVmd8IYe7T/aGNWJFB1orYLkmSnyfzxDxjIvU+BQ=
X-Received: by 2002:a05:6402:c19:: with SMTP id co25mr15549846edb.33.1642307164429;
 Sat, 15 Jan 2022 20:26:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqqy23h4nss.fsf@gitster.g>
In-Reply-To: <xmqqy23h4nss.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Jan 2022 20:25:53 -0800
Message-ID: <CABPp-BEROAzba2jDrBhyq1tzZZDYUqROAUGTNp4fNOHfYB3vOg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #04; Fri, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 15, 2022 at 9:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/present-despite-skipped (2022-01-14) 6 commits
>  - Accelerate clear_skip_worktree_from_present_files() by caching
>  - Update documentation related to sparsity and the skip-worktree bit
>  - repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>  - unpack-trees: fix accidental loss of user changes
>  - t1011: add testcase demonstrating accidental loss of user modifications
>  - Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>  (this branch uses vd/sparse-clean-etc.)
>
>  (NEEDSWORK: BY DOING WHAT), cope better with files on the working
>  tree that should not exist according to the sparse checkout
>  settings.
>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>

Perhaps:

In sparse-checkouts, files mis-marked as missing from the working tree
could lead to later problems.  Such files were hard to discover, and
harder to correct.  Automatically detecting and correcting the marking
of such files has been added to avoid these problems.
