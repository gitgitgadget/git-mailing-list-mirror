Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3675C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 00:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiDWAk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiDWAkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 20:40:24 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6EF180EF9
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 17:37:30 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id w21so3591364uan.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 17:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AOxIlrdCz66EKUedXMixxY8ugeExj6h7mJjp2p7fVTU=;
        b=gkE2QarEsy1j+0kmfWKTzCCjp9Lmzf8kF37dXRe++MZ3olbaPGJhJcohLy5+FS6jCK
         nVv1q4YC6evS+6D+iDrE70l1wxuTagXLczDG3S+EdHPTVwJ1z5CuUPZbO4KUgiBZw6GB
         8UIFTVLxUvWjQm/17x2qKLBg2Ojp85ewBMAC9Or2qbm+pgiAYEblZmGn0raK9ohGIXAV
         tWAMUZ1WFIhFhgkdAURlDS3ZXSdDQpVKsmZGOGE0BoM1YiKS3otfMQ2a0/YAfzT9Dqjz
         HUGSAOErYpMFOMY798bQ/7pyb+87f9F6AEZQOVU0iHU6spzmg2e0VzTlUG62EnjMsamM
         RCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AOxIlrdCz66EKUedXMixxY8ugeExj6h7mJjp2p7fVTU=;
        b=ssugTXwXDkqFHrDpOjv5mZ6MeHwac8L4hVZdqIrFRIuBpsj1+7y0RPE03tjTFWxOZB
         tOHM+0smW8sIjCLtbt6GNmHOqOGeZsQZpG4cIoHd/mF942FQ0PjuTN9AfNTzeH+sTLqn
         bbHH3UGTW2rwLvcjJ9QUGuvgZAsEr7d+GvqqDS8HNRaK2XoKUmMz6N/uGAa9fVp2Fwj/
         QHKsuXObmMMGvPJUkcL9A8UU8cc6O+vgG9MYeOuwtJve6aoO2c2JdcQ9tS2HybjyvTy6
         8E9j82a2+jZ7DRu6/UCGn8TgZs5h9muDS0sWIYBbFzdCg2d3nrHCbxRnGnUQdP0ESMUz
         tIjQ==
X-Gm-Message-State: AOAM532kI3IVz8cJZZIozSFLF99bQXYzQFrtTuTFPg644CzYrhQVxZI1
        hVpHaSttbeb3ZxYRS65qZTuUVF3ZquVT3++DhuZeuGDO
X-Google-Smtp-Source: ABdhPJyjMssd+bXLa3KWG16V+rzpB3OUWyZ9UVKJSVSEch/B6deG100lIxCR4NqJ5q/0mn70L7HG4io1bCeIKNozVeM=
X-Received: by 2002:ab0:53c9:0:b0:360:2831:be85 with SMTP id
 l9-20020ab053c9000000b003602831be85mr2534186uaa.28.1650674248722; Fri, 22 Apr
 2022 17:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220421225515.6316-1-carenas@gmail.com> <20220422013911.7646-1-carenas@gmail.com>
 <20220422013911.7646-2-carenas@gmail.com> <xmqqo80td5wj.fsf@gitster.g>
 <xmqq5yn069lq.fsf@gitster.g> <CAPUEspjGX4L-4T-93a2729SkB92TP500JYmEbKyrRFbv7moTXw@mail.gmail.com>
 <xmqqo80s4qn0.fsf@gitster.g>
In-Reply-To: <xmqqo80s4qn0.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 22 Apr 2022 17:37:17 -0700
Message-ID: <CAPUEspjJVQZb1q8Xk7E1nKT3PGmMcc4SJ6M=ejHCjOUVTVV51Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ci: make failure to find perforce more user friendly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 4:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > I have to also admit, with all the on the fly changes to these same
> > files, it might be wiser to wait until later anyway.
>
> Actually, I was thinking about taking these two (possibly with
> =C3=86var's "download with https://, we are in 21st century" change to
> make them 3-patch series) and fast-tracking.

Sounds like a good plan to me, and unlikely to introduce much pain to
all other on the fly changes, but I think it is worth mentioning that
some kind soul did fix the mismatch in homebrew already, so there is
not really an urgent need for fast-tracking right now either.

Carlo
