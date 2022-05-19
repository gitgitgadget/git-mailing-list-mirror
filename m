Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56408C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 14:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiESOcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbiESOcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 10:32:45 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84037A46E
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:32:44 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j3so4756120qvn.0
        for <git@vger.kernel.org>; Thu, 19 May 2022 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i/DcxAvYfDMm71IItBXeddJ1kxV14IklCiTpMiWd5Zk=;
        b=YXz4F1LajOO2Q8QDTNhQTHKfdpxVVEIfUiBUbmQsIUFF4t0T6DLEmKuesBerZwa3Xr
         p8vxS51XQc9jvSOF7wgCYOpzHt0URg3dOnAUV8hsqi/BKUHGigzmABvV/K4uv9q2QqTe
         mxvQ8VrvXGAuH00zioq6v2o6/Ph4sfcaUdkwCVUa7Ze6aUJi48jxwnBVklQ3Hqq39g0j
         m1J+hGIowWPrWedlVMqlWQcea3ekk1P/npaROiBjBTNpJYjuXPBw2BPCGNMucZAkJHQT
         zltfjU/1DefzAm4+fq8dUh3VYsZFsBevgcK5deRamieP2jrrpujJ6LN5d198kkg5lKVD
         ZgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i/DcxAvYfDMm71IItBXeddJ1kxV14IklCiTpMiWd5Zk=;
        b=0OEmX8rDFrSJOKLi3WktbcoyP2mltqX9NFUe77i1w5hSh0Zx0W/XB6b91HwIjHU9yA
         pkmq9zaS5YLIV67KLUJTPv56PB90ClcTYH4HAINuo+/q6HEAbrZ02lOYFgmDsae17ueB
         ONGfBFKk40fnr0yeGcd0it428o3RRfC7rcePexDV9+SoNK6djLCPBadjnxXsQNBVvEH1
         UbsmNuay89/aENHmMcrFYLYUYAfpVWBcn/29yzZIK261acacfGLxePgxjWu4gHjmrYLp
         CLhViLbX2GvsupO/xtu8HehkuWIloOo8+CNSPJ6I3LvCPw00iNvua26DzSFUJfvWRAY+
         PGcQ==
X-Gm-Message-State: AOAM532Oyz+HcS1AdYvrNewxQwK8KQgm2BeLIMxVHQoZZAWmnnQo1mae
        ZOwOAWsMMnqXzU8r0V8sYZeUMxtfO/wbMsC59zo=
X-Google-Smtp-Source: ABdhPJzNswLS1zBX+O8uTUFl+EbV08vh+oVdTXTKuqgRfRJ7hnTvOzfkFs4/DBtH1Vn4Li5SRCJ9/Mhy6Ri1n7waQzU=
X-Received: by 2002:a05:6214:5189:b0:461:df84:7575 with SMTP id
 kl9-20020a056214518900b00461df847575mr4178946qvb.37.1652970763877; Thu, 19
 May 2022 07:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-1-worldhello.net@gmail.com> <220519.864k1l6c2j.gmgdl@evledraar.gmail.com>
In-Reply-To: <220519.864k1l6c2j.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 19 May 2022 22:32:31 +0800
Message-ID: <CANYiYbEj_G=Zm4ybLB=DhwXSMo7jFC+rf57m=vnFObbgOnqzrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Incremental po/git.pot update and new l10n workflow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
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
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 6:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Thanks a lot for picking this up. I left some detailed comments on
> individual commits.
>
> My own latest WIP version of an approximation of this topic was
> https://github.com/avar/git/tree/avar/Makefile-incremental-po-git-pot-rul=
e,
> which is what I used for some of the range-diffs.
>
> (I think the first E-Mail I sent had a range-diff against the latest
> version I found in your fork, but I found that was probably the v1
> version, but I think those comments applied to your v2 (which I read
> on-list))
>
> Aside from differences already noted I spotted that your "make pot" ends
> up with a po/git.pot that has a header, but I omitted it in
> mine. Perhaps that explains some of the headers in 8/9? I.e. we don't
> need the header on po/git.pot, perhaps that explains the difference
> noted in my comment in 8/9?
>
> Also: shouldn't "make clean" remove the generated po/git.pot and
> po/git-core.pot? I see you added it to "distclean", maybe that's better
> (or maybe that's from a version of mine...).
>
> Just from some last minute testing I think you want this squashed in
> (and move that "sed" to the "init" and/or "update" of the individual
> po/XX.po files):
>
>         diff --git a/Makefile b/Makefile
>         index 65a7558261a..57db37db556 100644
>         --- a/Makefile
>         +++ b/Makefile
>         @@ -2778,14 +2778,7 @@ $(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.=
po: %
>                 $(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
>                         -o$@ $(XGETTEXT_FLAGS_PERL) $<
>
>         -.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
>         -       $(call mkdir_p_parent_template)
>         -       $(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
>         -               -o - /dev/null | \
>         -       sed -e 's|charset=3DCHARSET|charset=3DUTF-8|g' >$@ && \
>         -       echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESS=
ION;\\n"' >>$@
>         -
>         -po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
>         +po/git.pot: $(LOCALIZED_ALL_GEN_PO)
>                 $(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
>
>          .PHONY: pot
>
> I.e. we can just msgcat po/git.pot without the header. For both
> "po-init" and "po-update" that seems to do the right thing for me...

Benefits of having a header for "po/git.pot" file:
1. Have a nice field "Project-Id-Version: Git" in the head of a new
    generated po file.
2. We can identify the base version of "po/git.pot" by inspecting
    the "POT-Creation-Date" field in the header of a po file.
