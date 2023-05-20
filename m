Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7966C77B7D
	for <git@archiver.kernel.org>; Sat, 20 May 2023 09:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjETJZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjETJZp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 05:25:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26222DD
        for <git@vger.kernel.org>; Sat, 20 May 2023 02:25:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4645482e87.2
        for <git@vger.kernel.org>; Sat, 20 May 2023 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684574742; x=1687166742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trWB8vdzGiyPIHHUbJXlYR5eX+3Kb5eWd25hBYQrLaE=;
        b=hjcborOx2oZAbM138YqtgmcIMt8yxY79dTeRthc8q3sCsUdTrupI9Ooi96zZUOwk18
         cVRX4t/F4ppKp2wjSJi8Lv/XXK/7QgrKdS0Vr001VdgXjv1/IoNybkXGcLqvihVW5b8A
         DRQGiU7j8QgmzIDqXNw6fNz6PyhucWIWIfobiTTWtLpbubfGBH5oiPiBbYrb371HMbgq
         kLzGrzJQBGoWhGo1qv0JjG8gBDVo0habyI9TfXO8mvA6gD9ZoDXqbAwLiHtOyFR/XgnI
         5vYH7kH0938pVhdlehVC4pAjtuqpuDhZUuGAxXzlxetsUxNIs0QXC+2hwBqSxSM2R5OH
         /ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684574742; x=1687166742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trWB8vdzGiyPIHHUbJXlYR5eX+3Kb5eWd25hBYQrLaE=;
        b=jJH/5lbZCX+1R/sl9Ue9a6uYDo6UA1OQOBpu544IefUvtIrsylxyXaI4r3/XUVn6cx
         iillTcg4o8CD4x3Z1IUiIVnzo7ZOrnuHciRwCPgnKqoY12RkGHOYi2ynHBAyHc6XoTAr
         eUwNxmby6zMwkKYRDWG0npDadiy8/UvU5O0B8dEfefTvcZPe+RqKhDQ88zlz6pBqQJ9N
         yeRNTUBCo+aHrauikwIUQqpaAYuYytPEJkoNQtV6McSZ9vO8g5f+f5OdUKNyY1kIi/T0
         FhlBmdBY+3qO8ISBlrdtIOGRCeQpxg2Hl7478JZy/MiimA+HCaFwVkVpczOOdgaYLpdL
         q5lw==
X-Gm-Message-State: AC+VfDzVFekXl1pYO3D3E5hgHkAEP7Lh3XemuE4qdPfOX9Ri1KOOjeDr
        npbBDzbpSvMPNUdmmJTp3Ipit/RzG6jLMlUMW+xHkwH38lQ=
X-Google-Smtp-Source: ACHHUZ4X4u3cfaxUImF/LPtekCVcg2U0r6PwNsvD+ZjeQGH25VbOssTQU8Tf4gYHcyqHBbzZImcqp+1e+ohZ774InDo=
X-Received: by 2002:a05:6512:512:b0:4ec:9ef9:e3d with SMTP id
 o18-20020a056512051200b004ec9ef90e3dmr1461417lfb.26.1684574742215; Sat, 20
 May 2023 02:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
 <c6337eba029bd5a53f76433c51bbe86c82faf507.1684571874.git.code@khaugsbakk.name>
In-Reply-To: <c6337eba029bd5a53f76433c51bbe86c82faf507.1684571874.git.code@khaugsbakk.name>
From:   Minnie Shi <minnie.shi@gmail.com>
Date:   Sat, 20 May 2023 11:25:16 +0200
Message-ID: <CAOQx3Aa9_cW-s6YoeYLac0j8VuhJ8cvEdGieS-+K-gD7D7TBRQ@mail.gmail.com>
Subject: Re: [PATCH] doc: merge: fix mention of `ORIG_HEAD`
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The document says the =E2=80=9Ccurrent=E2=80=9D branch is master , which me=
ans the
HEAD is (G), which does not matter, it is not what I am challenging.

What I am challenging is that it continues the context and says:

Before the operation,
-`ORIG_HEAD` is set to the tip of the "current" branch (`C`).

that is not true, current branch is master, and it is (G), Maybe it
should be changed to "topic branch", so it reads like this:

Before the operation,
-`ORIG_HEAD` is set to the tip of the =E2=80=9Dtopic=E2=80=9D branch (`C`).


Min

On Sat, May 20, 2023 at 10:45=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> `ORIG_HEAD` before the attempted merge points at the commit that you are
> on (the tip of `master`), not the tip of the branch that you are trying
> to merge in.
>
> Reported-by: Minnie Shi <minnie.shi@gmail.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-merge.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 0aeff572a59..9019b6a1e50 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -38,7 +38,7 @@ Then "`git merge topic`" will replay the changes made o=
n the
>  its current commit (`C`) on top of `master`, and record the result
>  in a new commit along with the names of the two parent commits and
>  a log message from the user describing the changes. Before the operation=
,
> -`ORIG_HEAD` is set to the tip of the current branch (`C`).
> +`ORIG_HEAD` is set to the tip of the current branch (`G`).
>
>  ------------
>           A---B---C topic
> --
> 2.41.0.rc1
>


--=20
Kind regards
Min
