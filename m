Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3AC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 09:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiEWJhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiEWJhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 05:37:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF5DF19
        for <git@vger.kernel.org>; Mon, 23 May 2022 02:37:15 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y20so11664778qvx.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G1SEUC9jknd6nr3e673pTsNNe71fZVMIc6cLzRzZ44w=;
        b=b7L4KqVu11znOvCc2LwwX7jCu/DeSSyOfrvfnWK4vK2x1Tdby5J2chIwqMUrEM8CMo
         vfnWKlNoy7C4I21dErCrVmvEqmqXAUp6oHfntR68Rauf/rKu5lqUo3MrKqOPTKe5fdOO
         eZKwugn4wkSDG+HgezvVyUAihs0vrsMlX1bxciE8QGwapS4OoZ5PO03TBpfLw2d7smQI
         3e9P3MLDmKCWjEI65W8VJDjavrudTlruABKKADcJNexXyrC9Mqjwa0JO1sf97Q0BhL1H
         Dn64gxa3KZA3O5boKkVkHYONTHoG+iRJMM18GyitWW5ZnWAeCSVwJooONTCbzY1R8RyS
         DCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G1SEUC9jknd6nr3e673pTsNNe71fZVMIc6cLzRzZ44w=;
        b=u4URGIGHo44MSGJxxdDC3ED+4YknqJ43BjpYpbAmaiCZGt1D2shVq8hcpHwP3preTd
         o+up9OXJJEgeIbAcGHs70fuMgBSFRO1pZwfxzgtKHdUOARfQwr1gmHdExFioDWKiH4Nn
         3yVUgVUiHseP5whd6Eab4Ohbj8CAmNqo/5JW2J9APK304EQ/avPdlz2pH5FWqmcr9YPZ
         n+Obsm4fBYrKBBF/ytBes/gHcTWeKTO+5o1q3ljXYm99HwnHxXLFgSHFlzEtrX6k93tI
         AQLIpbtKCtufhd6RpOI0jNJ2CCVdQ0ydYZdkXkU+4jQaYWC0Vqd/VHEENnQhp19ClPf2
         ojVA==
X-Gm-Message-State: AOAM530bv31ZUgsmHqTXQsDC3M5ZhGziLNfBU5Qc2uwNWgBcpqOzUBOW
        jaH+NXCa+Y7yRdsAaJZ2PnrEwJ8qlKLXpEp/meQ=
X-Google-Smtp-Source: ABdhPJzAQHdsqEc8X8aXXFKsZQUXLPMsYAx1/Row3IIe0CJ2x6Hy/9ktjwcquQA/89tT6Dr6ahblWbB5VQPhnvxffto=
X-Received: by 2002:a05:6214:c21:b0:443:a2d2:a685 with SMTP id
 a1-20020a0562140c2100b00443a2d2a685mr16535337qvd.52.1653298633719; Mon, 23
 May 2022 02:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-4-worldhello.net@gmail.com> <xmqq8rqsu0l2.fsf@gitster.g>
In-Reply-To: <xmqq8rqsu0l2.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 17:37:02 +0800
Message-ID: <CANYiYbE0izM6UoK4+UPwAU61=qBgrg9FJUZ+hU-a20MEfW_aXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] Makefile: have "make pot" not "reset --hard"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
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

On Mon, May 23, 2022 at 4:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> >
> > Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
> > custom PRItime format, 2017-07-20) we'd consider source files as-is
>
> ", we'd consider".
>
> > with gettext, but because we need to understand PRItime in the same way
> > that gettext itself understands PRIuMAX we'd first check if we had a
>
> "PRIuMAX, we'd first"
>
> > clean checkout, then munge all of the processed files in-place with
> > "sed", generate "po/git.pot", and then finally "reset --hard" to undo
> > our changes.
> >
> > By generating "pot" snippets in ".build/pot/po" for each source file
> > and rewriting certain source files with PRItime macros to temporary
> > files in ".build/pot/po", we can avoid running "make pot" by altering
> > files in place and doing a "reset --hard" afterwards.
>
> Good.
>
> > This speed of "make pot" is slower than before on an initial run,
> > because we run "xgettext" many times (once per source file), but it
> > can be boosted by parallelization. It is *much* faster for incremental
> > runs, and will allow us to implement related targets in subsequent
> > commits.
>
> This is to show my ignorance, but is there any downside, other than
> increased overhead coming from runing many instances of the program,
> in the "one file at a time" approach?  I was wondering if two or
> more identical translatable strings appear in multiple source files,
> where they are coalesced into a single entry in the resulting .pot
> file, and if xgettext having visibility into all these files would
> somehow help the process, but presumably we'd use msgcat to unify
> them into one entry so there wouldn't be such a downside there.  But
> are there others?

Both xgettext and msgcat have the ability to unify identical
translatable strings, and list all the filenames and locations in the
reference-comment part of the entry. In the following example, we can
see the message "could not write index" comes from several C source
files. We can also find this message in the corresponding intermediate
po files, such as: ".build/pot/po/add-interactive.c.po" and
".build/pot/po/reset.c.po".

    #: add-interactive.c:709 add-interactive.c:898 reset.c:160 ...
    msgid "could not write index"
    msgstr ""

If there are different contexts (I.E. notes for translators in source
code) for the identical translatable string from different files,
"msgcat" will add additional lines "#. #-#-#-#-# ... #-#-#-#-#" for
disambiguation like below:

    +#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
     #. TRANSLATORS: 'it' refers to the patch mentioned in the
previous messages.
     #: add-patch.c:1106 git-add--interactive.perl:1129
     msgid ""
     "If it does not apply cleanly, you will be given an opportunity to\n"
     "edit again.  If all lines of the hunk are removed, then the edit is\n=
"
     "aborted and the hunk is left unchanged.\n"
     msgstr ""

The filename in the disambiguation comment line ends with ".po"
extension. =C3=86var tries to fix this issue by introducing more
intermediate files (which I will try to understand by some experiment)
or remove ".po" extension from po files, while I think it is
tolerable.
