Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A7C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 01:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiEZBKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 21:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiEZBKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 21:10:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2B91575
        for <git@vger.kernel.org>; Wed, 25 May 2022 18:10:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i15so684963qvk.6
        for <git@vger.kernel.org>; Wed, 25 May 2022 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pwvcvkNL2p0BXWIvGLFh3hJIAwOGuHD21FZ1lmUNVo=;
        b=HZYZpE9JXFOImH4cj/ptg1dyzQZDhtTn3Lo00HAU1h4zOnpJeYFNoXqy3o0/6MzTLU
         JeTf6kws2uUV4SoOO1FOnU/7zT+v17zzZwgYBRWtT2yEbkBOrN5Cg5CceQMXGZHJD7dK
         e0MD+MEYr4fWymgsBzx7VcQYku4VW8wEGNbh+H916gSbKD2b6Zld8FhBRvXFerK9JFDW
         Bm3LCPsUko1B2+DdUwIPaqGc+IcBjaSBUdjD/lpyzlQA2px1Amm9lUmlpIar87Le7fee
         ftuihybgVPkIrFDznCTPmAlkE6fnVhmeBwFoBpm17tddOzMjd+UxmJ45TXglDA7ux3Tw
         eVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pwvcvkNL2p0BXWIvGLFh3hJIAwOGuHD21FZ1lmUNVo=;
        b=tkJaIqchiYPtfr+dVcZNHCCPh1k+p+9FP8//Dx0VQDT9kVnm0CwO1PT8CNZnz6O7m+
         srRTy1wsLVymNglPEpxJu0URhyluFaRjHujheruD3S4THNlBfbJZnOZOYgfEqvuDJ14+
         uts4ADkmbINgN2Ml6Z2944ZExXxNhOdXI+MWY/WwYDSz7S0paXb802VpMT+J5nu+/vDn
         CesMv5w1Fh5yOn26WThUA/PrmMhLnoO7B304LUjTxihNMitK21XJKEM3HAW/uDlKSMgZ
         Vk78+RCooxQ07TTx8RtrhlMIv3EF+Wki2ieklReakcY3RFIREXAaJi3KOZBdivj2IrjK
         YdNA==
X-Gm-Message-State: AOAM533rf+fQ1xTi4s14NKhrBTIMWw+Ry5FAhPUXRJmQ9XbQUVCdEdUB
        9SkMiyzDWYhEAdqsqXD6lZ7nkG/EjpEUuZDXQtEtdkHxYpU=
X-Google-Smtp-Source: ABdhPJy6vkCcx23W14NRHaa2vVhjWfWKfDeeMVwiB/qIzqHWvpeXWBJNGOSQv393ZLx84VyVYu38/4VJxh/lZAja4Is=
X-Received: by 2002:ad4:4672:0:b0:462:6b2d:1edb with SMTP id
 z18-20020ad44672000000b004626b2d1edbmr1008534qvv.18.1653527435509; Wed, 25
 May 2022 18:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220523012531.4505-1-worldhello.net@gmail.com>
 <20220523152128.26380-4-worldhello.net@gmail.com> <xmqqzgj545md.fsf@gitster.g>
 <xmqqtu9d45f7.fsf@gitster.g>
In-Reply-To: <xmqqtu9d45f7.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 26 May 2022 09:10:23 +0800
Message-ID: <CANYiYbFL4Yo5ZfcgGDb60yeGc3rUySYz6GwgMkqUHf6cQx9Apg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] Makefile: have "make pot" not "reset --hard"
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
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 6:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jiang Xin <worldhello.net@gmail.com> writes:
> >
> >>  ## Gettext tools cannot work with our own custom PRItime type, so
> >>  ## we replace PRItime with PRIuMAX.  We need to update this to
> >>  ## PRIdMAX if we switch to a signed type later.
> >> +$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
> >> +    $(call mkdir_p_parent_template)
> >> +    $(QUIET_XGETTEXT) \
> >> +        if grep -q PRItime $<; then \
> >> +            (\
> >> +                    sed -e 's|PRItime|PRIuMAX|g' <$< \
> >> +                            >.build/pot/po/$< && \
> >> +                    cd .build/pot/po && \
> >> +                    $(XGETTEXT) --omit-header \
> >> +                            -o $(@:.build/pot/po/%=%) \
> >> +                            $(XGETTEXT_FLAGS_C) $< && \
> >> +                    rm $<; \
> >> +            ); \
> >> +        else \
> >> +            $(XGETTEXT) --omit-header \
> >> +                    -o $@ $(XGETTEXT_FLAGS_C) $<; \
> >> +        fi
> >
> > My build (a random hack on top of 'seen') is getting this message
> >
> > $ make
> > Makefile:2755: target '.build/pot/po/archive.c.po' given more than once in the same rule
> > Makefile:2755: target '.build/pot/po/archive.c.po' given more than once in the same rule
> >     SUBDIR git-gui
> >
> > I haven't changed archive.c in particular relative to 'seen', and
> > .build/pot/po directory seems to be empty (understandably---I have
> > not run the po/ stuff myself lately).
>
> Well, I lied.  I am doing the random hack while in a conflicted
> state coming from an interrupted merge that had conflicts in the
> archive.c.
>
> Perhaps we need some logic to dedup "ls-files" output?

Yes, we can pass the option "--deduplicate" to git-ls-files to
suppress duplicate entries for unresolved conflicts. Will send an
additional patch for this.
