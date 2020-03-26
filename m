Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD9DC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 02:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0D220719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 02:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkfnMZ5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZCZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:25:44 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34223 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZCZo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 22:25:44 -0400
Received: by mail-yb1-f193.google.com with SMTP id l84so2419286ybb.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dmGPv1cbEiXcD0yk2qYHi42JB/q5f2nDDPABk/AOuM0=;
        b=PkfnMZ5bP1B9UocuvIdWLwJotf3RFfSYuPpbxbUv4HUvHn7pbQe5oHA/uM/Mxo84Bf
         t7rtil/6mobbQEF19vxou9v7Uw6IAWtnf+81ougwBpOjk6jY0FaG2W0UhxuYc6THjToe
         cOgJadlOiEhRy+VsvkKhO94xayb1wPi+vKh/ZJKkn25CmpD19CG8QNP/ZEFkQAG3+kGK
         bUQ7oglj/1Hs09dzI6pJYAEm8a6eQNz526eXDKpUulUC1bccK4GjX2mjQD/YF3PMyh0+
         OwjZT6nHKs7f6mcZo0qHc2nv06a5oRP8vD+9uEeyVGx42O2uhe8pfm9A8/x0FK+3oLbc
         Q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dmGPv1cbEiXcD0yk2qYHi42JB/q5f2nDDPABk/AOuM0=;
        b=XpRcxy+oBfBsjUVxPi0dxGycy18XaigF9S/IiUnvoWfk7owhG4KwGeEL0FYn9DtPaQ
         lOb0d3zg7B6NC0YVeLsjb/nqchfISHz1vXCHH9SaloTLfWrPZWU6UMXm503wNS3fOixl
         j1wTzEhrS4PlWGstGcidBSK8boNnGFXVPUFR+vLSfFQTEOi7EsqFmZruDzfrOSKoh9rG
         5m5ZYRSp8bJugRYoAeMvoe/AfpumdFq38PJnVyHKbInuJJlHa69RK95f1xVBk6t050dN
         tuOD1315lFyYlliG9q0Z3U2HHi8dxWBMLMUXPkZN4t0MTvQQ3RIR3x0g7wSNh41Ny8Ok
         uz1Q==
X-Gm-Message-State: ANhLgQ0mDB/YT4J/ZBfzAt95NRHLOiG+2QwQ88SOZ+WpPYJPQ6UxkvU4
        MBdHaglH0A3dQtxIf7LWPceIMOH9nfaA3458cys=
X-Google-Smtp-Source: ADFU+vuKtcg5JN6fZU3L3bFDIqSgZtiBz0Qk27t9VyN+6Z/UtTYNFRA3kawQcHsQqI+jBcOs5Lu0hxCnjojk3VLCXwU=
X-Received: by 2002:a25:b0a1:: with SMTP id f33mr10711279ybj.403.1585189541629;
 Wed, 25 Mar 2020 19:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200322131815.11872-3-worldhello.net@gmail.com>
 <20200325143608.45141-2-zhiyou.jx@alibaba-inc.com> <xmqqa744xyoo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa744xyoo.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 26 Mar 2020 10:25:30 +0800
Message-ID: <CANYiYbEQPUu5OyrGkmM7SVuX-edffn_5n5ywXv6D2Xh0=O5raA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t5543: never report what we do not push
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > +format_git_output () {
>
> Unless this helper is able to take any git output and massage,
> please describe what kind of git output it is meant to handle.
>
Wil use "cut_status_report_and_tidy" as the function name.

> Also, "format" does not tell anything to the readers why it wants to
> transform its input or what its output is supposed to look like.  It
> does not help readers and future developers.
>
> > +     awk '/^(To| !) / {print}' | \
> > +     sed \
> > +             -e "s/  *\$//g" \
>
> What's the point of /g?  You are anchoring the pattern (i.e. one or
> more SP) to the right end of the line, so it's not like it would
> transform "a  b c   " into "abc".  Also it would be sufficient to
> say "zero or more" and that would be shorter, I think.

I want to remove the trailing spaces in git output.  I don't know why
there are trailing spaces in each "remote: " message.
But there is not trailing spaces in status report message, so I will
remote it in next reroll.

>
> > +             -e "s/'/\"/g"
>
> It is unclear what this thing is for.  If the output from a git
> subcommand you are munging with the helper says <don't>, this will
> turn it into <don"t>, presumably before comparing it with the
> expected output you'd literally prepare in the test script.  Are the
> git subcommands whose output you are munging unstable and sometimes
> use single and sometimes use double quotes?
>
> If not, if you used single quotes when preparing the expected
> output, wouldn't you be able to do without this?
>
> Is it because you'd have the code that prepares the expected output
> inside a sq pair (because it is in test_expect_thing), and it is
> cumbersome to write a literal single quote?  If that is the reason,
> that is understandable, but I think readers deserve some comments
> explaining why these transformations are done.  Please do not waste
> readers' time.

To prepare expect message, sometime I have to escape the single quote like =
this

    cat >expect <<-EOF
        error: failed to push some refs to '"'"'../upstream'"'"'
    EOF

It's boring to type '"'"' instead of a double quote.

>
> It looks wasteful to pipe awk output to sed.  I wonder if something
> along the lines of
>
>         sed -ne "/^\(To\| !\) /{
>                 s/ *\$//
>                 s/'/\"/g
>                 p
>         }"
>
> would do the same thing with a single tool.

That's better.

> > +# References in upstream : master(1) one(1) foo(1)
> > +# References in workbench: master(2)        foo(1) two(2) bar(2)
> > +# Atomic push            : master(2)               two(2) bar(2)
> > +test_expect_failure 'atomic push reports (reject by update hook)' '
> > +     mk_repo_pair &&
> > +     (
> > +             cd workbench &&
> > +             # Keep constant output.
> > +             git config core.abbrev 7 &&
>
> This '7' is "use at least seven hexdigits", so it does not give any
> guarantee that your output will be stable.  Depending on chance,
> some objects may be shown using 8 or more---is our "munge output
> before comparison" helper prepared for such a case?

Will use sed -e 's/   */ /g' on output message to make it stable.

>
> > +             test_commit one &&
> > +             git branch foo &&
> > +             git push up master one foo &&
> > +             git tag -d one
> > +     ) &&
> > +     (
> > +             mkdir -p upstream/.git/hooks &&
> > +             cat >upstream/.git/hooks/update <<-EOF &&
> > +             #!/bin/sh
> > +
> > +             if test "\$1" =3D "refs/heads/bar"
> > +             then
> > +                     echo >2 "Pusing to branch bar is prohibited"
>
> Meant to redirect to the standard error stream, not a file "2"?

It's a typo, should be "echo >&2".
