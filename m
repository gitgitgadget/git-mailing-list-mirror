Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F05C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E4A23D98
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbgLJKtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbgLJKtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 05:49:14 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300DC06138C
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:48:13 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id k4so4991048edl.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xdnXL2exCA47SkKqjfBllk6VnpnJ5Aq6kxXSsBKlpdA=;
        b=bFXeBHVIxA05JuCwkA/9K7BHltVoysodG63+BmQLuFPnsKY1vBqpaXGolmRwdKsyF3
         3lOsdIUYlfPujwcJGYxrILBMglOMm7cfduXbPmmansevAeG0UK/YepP6MSYidCq4+DiW
         QT4NaygJ+W6bgezrOReiSZ9+JaJBinpPsV/msDWnBg+0SFyOYIERL463K+hYmaP32brJ
         MWgQTw7gujE4WKNTG7QjHsOSnwqflAhNvREbj4PtU1SjRZZazlLjSAweTEIPOCor4Ki7
         91LAQpxOL5/bigos7dUHpX7TYFGgQTEjEYitlgrmCcUoA5exkHLAoTYoAlAuG26kmQ9W
         ggVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xdnXL2exCA47SkKqjfBllk6VnpnJ5Aq6kxXSsBKlpdA=;
        b=VGqtUfirPoMpitPXL+M6cZcm3Hhk9W5PYn/aytHyRP1rqR6doc19V+a75IXQKa1XLN
         ziysltriJtrOs4pBIb9HJEDxIJ5t9xKvuxOfRNy7am1PYwnewmZECUXxgEWuX+bxg0zC
         SwHwtyXWwgmQp+XbCi9ps84t+B4FAEcv5M0+IirxsJ58DA/Idjk4VGX14sFO0Jlwg2on
         x7A9bVoCFVb77luQf/igelHxM0MPuHhjngav3wTlJW+YYZLspSUzde1uOafAcjs6L2td
         3GDL6rwQRrgzYbOrCX/XrGE9zWyfg0I6NAOihfrFDhae6eDkLJ8yfyRoQZT+wTmKOnYi
         sufA==
X-Gm-Message-State: AOAM5336aP5EZ9pLi6QYpJSLfS28Gshea8nxvpgF/0aICtV+7fgSy2EV
        UY3YHrGIQsHWH4uFLn/0YZNcAof3dMY0ANAvT25z9yz7Dqmqwg==
X-Google-Smtp-Source: ABdhPJxoKd7TalZAlSVfGZDjF+KMHmnmkeazjsifvGrEx4aiTuYqecCO9EiQSeQ/Fm5zfh62GoZsRUqjLHT8L8cdyjQ=
X-Received: by 2002:a50:b761:: with SMTP id g88mr6214558ede.387.1607597292201;
 Thu, 10 Dec 2020 02:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20201206002449.31452-1-avarab@gmail.com> <20201209155208.17782-1-avarab@gmail.com>
In-Reply-To: <20201209155208.17782-1-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 Dec 2020 11:48:01 +0100
Message-ID: <CAP8UFD0A-wLb3eAHWtnkd-kUbiEt=BReP7pKjgHOktcNrtRnTQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] pretty format %(trailers): improve machine readability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 4:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> A minor iteration on v2 with a commit message wording change &
> s/=3DBOOL/=3D<BOOL>/g in the docs, as suggested by Christian
> Couder. Range-diff below:

This one looks good to me!

Reviewed-by: Christian Couder <chriscool@tuxfamily.org>
