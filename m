Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0BC433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 00:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354685AbiDPAFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiDPAFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 20:05:39 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3F41F8E
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 17:03:09 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id w67so4075646vkw.6
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u0WbN9sQn7VzLC9WFZif26LZKpKS2qprQDojC0zlgYk=;
        b=NL7kVaX+r+t4U5QtSWheCo2CWTJO+GbwantPViS5mz4Np1YmYBuyDrroenlVwZDiVH
         o6ShPadarvADXUfOQVldnT4gO8FXLdptCv76qZ1uEy0ro3wOk/O4a0hsrqg2Ucpm2OCN
         1sHeQRqFcS9mnnG0BaI6bt6wVoL0j3AgQm+AVBDmC/qw7pWp/FkD9RyrkqB8oLP282Ij
         GkL7VkgllTQHZL/SgmjyFgVcg49A+TW2lL83hlz69Yt4e3tqBa9IHMhF/axFW74kfrYU
         JgeHL6ISFATI5tARo4vNnMal75JMa3n6nagXF4CIKhuSNq0/UI+qzW+xzRNQHEJjN97P
         /zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0WbN9sQn7VzLC9WFZif26LZKpKS2qprQDojC0zlgYk=;
        b=ifnJ1Z2NIllfeFMdVBOCoEijSgeR4ZJzNUVDVkIRaFRPBgE8oSzcXocUUzhm2gf2Uo
         r9a5/0HRiHU0h/Y/bpEhb6Q7MOTIhJsdpXCUcpknlEDsl891ldQaJb0APN8Nd7iPApOx
         FuXDc0AYCldsu2zInkbxhvsWffsIjoxqqBd6QIm/Wnq5WYu1sECWx/YjK7y/aXkZbTdY
         +uclg1bHYtCSgrW1Yavezrh8PYb3FiMEy7cwlY+0MU8Ns5ahStbYzWhQrqYgw7VC9SGN
         FPxZwb/OoBd96gj9zNw6xMs3ZrwJ/KfWZgR4P1XR/a+pgW0QqBuojqL7stb3wu4fhCYQ
         jvVA==
X-Gm-Message-State: AOAM532bBpu/5YuDQr3FzbrW2fQ4tQjBc/+4w5qVePgW1waIaR1ZJONy
        UhE8YGmSBozUcC2uO62JB2Fq5rmZ2kEeBRPNSSw=
X-Google-Smtp-Source: ABdhPJzqmRljWCj/IAPozD18aCGa5S5GDUHXwY4T0FwiKhwxOSUZyap2M97shHCYwfOWZp6WE3c+zI5ShIMrjVRaZTA=
X-Received: by 2002:a1f:43d2:0:b0:345:12db:2f26 with SMTP id
 q201-20020a1f43d2000000b0034512db2f26mr345164vka.23.1650067388184; Fri, 15
 Apr 2022 17:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220415123922.30926-1-carenas@gmail.com> <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-3-carenas@gmail.com> <xmqqh76taplg.fsf@gitster.g>
In-Reply-To: <xmqqh76taplg.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 15 Apr 2022 17:02:57 -0700
Message-ID: <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> diff --git c/http.c w/http.c
> index 229da4d148..85437b1980 100644
> --- c/http.c
> +++ w/http.c
> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *sl=
ot)
>                         select(max_fd+1, &readfds, &writefds, &excfds, &s=
elect_timeout);
>                 }
>         }
> +
> +       if (slot->finished =3D=3D &finished)
> +               slot->finished =3D NULL;
>  }
>
>  static void release_active_slot(struct active_request_slot *slot)

this would be IMHO a better fix than the one currently queued in
ab/http-gcc-12-workaround and indeed squashes the warning with the gcc
12 version that is likely to be released with Fedora 36, but notice
that it was proposed before[1] and apparently didn't work with the
version of the compiler that =C3=86var was using at that time, as
documented in the commit message.

Either way, my hope is (assuming this series will go earlier than the
other one), that a revert to this commit is included at the end of
ab/http-gcc-12-workaround, instead of adding any code changes to this
series.

Carlo

[1] https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/
