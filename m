Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC65C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 02:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiCBCdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 21:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiCBCdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 21:33:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AE336E05
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 18:32:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i11so334961eda.9
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 18:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SS9hUhg78FT6bUIxkhEr+mazVkEcNm/syLCJ32ovF7c=;
        b=FpTXzl3KvtfyxtctsG6GbjC4+hNDYR40Po9NJR9sGCSn0Hre2CioCZu/NjHZoZIkw0
         GI3RjPw3cx0mscriWgrftAt7Zib3mhi9rYni4f4AOocAh6KY89eNteGeH9oqGOrTHQ4x
         W9hn51d+FXqyqPe/JgZANP3VmD6MG0+eatCkdVtb/Dg58SkSUiib4yaiHxbIUFymsSiP
         83Cz3KkCi5CBBzWVw7/ukgbt2wdmJnAZyeM/lI6aG055A5WZONI/U/fePqTAZ4L7y9w1
         paefpdl5yFrdDkrdyAr7tMZk6d71023NrrmBeuBaGkdJE5JwS7bRCUOUm93zb63Ex0TD
         b+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS9hUhg78FT6bUIxkhEr+mazVkEcNm/syLCJ32ovF7c=;
        b=uEpUBhqh4K8IVMtnNx0JIpIjAt6jyy3xzuCSx9c6rM1K9ujN0AgRvqgMTPG7ahP3Sl
         vzh0fEXydyY7GF+yFUFL7260hIWC6FSLMNgc/1ea4TSeisKkwW9dlPYVrgMYq0EcpHSV
         Y4nDOTCpucAsVeoTsElEpQlW+7pV9mP7Q9zfYMAkF4p4rp9UA+4++T1ixtbFS9i26yM+
         vSZiyy6d/R4zvKwph1rcn7IC7vFuv74Zx2biMQvqQlczUbEBQ60hPrrE3TPPOCeqf49o
         tXQwD+TgMWdN5SOqDaMfY6C8tbXk1NGlI0ZKw79/SQZ8uweaysQlOEYlZeK002C3eYzc
         HomA==
X-Gm-Message-State: AOAM532/8BVFsQN0S0ADew8YwHs7rZ9O3wQeKsVKHQR8P2egFPXFCv04
        jtKEFqSzeniRedIEiyU7qWVMMQYw9tJ7yeogFoM=
X-Google-Smtp-Source: ABdhPJzbXeVLZy0sAsiwESMbMRkqCTUelLfAlXsa95IbzSZIQ3ZNUViOzp85PGIosC1KQ9/17GQQ3WQIQAQG+7ZDl4s=
X-Received: by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id
 b5-20020a056402138500b004132bc64400mr27228177edv.94.1646188351912; Tue, 01
 Mar 2022 18:32:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1121.git.1645079923090.gitgitgadget@gmail.com>
 <xmqqsfsh5btd.fsf@gitster.g> <xmqqwnheuq79.fsf@gitster.g>
In-Reply-To: <xmqqwnheuq79.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Mar 2022 18:32:20 -0800
Message-ID: <CABPp-BFgLfjLBEK96SLaLxoq6Nspse=FBgViKfiQPk4GaQadFQ@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: make informational messages from recursive
 merges clearer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 10:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> One other thing to note here, that I didn't notice until typing up this
> >> commit message, is that merge-recursive does not print any messages from
> >> the inner merges by default; the extra verbosity has to be requested.
> >> merge-ort currently has no verbosity controls and always prints these.
> >> We may also want to change that, but for now, just make the output
> >> clearer with these extra markings and indentation.
> >
> > Yup, I found that the messages on inner conflicts, especially when
> > they "cancel out" at the outer merge, are mostly noise that carries
> > very little useful information (by being noisy, the user gets a sense
> > of how complex the histories being merged are).  Reducing the default
> > messaging level would probably be a good idea.
>
> Here is what I just had to scroll through to update 'next' by
> merging back 'master', only to grab the updates to the release
> notes.  Needless to say, this would have been somewhat baffling
> if I didn't know to expect it.
>
> It would be good to squelch it before we hear another complaints
> from old-timer power users ;-)

I'll submit a patch soon.

>
> $ git merge -m 'Sync with master' --no-log master
>   From inner merge:  Auto-merging blame.c
>   From inner merge:  Auto-merging builtin/am.c
>   From inner merge:  Auto-merging builtin/blame.c
>   From inner merge:  Auto-merging builtin/clone.c
>   From inner merge:  Auto-merging builtin/clone.c
>   From inner merge:  Auto-merging builtin/commit.c
>   From inner merge:  Auto-merging builtin/fetch.c
>   From inner merge:  Auto-merging builtin/fetch.c
>   From inner merge:  Auto-merging builtin/grep.c
>   From inner merge:  Auto-merging builtin/hash-object.c
>   From inner merge:  Auto-merging builtin/log.c
>   From inner merge:  Auto-merging builtin/log.c
>   From inner merge:  Auto-merging builtin/pack-objects.c
>   From inner merge:  Auto-merging builtin/pull.c
>   From inner merge:  Auto-merging builtin/pull.c
>   From inner merge:  Auto-merging builtin/rebase.c
>   From inner merge:  Auto-merging builtin/rebase.c
>   From inner merge:  Auto-merging builtin/reflog.c
>   From inner merge:  CONFLICT (content): Merge conflict in builtin/reflog.c
> Auto-merging builtin/reflog.c
>   From inner merge:  Auto-merging builtin/reset.c
>   From inner merge:  Auto-merging builtin/sparse-checkout.c
>   From inner merge:  Auto-merging builtin/sparse-checkout.c
>   From inner merge:  Auto-merging builtin/submodule--helper.c
>   From inner merge:  Auto-merging builtin/submodule--helper.c
>   From inner merge:  CONFLICT (content): Merge conflict in builtin/submodule--helper.c
> Auto-merging builtin/submodule--helper.c
>   From inner merge:  Auto-merging builtin/worktree.c
>   From inner merge:  Auto-merging cache.h
>   From inner merge:  Auto-merging config.c
>   From inner merge:  Auto-merging config.h
>   From inner merge:  Auto-merging diff-merges.c
>   From inner merge:  Auto-merging diff.c
>   From inner merge:  Auto-merging git.c
>   From inner merge:  Auto-merging gpg-interface.c
>   From inner merge:  Auto-merging grep.c
>   From inner merge:  Auto-merging grep.c
>   From inner merge:  Auto-merging notes-merge.c
>   From inner merge:  Auto-merging object-name.c
>   From inner merge:  Auto-merging pack-bitmap-write.c
>   From inner merge:  Auto-merging parse-options.c
>   From inner merge:  CONFLICT (content): Merge conflict in parse-options.c
>   From inner merge:  Auto-merging parse-options.h
>   From inner merge:  CONFLICT (content): Merge conflict in parse-options.h
>   From inner merge:  Auto-merging refs.c
>   From inner merge:  Auto-merging revision.c
>   From inner merge:  Auto-merging sequencer.c
>   From inner merge:  Auto-merging sequencer.c
>   From inner merge:  Auto-merging sparse-index.c
>   From inner merge:  Auto-merging submodule-config.c
>   From inner merge:  Auto-merging t/t1091-sparse-checkout-builtin.sh
>   From inner merge:  CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
> Auto-merging t/t1091-sparse-checkout-builtin.sh
>   From inner merge:  Auto-merging t/t1512-rev-parse-disambiguation.sh
>   From inner merge:  Auto-merging t/t4202-log.sh
>   From inner merge:  Auto-merging t/t4202-log.sh
>   From inner merge:    Auto-merging t/t4202-log.sh
>   From inner merge:  Auto-merging t/t4202-log.sh
>   From inner merge:  Auto-merging t/t4202-log.sh
>   From inner merge:  Auto-merging t/t5316-pack-delta-depth.sh
>   From inner merge:  Auto-merging t/t6120-describe.sh
>   From inner merge:    Auto-merging t/t6120-describe.sh
>   From inner merge:  Auto-merging worktree.c
> Merge made by the 'ort' strategy.
>  Documentation/RelNotes/2.36.0.txt | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
>
