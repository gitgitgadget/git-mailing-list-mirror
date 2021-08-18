Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07834C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AC560C3E
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 08:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhHRIei (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbhHRIef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 04:34:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C5C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:33:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cn28so1895848edb.6
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPRG9TpefNIbPtbAOh96UqTENoFq17FLI+9667GW5Vw=;
        b=BiGIorPxYKHDvR22EHDP+C8pmv9yDwMaituCrWrpmhvL7G0eqoOyIONIwsOfFecRZq
         AntZhSvHspvp9hQ99GsuL9u20Ey4it/8h95f1nfohGylTY0oFNOGDj9krU0MTlXpZFUe
         HvCIuHAp0TvKEpU3gE3URxLU7YrZUA8oJFvjxpbZXGiT8RfJJ0ZlCnTQVcAhep2RVFMJ
         9hkjIImNh50LkHq+60ZhRk4vU7gAUegdLVT7ODjQkM1DQoaKDHWXv9zv+I5yUy+qb4ob
         SvmzAZFk0SfCJ8zoffCVgOTXCavdSdne+Z1fJwaY79lMSrL3cAESlUmX/SYIpf1nF2JI
         3i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPRG9TpefNIbPtbAOh96UqTENoFq17FLI+9667GW5Vw=;
        b=eFRFB4MfidWVFNBAtdjqzzTVfiaf/rKJu68YE0oSIgguLs8uzGj38Qto6p+N6HCxVV
         cFH1PPRd0qEL22z75hohF7WuK+ZOcv8EaL9D3uz1eZiHw/OiZh8sfTY2cPfz3w+byQ3C
         6XTJwLPaZawqIODp6vH1t4DzzhC8nJS4gh/8Cze99JURVYlJzoKIGXL/yUmfjX/B/G4B
         GLUaLkAeBRAZpQBE8+/MmSP6dD9KbdLYX0glD0QrhTxmVSNiJr/wq88r2RIUMXVM1elh
         pwirqLulKReZ4m3hD+pK3x6dvb2OOJ6OU8OgohOL79zRtoh7cdZZNfG6lMgL6M55+mpz
         HGtg==
X-Gm-Message-State: AOAM531ssDnu1FbhkgbaZu8HaTOst4bDh4fDerx1JMIx7LroDqw6+3GD
        KqOQll52AW2yWhjTgYwRS5dXqHoCX5jpj//oYKg=
X-Google-Smtp-Source: ABdhPJzDWpdOVnv0rV9PBYzpfXwELWswSkaCNtD3CBrmouYdXx81dWps8bsxFS0VXq6aqgIgh/Se1IV8zKbPS/uwPxI=
X-Received: by 2002:aa7:ce07:: with SMTP id d7mr8960281edv.127.1629275636242;
 Wed, 18 Aug 2021 01:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-6-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2108171332370.55@tvgsbejvaqbjf.bet> <CAN7CjDDEv6vGPKZo3sxz8bgfN2Nzqh0HChR-tGrjDGbkhKZo=A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2108172332050.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108172332050.55@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Aug 2021 10:33:44 +0200
Message-ID: <CAP8UFD2PE0-8AH7-RH1Xv_cZ5s2bOfR3_KYEhBTdNqYc-Zs5-Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 11:36 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Miriam,
>
> On Tue, 17 Aug 2021, Miriam R. wrote:
>
> > El mar, 17 ago 2021 a las 13:42, Johannes Schindelin

> > > Also: I think at this stage, an equivalent to `cat
> > > "$GIT_DIR/BISECT_RUN"` is missing.
> >
> > In the previous patch series (v3), I implemented the equivalent to the
> > cat command but I understood reviewers wanted to print the output to the
> > user, so I reverted my changes for this version.
> > https://lore.kernel.org/git/20210411095538.34129-4-mirucam@gmail.com/
>
> I am a bit confused: doesn't `bisect_state()` write to the `BISECT_RUN`
> file? If so, I think we do need to show the contents by opening the file
> and piping it to `stdout`.
>
> FWIW I read
> https://lore.kernel.org/git/CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ciavCVQ@mail.gmail.com/
> to mean the same thing, although I have to admit that I am not 100%
> certain.

I agree that, after `bisect_state()` has written into the `BISECT_RUN`
file, we should indeed be opening it and piping it to `stdout`. That's
what I meant in the above message.
