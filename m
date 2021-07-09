Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF0C07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D06613B2
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGIBgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 21:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGIBgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 21:36:18 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DFCC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 18:33:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r135so12105626ybc.0
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KweNPCa11+DwvRI62HmJnBIWCufFpd31LE3zwTMLsTY=;
        b=sb2N3xIA/osu3YeCZt55HHoM+jCa7i9VpbDN/KupYTQqUIxl+xqd+9zSaF9CvI4jZO
         eFEPE1LGV1PGjYpBY5y89WsI3mdu+Dd5ibS5cO1BtJsIXsg/fiyvSl5gNvhTT37ENG07
         joyh0kImrWF2lbAV19ee+/zz4EBOUh14RfTrkdcI4+2M7twr8KOgU2NducGpzLmR7V6s
         IAZTxqJ6ahrN8PZ0UbeXfrD5l0tYkYn6r/GtFtY41PVth1J6y3p7cMautzum8AdlXbc4
         JU4tGj8eOHeLfyeQvxORH8olZuY9+oiTHziO3XNKQJsIa6g/PbkLPpbIp8NtChtWi2td
         EXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=KweNPCa11+DwvRI62HmJnBIWCufFpd31LE3zwTMLsTY=;
        b=tsqew4xmWBIxM2YNiYpYh/Q4SyJFkA1UNeZv6/hC2C5sB0wkouNkrxeForW7D4arpa
         Ibb7useEMZGgj6S6qz7vaRu2NMtcXIZrJeWqVV3A7JInEwE9UPWd3K8geFUXb7wrL7dU
         XvIFUg7OQn43F8TgpWUZOHnH6w3zpPqCHoF+jjE8k+bMRhZxRs0brKQ3BrSZOkahFIgn
         qlRgp/BcK8KmDcHN2pNHrABmr2dOmR13x7MPA5cftFsId8S0bKuDnNXe5qKJD5tPZiVm
         /f+KSgk2QkoCSw7tQZ48RLScSYvnJLH8hZqY0yOvCxNN5Y0m+Gsv/dzXXV1zQGPjPBan
         8OsA==
X-Gm-Message-State: AOAM531ilmazC00b5UvygAFzDo/W9gaUMppm5gSq8u61isFpaAJ5uIT3
        a6W1RcTjIOUTsTNuxEC1FMokGj/PP3zvscJDB1M=
X-Google-Smtp-Source: ABdhPJyHBdD+KpiomxeME3/ShS/xAmcw9SZt9LBL4fgoYhfGse2MMszrLzwUmQGuKsr2RTMFMFhWiudBjLV6geLDG0A=
X-Received: by 2002:a25:be0f:: with SMTP id h15mr43731306ybk.520.1625794414663;
 Thu, 08 Jul 2021 18:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210708150316.10855-1-worldhello.net@gmail.com> <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
In-Reply-To: <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 9 Jul 2021 09:33:23 +0800
Message-ID: <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson <sandals@crustytoothpaste.net> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=889=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:02=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On 2021-07-08 at 15:03:16, Jiang Xin wrote:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Options and revisions can be seperated by the option "--end-of-options"
> > by introducing commit 19e8789b23 (revision: allow --end-of-options to
> > end option parsing, 2019-08-06).  The following command will show
> > revisions which have changes on file "bar" on a branch named "--foo":
> >
> >     git rev-list --oneline --end-of-options --foo -- bar
> >
> > If we want to see revisions between two revisions (rev1 and rev2), we
> > can use the following command:
> >
> >     git rev-list --oneline --end-of-options rev1..rev2 --
> >
> > We know that "rev1..rev2" is a shorthand for "rev2 --not rev1", but
> > we can not use the longer expression with option "--not" after the
> > "--end-of-options" option.  This is because the parser will not consume
> > revision pseudo options after seeing "--end-of-option".
> >
> > Allow parsing revision pseudo options after "--end-of-options", the
> > following command is valid:
> >
> >     git rev-list --oneline --end-of-options rev2 --not rev2 --
>
> I don't think we want to do this.  The goal of --end-of-options is to
> prevent parsing all future items as options, so if someone specifies a
> revision starting with a dash, we don't end up with it being interpreted
> as an option.

New test case in t6000 covered this case. Branch "--output=3Dyikes"
which starts with a dash is used as revision after the option
"--end-of-options", and it won't be interpreted as an option.

    test_expect_success 'parse pseudo option "--not" after "--end-of-option=
s"' '
        cat >expect <<-EOF &&
        > three
        EOF
        git log --pretty=3D"%m %s" --end-of-options \
                HEAD --not --output=3Dyikes -- \
                two/three >actual &&
        test_cmp expect actual
    '

But for the original implementation, because pseudo revision options
(--branches, --tags, --not, ..., etc) can not be used after the
"--end-of-options" option, we have to put "--end-of-options" at the
end of revisions, such as:

    git log --pretty=3D"%m %s" rev1 --not rev2 rev3 rev4 \
            --end-of-options -- path/file

We can see from the above command, the option "--end-of-options" is
immediately followed by a dashdash. That is very strange.  DashDash is
designed to separate pathspecs from args, and "--end-of-options" is
designed to separate revisions from options. But because of the pseudo
revision options, "--end-of-options" is meaningless for commands
calling "setup_revisions()".

Yes, "--end-of-options" must be used if there is a revision which
starts with dash, such as branch "--output=3Dyikes" in t6000. That's
even stranger, for we have to write  command in the middle of
revisions like this:

    git log --pretty=3D"%m %s" rev1 --not rev2 rev3 \
            --end-of-options --output=3Dyikes -- path/file

I know "rev1..rev2" and "rev2 ^rev1", but I prefer to use "rev1 --not
rev2 rev3" instead of "rev1 ^rev2 ^rev3".
