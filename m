Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3EC433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 09:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiDWJP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiDWJP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 05:15:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B73E083
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 02:13:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p21so10893069ioj.4
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aN6tLyIFgjgyvjfIt/V6Q5tyTRPFWB9dFkZzwgLDA68=;
        b=AHnJihd7v2CHbsYntWWBd2sxYNcuG4Oh2uuIKv3lvLpmXhXvvDJPHPlDeBRymYFZu9
         dETdwLZ8nt64FGKNmhhMKf6CZYHw59KczreMUnvXz4QBZQ8iWJz3JmtDNd1vGYz8kZ2r
         LTUMz8G02SLOPu5ta6bzlfehUlgEtQwbZK6+Baj4uA7ltki1DaFGsIYKdmPMi/pzbsWm
         X9QY3asAtUySHTojuhhtMy7bSms5qwGmwbz2VaUhPrLtullQJVVxLDwbTmlrmAfUjMVG
         Q0y+dHK982ItIKJo4VmTES8D/qXEq9y+TrIMAv3DmV9UXdTvrzixAb9GNYg0GhT1Mh+o
         BIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aN6tLyIFgjgyvjfIt/V6Q5tyTRPFWB9dFkZzwgLDA68=;
        b=fHOclz5QM0sUJgq0DqvsfidZ92X4eZSVHCydWelXnJumqlE5Nl/tMMJvtnMWiDWTZP
         feK7b4bSU+sx+OcCCufHQ605IzkGkY5EqwsG30sEPNnRzRUDjdoFOv8ORaDO7nMvhbPi
         Jmi/f8I1RYPyisbXxq7Piv8WeJHuXAm8mOTGxcdUquXdRVAL81fJG1EMxh4wkZH6Gdjy
         Pr34e15/FPyEo6+mGnT76PBJe/i9XpVnSfyloR4LKH8YZULDGvUlcahqjTs1cCJTwEgA
         CS6Xt8pypdATRpL5sjGgfKp/GwwGcR0t3k1eyWU8zfbEoP+Jz+SMLb7VsLdK35XpAqpK
         iSuQ==
X-Gm-Message-State: AOAM5316Zk8d6MxuvEyIh0yjQ22MjDiF4TuIBu3wgxyzQ4GxhxdaDbx3
        I7qMJ3DiOI0naJ1ma9U6J8dN2KoE1fGpO9psZjzH2t3y7ra1xQ==
X-Google-Smtp-Source: ABdhPJxJ2A/34Ko1Y+xDfPB+hMBU3LdCBGFP5FyhYrdgISRNGzxZ+3f0CY3ElQuiF3jmBPyDBvseJE+GYoREciI+31M=
X-Received: by 2002:a05:6602:1341:b0:637:d4dc:6f85 with SMTP id
 i1-20020a056602134100b00637d4dc6f85mr3422527iov.155.1650705181385; Sat, 23
 Apr 2022 02:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220422183744.347327-1-eantoranz@gmail.com> <220423.86bkwsra4a.gmgdl@evledraar.gmail.com>
In-Reply-To: <220423.86bkwsra4a.gmgdl@evledraar.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 23 Apr 2022 11:12:49 +0200
Message-ID: <CAOc6etYcByq=n=k+3r=mBR8q=8i-i_G+3LYESN8u0=Krqxt8Fg@mail.gmail.com>
Subject: Re: [PATCH v1] rebase - recycle
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 1:06 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
Thanks for all the feedback. I'll go through it.
