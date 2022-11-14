Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F311EC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiKNV4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNV4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 16:56:39 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926D12D34
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:56:38 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q1-20020a17090aa00100b002139a592adbso10916926pjp.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mimlr7Hl/qNMH3KmBIFQE/KhGZEOJBz05FhI+VelRJg=;
        b=DQRy+LoX/6MXhXi8LEJA4oR/v1vPVZHpwLb3ORFenUf2l3GM2XgmkfDiz8zAGQXMcg
         tsAsP+xFhQagX8e1LANf07S619byGt+OEKcnvxq4ObRNoCrsL9AtAhm8bXMV0TSyCuQP
         ClM8+cyC2VTt1nxomRIJIDYwaHbDg63WBsOV2ZgUew1TgYdOkHSpwnXXfet6UqacMeFm
         FVi3qE/ncYa2Aba6aLOS6xfBt6NCB91G+OzJy2CYrp8kQrsNmG7l5cbMon/zzLxdzd/j
         MkCVYYCjdG4q2QAR6sTLEiOBIFL2S24thgCi3g/QSsEqHuMV+wWFHGA428W6T2kxy9LX
         8unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mimlr7Hl/qNMH3KmBIFQE/KhGZEOJBz05FhI+VelRJg=;
        b=FYm8umgrlePPS2HTure6Vpoe2KeHN1hofVG/G1QYjGYGOAgNTouux4EQLj1Pj6tV09
         N5XvPUaERou4f0MArn0XtkbIVM7c/GLiBw5jIFV1kU37AbuHUkYyOStnEw0WbGhER99W
         MPOoZogrCOYhI4Oz7aTXAOAW7oPLJgDTAZ0k+ftuumceU955z+0YHAAaSIspp04ZOTii
         WcouDiMOCJ7bCqjT2XEqhv/vUZ7t6f63z1oEh04rMvX/gsr9ON5fagkP1crU5VIX3ca3
         JMZv2JhJztc6hgBNsum19EiS2UJZPZEuP+nmejHYMCZSMJ9ckhV2ghS3bSHlbC6z8kwX
         uedA==
X-Gm-Message-State: ANoB5pnc9LIHkF0Za1iEiu95op5D5V5XXPMBMe3D8li4IgtyZ5S5ErOb
        e75DFqRT6VPcEiF1upYgQZX5gOMfVc/lXw==
X-Google-Smtp-Source: AA0mqf423WCSAFoEnlTnr1djQTBp3+ixSLJgtG8xPBjLNRvO0NAEbyuGGAFEdReQQrkK/FbNsHIEBYY3BSIvNQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:3492:b0:56b:a80f:38d4 with SMTP
 id cp18-20020a056a00349200b0056ba80f38d4mr15706483pfb.12.1668462998119; Mon,
 14 Nov 2022 13:56:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:56:30 -0800
In-Reply-To: <patch-v2-04.10-935d8070834-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <patch-v2-04.10-935d8070834-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6l7czxp5dd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 04/10] submodule--helper: convert "foreach" to its own "--super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As with a preceding commit to convert "absorbgitdirs", we can convert
> "submodule--helper foreach" to use its own "--super-prefix", instead
> of relying on the global "--super-prefix" argument to "git"
> itself. See that earlier commit for the rationale and background.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c4d5e029b37..989c75280af 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -396,7 +398,9 @@ static int module_foreach(int argc, const char **argv=
, const char *prefix)
>  	struct foreach_cb info =3D FOREACH_CB_INIT;
>  	struct pathspec pathspec =3D { 0 };
>  	struct module_list list =3D MODULE_LIST_INIT;
> +	const char *super_prefix =3D NULL;
>  	struct option module_foreach_options[] =3D {
> +		OPT__SUPER_PREFIX(&super_prefix),
>  		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule=
 command")),
>  		OPT_BOOL(0, "recursive", &info.recursive,
>  			 N_("recurse into nested submodules")),
> @@ -417,6 +421,7 @@ static int module_foreach(int argc, const char **argv=
, const char *prefix)
>  	info.argc =3D argc;
>  	info.argv =3D argv;
>  	info.prefix =3D prefix;
> +	info.super_prefix =3D super_prefix;

(Also applies to subsequent patches) Why don't we assign the super
prefix directly to the struct's field? e.g.

		OPT__SUPER_PREFIX(&info.super_prefix),

> =20
>  	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
> =20
