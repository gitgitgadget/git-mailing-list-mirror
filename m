Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285A8C43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 07:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DF720795
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 07:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo3JU7tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgISHlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISHlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 03:41:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567DFC0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 00:41:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so11031550ejf.6
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nP9aEkTeM/4rRcbtd7kGylZzEgFWhf/7pQkFPlQNcDE=;
        b=Vo3JU7tJ26rT+xQUmA13pMS+uTRA4prgZWNb3Ijn35y70DE00/YbT44Iq+3Ux9daWH
         36h6KCO8sTx6A0WmzsiE4s6WTbslQdy3VelVjs+9nk4IoKIHGmnyLxBdrc3YS9yO9+h4
         QnyJWIoqmkU6H7dv7fvqcCrNyNJIDK/8DOWSxAnSyUxTzhhZHB5MNyK3tgz0wjFohV1F
         VCdHv93WDRaZkSb2LRS97M1D9LQutqZno+IGz49nTx0Oo9lfRKJ3hV4jDDCmTFBZ+egP
         g1MxqS+gJVWPmGOxVzhQ4uULarkjpuH7ftpn8SpK2fX7LOviZdjqDo3fSXn6s9E1S1/e
         YUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nP9aEkTeM/4rRcbtd7kGylZzEgFWhf/7pQkFPlQNcDE=;
        b=SQ6oESyhP2JsTeXUmJgBwp7gbKbVGQZe5U1dV8ThhT5Vw3WD0wRwPzHGiEnSi79tDc
         xdCcL/nhs2jQL668QKlscyCGMzfUlMf8rpq7kEt+RIAtcba2dNgSlnvOXO7mzONPQcuM
         A7Qj6U25pyIGlcpPYhwQeCOR8R7LbiomlixyW3eNuMGMVX+PH3SeRmJ37kH2rISRvOVR
         pnOdMSzfdB2QE57l1jPqRzku3hexY7oOzh1HjyYUB4X8/D2ZM8eXghd3Sf8fhnpv3xFi
         axY3hjORh/yMP6NcQOPCv1ATXUkIU9QD3hfUtzr+/kgM/4WpAnh/jQ1ivBwByGLECAN8
         M+Yw==
X-Gm-Message-State: AOAM531FfyBCjcWjb5JeabLFQlRM9y1eiYchPw/nYRuKIiST1dgysjVY
        rRUBK1sSBsk61MsxiWMwTIlCp1FHUjcqzGYx0RpuMZ8xIkc=
X-Google-Smtp-Source: ABdhPJyg+AL+mC+Ry8cs+9ZTiwsrXi0O/vg4PGaRdKPb4/SJchV1KwFKt8uwm50DY6SGgaklCI948lHZ5VWtgX7oXwk=
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27mr41919464ejg.283.1600501267808;
 Sat, 19 Sep 2020 00:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com> <nycvar.QRO.7.76.6.2009072051470.56@tvgsbejvaqbjf.bet>
 <CAP8UFD0_75zR3xoBzbVZjgTY2+KvORLFNMZ36s8+m6KZyNTXPg@mail.gmail.com> <nycvar.QRO.7.76.6.2009162206580.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009162206580.56@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 19 Sep 2020 09:40:56 +0200
Message-ID: <CAP8UFD1BxnOk4-gaUQb9bY5zhAtD8Jy-x0RC=pNMSQvUaVxRmg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Sep 16, 2020 at 10:27 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Wed, 16 Sep 2020, Christian Couder wrote:

> > To summarize more, it seems to me that only the following scripts
> > could be worth converting:
> >
> > git-difftool--helper.sh
> > git-mergetool--lib.sh
> > git-mergetool.sh
> >
> > I wonder if they are really worth converting though, as they should
> > probably all be converted together and we would likely also need to
> > convert the scripts in mergetools/ at the same time. And then there
> > should be a way to still easily configure things for users. So perhaps
> > a better way to approach this would be first to convert the scripts in
> > mergetools/ into config files.
>
> The biggest problem is that they're all entangled.
> `git-difftool--helper.sh` sources `git-mergetool--lib.sh` and uses quite a
> bit of its machinery.

Yeah, I agree this is an issue.

> As to converting the scripts to config files, I'd rather have them
> hard-coded in the source code.

I am not sure what are the pros and cons of hardcoding vs config files
in this case.

My opinion is that config files would make it easier for people to
contribute what's needed for new tools, while hardcoding might make it
more easily extensible for us and might reduce backward compatibility
issues.

> I would then probably try to implement the bare minimum for the
> `difftool--helper` command to work (re-implementing in C only the parts of
> `mergetool--lib` that are necessary), and only in a next patch series work
> on `mergetool`.

Thanks for your opinion on this. For now I think it needs to be
discussed more before we could suggest it as a project.

Best,
Christian.
