Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C6C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 02:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiG1CSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 22:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiG1CSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 22:18:32 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B70D58B76
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 19:18:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j195so1166727ybj.11
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VUSOUkOc68ITxvTx+gF0lUEMYgLCYJXLQtQxhrjYuI=;
        b=NRl8Xh6mStT/Q6avTOgYy+Qp4uQkUOXLZJ+4r7FOj5+rgE/1tH2I/XHtV2fTeYtlxT
         3EKBcYciP6a2cTTfGi7O4nzsy1Z4UK5e80CQs33tlFsZ5MjoPmWDs6s1BtfuVXdAsuMd
         Ca2NLoso+QCtko0zh+h6W7BScZXicrJq2QUc8MlA9nzB5kJskgKAJIfiGdWPfBVRCJA1
         y5ysjzZcwZkjE5uXM2KmVHGbim3iv50DsPcbRhykNvHL/RrVRjfLurFVcbdNeFEDwc1q
         QHWnwhINpZLIXfGTpBj6SF3g/XRFcqlx04XQh9BkysExnoxHOY1/4ROmU7kNRyeB9yNd
         Zz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VUSOUkOc68ITxvTx+gF0lUEMYgLCYJXLQtQxhrjYuI=;
        b=zOOFpdgNmTOhikVZveny7hV3dG5MLA91SmyvOs7zKtx6e6iuvOaWyj49frAhcYW4Qj
         5ymZqPb8jwuHqOdHnqOHZ7kR0nreE/0nZCjyGGwS/GMNcmQdgX4q11EeHYrGFvgI5ZBl
         4aFqxiCTJqAwnj/QLvZV6Vrvdkjex2GVmWQj9zCgcajaDVxQVnQQtaZ+AiJaEuXD0akG
         WNHk41uFZCgHYOzD6Vi7BPt0LPbS/abUdn+DdX8n4GGFif1n4kR/u4+2q983CDjWtTiy
         yCo3EOW+W1xv+wo8Bi5WiNRzCqEaugabSEAOY/PnnLIjv4z/ZH481xbGeOlvc3fa2S27
         fC2Q==
X-Gm-Message-State: AJIora9FsU73j4mTJKiqlQOlnH4xgkK/WnWMz6RIj5jYPAEnvWuYXpQu
        0YkVYWmSMyyW4Iy1ePaORrjVTrOY5QPyxkIzgDefM41W614=
X-Google-Smtp-Source: AGRyM1vWbGknJ1oW1ktodEK+3rHFCSNpvp+v8zi0cpAQ39q3gfaAxmcXeWlvgJHTq3ubfamNIfDpXvyxHaaD1uwxb0k=
X-Received: by 2002:a25:6ed5:0:b0:669:8b84:bb57 with SMTP id
 j204-20020a256ed5000000b006698b84bb57mr18850745ybc.227.1658974708539; Wed, 27
 Jul 2022 19:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com> <xmqq35ems49j.fsf@gitster.g>
In-Reply-To: <xmqq35ems49j.fsf@gitster.g>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Wed, 27 Jul 2022 22:17:52 -0400
Message-ID: <CAGTqyRzfeh4HLbXUCb3Zv=bWNoBmvBU5QB=N2g2d0=y+NEToag@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: show 'CONFLICT' indicator at command prompt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback.


On Wed, Jul 27, 2022 at 4:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> > index 1435548e004..2d30eb5c17e 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -84,6 +84,9 @@
> >  # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
> >  # by setting GIT_PS1_OMITSPARSESTATE.
> >  #
> > +# When there is a conflict, the prompt will include "|CONFLICT". This can
> > +# be omitted by setting GIT_PS1_OMITCONFLICTSTATE.
> > +#
>
> It is unusual to subject our unsuspecting users to new features in a
> way that is done by this patch.  A more usual practice, I think, is
> to tell the users that they can set GIT_PS1_INCLUDECONFLICTSTATE to
> "yes" if they want to opt in, and trigger the new feature only to
> them.  Later, we may decide that the feature is useful and widely
> apprlicable enough, at which time it may be turned on by default and
> tell the users to set GIT_PS1_INCLUDECONFLICTSTATE to "no" if they
> do not want to see it.  But one step at a time.
>

I see that most of the state indicators are disabled by default, so it
makes sense to be consistent. Should I make a variable with 'yes'/'no'
values, or set/unset? 'yes'/'no' has the benefit that if the default
is later changed, existing setups will continue to work. Set/unset
makes it harder to change the default later (I guess you could just
use a new variable with a different name), but is more consistent with
the other state indicators. I'm leaning towards set/unset, but it's
not a strong preference. Let me know if you disagree.

> > @@ -508,6 +511,12 @@ __git_ps1 ()
> >               r="$r $step/$total"
> >       fi
> >
> > +     local conflict="" # state indicator for unresolved conflicts
> > +     if [[ -z "${GIT_PS1_OMITCONFLICTSTATE-}" ]] &&
>
> And flipping the polarity and disabling it by default would be a
> simple change, I would imagine, that can be made here.
>
> > +        [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
> > +             conflict="|CONFLICT"
> > +     fi
> > +
> >       local w=""
> >       local i=""
> >       local s=""
> > @@ -572,7 +581,7 @@ __git_ps1 ()
> >       fi
> >
> >       local f="$h$w$i$s$u$p"
> > -     local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
> > +     local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
> >
> >       if [ $pcmode = yes ]; then
> >               if [ "${__git_printf_supports_v-}" != yes ]; then
> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index 6a30f5719c3..9314776211c 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -183,7 +183,7 @@ test_expect_success 'prompt - interactive rebase' '
> >  '
> >
> >  test_expect_success 'prompt - rebase merge' '
>
> Of course, this needs to be tweaked if we did so.  Running the test
> in the default state will not need this change, but then ...
>
> > -     printf " (b2|REBASE 1/3)" >expected &&
> > +     printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
> >       git checkout b2 &&
> >       test_when_finished "git checkout main" &&
> >       test_must_fail git rebase --merge b1 b2 &&
>
> ... a new test that runs the same thing but with the new feature
> asked by setting the environment variable would show the new |CONFLICT
> marker.

I'll add these.

>
> Thanks.
