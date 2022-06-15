Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB27C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 04:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiFOELm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFOELl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 00:11:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A22427FA
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:11:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d5so6774746plo.12
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKa4X1AREsaSC42DHPlItfQeq+iZfiHiK+BoBIwl9f0=;
        b=Ezn8iuzLxO0dM0MBe8mBx8Th5/kbgh6ARZ6s//jUwG/k6qi0HE09ayvQXtjzc/m4bm
         rLUjHId+uHi/ZYv9PYBDLDE9JEucUl9gWhUbuPzrfRngKKilSx83H5FivlRNNGyGoVVX
         kUYfYGuXMKwW8PWxOZQIMO2ucwWBnQ1dyDvRktuCtNiFhy51kY2f02lfMhN/SV5vJ8b6
         P4E565BmhhKPQZ5tdH81uG55bYt7ZKkgkk+xWTfe4qW8lf5Vm+yd1FPUEZgt2senR+Gl
         fxiT0UsheLgn27cfVMTzU9StDtblMmJ39TlWpmzuU0ANLydTZHxmN6CTZPOcTa497MjL
         dUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKa4X1AREsaSC42DHPlItfQeq+iZfiHiK+BoBIwl9f0=;
        b=GfQkePlzjR2e/duqf4qlTxk2H1y497APMoQ2JqJcvrvMX58hAByokXmr+JEe+TehxZ
         YJ0CccaM/0SoA4NfPE9mGWpmj6TdxcRfdmOOdhEnbMf+cFzxx2brSqzuHqWKLTak1eIP
         kAUi/3hGCtLe7W1fLbuZ8u9jfzZNatt9dwpF5Ro1VcBiL3OBjBZJw4eHF3M0j37+lEbH
         wmUN8SyXCwCYcXam6dsGtJHw8GPov1hJHYWmATbmjBop7Xx0f4Tt6k4Xk8GdT0m28aHe
         QAVPaqdy80/QoDRFAFES6D8679aVbB4jFiF8mWTze9uiN/RA0jndYkxuLDAyp7UXhPsZ
         gRrg==
X-Gm-Message-State: AJIora+5oxSiUqIkV9qqCqKx0+3e6OsTBAHCKXOKBACCD+E9bN5uectl
        VQz9DvyMh59lO4Jk/CKx99SvLglqdnpmmxZ/ElYHU3rzluE=
X-Google-Smtp-Source: AGRyM1vwVT9VfFHes3YeIiBD68YWO1BO0CIjs8JCDlZ5ZLOG2HVcdLkkMjPre00XiG5he228VJQi8v9OhcF7+8okRWM=
X-Received: by 2002:a17:90b:1c10:b0:1e8:90bd:d912 with SMTP id
 oc16-20020a17090b1c1000b001e890bdd912mr7995295pjb.233.1655266298580; Tue, 14
 Jun 2022 21:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet> <CANWRddNa1nB9shoppfXuA2yqmd2353HVBopoufkh0SevnVrngA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206102327540.353@tvgsbejvaqbjf.bet> <xmqq5yl8chhz.fsf@gitster.g>
In-Reply-To: <xmqq5yl8chhz.fsf@gitster.g>
From:   Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
Date:   Tue, 14 Jun 2022 21:11:27 -0700
Message-ID: <CANWRddMXrhs2grTfq9NtHM7KqxaFRejvaXxvDGV90_m=Kmm-uA@mail.gmail.com>
Subject: Re: Best way to update `HEAD` in mirrored repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Apologies for the delay, I'd never built Git from source so I put it
off until I had a chunk of time, assuming it might take me a bit -
thankfully it was painless.

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Here, you set this up as a fetch mirror. That is something I've missed
> before. It is also important because it means that there is no
> `refs/remotes/origin/HEAD`.

Ahhh, the reason it wasn't working before clicked for me now, thanks
for the explanation.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index eddd40c8f87..fead15adb97 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1344,7 +1344,7 @@ static int show(int argc, const char **argv)
>
>  static int set_head(int argc, const char **argv)
>  {
> -     int i, opt_a = 0, opt_d = 0, result = 0;
> +     int i, opt_a = 0, opt_d = 0, result = 0, is_mirror = 0;
>       struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
>       char *head_name = NULL;
>
> @@ -1357,8 +1357,16 @@ static int set_head(int argc, const char **argv)
>       };
>       argc = parse_options(argc, argv, NULL, options, builtin_remote_sethead_usage,
>                            0);
> -     if (argc)
> -             strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
> +     if (argc) {
> +             struct remote *remote = remote_get(argv[0]);
> +
> +             if (!remote || !remote->mirror)
> +                     strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
> +             else {
> +                     is_mirror = 1;
> +                     strbuf_addstr(&buf, "HEAD");
> +             }
> +     }

> Would you have a chance to build Git with this patch and verify that it
> works for you, too?

Good news Johannes, your patch worked for me as well! Here's a run
with the patched code.

    $ git --version
    git version 2.37.0.rc0.dirty
    $ git clone git@github.com:xvandish/livegrep-fragment.git --mirror
    $ cd livegrep-fragment
    $ git symbolic-ref HEAD
    refs/heads/good_main_5
    $ // I changed the github default branch name at this moment
    $ git ls-remote --symref origin HEAD
    ref: refs/heads/good_main_5     HEAD
    0666a519f94b8500ab6f14bdf7c9c2e5ca7d5821        HEAD
    $ git fetch -p
    From github.com:xvandish/livegrep-fragment
    - [deleted]         (none)     -> good_main_4
    * [new branch]      good_main_5 -> good_main_5
    $ git remote set-head -a origin
    origin/HEAD set to good_main_5
    $ git symbolic-ref HEAD
    refs/heads/good_main_5


On Fri, Jun 10, 2022 at 2:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> Good.
>
> Regardless of the "mirror" issue, it makes tons of sense to ask the
> remote API how the remote-tracking refs for the given remote is set
> up, instead of assuming that it must be "refs/remotes/<remote>"
> blindly like in the original code.
>
> That way, we could even handle a case like so:
>
>         [remote "frotz"]
>                 fetch = +refs/heads/*:refs/remotes/nitfol/*
>
> Their HEAD should be mapped to refs/remotes/nitfol/HEAD on our end,
> so set-head should be able to notice that, too, if we go further
> with your "do not assume, instead ask remote API" approach.
>
> Thanks.

This makes sense to me as well, as a continuation of the "ask remote " style.
I only have a very vague idea of how I'd implement this from a look at
the codebase, so I'd be of more
help testing things out. If this idea carries forward let me know if I
can be of help testing, or if you'd like me to
like me to try to put a patch up let me know.


Thanks to both of you for your time.
