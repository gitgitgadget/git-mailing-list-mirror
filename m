Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0696CC00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiGaPCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGaPCx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 11:02:53 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C502AD1
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 08:02:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h16so4421162ilc.10
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eR2uFzkmrAKg+F6EeTxHjKy5XVngDwhNvnSx8kGE+rc=;
        b=LMPrCqtL+EMXbukPh+2JimxeQVrKay7vGlmjWWJmiMFM+CdMbklVuTjSu8Lg8iVFW4
         MFHhcHqgbveZqjCfqKCp9m+WvYZnBdQVge0TBAT7JZFr3XUJpVWJROaFYiSeCT5vMmRs
         RZG+U97A/QSpNitwd3/2vMp0WIySPbMH6IK8XommI8iErJenDoSrhHrzsdgLE7//420P
         Qjzb3Ca/Sep0uLX9ZNhocbLluXBYtMgiHKpM1GU+Ta1JQUic1TFfvlMUL/suiZfY24EU
         LC2Gn6S8zV/HKRb+9LU7CtIsiVT6dV8sR7+8VWKAE66WZAmN3oRr6jOjX7EEuJBHB99g
         paOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eR2uFzkmrAKg+F6EeTxHjKy5XVngDwhNvnSx8kGE+rc=;
        b=g98D84V+fNDF5qnjZeEzxK4zwG/DvVw6T5NrgLSKIohQHEds8jn/iVJi+GciDmi+Xj
         fsqVgAwnLF58DQdIdESUKoTXcoG0l9y/mvOkhE7YEhiUlm0tMQISW0//otY3fMY/oKyY
         s3hEFwlvG7ac1P8Y8xNOofQAvqfJe7FDcq41gV4oPQC3kJh8odH1ICRLQATVaZG1HBt2
         thNngbye+8GdLahazkXksEhYMpNxrjgtLWrMWWNnwSfAwYV+9pUjt1Vo5Lh85i0u/zQ6
         DXdsw/n03myblPON4JW1FsXsdcpcGP/ToQf0sPJE6LNn15KcZLblzVGUdEnPoh4WLK/J
         3M7A==
X-Gm-Message-State: AJIora8qJNDzFAGgIwVwgw1QyOIcmtUxL6WN8ApFcuWnwWATnv7YUG3U
        bAgT8j37TrFu+cAA25l++jnTm2S98zG2ltNkRLU=
X-Google-Smtp-Source: AGRyM1s/D3hzwNIsTKeoAJeh9mwH5BHBU7aldMr2odxmpAh2OU9QjFG+WjG2bZtCUqAA6dfTgeOwaprpCToFVAbIs5k=
X-Received: by 2002:a92:d0cd:0:b0:2de:11e6:ef8 with SMTP id
 y13-20020a92d0cd000000b002de11e60ef8mr4615092ila.254.1659279772197; Sun, 31
 Jul 2022 08:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 31 Jul 2022 23:02:41 +0800
Message-ID: <CAOLTT8Q-241cExFcbXSUfj42GontKH0uQpX1Voekf4RJ95hAVw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] cat-file: add --batch-command remote-object-info command
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.email>, johncai86@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Calvin Wan,

Calvin Wan <calvinwan@google.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C 08:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Sometimes it is useful to get information about an object without having
> to download it completely. The server logic has already been implemented
> as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,
> 2021-04-20)=E2=80=9D. This patch implements the client option for it.
>
> Add `--object-info` option to `cat-file --batch-command`. This option
> allows the client to make an object-info command request to a server
> that supports protocol v2. If the server is v2, but does not allow for
> the object-info command request, the entire object is fetched and the
> relevant object info is returned.
>
> Summary of changes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Patches 1, 2, 3, and 7 are small changes that setup the main
> implementation. Patch 4 sets up object-info to be backwards compatible
> for future patch series that adds additional attributes.  Patch 5 adds
> internal trasnport functions to send and receive object-info command
> request packets. Patch 6 adds the fallback if object-info is not
> supported or fails.  Patch 8 adds the cat-file implementation.
>

I have to say I am very curious about this feature. Since the current
git partial-clone interface supports only a few filters:

blob:limit
blob:none
sparse:oid
tree:0

Though these filters reduce the number of objects downloaded each time,
sometimes I just need *only* one blob object, git partial-clone will still
download some additional commits and tree objects from the remote.

This patch can get the remote-object-info by git cat-file, so can we go
further to get the remote-object-content of the object?

Something like:

$ git cat-file --batch-command
remote-object-content origin <oid>

> Changes since V3 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Object-info is now implemented in cat-file --batch-command rather
>    than fetch (new base commit)
>  * Removed config option to advertise object-info
>  * Added forwards and backwards compability for object-info
>  * Split up some patches to better describe and visualize changes
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
>
> Calvin Wan (8):
>   fetch-pack: refactor packet writing
>   fetch-pack: move fetch default settings
>   object-store: add function to free object_info contents
>   object-info: send attribute packet regardless of object ids
>   transport: add client side capability to request object-info
>   transport: add object-info fallback to fetch
>   cat-file: move parse_cmd and DEFAULT_FORMAT up
>   cat-file: add --batch-command remote-object-info command
>
>  Documentation/git-cat-file.txt |  16 +-
>  builtin/cat-file.c             | 225 ++++++++++++++++-----
>  fetch-pack.c                   |  61 ++++--
>  fetch-pack.h                   |  10 +
>  object-file.c                  |  16 ++
>  object-store.h                 |   3 +
>  protocol-caps.c                |  14 +-
>  t/t1006-cat-file.sh            | 347 +++++++++++++++++++++++++++++++++
>  transport-helper.c             |   7 +-
>  transport.c                    |  97 ++++++++-
>  transport.h                    |  11 ++
>  11 files changed, 728 insertions(+), 79 deletions(-)
>
> --
> 2.36.0.rc2.10170.gb555eefa6f
>

Thanks!

ZheNing Hu
