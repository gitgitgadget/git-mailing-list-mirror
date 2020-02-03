Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8CC33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7F120658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCWlCzQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBCLBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:01:36 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42808 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgBCLBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 06:01:36 -0500
Received: by mail-io1-f41.google.com with SMTP id s6so5806389iol.9
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YUDnEJ/o097O8W/8Oum7TGhj/ujIHf+o82761V678fg=;
        b=YCWlCzQyBiDoNXmoIehtwrFCtGE1syNB4wfqwhnzjS8Uk0IA95cY1/yCVYFlYyLRwa
         bYs9gQ/laC2mbG9PFcx0QlMGTBhQiKZgSPPzAly3C88CFKZWytJicTOzpmXMaLbII5AL
         Oo6vhUiLrGg0Dik0ExyODe2H8LQPAHzJav/MFGCjrYRcE2rto93wUvbHvaCbE/DJ2LNA
         3P6mnz1rCquRQtlIfCp15XyDIphko+b30qtu/JxWn4kk1iqHHoVvjFXSHcSclUs0RbtS
         dMytK8dG8+/qaE41T1VKBq9X6FkM8ejIcX7jVl8qnK/lLyWePoO7pWM/S0DoLMUxbdzg
         L70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YUDnEJ/o097O8W/8Oum7TGhj/ujIHf+o82761V678fg=;
        b=GFkItoPJ/4/fdj3tih+9EoY83iBnE2T/X0fcJJxYLKlBMlFHxy9vOwx7LTFGZpUds/
         fBGKyKJHAJlfQMxRRQFFi76roXSBXFuos95EY8MXqwxvjPHonXPsHjnQHJT5FbIYhg7H
         JoRHMGsrR0Wum+EGt3IV90TQmfBxfjoa2pUSMSeFPsxsid0ZIaMn1vAxINqPhGq3tti9
         KdfQ0dx84Saoo6NPbLqA5THN4DNHpWhkxNlQ8jCsT3d5UYtDCdJKKnOrZW5rbVxQwTaI
         BcZYLROY2qrqArHjrx4J4s4EoItg9fl0PR3axanegIu/jQ+qxY8Tk8ybnVums7w0suf9
         Bprg==
X-Gm-Message-State: APjAAAUadZrPhW8QFye+P6pslYeGNEVyokFQpKSogUhfWPthD8V4byaW
        ywOgkQE0WhexkO0D2ab8WBRYaSHX7EuF2T5nXOb6ddhj
X-Google-Smtp-Source: APXvYqx6EFHUg+sx4yuhPyZFuSInEhsTdcd4VhDPxIjIi1CNk63xIsRGcFqrn/riVl2mPbXwcVwP4DU9V7a+S25D/WY=
X-Received: by 2002:a6b:b74a:: with SMTP id h71mr18009982iof.212.1580727695462;
 Mon, 03 Feb 2020 03:01:35 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8kXPi0teqdZ8NRJ677Z6btbmdafR=y4MFFaKZgZrB=d4A@mail.gmail.com>
 <20200203084356.GB2164@coredump.intra.peff.net>
In-Reply-To: <20200203084356.GB2164@coredump.intra.peff.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 3 Feb 2020 06:00:18 -0500
Message-ID: <CAH8yC8=-ht7D3CyM-YoJSfW3hueaWVp5WQz2+BJOFMjmt8aDsg@mail.gmail.com>
Subject: Re: Git 2.25 and failed self tests on OS X
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 3:43 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Feb 02, 2020 at 11:08:17PM -0500, Jeffrey Walton wrote:
>
> > I'm seeing some self-tests failures building the 2.25 release tarball
> > on OS X. I'm seeing it on the old PowerMac with OS X 10.5, and a
> > modern Intel Mac with OS X 10.9. PowerMac failures are not too
> > surprising, but the modern Mac should probably pass its self tests.
> >
> > *** t3902-quoted.sh ***
> > not ok 1 - setup
> > #
> > #
> > #               mkdir "$FN" &&
> > #               for_each_name "echo initial >\"\$name\"" &&
> > #               git add . &&
> > #               git commit -q -m Initial &&
> > #
> > #               for_each_name "echo second >\"\$name\"" &&
> > #               git commit -a -m Second &&
> > #
> > #               for_each_name "echo modified >\"\$name\""
>
> It's hard to see what's going on with this output. Try running:
>
>   ./t3902-quoted.sh -v -x -i
>
> to get more verbose output.
>
> Looking at this test, it tries to create files with funny characters in
> the names. Presumably your filesystem isn't happy with one or more of
> them. The verbose output will probably make it clear which.
>
> Version 10.9 isn't incredibly new, but these tests have been around a
> long time. If OS X has a problem with these filenames, it seems odd for
> it to be surfacing now.
>
> Do you know what filesystem you're using? You aren't running the tests
> by any chance on a network mount from a Windows machine?

According to `diskutil info /`, the filesystem is Journaled HFS+. The
tests are running locally on the Mac after logging in over SSH.

I'm wondering if Perl is the problem. I had to cut-over to OpenSSL 1.1
due to deprecation of 1.0.2. OpenSSL 1.1 increased Perl requirements,
so now I have to build Perl, too. Previously I was not building Perl.

I'm installing Perl 5.30.1, but it is a minimal install. I only
install Text::Template Test::More (plus whatever else Perl installs on
its own from cspan). However I could not install HTTP::Daemon
HTTP::Request. There's some bug in the cspan installer. It gets stuck
on one package and tries to download/install it over and over again.

Do you know if Git is using one of Perl's Text:: packages for the test?

Jeff
