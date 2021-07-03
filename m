Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D33C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F6C61490
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhGCOfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGCOfx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 10:35:53 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69580C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 07:33:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id b13so21337959ybk.4
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mxdgWanBkmczo9PJH/B3/FUMngTaQY13p/kjimuLeJ8=;
        b=SU+E0AfqxFv/mqNHOeCJLuUJTuis3DSaqYbNS1u+0PI1fWBf5BCjkBX2LSZlKq/t1+
         miwKFB5KL5pFWZkOKzYqP7vRRR87WodidrSNnj02LnqzXj4rl2WiQwkIFSXe6bkyAm3U
         VwWLEYZXEuC46IAcbfrmMdSS7RAnZswFn4VOcNUDYXE0JkCgudIYLj4Es+HmAAAoDrQe
         ghwu//6oANOfLuPkAyPMVF7KynRbU/JNrqD4Wq6eVGqeL6IvH+Ut38KZgaEWcMwcLCKm
         f9UqS9rmyzVIq7aIlVkJ33hNM+2E9kf5eyjvbdGULaAOJC+BBofWgcr37mFprqp1Hmu/
         B+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mxdgWanBkmczo9PJH/B3/FUMngTaQY13p/kjimuLeJ8=;
        b=PbK0GrwrQMIGoFabRFRhHLq5xRVXbafDkCbXoCXWtQF6vfZzFSHjOCWPFN2Mxlz3FM
         vFaSSIoGy4ahzRYLfJaSB0AOyjKiRUNYmlTbig3A8iZotzKtkwi+LBVaadAhfRkk0slV
         vUA5S1Lkz7VqJp9GkuvIJJH4+ZZJ1ByxowAu9HQ5b5QvKjdc+D1hDaaAk5YZeBTeJdrP
         wG7A7iSKGEC7Vr8gzxuRjSl6JaKCDJLvniYSFI6t4ckvGY+iMzOlAlVnvlWzevPVbUIg
         aQigDwu3PVw45qges4NBQjdTXJ+NpUeIJQKAnjH6yjdMTc86B82rwTWvpv5OBm3YOCdp
         R6WQ==
X-Gm-Message-State: AOAM532imYWIAVviUC/iG22R1Q2Y4OWOBaL97miM3xVKEFWIH2ZAyGc/
        9SLO7TgYoh8Nzmz7H6Yaw7Wmc6Hol3eNfQOefds=
X-Google-Smtp-Source: ABdhPJyrFv5ee2lnPnSjxE3EbonukRKa5Wz++V9VlTeSanUhLAj51Cv/Aa/jMOkfFBCghrGBdXOofUUxs/xK+OSjM/M=
X-Received: by 2002:a25:3415:: with SMTP id b21mr5633427yba.155.1625322797732;
 Sat, 03 Jul 2021 07:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
 <20210703111837.14894-1-worldhello.net@gmail.com> <87sg0v8vr8.fsf@evledraar.gmail.com>
In-Reply-To: <87sg0v8vr8.fsf@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 3 Jul 2021 22:33:06 +0800
Message-ID: <CANYiYbG3SVqwnHv67K8JGNxHBBC+EY-LGWCsmt4ZQJOY2Me8yg@mail.gmail.com>
Subject: Re: [L10N] fixed mismatched variable names
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jimmy Angelakos <vyruss@hellug.gr>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=883=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:47=E5=86=
=99=E9=81=93=EF=BC=9A
>
> This seems like a good narrow fix for now, but I'd think a much better
> fix would be to e.g. add something to the CI or a lintk check based on
> "git help --config" that errored if any string meant for gettext
> contains such a variable.
>
> It's data that isn't meant to be translated at all, so we should be
> passing it as %s to the format string.
>
> I see there's at least one fix that fixes a reference to a function
> internal to git.git, such a check wouldn't catch that, but that message
> should be fixed too. We shouldn't have anything referencing code names
> except the BUG() messages (which we don't translate)>

There are at least three types of constant strings that should not be
translated: git config variables, function or variable names, git
commands or command options. See new test cases in commit:

https://github.com/git-l10n/git-po-helper/commit/86791cf25b17b6853bcbad7b50=
1a76906ac86a02
