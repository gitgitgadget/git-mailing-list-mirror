Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD8C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 13:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiESNT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiESNTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 09:19:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6056C3D3A
        for <git@vger.kernel.org>; Thu, 19 May 2022 06:19:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so4670103qkp.9
        for <git@vger.kernel.org>; Thu, 19 May 2022 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VE51fNaAyYwyImFz0oIEsj5KMQcZoETZFjpisQc77Tc=;
        b=iA5j7vopdRnJDbgthgsa2StQcE7YyfOixiI8yhJV8uVU+EKwH98dB3ccDrxIWnpd5o
         zIpe5t2clUiXlpbyiFFfgTxtnabED7NQrlJqZPAB+QRENmvBimeUSQgN5ofrvkhIJlS/
         XuXTavpjtzPEykZbmrLhlbhILyr9D7KANyU55MEybMhyZD+xoAC4YOvfAkTMgfYzAIZU
         etTFgxEbABx6QAYGwZqtQkBHH32EkS8mFK/LmvCGAxyuvFBaTr5ys3JejKfI4udgg1Qh
         RtEV4o3WTkrsIJMoPQXotO4Mc99DmpTbcO6bqYe4PONWkndtxVWh1GP5hlNljvjnAMDA
         sR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VE51fNaAyYwyImFz0oIEsj5KMQcZoETZFjpisQc77Tc=;
        b=l0pvl9XMKNHLoqgLjip/hvDtjl/MtScz0lgluvyGvlUpEe/sC+kdO35WMsyNMJ54jk
         U/EF9SSVGCaHgmH+m2VDxUhgRhVvpcwmTY/4xzUx3XhgmLPcUBPhIvQwm9xhMj9C2u41
         UVMYJJbCU/ieTiqsVL6KwJqDb5qHb7DANMp1h0Irz42sO+uHBw0fHu8DclZu2p6+sMs+
         /1HPiyWTDiLN3CVMNS4Oa50GAX/EEPI4hbbDPd1qgAgifxCMiZkFxQ8aNizGsYtU3PTZ
         4FCgoQxHEInp74iF4VsCPVU8uDisavFgk7C7pTiZP3KRI1+662nuBd9J70uL7jsA6hql
         imEQ==
X-Gm-Message-State: AOAM532pzP4Rx2vJLThXfCkiRW8sq5q/X5YUMs3aaFt3AVBJj3tj/WVx
        5zEHIGXRr985tcYCLvTDIuZ/CsmN33jRIIsDCNg=
X-Google-Smtp-Source: ABdhPJy+LNSSxrPq+NYzLiTBUWCLJjWI1ouknDOlKHDQu9dkQ78sp0S3h7P/wN6oi1AMsfeHmiWRH9D/fZv0fx0KdcE=
X-Received: by 2002:a37:a097:0:b0:69f:d58b:cf62 with SMTP id
 j145-20020a37a097000000b0069fd58bcf62mr3009899qke.504.1652966362874; Thu, 19
 May 2022 06:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-4-worldhello.net@gmail.com> <220519.86leux6e82.gmgdl@evledraar.gmail.com>
In-Reply-To: <220519.86leux6e82.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 19 May 2022 21:19:11 +0800
Message-ID: <CANYiYbGpMx8JkHj2EMxYYk6KgdpiPr5=7VWEXKevp+J+e7NKcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] Makefile: have "make pot" not "reset --hard"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 5:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> In the previous discussion of kicking things around I lost track of what
> version of mine this is picked up from, but I range-diff'd it to my
> 6cf9c1f7022 (Makefile: have "make pot" not "reset --hard", 2022-04-02),
> which is the latest I had in avar/Makefile-incremental-po-git-pot-rule
> on my branch.
>
> A range-diff of the two follows below (yours being the RHS). Some
> comments:
>
>  * There's a bug here where you're creating .build/pot/po/pretty.c.po
>    files, not .build/pot/po/pretty.c, i.e. you add a *.po extension.

In the original version of your commit, each source file has a
duplicate version in the ".build/" directory, and this will confuse
IDE (E.g.: VS Code) when I jump to a function declaration.

Name the "pot" snippets with the ".po" extension only have the
following side effect, nothing else:

            +#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
             #. TRANSLATORS: do not translate [y/n]
            [...]
            +#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#

I add some notes in commit message:

    While we could rename the "pot" snippets without the ".po" extension
    to use more intuitive filenames in the comments, but that will
    confuse the IDE with lots of invalid C or perl source files in
    ".build/pot/po" directory.

>  * We went a bit back & forth on the "if grep -q PRItime" part on the GH
>    ticket. FWIW I still think just skipping that work is a better
>    choice. Yes we'll have ~10MB of redundant files in .build, and it's

Redundant source files (*.c, *.h, *.perl) in .build will make IDE mad.

>    marginally slower, but "make pot" isn't a hot target, better to
>    optimize for simplicity.
>
>    But if you're really set on having it I don't mind...
>
>  * You add a "MSGCAT_FLAGS =3D --sort-by-file" here, maybe worth having
>    some "common" flags variable in the earlier commit we can use here?
>    I.e. share --sort-by-file with xgettext.
>
>  * Your version is missing FORCE on po/git.pot, which is a bug. We can't
>    omit it on any file that's checked in. We're about to "git rm" it
>    anyway, so maybe we shouldn't worry about it though...

I'm confused. Since the "po/git.pot" target has a full set of
prerequisites, it is fine to remove FORCE from dependence.
