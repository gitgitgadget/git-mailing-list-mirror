Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B59C47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C75613DB
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbhEUSKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhEUSKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 14:10:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555ACC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:09:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s19so20433750oic.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jH50ug+CwaFsWvUIOOFNX7MszizIWHrCTmgm5JPrfSE=;
        b=ZP9ZSq4q9eegapGCF9wR1sAM3onH48CsB81pngJYzizsYCfAOp8nhvXXikzitKeO67
         /uQ4ySXp6Feevnw4GNT4HWvjCoM9Sa6ChkytYKP6512Fu/Eg4RZuRCVB53k2Yd4YHCbR
         O64Fc1ARpapao8az/AWv8krsL0CaVFiRJm+UhWGEqlbOqbuMxCNCgfTalCwH5pqWAzpH
         YDNiabVh1/6/nCMHjI8nbOpeb5IIabwAUb99pgNeoPK1Q0Oe32acdNFvcorEJ5KTUzAj
         SUe2ZEtAWX2SipkWcmh0jihKlgeM3sSEzzqnL8oHXPc6XiePLWI5slA9L4fuJwtqVQ/O
         Xkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jH50ug+CwaFsWvUIOOFNX7MszizIWHrCTmgm5JPrfSE=;
        b=NeQQqtg3WsL6MNhiaJrrUjoSIAbklRRJLlOP6mHopB4oEVPB+T7rwY1RN5QxhR1R1Q
         6DCPthg5bMtM6CwS3Wio4HvxDM00XGo1z4Dh9QLMiMoGj+v6Wxj1oFoqpTZ0R0rTOcwE
         XPQthorXQfYBebtOUCjwo12nN5SD3HxaqIMcCaS8jqKZpYRZFDY9SxszLLyhDanvTSeY
         U6PG+Lr8pAT+Fw2dD53xx3yQZdM+xJViTkPE7L+sZtFj5NzaqsRDCCNIdCwKO2CDFMLC
         xfQ7gl/iGGWTssZZviyBwIYZCQg0tuSIv3Ab2IcC1yX0V4yjw4dVCRn0EXMrvNJZHSmI
         Rr7w==
X-Gm-Message-State: AOAM530gK7qroEwi0F7GdWFKn0FMQh9adwQUdHQTFAZOGbXqddad6SJr
        Hu8+DrSz0Rg9twO+7tiHH/0=
X-Google-Smtp-Source: ABdhPJzgG22QrOOekc8N+g5Dh+2J5S/fVwS0R0g0qowmivtWcqbS6/jtNZfD5WxuqA3tBfz0RKuXUA==
X-Received: by 2002:aca:4ed4:: with SMTP id c203mr3099473oib.51.1621620558781;
        Fri, 21 May 2021 11:09:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w4sm1499741otl.21.2021.05.21.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:09:17 -0700 (PDT)
Date:   Fri, 21 May 2021 13:09:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Message-ID: <60a7f7427eab6_55039208ba@natae.notmuch>
In-Reply-To: <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-19 at 08:41:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
> > It also doesn't seem to me to satisfy their FAQ point #1, i.e. users =
who
> > actually want no color at all can just set TERM=3Ddumb, and we suppor=
t
> > that. The proposed patch is the same as having TERM=3Ddumb set.
> > =

> > This NO_COLOR=3D1 actually means something like "I do support colors,=
 so
> > show them if it's important, but don't color things willy-nilly".
> =

> I don't agree.  The way I read it is that it means that if your program=

> receives colored input, it is not obligated to strip it out, but it is
> obligated not to add any.

The very example they give says otherwise:

  It is reasonable to configure certain software such as a text editor
  to use color

They are saying a text editor adding color is *fine*.

> NO_COLOR=3D1 says, "I don't want color, but I have a fully functional
> terminal I would like to use, thank you."

That's not what it says.

> In other words, I think in this case, the user has opted to configure
> their editor as they like it and invoke it without NO_COLOR, but has
> instructed other programs to not add color with NO_COLOR.

That is a reasonable interpretation... until you read the next
answer:

  A user should be able to export $NO_COLOR in their shell configuration
  file as a default, but configure a specific program in its
  configuration file to specifically enable color.

The whole point is not to configure each program to disable color, but
have a global NO_COLOR.

So I don't think your interpretation is correct.

-- =

Felipe Contreras=
