Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E061F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbeGTTxV (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:53:21 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35515 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTTxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:53:20 -0400
Received: by mail-vk0-f65.google.com with SMTP id p12-v6so6555957vkf.2
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yzCMC0EM4ti/m5G0KN0q4h+YqibUm4/Yv/kE3x2FxCU=;
        b=S5x+tOc9ZVcAdRxmDAg6IZtAedMLqBTLAnlRgesiIp8fJ5WJfBpeimGEt9dg4reQbO
         Bf0ZA2AWIWi9cuQEeDymvQEYPRqCLnMNIElklyZYkdR9iKYcaguQIQ9IB3Z+lCqXB9RG
         MPwqYNP7xSyeZ12ooPySkYfU3LOFWhUhJKn01P3E9KG6BRAUPJEKsy5SyuT002aZOXfc
         ASkjfHPorrb2hXe1k7zUQMyiWubZTckUrgp9s8vDlL6fZQkjZW+hAKI7f6CeHQk5HGm+
         T7HLPKxQTBgrzyzCVpsvjVTyRmQpK+7tbhm7bVg8K9QnW/p3i92BtJLTzHYNB933n3AZ
         y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yzCMC0EM4ti/m5G0KN0q4h+YqibUm4/Yv/kE3x2FxCU=;
        b=DTh4MU5xTgtCoF/ff6mhsvmOfF+fApZCqy10ormmigWbJQWMBSkqP65ZaUCq5tgHNr
         D+9C2OMpmX3G30FKtxNvtXmwvGRYCnwhss8ycwny3byhIG9Wvo4w7a7V0N2JXAa5r+2a
         NLW9dmKN+YgHDp8nz/+xTznyym5eB7vnfAzVt24zWxZbGECCOoJhpGi4m4MJu2hWvTQr
         oPJHU9F+//4wwryOqDKtxlupEUoPv81SM6jjkdcjtvp1p/sCruKFyPjQ8TV1E73bIYDi
         GgkVZ+d0yq2juc/+Ayw4Lq0HG0Kvh4uapS97puPszkD4QeGfa0//DFmP6JoFAgudpWLv
         8XRw==
X-Gm-Message-State: AOUpUlGNu/dtk5XjM29Wu/1ZwS0IHVmTqKTpJBHEXkouzp3aXhXYORFH
        J0VQpZ2lwtsxFk5fWPKhtbV53RJqHUdQYe2X931WeyJm
X-Google-Smtp-Source: AAOMgpeT+j1wXXg8oASEpMiqSiTi+yE7eBgNgGI4/w2FrI0UUkzDvDBtICQtCHFE43n6M6qj3SjAlvAj/yHl5Sel0CQ=
X-Received: by 2002:a1f:e1c7:: with SMTP id y190-v6mr1838702vkg.129.1532113424935;
 Fri, 20 Jul 2018 12:03:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 12:03:44
 -0700 (PDT)
In-Reply-To: <20180719222641.12152-1-szeder.dev@gmail.com>
References: <20180719222641.12152-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 12:03:44 -0700
Message-ID: <CABPp-BGko5_N7uX=AgTqjTyF2rSusR81FnSQpSNhXxi64uvY3A@mail.gmail.com>
Subject: Re: [PATCH] t9300: wait for background fast-import process to die
 after killing it
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Rannaud <e@nanocritical.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 3:26 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> The five new tests added to 't9300-fast-import.sh' in 30e215a65c
> (fast-import: checkpoint: dump branches/tags/marks even if
> object_count=3D=3D0, 2017-09-28), all with the prefix "V:" in their test
> description, run 'git fast-import' in the background and then 'kill'
> it as part of a 'test_when_finished' cleanup command.  When this test
> script is executed with Bash, some or even all of these tests tend to
> pollute the test script's stderr, and messages about terminated
> processes end up on the terminal:
>
>   $ bash ./t9300-fast-import.sh
>   <... snip ...>
>   ok 179 - V: checkpoint helper does not get stuck with extra output
>   /<...>/test-lib-functions.sh: line 388: 28383 Terminated              g=
it fast-import $options 0<&8 1>&9
>   ok 180 - V: checkpoint updates refs after reset
>   ./t9300-fast-import.sh: line 3210: 28401 Terminated              git fa=
st-import $options 0<&8 1>&9
>   ok 181 - V: checkpoint updates refs and marks after commit
>   ok 182 - V: checkpoint updates refs and marks after commit (no new obje=
cts)
>   ./test-lib.sh: line 634: line 3250: 28485 Terminated              git f=
ast-import $options 0<&8 1>&9
>   ok 183 - V: checkpoint updates tags after tag
>   ./t9300-fast-import.sh: line 3264: 28510 Terminated              git fa=
st-import $options 0<&8 1>&9
>
> After a background child process terminates, its parent Bash process
> always outputs a message like those above to stderr, even when in
> non-interactive mode.
>
> But how do some of these messages end up on the test script's stderr,
> why don't we get them from all five tests, and why do they come from
> different file/line locations?  Well, after sending the TERM signal to
> the background child process, it takes a little while until that
> process receives the signal and terminates, and then it takes another
> while until the parent process notices it.  During this time the
> parent Bash process is continuing execution, and by the time it
> notices that its child terminated it might have already left
> 'test_eval_inner_' and its stderr is not redirected to /dev/null
> anymore.  That's why such a message can appear on the test script's
> stderr, while other times, when the child terminates fast and/or the
> parent shell is slow enough, the message ends up in /dev/null, just
> like any other output of the test does.  Bash always adds the file
> name and line number of the code location it was about to execute when
> it notices the termination of its child process as a prefix to that
> message, hence the varying and sometimes totally unrelated location
> prefixes in those messages (e.g. line 388 in 'test-lib-functions.sh'
> is 'test_verify_prereq', and I saw such a message pointing to
> 'say_color' as well).
>
> Prevent these messages from appearing on the test script's stderr by
> 'wait'-ing on the pid of the background 'git fast-import' process
> after sending it the TERM signal.  This ensures that the executing
> shell's stderr is still redirected when the shell notices the
> termination of its child process in the background, and that these
> messages get a consistent file/line location prefix.
>
> Note that this is not an issue when the test script is run with Bash
> and '-v', because then these messages are supposed to go to the test
> script's stderr anyway, and indeed all of them do; though the
> sometimes seemingly random file/line prefixes could be confusing
> still.  Similarly, it's not an issue with Bash and '--verbose-log'
> either, because then all messages go to the log file as they should.
> Finally, it's not an issue with some other shells (I tried dash, ksh,
> ksh93 and mksh) even without any of the verbose options, because they
> don't print messages like these in non-interactive mode in the first
> place.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t9300-fast-import.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 9e7f96223d..fac33e524c 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3147,7 +3147,10 @@ background_import_then_checkpoint () {
>         echo $! >V.pid
>         # We don't mind if fast-import has already died by the time the t=
est
>         # ends.
> -       test_when_finished "exec 8>&-; exec 9>&-; kill $(cat V.pid) || tr=
ue"
> +       test_when_finished "
> +               exec 8>&-; exec 9>&-;
> +               kill $(cat V.pid) && wait $(cat V.pid)
> +               true"
>
>         # Start in the background to ensure we adhere strictly to (blocki=
ng)
>         # pipes writing sequence. We want to assume that the write below =
could
> --
> 2.18.0.408.g42635c01bc

Sweet, thanks for fixing this.  I got these messages nearly 100% of
the time on a certain machine when running prove with a high enough
parallel flag.  I was getting a little annoyed by them, but hadn't dug
in yet.  Your patch squelches them up in my testing.
