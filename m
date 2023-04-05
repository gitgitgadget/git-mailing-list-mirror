Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2FFC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 07:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjDEHpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDEHpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 03:45:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114C710FA
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 00:45:51 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r187so41499599ybr.6
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680680750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcEIM6qYYuM8tA2n9NvY8WlYhtRmiqn1gKnbY2MQTgE=;
        b=bguDe0TQmApg165slbuUB/aSwB4ceLdLfrMI2NBffE7AITcgMTbd/cWxjScEK/LQ4J
         7KaR56O6tx92mGOgtSmy6jW4Ej5UeEZOpLYBaC/RgYwd9NoAuCeK6evR3+l6wCP+iXI7
         WGJ1XmuBsfC/ZIHI5rPjWPbnkvv9o1cCw8E3Q7PhXFGLvMG9o4BwYqLtFGee2jLevrNW
         Jmvc1Ar392YdLxeRbgeZxM6HkGlibrzLxDVBssLskJoAnf60fZkvbu+CWPr7x4Lf94FS
         aENZQMAOduyEAN8lsuOZ4n36cd2EQLZ6HAM8Tz82Nv7OiJ8dE0Mv7Vjrv3eNo3CtsXB3
         uBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680680750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcEIM6qYYuM8tA2n9NvY8WlYhtRmiqn1gKnbY2MQTgE=;
        b=up/kWoW/eCAXPyL7QnAxtLOn94MwjDqOKmai7ALqNHpDEWrl879OzF7aI1YIxnMJ+3
         0SM71Y+5ONWl8cEBDSd14smPdq3f3NeX1Yp+UVruTLOhJ3beD+3jmPX1wlG7JIIHYv0e
         um2hh6mcahr3ffEglL3xveFHbHG8pGcl+dV3R8XbPrCJ40I8ETKspBB6Pb8/DwsZiqzT
         se/58cr//QypZ4FbogIFp2eLoTM3/VC0Bcp/vqgUA7zq4icYIBjLjMN30ilcYFLJvibQ
         6Moi20PPXOzMp9N/GAPlMED15W/AcLITqVUO22jEdvXqn3bYUfLQFqGnvi1DJ+d5xURB
         b3rg==
X-Gm-Message-State: AAQBX9dhLbwXqBLcwpHmAnHGtEytNn4xZuTWihOEL4M3kb2pse+C/U10
        Rco9DoT6MCDz6W7+P/jU6pyeDh4mD/4ar7E0K9g=
X-Google-Smtp-Source: AKy350bNrjT2wutazNwjpnmiQ8zM86KlVU8nkPlHBXSCPLbT2wacpH/TeqSQqtBgE/btgL6rlisXK7fDDRygvEklMuk=
X-Received: by 2002:a25:d406:0:b0:b7d:4c96:de0 with SMTP id
 m6-20020a25d406000000b00b7d4c960de0mr3087197ybf.5.1680680750200; Wed, 05 Apr
 2023 00:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230331181229.15255-1-code@khaugsbakk.name> <cover.1680548650.git.code@khaugsbakk.name>
 <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
In-Reply-To: <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 5 Apr 2023 15:45:48 +0800
Message-ID: <CAOLTT8QJYumrv1G1SQ8005n2ab1Ycyoc6T_YyFHunJM5=6ZmtQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2=2F3=5D_doc=3A_interpret=2Dtrailers=3A_don=E2=80=99t_?=
        =?UTF-8?Q?use_deprecated_config?=
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> =E4=BA=8E2023=E5=B9=B44=E6=9C=
=884=E6=97=A5=E5=91=A8=E4=BA=8C 03:24=E5=86=99=E9=81=93=EF=BC=9A
>
> `command` has been deprecated since commit c364b7ef51 (trailer: add new
> .cmd config option, 2021-05-03).
>
> Use the commit message of c364b7ef51 as a guide to replace the use of
> `$ARG` and to use a script instead of an inline command.[1] Also,
> explicitly trigger the command by passing in `--trailer=3Dsee`, since
> this config is not automatically used.[2]
>
> [1]: =E2=80=9CInstead of "$ARG", users can refer to the value as position=
al
>    argument, $1, in their scripts.=E2=80=9D
> [2]: =E2=80=9CAt the same time, in order to allow `git interpret-trailers=
` to
>    better simulate the behavior of `git command -s`,
>    'trailer.<token>.cmd' will not automatically execute.=E2=80=9D
>

Changing these examples from command -> cmd makes sense.
So users will tend to use 'cmd' instead of 'command' as much as
possible when referring to examples.

> Cc: ZheNing Hu <adlternative@gmail.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-interpret-trailers.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git=
-interpret-trailers.txt
> index dbbb6815c3..c76efae76a 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -325,7 +325,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@=
example.com>' --trailer 'Re
>  $ git config trailer.sign.key "Signed-off-by: "
>  $ git config trailer.sign.ifmissing add
>  $ git config trailer.sign.ifexists doNothing
> -$ git config trailer.sign.command 'echo "$(git config user.name) <$(git =
config user.email)>"'
> +$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git conf=
ig user.email)>"'
>  $ cat empty-msg.txt | git interpret-trailers
>
>  Signed-off-by: Bob <bob@example.com>
> @@ -403,11 +403,14 @@ $ cat msg.txt
>  subject
>
>  message
> +$ cat ~/bin/glog-ref
> +#!/bin/sh
> +git log -1 --oneline --format=3D"%h (%s)" --abbrev-commit --abbrev=3D14
>  $ git config trailer.see.key "See-also: "
>  $ git config trailer.see.ifExists "replace"
>  $ git config trailer.see.ifMissing "doNothing"
> -$ git config trailer.see.command "git log -1 --oneline --format=3D\"%h (=
%s)\" --abbrev-commit --abbrev=3D14 \$ARG"
> -$ cat msg.txt | git interpret-trailers
> +$ git config trailer.see.cmd "glog-ref"
> +$ cat msg.txt | git interpret-trailers --trailer=3Dsee
>  subject
>
>  message
> --
> 2.40.0
>

Thanks.
--
ZheNing Hu
