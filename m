Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B526620248
	for <e@80x24.org>; Sat, 16 Mar 2019 03:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCPD7j (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 23:59:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40406 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCPD7j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 23:59:39 -0400
Received: by mail-io1-f66.google.com with SMTP id p17so9982695iol.7
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=crKVcqbww6b4ssmLDsSwEkMkiI0S0m1Nc3pPGhMnpkU=;
        b=Le/9u0wcImHNF3QKrIYuFt1UD7EPfwCwpsXlnohZLAkLXXsj02CBFVb6E6CaBcjUnN
         PLvSPo5XPULcKpnNTwvxULr0BJQNvsHOpQtyZ3oXgW5QP9ebsfHBvFBux+VoIOXcLQcl
         J6EhpDHATBhWRyznlXAeOIqM2z2BmgHOhXmblrI0NEbihMBHqWS7OyDzVpvh5YSuc/yu
         Yfu+d0QLi4o2HDxCawToVvVx5yCU3485Bb2qhajWTIjD/XmjCjQ7VdyH0A3roV+cl1Oc
         oyc3O+j8lWnfuVEMMOGR1dTynKhBov+iyU2rDIp5ZySIsKO1j9/Ae5r5uaxqA7stIMPi
         ikKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=crKVcqbww6b4ssmLDsSwEkMkiI0S0m1Nc3pPGhMnpkU=;
        b=gyjwbT7dKlHJV3iTVNNwsVOArWk4opU+rdrD75P9HpYy+/Z5Vw+2ue4hphKPbKCGmm
         XSZ12msuKV3PWAq76fzXa7zf1c0Azup3DKh+UjpuVYlrMOUZ8FrR4Gyw6JUBn4FcqJRG
         Mjys08iv4qZk5SmMZUu+BB3CIWW2ShFm1vzDlrTXF6ACi0OpW6j2uszCiE5nxdpnbwGL
         RipCvn8uWK2IhYbDAL7Q7nqkVhelri1Mt7lY6+K2VG/RCcuWEBhEEN/wUX9ZM2GeqtLL
         ILhIYxDim8upqQy/CbKTzbydKvE8R+IjDj75xJYoFWUyMPqImq48Ol61m7p7eGx7CNE+
         dptw==
X-Gm-Message-State: APjAAAWU92gXP7pWh4Uedmznd8/wXZC7Wa1fDfQx6QOuuMFQ7ZdlO7l7
        Bwsa+WjfFy57XHsFNebu/cj/W2V5WHLcSJHvLrM=
X-Google-Smtp-Source: APXvYqyVGs8dTyx1gsd74l0bZ676cNeg6v5gSI/Gc6lUKZnzyWSewA/SSqTfjvn6xF45tT5SYzIj0B0uys9GZHcO0tc=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr3781596ior.236.1552708778330;
 Fri, 15 Mar 2019 20:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-18-pclouds@gmail.com> <20190313183604.GA27503@esm>
In-Reply-To: <20190313183604.GA27503@esm>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 16 Mar 2019 10:59:12 +0700
Message-ID: <CACsJy8Ddc+pYJRqX7ELEdryomNnG48i0Oncr1L0SjV0A7b6n8A@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] switch: no implicit dwim, use --guess to dwim
To:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 1:36 AM Eckhard Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
> And while at it - what should happen, if:
>
> - there is a tag named example
> - no local branch example
> - a branch at origin/example
>
> ... and we switch then? Right now it just gives "cannot find branch",
> should there be more information? Should it even create a branch
> example? With switch, switching a branch is unambiguous, even though
> there is a tag with that name. If I really want to --guess - should I be
> given more information?

There's checkout.defaultRemote that changes this behavior and it
affects git-switch as well.

I like the idea of giving more information than just the terse (and
technically correct) "cannot find branch". But I may have to delay
implementing this a bit. There's a been a lot of updates in git-switch
(which is great, don't get me wrong, I appreciate the feedback). I
need to get v4 out for review soon then maybe handle the rest in v5
(and finally take a real hard look at git-restore comments).
--=20
Duy
