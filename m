Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6204C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 09:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB8B610A5
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhDAJ6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhDAJ6T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 05:58:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5992DC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 02:58:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c17so1540633ilj.7
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UAXiiRPCjIUWY0N7hn0k7gwsXtKI9ill7G1KCyCvZ98=;
        b=jVPfncwya1DzG/5zej762/KROSFVtuwdzpYRqiOOYiDn9UzE/qKfOgpuZNkyafjD8R
         nOUKEJ1c0eHc8Z0i5FDGIFjIYacUIeC02CqVf3fMq+iJ/YhiybGrwFSYuk1xQEYE6dQl
         nnXDe64H6Kod4nGkSCp72ekpocLN9oS5EAkWUNsWfCPALjjxYkuazxSgJpzieRK8Cvcp
         k2kn/HBtCG9crxxOxB4fZq9lRJJ98Smk+/A+p6AXPiSoV5anO5jeho78Tu8gIlCfuucV
         c7skGpJztXgLjDWNfBHaRD7Y/7FREKE9upokOdte5JJOUWFgVmQ1D2A6LzMWlGTMONAS
         1Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UAXiiRPCjIUWY0N7hn0k7gwsXtKI9ill7G1KCyCvZ98=;
        b=kytVzA8Kff1i4E1zaWsXItDYQmBAhFtqPtdKYtkE19AcxGOIQGEsAIxtXlAV55vGob
         ZaR2S7Qr19fL3l3E5jjDBklJdWlyWiRFK+h6fvkZUMx5G9ATS/ruA7ux1Gt1gBy1D0Kk
         nYCBccFtCJ29YpS0YuYgq57vL7RSL9VUfxCXjVBod40vjVYChC456eflqfeIWVf+1vFz
         Gj2h+8Vj8uzxA2DchKaE4sL0w5zz4FYfYIm8rZn7sVTGqxLC0gGPH0lBKCiih56bYGBI
         AuLLlqU/iR4DpvBqEL9STiXygRM+0cwJQUS+LoHEb8zYvYkbnlpwackrsV8vK+4xb/vR
         7R6Q==
X-Gm-Message-State: AOAM530p5luhlvJZeTFDD/EAtYhtzx9uaLVlr1GfEK+OUkCHU698sLgB
        jIo062T1aC8st7Y+t+XLtDH41CMBZUx4XSM1B6s=
X-Google-Smtp-Source: ABdhPJwqejQ2UDewZIJtdU1zcgxuV6QQWwEtuL/9lnHSn74W1OLRvyOcjrHXcUMgSDniK45uw7qgZGwWPkdaYN91aVE=
X-Received: by 2002:a05:6e02:1d8e:: with SMTP id h14mr5917264ila.301.1617271098800;
 Thu, 01 Apr 2021 02:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
 <pull.913.v5.git.1617185147.gitgitgadget@gmail.com> <4c59cab53a0d9bb7c9cccfaf5544ae5c904bb2ba.1617185147.git.gitgitgadget@gmail.com>
 <CAP8UFD2tb6Fca58YPiFejqGKm3Mu+NaMA8YU3HQj+c2L-AH-Yw@mail.gmail.com>
In-Reply-To: <CAP8UFD2tb6Fca58YPiFejqGKm3Mu+NaMA8YU3HQj+c2L-AH-Yw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 1 Apr 2021 17:58:07 +0800
Message-ID: <CAOLTT8QUwjpb5AqKR0FgxWH_ESPzy8-fkDJk18uggO_SkT4Fzg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] [GSOC] run-command: add shell_no_implicit_args option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=881=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:22=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Wed, Mar 31, 2021 at 12:05 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use subprocess to run a shell-script, if we have any
>
> Maybe: s/subprocess/a subprocess/
>
> > args, git will add extra $@ to the end of the shell-script,
> > This can pass positional parameters correctly, But if we just
> > want to use some of these passed parameters, git will still
> > add an extra "$@", which contains all positional parameters we
> > passed. This does not meet our expectations.
>
> I am not sure explaining things using $@ is the best way to make this
> as clear as possible. I don't have a clear alternative right now
> though.
>
> > E.g. our shell-script is:
> > "echo \"\$1\""
> > and pass $1 "abc",
>
> Maybe: s/pass $1 "abc"/we pass "abc" as $1/
>
> > git will change our script to:
> > "echo \"\$1\" \"$@\""
>
> Where will "abc" appear then?
>
> > The positional parameters we entered will be printed
> > repeatedly.
>
> If you take us passing "abc" in $1 as an example, then I think it's a
> good idea to show us the result of that.
>
> > So let add a new `shell_no_implicit_args`
>
> Maybe: s/`shell_no_implicit_args`/`shell_no_implicit_args` flag/
>

Thanks for these grammar corrections.

> > to `struct child_process`, which can suppress the
> > joining of $@ if `shell_no_implicit_args` is set to 1,
> > this will allow us to use only few of positional args
> > in multi-parameter shell script, instead of using all
> > of them.
>
> I think our goal is more to have each argument we pass be passed just onc=
e.

More accurately, we only want those explicit positional
parameters to be replaced.
But Junio probably thinks it's OK to put on a layer of
"sh -c"  to "absorb" the "$@". I think it works, but it may
cause some trouble for users.

--
ZheNing Hu
