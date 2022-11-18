Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E451EC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKRTxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKRTxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7CCB481B
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:53:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f27so15635276eje.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSIFGHNza1VvI1mI3qneBoOSsN7SfcXHw2oLsjh3zBk=;
        b=QJvYq8uYbd5dS93/PVdns34+HYzU5YT6ZTXscddg+pQE+PByLP+7nzWCYnphfO0HBP
         e79Yv6zcghLWEe6ap5WGxhJiu7EHpamBw35oOIt7MxLNy5Nf41vxSyrqWRfOJ1cATOVz
         neJU2p6NZZ6VqgvgGNnUE8izcK5hvw42WyGeBcALNAIsDKIyi0mBC1YZr/BX1AS5C1eV
         tN35nFW/8gHrUohOzhPssX7OMj7W+7fdiR1TcQojvIqBmNZwTC563Z6g6l9RdLPSsDXR
         mSXaL35Eds+JFgNuR5JK6QmzHegaUPN68YTZhoFvfKhyNUPJR9BO8pixFoNSCp1rkEl7
         myaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSIFGHNza1VvI1mI3qneBoOSsN7SfcXHw2oLsjh3zBk=;
        b=rs986axkT3yFPNuYgd2tsM970pJVS1YuJhrpYLq703tna1Kor90CF/iA3ELbWiJGnC
         9Y9u2fHnh0OYGjjRwPl27YDWGLKLflNe44w2XsWnitWDqeJ93DAm4fK28OONnco5eNwF
         hyMmgMVuNiaMPCXU8IdSya88NdqEdybjWrhuOis+tnooJOp8AlVgbgUIZV+hRZdC4kl9
         8xrqVK51mdFlJLaB6F1EPbYOeKJ5N2EEBuGM64p3jWa3A2WE7Ba/r8It3ubvZbYWFhCA
         ETBP7WYHCr75YtEgsJ8jMK2KgTrL3p8mDL1+7D8deKdJ/L9XWrD2d09jef2CCN6Fgubi
         Pj6A==
X-Gm-Message-State: ANoB5pmrvbbaIG5Zir2yNK3IqSq4DNS8pUQHmiaGNE5rU3KTYJcOpfxF
        bfrevRSdw4jeE0WiImT2iIhiQ8yPtnIUAA==
X-Google-Smtp-Source: AA0mqf6f2NhlcHJHV79s0ix7FXxU/S8PovRMMlmwy3g5/Hh8kxMjpRl4bWOgewLGXrp3nhDKLgYE5Q==
X-Received: by 2002:a17:906:d293:b0:7ae:27a7:2a66 with SMTP id ay19-20020a170906d29300b007ae27a72a66mr7351172ejb.72.1668801183468;
        Fri, 18 Nov 2022 11:53:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709065a8900b00773c60c2129sm2093342ejq.141.2022.11.18.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:53:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ow7Q6-005j3j-1X;
        Fri, 18 Nov 2022 20:53:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Ivanov <icegood1980@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug report: add/delete instead of rename
Date:   Fri, 18 Nov 2022 20:50:43 +0100
References: <CAJCbrz5+LC9g34x0E_2HAezFNaMGW7ECSA9iXpHgnAHGoQNzHA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAJCbrz5+LC9g34x0E_2HAezFNaMGW7ECSA9iXpHgnAHGoQNzHA@mail.gmail.com>
Message-ID: <221118.86iljcf3a9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Sergey Ivanov wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened?
>
> hard rename of files and directories via 'git mv' . git status before
> commit for some related files:
>
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>
> new file:   sepolicy/private/file.te
> renamed:    sepolicy/components/icl_infotainment.te ->
> sepolicy/private/icl_infotainment.te
> renamed:    sepolicy/common/hal_icl_infotainment.te ->
> sepolicy/public/icl_infotainment.te
> renamed:    sepolicy/common/file.te -> sepolicy/public/file.te
>
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
> modified:   sepolicy/private/icl_infotainment.te
> modified:   sepolicy/public/file.te
>
> What did you expect to happen?
>
> All related nodes are renamed during commit
>
> What happened instead? (Actual behavior)
>
> delete mode 100644 sepolicy/common/file.te
> delete mode 100644 sepolicy/components/icl_infotainment.te
> create mode 100644 sepolicy/private/icl_infotainment.te
> create mode 100644 sepolicy/private/file.te
> create mode 100644 sepolicy/public/file.te
> rename sepolicy/{common/hal_icl_infotainment.te =>
> public/icl_infotainment.te} (90%)
>
> What's different between what you expected and what actually happened?
>
> Instead of renaming 2 more pairs of create/delete formed.
> It makes harder to see changes on gitlab UI after push.
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

Git, unlike some other SCM's (e.g. SVN) doesn't track renames at
all. I.e. it doesn't matter if you use "git mv", or just manually remove
a file, "git add" that removal, add another file separately etc.

So I think you're probably just running into that. I.e. "renames" are
heuristically determined based on how similar the file is
before/after. Likely you rewrote it more than the rename detection was
willing to accept.

But see the "git log" manual for details, as it's a heuristic you can
tweak it, and e.g. set -M<n> for how similar two files should be before
they're considered a rename.
