Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F0C2BB41
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 19:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiHQTlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 15:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiHQTk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 15:40:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D9098D3A
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:40:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy5so26325951ejc.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Wr4Co+hdSk1HzVrPUVWgbbai/NxCTGufDRxwdtw8h/s=;
        b=dHf/87egS7VJErhXHT1WZFPbgGKdhgNPLLEgHvvNdU49uL6XueETGtOulGo9DfG841
         p7mZhRcIsSDokHL4Hg/Qpy31IDsoxKfiWX9MI4JqdK6mhReXXhWf2HsR365hh5W4+uVY
         b5Yq5rOZpPZR9mVLpYZU0wlZ8pWHmH+dsiRk8/kgQH3any4I/PUX7iHlrVXFXS3CqXsn
         Fce1fyOnEVFU0Q10IU8YIXZEb0Gc/ZoEelaGrr+ewm0xkNGi+b41+9Xn8kEAvpWKnYil
         0XU4GVSPLptfENA3F+d8NsAM58CHStdZ6H/AlAH/CyuWHP6kYIlF19h5ueRvopurF5bH
         HZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Wr4Co+hdSk1HzVrPUVWgbbai/NxCTGufDRxwdtw8h/s=;
        b=EtE5zD9bcXV0Lk6bv28UKFhiQeA3wO8Nyo5CxQnMz+TKuOFuu0buCqjZnj5eZYtApF
         CJZpV6OxFxdvjclLiG3K+VHZPGRhcSadB1tdxytp2y+KB+xE1y9BQU2dLgo4msuIyWho
         /fRHMptJKtzDuUrQPo0/HOzaKhbvAvYlQ5ITXFyzmWXzJWnJXxSxFHl1WU9UJwcA8T5D
         ml9tO732To/60F27kgkxwWYd+E/VC6k1TTGar+Ca2LUA84uCOO2k4icmwYc9bnkyONT8
         I00LiDW4XQAksWRa4wsiTgztQiA36FKfBM7sEeb07Q8jzvSUAOXEKueD399BjwWMTjXi
         N67Q==
X-Gm-Message-State: ACgBeo09n0eYUoPi4gxdzCyWn1l77+7sWv/COFLYkavVWLckfd616qUH
        sxZjJw+lfPPkLrGnq3USmtHhuoMOKgwQM/MvHeUlWHj6+wg=
X-Google-Smtp-Source: AA6agR4xvcwfRnQbk4GfArDNpBJ+JMhwW8o3J7rpDSj9ngEAVLEeUQtla+L67QG9NiD81rHxVn3bNxZxXQaxRBoPZEg=
X-Received: by 2002:a17:907:2c62:b0:730:d9b9:aabb with SMTP id
 ib2-20020a1709072c6200b00730d9b9aabbmr17223807ejc.84.1660765255307; Wed, 17
 Aug 2022 12:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220817094909.v2ev4rpsmxjnii4x@pengutronix.de>
In-Reply-To: <20220817094909.v2ev4rpsmxjnii4x@pengutronix.de>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 17 Aug 2022 14:40:44 -0500
Message-ID: <CAMP44s3iRbqgA9U4SeyRQUXdfqk=Stsw3kGqoGrFDRDWkV6GKA@mail.gmail.com>
Subject: Re: Bug in rebase --autosquash
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 4:54 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> after:

...

> running
>
>         git rebase -i --autosquash @~2
>
> my editor presents me with:
>
>         pick ef8f0bd27a56 fixup! file with content
>         pick b40a214bf5fb fixup! fixup! file with content
>
> However I would have expected
>
>         pick ef8f0bd27a56 fixup! file with content
>         fixup b40a214bf5fb fixup! fixup! file with content
>
> instead.
>
> Is this a feature I don't understand?

The problem is the code removes all "fixup! " prefixes and then tries
to find a commit with that title, which isn't in the list. If you
specify the commit hash, then it finds it and it works as you
intended.

I don't see why the code would do that though, since you are clearly
intending to fix "fixup! file with content", not "file with content".

This patch below (apologies for gmail auto wrapping in advance) should
make it work as you intend.

--- a/sequencer.c
+++ b/sequencer.c
@@ -6213,12 +6213,8 @@ int todo_list_rearrange_squash(struct todo_list
*todo_list)
                if (skip_fixupish(subject, &p)) {
                        struct commit *commit2;

-                       for (;;) {
-                               while (isspace(*p))
-                                       p++;
-                               if (!skip_fixupish(p, &p))
-                                       break;
-                       }
+                       while (isspace(*p))
+                               p++;

                        entry =3D hashmap_get_entry_from_hash(&subject2item=
,
                                                strhash(p), p,

--=20
Felipe Contreras
