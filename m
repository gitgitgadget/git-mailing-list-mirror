Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F66320960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbdDMSIR (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:08:17 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33849 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753873AbdDMSIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:08:14 -0400
Received: by mail-ua0-f195.google.com with SMTP id u59so5113014uau.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xlAvcA0ZKfixCRhZbkpIJqOzBVJBnMpBHSFJ/xGergY=;
        b=GU9OuvrNAlaeuLvCkvx3zwYwaNyBGCIZqvkJazBa6RHYXf0qcC1+cDVXKMeYT3bs6H
         EkOMn8qUnlTVJfQQIONsoJvqAdf61w5kpWHEOGsU4PS92pYRSomjp2u7nWU31FE5E80x
         WbpH45Jq0GF4sR0UDxbAgEYph5jiyrL4HoNe0waQTzHwtRxmEJJDktDTa+9F77zZAZWt
         ma+WPbM0p/sIPIIEdWd1RPcsq0cMGIJh0UgUVKkiB/1JepNfNmjWtzDrGC8FPfknnZHH
         0mrAxQSTOkAlx7UlBhMvH/GZoP6SERSopM2MRTiOhhgzoqvVrf3lGyd1vgsO+dFX48cD
         ycAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xlAvcA0ZKfixCRhZbkpIJqOzBVJBnMpBHSFJ/xGergY=;
        b=MPnXpfgr2NPnI5Fof4Kc6B8RqwzkpmOjPKsdr1RzrTT6Zf7cb3c8EkPLU7IoShj3fS
         ONsPJguR0fGfcuHN4XqRxvzeSYVYC83QUKITVaxyt34XEA1waub0YBkVVY08g+RCZNnI
         crisiY6iu9nZ2FM6onlzjcl3h7jO70s9Oz7Jk+8Xz260SHPA9HeeogJQGGovcE41ncmY
         PgUjQW7ipS2iVABkPPVh4Mbry5asCSGB4NUedKDLLW6PdTAYPpAG2PeecCBkSwz1urzc
         XEOjVh4C/0pZgDcUtXnrOUVN4D/5vVDGrAUucjg7dpSnjG1vMqaS5JVi4SjLyHdN1Ovq
         qkhw==
X-Gm-Message-State: AN3rC/7yNeJhYX1UviEh6UZw9+eqUyE8J+XvHNVyXb0A360BGdrJFaIy
        /WiKfgjW6i3Q76gxEXVMd4Zx6hJ1VA==
X-Received: by 10.176.74.80 with SMTP id r16mr1651165uae.39.1492106893036;
 Thu, 13 Apr 2017 11:08:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Thu, 13 Apr 2017 11:08:12 -0700 (PDT)
In-Reply-To: <20170413164451.quvt7xdzsm64lntp@sigill.intra.peff.net>
References: <20170412220717.7357-1-szeder.dev@gmail.com> <20170413103138.12717-1-szeder.dev@gmail.com>
 <20170413164451.quvt7xdzsm64lntp@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 13 Apr 2017 20:08:12 +0200
Message-ID: <CAM0VKjkA3O9YB5QpT+hBwt13FtQXOwiW5Fh3goSbi42V8rTzjQ@mail.gmail.com>
Subject: Re: [PATCHv2.1] t6500: wait for detached auto gc at the end of the
 test script
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 6:44 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 13, 2017 at 12:31:38PM +0200, SZEDER G=C3=A1bor wrote:

> I did wonder what will happen if Windows learns to daemonize() the
> auto-gc. I don't think we'll get an immediate test failure, but this
> test will become racy again. But this time we'll actually notice the
> racy failure, because the "ls" will report extra packs if it runs before
> the background gc does. At which point we can revisit this.

Dscho said that it would take significant effort to make daemonize()
work on Windows, so I guess it will take a while before we'll have to
revisit this.

> It would be nice if there were a non-racy way to detect whether we
> daemonized or not, and complain on Windows when we do. Then we'll be
> notified immediately when daemonize() changes by the test failure,
> rather than waiting for a racy failure.
>
> I guess we could probably grep for the "in the background" message from
> the parent gc. OTOH, maybe it is not even worth it.

That wouldn't work at the moment, because auto gc says that it will go
to the background even on Windows.

As it is, auto gc first prints the "Auto packing the repo..." message,
and calls daemonize() after that.  Which message it prints, i.e. "in
background" or not, depends solely on the value of the 'gc.autoDetach'
config variable, which is true by default.  The only platform-specific
thing about all this is the #ifdef in daemonize(), but then it's
already too late, the misleading message has already been printed.

See the discussion the patch for the same issue in a different test
script (bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01)),
including a patch at the end that prevents auto gc on Windows from
lying about going to the background (which I, not being a Windows
user, didn't follow through).

  http://public-inbox.org/git/20160505171430.Horde.-GuvDpZBfS8VI1Zcfn4bJQI@=
webmail.informatik.kit.edu/T/#u

> The racy version
> should fail reasonably promptly, I think, and the comments you've left
> would point any investigator in the right direction.
