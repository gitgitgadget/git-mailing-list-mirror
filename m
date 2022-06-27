Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF4C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 11:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiF0LGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiF0LGi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 07:06:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5986467
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 04:06:37 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u20so9151142iob.8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZXLHh1uXQv/cf0PPRm4LCKMbRccLG3GsBB3lCHIT6hs=;
        b=ZED8qJIRW804LtLnwoWfPQB5K+VMYRiQ/bBG6jUOrpVyy4hoiBWLpKg2X4samq5xmG
         GilIPHQjCIshaQkVkCwEIXdC728QJDA1IGTTtM9Z/sw1TDCL18iERpdDblbXifUDv6Rb
         1j47gJOs8fNPLGZ9d/xsRHaFRQEL8+SF4f8XXx4r2RRHfxzvA6K78JErT/E7H/VL2hTX
         61zi9HhBUOiB+fXVsGrLNwqwv0UayKXcUA1DAB+Iwbszs+jqUc2vK7fF4BT9xJwBL4WU
         P8GC4QBm2YuU6SquDYvjjy78nJE9vq14JDRw4W2XOOaLI7joc0RpchA0hVij+LmjGQh2
         71Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZXLHh1uXQv/cf0PPRm4LCKMbRccLG3GsBB3lCHIT6hs=;
        b=cLOZ72zjz6il3msGPe27OjiYU2R5t7sk8stissQZ7P6Qe+GCSwvZetwpE4W8QwiM3b
         x1KtZ0gRd+8aBNUdAQD8adX8nO6HpJpdiW49P75MwwU8OZpn5q1kRbai6J/yyCgHZRhr
         F7DjtWPbVjGzdYODemVuu6qQ3IBCHFEla1XSEW+YZ55BeY32uCib0XKs5QdmBQliT69E
         p4wdcduFuEDBnQuvRMofBhc8j9SeDOou97qgb7tsEGbMvB1hHfgrpwpCc2/mxBCVC+m9
         sBKX+55Ty5rWLEPzhcpBYVmI+lBCZKjVthxdNc1cPmqquY7IeH6eqIhUigiSUcXvUq36
         Ff0w==
X-Gm-Message-State: AJIora+DnE8G6Wc7Kzn4XTiev+9ZhA9eluf4Fc0aOXQXuh57SnyI/GYs
        p0DZQr5mOpAGW+j8H5BRKzJJ5/LlISHS11CHioAzp1VUnfI=
X-Google-Smtp-Source: AGRyM1uOARZfZYjPJt1B4RWoHmdQNnaPxDB7HMlVSXtTL3qSEfuvDKPSCyRMX048epCxU6BwI/O9BODL5/Bf1UGEduI=
X-Received: by 2002:a05:6638:ec9:b0:339:c3a2:b14c with SMTP id
 q9-20020a0566380ec900b00339c3a2b14cmr7543198jas.128.1656327996799; Mon, 27
 Jun 2022 04:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com> <220624.86letmi383.gmgdl@evledraar.gmail.com>
 <xmqqsfnuvzxc.fsf@gitster.g> <CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55OcXTSRA@mail.gmail.com>
 <xmqq7d52sehc.fsf@gitster.g>
In-Reply-To: <xmqq7d52sehc.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 27 Jun 2022 19:06:25 +0800
Message-ID: <CAOLTT8RpBXR4PaHkaBADG9rWXyV0tRwsFD0VUqBEvPJVofMCNQ@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 16:22=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> >> +    else if (skip_prefix(start, "(path)", &p))
> >> >> +            write_name_to_buf(sb, data->pathname);
> >>
> >> These are just "values".
> >> ...
> >> >> +    else if (skip_prefix(start, "(size)", &p))
> >> >> +            strbuf_addf(sb, "size: %u", sd->sd_size);
> >> >> +    else if (skip_prefix(start, "(flags)", &p))
> >> >> +            strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
> >>
> >> These are not.
> >>
> > ... If someone else
> > need them for some reason, we can add them back.
>
> If someone else needs to see "size:" printed in front of the value
> of sd_size member, we DO NOT HAVE TO DO ANYTHING!  That someone else
> can write "--format=3Dsize: %(size)" to do so themselves.
>
>

Oh, sorry, I mean if someone need some atoms from %(size) to %(flags), we c=
an
add them back.
