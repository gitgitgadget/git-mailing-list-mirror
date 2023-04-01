Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD17C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 18:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjDASuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDASt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 14:49:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F7AF3F
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 11:49:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bi9so33022504lfb.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680374995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AhwiNYCxxDn4xlT7Mil5uQZnCP9ZLBB5kg9eiHVBpk=;
        b=pxkekjgG+zqyPeT7PbxCkXDtFCW/AZm2wsid18u/kjmsGW4pgvP0z05+v4tFTCXXU9
         dnNkwzMc/mXytsQ7ml8fj7a2WSTwKl3uesPWin1qnp+xZv/biMGlNLPTGWm8ZWYR6Noq
         RVrtjxhwEcCHWQigfnOtPKNcGOJvYXeRLo7HcXYALInRPqDv1xADxAKvwvk8KpKU4V6d
         zKGSnCzTH4IquwKe0BIamBDlr9q0P3vGB0VEA494seWvdd00eBhlr2xEW8HfQUyGzISr
         4/LIXdJLwyI7rRU4Reqb3BUXJg7vHPWWqrw1N5Jb7bx/72olLt0D12Kt3aSyDatd+sxG
         J1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680374995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AhwiNYCxxDn4xlT7Mil5uQZnCP9ZLBB5kg9eiHVBpk=;
        b=x7FgqYWZ4iopu0tMXccSJ+l3l/9VSR5ex9WcAEsI3xowfD7qVsNIhXW1tmt9lY2fIe
         sZZ0i8aqmEicZp1gmMybNnhpU85UKHxr0YhbCOPARxH+emiK472CH5gvYfhpbTpXSvtv
         dSuAYBZ+ZZRtxr1h+LGCOpBg/LE6+M37JInWUqB8HYlrCrgIGr5h6fmTymxYnIdATBu1
         SE02kcKM6h7j4P4COET5Z8pZeVDAQ/U1i4fyT91xgXhZJaMhKZxpMcfrf+Hob3KKrLwK
         tluHiKbn7/wWO+hoPnaQDVOzvfC4sM+iE+2qdyhuqw07sCc65nOZwOXL6emF8l8ZfKUV
         FGUA==
X-Gm-Message-State: AAQBX9dRKxY+fS+f+wYsN8+GDI81o75JCNk2rrBMwTk4ECcp06lWwBB8
        mVMhXhA3Zp2ZHtXdrR/uN3WQyetIPoqKN4zqL+bry/RQ
X-Google-Smtp-Source: AKy350YyyI0+1Ii63BWdEZMPwS011/OHNxSz8I6ISmEzGAeYJoT502RdYPSj++/S8hDAnMbkkYMZdydhGpE+S3fYMxk=
X-Received: by 2002:ac2:5ed9:0:b0:4e9:a3b7:2369 with SMTP id
 d25-20020ac25ed9000000b004e9a3b72369mr9333461lfq.7.1680374994477; Sat, 01 Apr
 2023 11:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com> <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 11:49:42 -0700
Message-ID: <CABPp-BHhjjO32EAzi_Deck6fxsyG=uMrvAnJLaD0e9qMtrcDEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] builtin/sparse-checkout: add check-rules command
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 27, 2023 at 12:55=E2=80=AFAM William Sprent via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Hi
>
> This v2 addresses comments from Elijah's review comments.
>
> There's one thing worth highlighting. Elijah pointed out that the the
> "check-rules cone mode is default" test would be stronger if the test its=
elf
> started with a 'git sparse-checkout set --no-cone' to explicitly test tha=
t
> the default interpretation of the rules passed with the '--rules-file'
> option is cone mode even though the current checkout is non-cone. I
> implemented this and it exposed that the option did not actually behave t=
hat
> way, and that the test only verified the default behaviour of a bare
> repository.
>
> I've modified the logic of the '--rules-file' option such that it default=
s
> to cone mode unless combined with '--no-cone', and I've added a line to t=
he
> documentation to make this more explicit.
>
> The alternative would be to have '--rules-file' assume non cone mode when=
 in
> a non cone mode checkout, but I think this depends a bit on "how deprecat=
ed"
> non-cone mode is vs. how important it is to have the option behave
> consistently with 'sparse-checkout set' (which respects the current
> checkout).

Ooh, nice catch.

Given that the whole point of check-rules and --rules-file is to
determine how a _different_ sparse checkout would behave, I agree with
your decision here that the current sparse checkout should not affect
how --rules-file functions.

>
> Changes since v1:
>
>  * Explicitly state in documentation that '--rules-file' expects newline
>    separated rules.
>  * Explicitly state in documentation that '-z' does not affect the
>    '--rules-file' input.
>  * Fixup typo where 'When called with the --rules-file <file> flag' was
>    missing "flag".
>  * Fixup behaviour in 'check-rules --rules-file', such that it defaults t=
o
>    accepting cone mode patterns when in a non cone checkout.
>  * Remember to release string buffers in 'check_rules()'.
>  * Explicitly state in documentation that '--rules-file' defaults to cone
>    mode unless combined with '--no-cone'.
>  * Better test that the default of '--rules-file' is to expect '--cone-mo=
de'
>    by running 'check-rules' in a non-cone mode checkout.

This round addresses all my issues, and I agree with the other change
made in this round.  So, v2 is:

Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks for sending this in, William!
