Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3CC433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiGQRNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGQRNa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 13:13:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0BC13FA0
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 10:13:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d12so15838411lfq.12
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9mNskoA/iVPwTcluFIJONlMmoZabzT4Q0hbY6oQh/kA=;
        b=C9wjPtb5IZ1LcNkjAdIuCnFDXjxlo5qVGh+jgnXbxhtBMxYXJ5jeaYSpQBo0pL1q+Y
         ot0BiEw0sTNdSGHhqabmUXM84orAahy1mpatrFyAsXrUkx8Mj8+HuJnHUWIMJlW3J/7F
         ZPX6B3u0/LSl6D6tn6T8j0mH5w9LEJxYDORXrpJiHAyxTWvh1VoWyatWy2SrpS6VuiWP
         zMoX8Y9y4ORepwROxZN6eFuukgD4mipgBJBtX1u2OEVlKfLLXlaTdavCxW66iMOvuFm7
         Cbdx/W7VduOG5b0qPS74xAOBiOoA8SNSOL120T2BvPhhs9Di9AnIHMYb6LWIGYeEVTiG
         kUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9mNskoA/iVPwTcluFIJONlMmoZabzT4Q0hbY6oQh/kA=;
        b=Lm7AQ/2RFoVRIbYjfWfeealO+F9ozneRTMD9wbMcMfKvHfgo8jY6ZB3IX4pe12GeM3
         2/i2pTIHyG3MFQ8a3ErD6VbkSimMr+kYvxmoHlN835GJnEFHjXwAw3lQs1djZarbHaIq
         Xvu32qyEtInSf8PiX8SQxKysQJV8ldKqsGcgntCQdn1yILQNgcfJefmqqmx+n+6VfX0Y
         nRwRcWixNNdSNsP6VPybYUjdXFOKbNAs4hd0ldIW2JXZZ8ql7A91b0fhlhzYp0Q/0fv4
         nPhPFom2bsmuoxp5N4ImYgnEi0A1Gmy0IQRmQSwEspNXM5tuqcS+l04gDz+EMaUw1SB7
         Rwnw==
X-Gm-Message-State: AJIora/z5CogBzyl6BB4eeZ0Y3dAfLAwP2Z89SqsgehSq5nI4Di5GNlK
        XGcCP0y4dMsCah3LaaU7Equ3r9dypPe4WdDJB9INlJSZK3M=
X-Google-Smtp-Source: AGRyM1v5xEVxzjl8TlSl9ZHLzNKSrlkHAIWrzmt6at1XoJiRQJmJwy2/wY6QUY8lVBQM2Ii6V3o9jKzk7Xns8uJLYys=
X-Received: by 2002:ac2:4c52:0:b0:48a:1830:f589 with SMTP id
 o18-20020ac24c52000000b0048a1830f589mr8940159lfk.245.1658078005592; Sun, 17
 Jul 2022 10:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <220714.86ilnz1j1i.gmgdl@evledraar.gmail.com> <CAHd-oW4zHA1YLX-5B1vYTA1f8PocziUCi0WxvSEkFUuf2GqKxg@mail.gmail.com>
 <220716.867d4dze37.gmgdl@evledraar.gmail.com>
In-Reply-To: <220716.867d4dze37.gmgdl@evledraar.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sun, 17 Jul 2022 14:13:14 -0300
Message-ID: <CAHd-oW6ompHPJ_8X6XqwBJs8mda52a=NJge7=AwVwuEg-9VHZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] doc: unify config info on some cmds
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2022 at 4:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I can submit what I've got as a v2 if you'd like, but I'd be just as
> happy with you picking this up & running with it, whether that's seeing
> what you'd like to integrate into your series here, or perhaps rebasing
> your patches on the 1st patch I have (the one that introduces those
> "Everything below this..." template)
>
> But OTOH if you're going to drop the "ifndef" idea I think what you'd
> come up with will be identical to the patch bodies I've got for the bits
> you modified, so perhaps it's easier if I just submit mine...

Yup, that's what I thought too. Feel free to do so, if you like :)
