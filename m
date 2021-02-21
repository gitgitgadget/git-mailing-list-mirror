Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80839C433E0
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 06:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430EA64EE6
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 06:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhBUGgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 01:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhBUGgV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 01:36:21 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3117C061574
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 22:35:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id r19so1864197otk.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 22:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNF32EHCxSgi1wr0Q8JyuoXM/gb3uxtecKk3LvlBDGI=;
        b=kNYYCEgDrjps77SJXWJ0rw9ycazXxprspOeqUIUPJsSS0AR7oPb8LtbTZYoHYipy5V
         cmz2QBpMZVdN530Oc6sYjlsxv0MqowOnSX3xgTpA4K/8qcefmyshzF1DjjBj/1ixXala
         yUnJWVdxFYwlKbreZgibIQvj8WAwArLzHq7m29FtZztspXQ4QVIu6LLW8d+1tkDLZ3LZ
         sffiIFwplXA/3+zvRqmtwQkPHg3h/IfjxcNnyDvRzZEjlExREZB9tqEcl+0Hll2AfC+9
         Cwrqb1PJGZ6rIlDER25F1ul+B9TKgshwlj5BG10OKIKTFrgwpwcWJ5KuUxdfbV/N6dhZ
         KCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNF32EHCxSgi1wr0Q8JyuoXM/gb3uxtecKk3LvlBDGI=;
        b=U9x0XIMc/ynXSWfjjUD7cOpCQcVuW8qJHq7TWYBkidTrRc2RVKfH/eSVCFCiNbvgov
         CSsGj4SFp5Sly3/P4GG7dFBZA8P/9gtZHvTSOpLsm5QIUxbKoLtmudvTlozOSgjhE1L4
         KmCNEseENbNwMwK5zqr3mnVcrWhErB0aU+1zh2/5lAPUqJrfE9DOckJX0hTdo7vy5WZd
         gqnB3WY6TqRo9O9dk1Xki+Fe0w+OQCwFs1HSJlfB55r4qTGIjgMFAU2JJCr3/4fqTmKd
         qKllqbPTst9tl8rPJQ99PG6yqvUVkbvU37lhGoRdtLDnl7bp7BP+gAWyfDfwhIoMU+3M
         6F4A==
X-Gm-Message-State: AOAM531RE9ca7/ZOdy4keVCXYbpruWfl0CrKH4RRO6Bt+VcGUvEORnSN
        UjMcBJw6Xuf+HkfztcvZFRDoEN4qGc4f9ybfzjo=
X-Google-Smtp-Source: ABdhPJzLe3Qk4mdULkpVZmpJHcZbCp6iEF3EdrMqWSxeVa3vXGM06Xi8kD+KqCcZfU56A2A7oMB9Y0hILJgiqw/4Sos=
X-Received: by 2002:a9d:313:: with SMTP id 19mr12532317otv.147.1613889340878;
 Sat, 20 Feb 2021 22:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-2-charvi077@gmail.com> <xmqq35xulbj0.fsf@gitster.g>
 <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
 <xmqqpn0xfal8.fsf@gitster.g> <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
 <xmqq4ki7bf9y.fsf@gitster.g>
In-Reply-To: <xmqq4ki7bf9y.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 21 Feb 2021 12:05:29 +0530
Message-ID: <CAPSFM5cRq9OfxypwTAsv3OFpTPM88e4_agTmFEGbaVyLi6Qbig@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 20 Feb 2021 at 08:46, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > For end-users "-m" or "-F" will make it easier to prepare an "amend!"
> > commit. Because using the "-m" reduces the cost of opening an editor
> > to prepare "amend!" commit and it can be done with command line only.
>
> Hmph.  That is not very convicing to me.  The user is motivated
> enough to fix a wrong commit log message and replace it with an
> improved one by using the "--fixup:amend" feature---why would that
> improved message can sufficiently be written with just an "-m
> message", which by definition would be much less capable of
> preparing a well-thought-out message than with an editor?
>
> Yes, with "-m", you can add some short string easily at the end of
> the existing commit message without opening an editor.  But I am
> trying to see why it is a good thing to be able to do so in the
> first place.  It is very easy to make typoes while doing so and it
> would be hard to fix these typoes, exactly because you are doing so
> without being in an editor.  And the whole point of --fixup=amend is
> about improving the message (as opposed to --fixup that is to record
> the contents that have already been improved in the index).
>
> This is why I kept asking what the use case would look like.  I am
> trying to find out if you have a good end-user story in mind that we
> can use in the documentation to sell the feature to end-users, but I
> am not seeing one.
>

I was in my mind that, as we can easily prepare the commit using `git
commit -m "commit message"`. Similarly, we can extend this working
with `git commit --fixup=amend:<commit> -m "new commit message"`. And
the difference is that in the later one the goal of changing the
commit message will be achieved after `git rebase --autosquash` i.e
the later command works with sequencer. This will easily allow us to
write a new message for the commit we are fixing up through the
command line only similar to `git commit -m` and if we need to fixup
the commit msg then it can be done without `-m` and the editor gets
open with a seeded commit message we want to fixup. Also the same
working applies to `reword` option also and may allow to reword the
commit msg from command line only.

But I am still doubtful, as I agree with above that the main concern
is to only fixup the wrong commit message and in that case the "-m"
option can't be that much productive or maybe confusing for users.

> Is the combination of "--fixup=amend" and "-m <msg>" meant to be
> used primarily "to leave a note to myself" when the user runs
> --fixup=amend:<commit>, to just record the points to be elaborated
> when the message is written for real much later?  E.g.
>
>     ... hack hack hack ...
>     ... good stopping point, but cannot afford time to write
>     ... a good log message now
>     $ git commit --fixup=amend:HEAD~2 -m 'talk about X, Y and Z' -a
>     ... hack hack hack ...
>     ... possibly doing something entirely different ...
>     ... finally comes back to finish cleaning up the branch for real ...
>     $ git rebase --autosquash -i origin
>
> And one of the insn created in the todo sheet would be amend!, whose
> commit message has the message taken from the original HEAD~2 PLUS the
> reminder to the user that s/he needs to talk about X, Y and Z?  And
> the user at that point writes more comprehensive message about these
> three things?
>

But here in this case, after `git rebase --autosquash -i origin`, it
will not open editor again and user is not allowed to write more
comprehensive message about these three things, unless the user
manually changes from automatically converted `pick` to `fixup -C`,
to `fixup -c` command in the rebase todo list that gets opened after
`git rebase --autosquash`. And for this case `git commit --squash` is
more easy to use.

> That is a made-up example of what "appending some short strings
> possibly full of typoes without having to open an editor" could be
> useful for.  I am not sure if it is truly useful, or if it is just a
> hand wavy excuse not to mark -m/-F incompatible with --fixup=amend
> without a real merit [*].
>
>     Side note: one reason why I do not find it realistic is that it
>     is unlikely that the user would use --fixup=amend to slurp in
>     the original log message when recording "good stopping point,
>     but cannot afford time" fixup.  "--squash HEAD~2 -m <msg>" would
>     be much faster to record the "note to myself" reminder, and when
>     the user finally comes back to clean things up, the amount of
>     work to edit the original's message while looking at the "note
>     to myself" appended at the end would not be any different in
>     either workflow.
>

Yes, I also thought the same and agree with it.

> In any case, that was the kind of answer(s) I was looking for when I
> asked "what is this good for?" question.
>

Thanks a lot for explaining each perspective in detail. So, now if we
use `-m` as an option to write side-note then `--squash` is already
available and for fixing the commit message opening the editor is a
must expected option. So shall we remove the `-m` option compatibility
if `amend`/ `reword` suboptions are passed to `git commit --fixup` ?

Thanks and Regards,
Charvi
