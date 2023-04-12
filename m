Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C5C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDLGsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDLGsS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:48:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CF5B92
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:48:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v7so9180959ybi.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681282096; x=1683874096;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8/NexVqII/xSg9aBEbR6qB6pxKdLlluodrkq8/PE4w=;
        b=IerjK/qkZZ2Ib54LmXnt/Sg5HExMfWDiN4ndN717GpkR3M99eD5cYgP8fGRSrfv9O2
         LsL4pXqVn5WrjoBfgx7Qz42ExvpPNA4zNwsqrmpjNQ5r4OV5jQt4PMqFm2msDqEHcgCo
         5mBZS1IC7MRN7a71G5CbUj9AbcPwGYvqGlPelCUi8mcLbOj0F/roHoDNYIaUh4st/5eO
         PFsiDltQGGONSFHY4BLrlgkwbfIBkDHC22R7On9UJFvB/YVkbRW9p3f6OgQUqhckqFg/
         2TYp6sprqwMKfeY/a7/NTjWBvpondXQrIWpV2dMinykvzV865dVGOjUwdjM74gpdaqir
         qhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681282096; x=1683874096;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8/NexVqII/xSg9aBEbR6qB6pxKdLlluodrkq8/PE4w=;
        b=CuZi52SvPvovfK+fsqEa4ekkZgMcdod8f4oHo+iUohoqhLOdKNgz627e9u6L2S4/sO
         eA+1ryNMH6MYMPZnjcVtDUtaVb3iPBNAC3qoZmVvW3J/Hj1VN7zVH8aIoTzF8r5VrOjj
         1RQYPBgfWwZg7WnjGjlCSf5ASbqNdISZ1WwOB2Lo1lqZlgZtOM7AlPv57XtL+A2ukIgQ
         WFqloutlL1fIivsvhwKKC6RIWjitJ9vjgFrdSZRvSwX+1B5cUSBZko8CmxSWtY1KI7Gk
         3y+AkJ4NgALW/kLxbl8yah90CVpHrD2Z5EyPOsvWgfICVymvvsFe9aksxGoM+o3m16Pm
         DCXg==
X-Gm-Message-State: AAQBX9flZ7eX/1bWx1tAv/Md/T/Pg4ehv7dBXe2mag8dkgH+lyZdYFV6
        AZfUOwjInj8QYJcfZmIE682lNkAt4vQEiHJMpJSNC/ecrDIGh3af
X-Google-Smtp-Source: AKy350a852YVsCAvtYkgdCDB+iOVfT/gz9IcmTxgO2ywAyNPP9ol7bWKzApubXsvnJhlPTSYlWKCOwqKCkT4rwdw0MQ=
X-Received: by 2002:a25:cb4f:0:b0:b6a:5594:5936 with SMTP id
 b76-20020a25cb4f000000b00b6a55945936mr1020117ybg.5.1681282096441; Tue, 11 Apr
 2023 23:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8Tg_Gkj6jid-sH_A=-xajN=rd=Vgh-nqHY5NcJ4-VExbg@mail.gmail.com>
In-Reply-To: <CAOLTT8Tg_Gkj6jid-sH_A=-xajN=rd=Vgh-nqHY5NcJ4-VExbg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 12 Apr 2023 14:48:25 +0800
Message-ID: <CAOLTT8RAhCY_Xo_jDopggCVEF8t5Kghji4h+Td6Gja_3kMSpJQ@mail.gmail.com>
Subject: Re: [QUESTION] How does Git ref backend work
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 14:25=E5=86=99=E9=81=93=EF=BC=9A
>
> 1. I noticed that normally refs transactions use the refs files-backend,
> looking at the reference transaction of refs files-backend alone:
> First, it opens a transaction in memory, then multiple update items
> are added in memory, and finally, when the reference transaction
> is committed, it creates a ref.lock for each update item, renames it
> to the real address of the ref.
>
> but there seems to be some packed-backend logic coupled inside of
> files-backend. This makes me wonder why these ref backends are not
> independent?
>
> 2. Is the reftable backend in a usable state? How can I enable it?
> I couldn't find any clues on https://www.git-scm.com/docs/reftable.
> 3. Will future git refs backend possibly support external storage media
> e.g. Redis?
>

I just found a similar discussion on the mailing list:
https://lore.kernel.org/git/CAJoAoZn7Nt37Eh17dpLDK+YX2BaEaAaii2rJPXO3L0BmQQ=
kcgQ@mail.gmail.com/

> Thanks,
> --
> ZheNing Hu
