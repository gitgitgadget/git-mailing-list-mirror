Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76406EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 15:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245687AbjFNPAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbjFNPAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 11:00:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C931FC7
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:00:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-97881a996a0so136008766b.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686754844; x=1689346844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+AKzhX5J135+LwYx4PF/DA27DttR3bSACqqIjOGxk0=;
        b=SEnfxE6jJ1Jyu8ya52uU639i+HHSHd3Hanr+VKHodtARZ5kdvlat85KdyetEJWT1pN
         xUzzLHG8ik3hrbmsZdykTx5fwQJ6NPaHl13yyQkldqXs4ScCM34rRTXBZRUP1ZBKW21d
         V1mAXZkhrCuxr2M1i0YWBtkEAtU91gD5v5C65Va00fCFogmi+roifNrlbSc7qB4xOvRo
         1ZElsfNtM3u39P6W69MIABQdDMnxfTrF9nwKLfwvr61ZpKfqtaNeFDZVXuMxxaXVC5zu
         Wsx+J5RDkrx36HoKM3034fXHo6pV/1NRfjxZakWZyEzhOEZvFYePbKIb0pLRB51dR5bM
         xruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754844; x=1689346844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+AKzhX5J135+LwYx4PF/DA27DttR3bSACqqIjOGxk0=;
        b=cS7qhQ1Ex4DybpsInjDFjObfFWse8S7dMINQ+1jRg4bgK2Q3iZESAQy41q6rhWhAS7
         XUy6KZQlbmRb2ES3tWyzmFT/ziEz+5/sGUXmZ2SaznfB4bSHhiIn3Hed9jeHuxwLN1YQ
         ydeGEfYdXr7coAIGRSLs+ggLPVpf5i9lEducmX1Uk/dy6nejTmTrTbXd2jRBvk4f6mSy
         /ra1ajOEWD7bSzv5szJ9tlfUWzcXYZNCQHu/x0wo9sUkqNfOClniMh9/GJu8Mzy7D3hu
         YeTj2o547hWtlN31TfxxZ7yexBuQaJuKJImioVW/YEbRkYyFsF8U4OEMyBv/9M7/RKpt
         kr8Q==
X-Gm-Message-State: AC+VfDwgVbOfnWYsxWp2dxWfaw90iWoBWoa6An5onRo/wbERlSm0EKzz
        GxhMWx1m5SNqK1VYPK6UlCF0rIlFSpJxyZ6gbZBU5D4C+fQ=
X-Google-Smtp-Source: ACHHUZ64laUU+0TX1f4/BQZarSKsBWCEB21G/aijJpUSqXjqEYIcMttFUbmcnYhtu09kge97Q1wq16tnUu/beVJQHqY=
X-Received: by 2002:a17:906:9747:b0:978:a555:9bde with SMTP id
 o7-20020a170906974700b00978a5559bdemr16923324ejy.59.1686754843843; Wed, 14
 Jun 2023 08:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
 <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com> <e0a56c8e61d80ef345885bf266e9844de289695f.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <e0a56c8e61d80ef345885bf266e9844de289695f.1686017304.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Jun 2023 17:00:31 +0200
Message-ID: <CAP8UFD2iej1EhUtR=+wqcnnoYrwCPFoR2ed71Wswyd8CYPthFA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] doc: trailer: drop "commit message part" phrasing
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2023 at 4:08=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> The command can take inputs that are either just a commit message, or
> an email-like output such as git-format-patch which includes a commit
> message, "---" divider, and patch part. The existing explanation blends
> these two inputs together in the first sentence
>
>     This command reads some patches or commit messages
>
> which then necessitates using the "commit message part" phrasing (as
> opposed to just "commit message") because the input is ambiguous per the
> above definition.
>
> This change separates the two input types and explains them separately,
> and so there is no longer a need to use the "commit message part"
> phrase.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 35 +++++++++++++-----------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git=
-interpret-trailers.txt
> index da8fec7d5fe..ffde97a6c3d 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -18,17 +18,22 @@ Add or parse 'trailer' lines that look similar to RFC=
 822 e-mail
>  headers, at the end of the otherwise free-form part of a commit
>  message.
>
> -This command reads some patches or commit messages from either the
> -<file> arguments or the standard input if no <file> is specified. If
> -`--parse` is specified, the output consists of the parsed trailers.
> -
> +This command reads commit messages from either the
> +<file> arguments or the standard input if no <file> is specified.
> +If `--parse` is specified, the output consists of the parsed trailers.
>  Otherwise, this command applies the arguments passed using the
> -`--trailer` option, if any, to the commit message part of each input
> -file. The result is emitted on the standard output.
> +`--trailer` option, if any, to each input file. The result is emitted on=
 the
> +standard output.
> +
> +This command can also operate on the output of linkgit:git-format-patch[=
1],
> +which is more elaborate than a plain commit message. Namely, such output
> +includes a commit message (as above), a "---" divider line, and a patch =
part.
> +For these inputs, the divider and patch parts are ignored, unless `--no-=
divider`
> +is specified.

I think saying "the divider and patch parts are ignored" is a bit
ambiguous. It could mean that when a patch is read by the command only
its commit message, possibly modified by the command, is emitted on
the standard output.

I would suggest something like:

"For these inputs, the divider and patch parts are not modified by
this command and are emitted as is on the output, unless
`--no-divider` is specified."
