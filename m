Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83669C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 04:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiK2EvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 23:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiK2EvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 23:51:05 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385083E097
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 20:51:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bn5so15558451ljb.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 20:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+n2yPWRWXubpkFBazQEHaXd32MxDPYHc3atlzWjxSfQ=;
        b=E9aU0q+aJx6Ssvlhe1Ozm4SStj5eMcQbWY4FiQ/HI0N8kr347INnVWIlVylgf7adxk
         pvoNLR/hvrPE5NiWgnztZwbigB3iuvd7PnHkPlB4/gtgtsk0kI1lEOmgeFy2Lo/Ko2ku
         S4YIHMkaCCZlZT87X8BKiiFmsFLshNtIUA26ViuFw846eu4F6VNERLxXwZRbcLDnFZNM
         utRg3jUnwreYlqA4wfVt3kLre8Rmr0f0VORxP3+MKbSG1lO44E/MqbbA5MxV76a3Iy/y
         80ApkRpT0JPU70HzDzSVcfXC1ImfcepxhNfauo9SOOGGlYQgKRUOaHnjzh7oQxp7BhEz
         dIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+n2yPWRWXubpkFBazQEHaXd32MxDPYHc3atlzWjxSfQ=;
        b=JMUyqooKPBNts86IZxs28l5PNtIuhBx+4lEXmEsJQfUfapDE+m4k0rrULLS656mYTh
         ZjSM0Raog2N2b6TbCTS6fRRGv0heWL1krfphEysWHkH58WKqFFY59KeC/JkUxMN0nNAI
         VI4W3/jvaXEmiIRsBF2Giyel2/P33NRjvJT0xFLdvSh/+8T703GUf9Txqi6lX9dF2tZU
         DnYiTr0XntakYHsigLuf5pXgUDL3wEwPsg8dHn9hvpiVYcXyV2eNWHVtm8266ocFx8BQ
         BQA2Pwo6muWdHeEQ6a34e4gibCktbfWf9yQt2rZVhiUM1nXbvsebWk45ANJgQuajvlUc
         3plA==
X-Gm-Message-State: ANoB5plXp25vfPKse5pVTuz8/4NpyMzM7tRjUmK+dg0nSh2SnurSD/M7
        eEDbTeP2MEsyHt0Rq/rJd1W7xEwye56xm1kmBqE=
X-Google-Smtp-Source: AA0mqf5QQMgPVOm7+yt8Qx+WHgXl8D+qiGpZ9MvpU3Pkmn7Fv2rOKUiy45x/RSZ3ndablLziydpLo83VLGTk9jmYZS8=
X-Received: by 2002:a05:651c:c85:b0:278:f572:c9ac with SMTP id
 bz5-20020a05651c0c8500b00278f572c9acmr19076528ljb.73.1669697459059; Mon, 28
 Nov 2022 20:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com>
In-Reply-To: <20221127093721.31012-1-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Nov 2022 20:50:45 -0800
Message-ID: <CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com>
Subject: Re: [PATCH 0/5] diff-merges: more features
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2022 at 1:37 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> 1. --diff-merges=[no]-hide

This seems problematic to me.  Currently, all the options to
diff-merges are exclusive of each other; the user is picking one of
them to determine how to format diffs for merges.  Now you are
introducing the ability to combine various options, leading users to
think that perhaps they can run with all three of
`--diff-merges=combined-dense --diff-merges=remerge
--diff-merges=separate` or other nonsensical combinations.  Shouldn't
this [no-]hide stuff be a separate flag rather than reusing
--diff-merges?

> The set of diff-merges options happened to be incomplete, and failed
> to implement exact semantics of -m option that hides output of diffs
> for merge commits unless -p option is active as well.
>
> The new "hide" option fixes this issue, so that now
>
>   --diff-merges=on --diff-merges=hide
>
> combo is the exact synonym for -m.

Why is completeness important here?  Perhaps I should state this
another way: when would users ever want to use this new "hide" option?
 I got through your cover letter not knowing the answer to this, but
was hoping it'd at least be covered in one of your commit messages or
documentation changes.  Maybe it was there, but I somehow missed it.

Is the only goal some sense of developer completeness for these
options, or are these end-user-facing options of utility to actual end
users?  I'm hoping the latter, but if so, can that be documented and
explained somewhere?  I'm pretty sure this is explained somewhere in
an old mailing list discussion, but where?

> The log.diffMerges configuration also accepts "hide" and "no-hide"
> values, and governs the default value for the hide bit. The
> configuration behaves as if "--diff-merges=[no-]hide" is inserted
> first in the command-line.
>
> 2. log.diffMerges-m-imply-p
>
> Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
> options do. Simply fixing this inconsistency by unconditional
> modification of '-m' semantics appeared to be a bad idea, as it broke
> some legacy scripts/aliases. This patch rather provides configuration
> variable to tweak '-m' behavior accordingly.

> 3. log.diffMergesForce
>
> Force specific log format for -c, --cc, and --remerge-diff options
> instead of their respective formats. The override is useful when some
> external tool hard-codes diff for merges format option.

Why just these three options and not -m (or --diff-merges=separate)?

Also, I read this and didn't quite fully grasp the intent; your
explanation in response to Junio seemed much more enlightening.
Perhaps the wording/explanation could be cleaned up a bit?  I'll
comment more on that specific patch...

> 4. Support list of values for --diff-merges
>
> This allows for shorter --diff-merges=on,hide forms.

And thus making users think they can pass
--diff-merges=combined-dense,remerge,separate and suspecting that
it'll do something useful?  Seems like this is reinforcing a mistake
to me.


> 5. Issue warning for lone '-m'.
>
> Lone '-m' is in use by scripts/aliases that aim at enabling diff
> output for merge commits, but only if '-p' is then specified as well.
>
> As '-m' may now be configured to imply '-p' (using
> 'log.diffMerges-m-imply-p'), issue warning if lone '-m' is specified,
> and suggest to instead use '--diff-merges=on,hide' that does not
> depend on user configuration.
>
> This is expected to give a provision for enabling
> log.diffMerges-m-imply-p by default in the future.
>
> Sergey Organov (5):
>   diff-merges: implement [no-]hide option and log.diffMergesHide config
>   diff-merges: implement log.diffMerges-m-imply-p config
>   diff-merges: implement log.diffMergesForce config
>   diff-merges: support list of values for --diff-merges
>   diff-merges: issue warning on lone '-m' option
>
>  Documentation/config/log.txt                  |  20 ++++
>  Documentation/diff-options.txt                |  20 +++-
>  builtin/log.c                                 |   6 +
>  diff-merges.c                                 | 108 +++++++++++++++---
>  diff-merges.h                                 |   6 +
>  t/t4013-diff-various.sh                       |  89 ++++++++++++++-
>  ...ges=first-parent_--diff-merges=hide_master |  34 ++++++
>  t/t9902-completion.sh                         |   9 ++
>  8 files changed, 272 insertions(+), 20 deletions(-)
>  create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_--diff-merges=hide_master
>
> --
> 2.37.3.526.g5f84746cb16b
>
