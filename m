Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693ACC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8BF20836
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbRp+/qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgBQVH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:07:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45940 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 16:07:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so17439396otp.12
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 13:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIaTKo989DQ5xM0dRZN+H3IDBlOZqW9WMHhZvhVm6kc=;
        b=fbRp+/qL/0JgKPGn5Lg12nDLZm9bO40bSh/FAGRUMRBunXwMl58sICBz3CTrOdPk/B
         wqNbkPC4KCeqR0GkSPpGnmvVyysPS3U0kl7ZmwjT8h1vPr1JqxZbxWZpYHpmWgG2PZgv
         1Y62hAJipGD0whOi3mhfqx6NE36J75GZ6fkSBkx785ZJbY/uI+i4gMEr+tvq49/MoGpZ
         z5IoZ2CN0QMxr8pWJAreorbTrsiGJOVhM5YTBhfyNm72iaFg47OIatWr6gRScuqwodvH
         njoyB2GI1kdY181ZblnYgBr8Aufd/anGVqm0F/9p/Lk9hQ4y9OoIOdIcL4s3h6BiYjeY
         tw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIaTKo989DQ5xM0dRZN+H3IDBlOZqW9WMHhZvhVm6kc=;
        b=eKBN7+ReiNU428uO1YeWWXEHUo/waB73F66bkHey559BYynGvFf9mTdpm6xXojdNk1
         ZJrViF3Ep+X8eJN1RN1HT3Jy2FRJuLPOT/OcY7xbX6xIHGfOlhHdL1qkq1OCP76b05OL
         905Uojv2bvDggP/JihkTT8tf1KQPyqR/JuzNxk/Jm7oPxTJS4M4NHPYJe4ASYEjNgEZv
         scdiLVahn4jQIQiwf4aG31IUI01xuQPKhLUhn4zFYV9TyQN7qzpqhTv9JWHjmEsFlybT
         d00FMPkZ+FNzdZ7uuZt2itWsodJKG58/zG3dgZvP3knzqR9DCyvv45Yl9WuMnteSqdTB
         uNXQ==
X-Gm-Message-State: APjAAAULtnSDzGVbtUTbPBtBKqxZhBPAc16V/KRB7f8IDwbc60nKjwx2
        LJwz149Y051ssx36GTsMbuU1WjGUMzDzb5hw0VI=
X-Google-Smtp-Source: APXvYqzHwDUOGii0sZ/8lTRYL2vU8Hpk1qze4OSSdpU4PrgOn2qJH8rN2qWucpPvyPXCjibyLLznwGGWVih9nSAdmrQ=
X-Received: by 2002:a05:6830:c9:: with SMTP id x9mr13593861oto.345.1581973677774;
 Mon, 17 Feb 2020 13:07:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
 <xmqqimk5ks39.fsf@gitster-ct.c.googlers.com> <CABPp-BEbojaeYkSMR7vntW0SkWf6dVOko5H=jqT-Yv2USRerxA@mail.gmail.com>
 <xmqqeeutkkur.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeeutkkur.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Feb 2020 13:07:46 -0800
Message-ID: <CABPp-BHaTK62W4_rUaJXNUPSfu9cBD5MrmjgbJeMuA+7s3+rGg@mail.gmail.com>
Subject: Re: [PATCH] check-ignore: fix handling with negated patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> I suspect that the above distorts history.  IIRC, it was meant as a
> >> tool to see which exact pattern in the exclude sequence had the
> >> final say for the given needle, written primarily as a debugging
> >> aid.  In that context, "This rule has the final say", whether the
> >> rule is a negative or positive, still means something.
> >
> > I can reword it; how does the following sound?
> >
> > check-ignore claims that it reports whether each path it is given is
> > excluded.  However, it fails to do so because it did not account for
> > negated patterns.
>
> I am not sure about "claims" part.
>
> Isn't it more like "check-ignore has been the tool that reports the
> rule that has final say on each of the paths it is given, but that
> is not very useful when the user wants to see if the path is
> excluded (e.g. the rule with the final say may be negative).

No, it is not more like that; the check-ignore manpage currently claims this:

       For each pathname given via the command-line or from a file via
--stdin, check whether the file is excluded by .gitignore (or
       other input files to the exclude mechanism) and output the path
if it is excluded.

Note also that this description at the beginning of the manpage says
nothing about reporting which rule has the final say.  And, in fact,
the command in default mode does not report which rule or rules were
involved.  All of that work falls to the --verbose flag, which was
documented as

           Also output details about the matching pattern (if any) for
each given pathname. For precedence rules within and between
           exclude sources, see gitignore(5).

Now, if you read both descriptions together, you find that these
claims are contradictory and that it cannot do both, so the "Also" bit
it leads with is a lie.  As such, my commit modified the definition of
verbose to make it instead read:

       Instead of printing the paths that are excluded, for each path
       that matches an exclude pattern print the exclude pattern
       together with the path.  (Matching an exclude pattern usually
       means the path is excluded, but if the pattern begins with '!'
       then it is a negated pattern and matching it means the path is
       NOT excluded.)

This was a change of description for the --verbose flag, not a change
of implementation.  Thus, in my opinion, no transition period is
needed: those who wanted to use check-ignore to see what rule would
have matched had to use --verbose before, and --verbose behaves the
same as before.

Those who wanted to use check-ignore without the --verbose flag to see
if a rule is excluded, get corrected behavior that will actually do
that.
