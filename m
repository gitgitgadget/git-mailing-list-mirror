Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4906C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 03:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJLDcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 23:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLDcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 23:32:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C97961F
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 20:32:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b18so645395ljr.13
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxHNzSuWSNVT5TAJ5nWJbQXTaWizA2b8F1ljFlSjgKo=;
        b=M9/55hfVcf5HRzgEwuVviI4IEQ0eAZ7PcHubm5qGR9TcrUfVhz9ExSa7XH1jmGeXcv
         QXcwYTSYMhWvH/hBrjazWUbZnoImGGeCQHcwgOfxxkNFgQFL5sQGJbnJY9178/oRZvdK
         dUiIOeYopDQ9DttPMBixyzG3GSsJSRAm15nkHD2zo4QJhLaNdwFgiBCcjVGcA4ts3paE
         t/DBSqUkVnpSeu7rxVhM3wyR6afLrjA/Gzt2bJhTUwv0QUDXTM66/C+Txe0OD7h5aX+v
         dVDE/pdOh5cnh+OksvzHPGrn/Vhksi4/bd4w07wevExA94lVlbE83R0oDoewjjEIfeo0
         Myug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxHNzSuWSNVT5TAJ5nWJbQXTaWizA2b8F1ljFlSjgKo=;
        b=5gMwfnhmobH2gmWCxHP1B+tREoPw7qU2BB37YkJijegY4DzGhA3GJpbeZzrSeZgcNc
         jLDnmTBd83itoV0xuJjZA+jR4hnLWFcs1MN4SnM5HOygu/SRXRsmNxe8JQZFinf/2PpJ
         BfvFuBBC37bgumEvmJm+Bcz036vwBYG4VEsb/5kgfKEXlysvsld346UrvjcTfGMLZ0HZ
         xrdLvQOpvSMGdpKMBDfwL9WtCp51mmKIRlFEKdIwuQfHpk6LnKjx97G1tfCakv8xBLmX
         ySj68hq/q6yY++wWuGyzeRcs42i2ZNGYrCXfiq+B0gtEoi6o6dwee4eqFoXyKqLsPaRO
         JtiQ==
X-Gm-Message-State: ACrzQf3VCo9FfJkgO93SPsYaqHm9B1ClZ5GGVm+32pz14Qya2joMLTyC
        Nm9ZgY8R+ZaufvYCXAWgb03OUKsS+eB8W1LI8NI=
X-Google-Smtp-Source: AMsMyM7RJGuofHhtEaywh7wsbOM43WSFdETIVHrozRGNbYm3EQ5GMdFrrdXuLppwhQNihBgTTF64b0l2kG2176cmd24=
X-Received: by 2002:a2e:701a:0:b0:26f:a35e:ff67 with SMTP id
 l26-20020a2e701a000000b0026fa35eff67mr5584144ljc.288.1665545525005; Tue, 11
 Oct 2022 20:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com> <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
In-Reply-To: <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Wed, 12 Oct 2022 06:31:52 +0300
Message-ID: <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team, I am reading through "My first contribution"
when I run make all doc, I get the following;

SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR templates
make -C Documentation all
make[1]: Entering directory '/mnt/c/Users/USER/documents/git/Documentation'
make[2]: Entering directory '/mnt/c/Users/USER/documents/git'
make[2]: 'GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory '/mnt/c/Users/USER/documents/git'
    XMLTO git-version.1
/bin/sh: 1: xmlto: not found
make[1]: *** [Makefile:355: git-version.1] Error 127
make[1]: Leaving directory '/mnt/c/Users/USER/documents/git/Documentation'
make: *** [Makefile:2720: doc] Error 2

How should I go about it?

On Tue, Oct 11, 2022 at 9:48 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Simple steps that I followed on windows 10
> -open the command line application with administrator rights
> -run wsl --install.
> - Restart the computer
> -check installed distributions, wsl --list --online
> -run ubuntu distribution, wsl -d ubuntu
> -add username and password
> After the above steps I was able to set up git on ubuntu
> NB: to start wsl when you stopped, just type wsl -u "the username u
> created" in the command line
>
> On Mon, Oct 10, 2022 at 9:22 PM Derrick Stolee <derrickstolee@github.com> wrote:
> >
> > On 10/10/2022 2:17 PM, NSENGIYUMVA WILBERFORCE wrote:
> > > thank you all for your suggestions, let me see what is easy for me
> > >
> > > On Mon, Oct 10, 2022 at 7:58 PM Luna Jernberg <droidbittin@gmail.com> wrote:
> > >>
> > >> Maybe WSL can be used?: https://learn.microsoft.com/en-us/windows/wsl/install
> >
> > If you do go the WSL route, then please share your learnings by updating the
> > contributing doc either in git-for-windows/git [1] or here on the mailing list.
> >
> > [1] https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md
> >
> > Thanks,
> > -Stolee
