Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FEB1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 20:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbeJPEGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 00:06:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42360 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeJPEGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 00:06:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so16158332oiw.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMMaXzJ6wA4bwhesp3uKP61VVNgUntJOkqJBcleaG3I=;
        b=jaDpH3+RD1bgaNe9Uc7Eg408Xwi/4YRzyOA1AUJ7HoLVyPA5kqlaoux+mMHYCSCasQ
         35iW+xvYcdaHnC3Kc64fmstvk9ArZUXF5RAVfX+hD6uHGyc8DnuIBPhnyb4MFz9xXh6A
         ZuYDuZQ7RmFk22Hl2oIT+iYRYW1mQaiphTvSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMMaXzJ6wA4bwhesp3uKP61VVNgUntJOkqJBcleaG3I=;
        b=L4hpmzAsMmF+tunEjMIsOTj0G3BelwIkW5dBgY4OHl8fFYXfrLxSZ5/GjquAIzF1oB
         v2uY5SBVrDpYYmn1X0YsX6epLM0hLFP42iwD11bYfLW1lOZHf1042SDAU9mnAAeiltH7
         NY/Xycz25OEZFdkLQfXAXbYLzYbVQB1ThSbwTNPslNriUXFiE//wSIDUf1Ce6/fFiM6W
         kS2fOLkrtdPnSHhl7sRRYVdnIiwDQqfYiowyjgxbszbuUgRPtycumMBruS1NgdK9wcTi
         wkf+pu01SyMNCd0jtITZgh6LDUO6vhatVkZb1WkvoXJOx14IvBFYwUBb37WJrOPcSDH3
         HzjA==
X-Gm-Message-State: ABuFfojuvLVzKfvOOQI7axJk9BcyuxWiNMwQIVuExaJRMtkA2MoE0jrm
        YoOWRb16VNr2R72C5kBv8S4Iu/7N4dwFuEnCg6Lx2w==
X-Google-Smtp-Source: ACcGV63wqoNXabYRpzIp268GGUMyT/cfmZyQHhy3WpgZk62ibDlRidB4Oqm6ngBN0Jn+E+ftjduoaguwXmlM7LuHSfY=
X-Received: by 2002:aca:f4c2:: with SMTP id s185-v6mr10179742oih.245.1539634768492;
 Mon, 15 Oct 2018 13:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com>
 <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
 <CAE5ih79cNkVVQOkaeJifSqkcp=HGmRb3a=jJC=g08iV8dYRyXg@mail.gmail.com> <nycvar.QRO.7.76.6.1810151657080.4546@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810151657080.4546@tvgsbejvaqbjf.bet>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 15 Oct 2018 21:19:17 +0100
Message-ID: <CAE5ih78gCgJgeXasdm6j+hO8Bk+_zk_-o5FqkMTr-q7fKDej9Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Oct 2018 at 16:02, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Luke,
>
> On Mon, 15 Oct 2018, Luke Diamand wrote:
>
> > On Mon, 15 Oct 2018 at 11:12, Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > This should be more reliable than the current method, and prepares the
> > > test suite for a consistent way to clean up before re-running the tests
> > > with different options.
> > >
> >
> > I'm finding that it's leaving p4d processes lying around.
>
> That's a bummer!
>
> > e.g.
> >
> > $ ./t9820-git-p4-editor-handling.sh
> > <passes>
> > $ ./t9820-git-p4-editor-handling.sh
> > <fails>
>
> Since I do not currently have a setup with p4d installed, can you run that
> with `sh -x ...` and see whether this code path is hit?

All you need to do is to put p4 and p4d in your PATH.

https://www.perforce.com/downloads/helix-core-p4d
https://www.perforce.com/downloads/helix-command-line-client-p4

The server is free to use for a small number of users, you don't need
to do anything to make it go.


>
>  test_done () {
>         GIT_EXIT_OK=t
>
> +       test -n "$immediate" || test_atexit_handler
> +

+ test -n
+ test_atexit_handler
./t9820-git-p4-editor-handling.sh: 764:
./t9820-git-p4-editor-handling.sh: test_atexit_handler: not found

Is that expected?




>         if test -n "$write_junit_xml" && test -n "$junit_xml_path"
>         then
>
> > And also
> >
> > $ ./t9800-git-p4-basic.sh
> > <starts running tests, but I get bored easily>
> > Ctrl-C
>
> Oh, you're right. I think I need to do something in this line:
>
>         trap 'exit $?' INT
>
> in t/test-lib.sh, something like
>
>         trap 'exit_code=$?; test_atexit_handler; exit $exit_code' INT
>
> would you agree? (And: could you test?)

Not sure.
Send me a patch and I can try it out.

Thanks,
Luke
