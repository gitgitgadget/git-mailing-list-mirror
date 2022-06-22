Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A8C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359287AbiFVQBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359400AbiFVQAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:00:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F530F78
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:59:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so11991486eda.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vOevZSmboVa5ApCIQDPQ7SzIi2r1bqr2F7y1tmijA4s=;
        b=dBD2l6PtI1ybCR7ep3kHRgPh5+ktaCcr7+aZr+VyKrMP+NTZyuV7YY+Io7H8q7LKo1
         kRDjToQEdoz7gAC9eyjXI7g+CAloMHeS2O3zhL4smxd36oUKk7p++2qPiUAMRmmXhun+
         ns4/9UjhmjxnN0FXaDm+VkpjiszutxKMEkkJwgSA9hMPoh5YrW0TJclsWsw44PlrHtIF
         ssbUVLM7uNmNDAVvk/jg2wbK53ATxgPQnrDpwhZWobjfYvKFKPtNM2sg949btiUYYDPt
         3bRzTkyH5dtJr2trpNMPPO2fLbP8C7feErRPQrQtid3iz2CtZaFYentONbMqAUHHShBz
         7BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vOevZSmboVa5ApCIQDPQ7SzIi2r1bqr2F7y1tmijA4s=;
        b=R+uOpjfzhggkedOgPpDMMzAkNmDewovCyRxmvNrh2bhB27MKBPVUACcDMlx9QOvvvK
         5t8KaNCYKvEW5SVO/r/iDz3D0rOMKxJaJFMaj5gEkamG/pWDt8uZBXpvuIoOzrJAAINT
         R8DGjWxT+d0jaxt8CJNT45YaayNYeTFMmAcRvLx3IdMjNolyiUmlb/skEIEnOjEOQF7I
         oxo3d8cDxl+ifQjoKCaM+tIMJoEbhGEwE4RPXiIJwKyd1Ei7ldpoFv+7Ha8w8ZDBm2nk
         0EJCcKys9RFKJft2uotcnE1mLHcK70FOkB1t39jXPZAKsXF3wTSNloGJmFyXMQGOAWTj
         SI8A==
X-Gm-Message-State: AJIora8bkdvnek9fXegYW68wlE77fG4WNoiDZ5kBEqhpKZWujvr/ChTF
        lzrcNU2ouslrB3K4LT9UxdeXz2jC8DpZJQ==
X-Google-Smtp-Source: AGRyM1simvRVLRljjYBJmfO5zwByB+Nqci+moVgCD0xiI0sArkewjGKW2l5q3ZeXSjEKtIvr2YbAEg==
X-Received: by 2002:a05:6402:3298:b0:435:8145:e6db with SMTP id f24-20020a056402329800b004358145e6dbmr4930619eda.294.1655913582142;
        Wed, 22 Jun 2022 08:59:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y24-20020a17090629d800b00722f0c7d081sm1307931eje.119.2022.06.22.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 08:59:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o42lY-000oSH-TW;
        Wed, 22 Jun 2022 17:59:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     haoyurenzhuxia@gmail.com
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        dyroneteng@gmail.com
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
Date:   Wed, 22 Jun 2022 17:56:16 +0200
References: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
Message-ID: <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, haoyurenzhuxia@gmail.com wrote:

> From: Xia XiaoWen <haoyurenzhuxia@gmail.com>
>
> The command: `git multi-pack-index write --bitmap` will create 3
> files in `objects/pack/`:
>     * multi-pack-index
>     * multi-pack-index-*.bitmap
>     * multi-pack-index-*.rev
>
> But if the command is terminated by the user (such as Ctl-C) or
> the system, the midx reverse index file (`multi-pack-index-*.rev`)
> is not removed and still exists in `objects/pack/`:
>
>     $ GIT_TEST_MIDX_WRITE_REV=3D1 git multi-pack-index write --bitmap
>     Selecting bitmap commits: 133020, done.
>     Building bitmaps:   0% (3/331)
>     ^C^C
>
>     $ tree objects/pack/
>     objects/pack/
>     =E2=94=9C=E2=94=80=E2=94=80 multi-pack-index-3b048d1b965842cd866e10b6=
ec1a3035dbede0a5.rev
>     =E2=94=9C=E2=94=80=E2=94=80 pack-b7d425f1b01727d5f364f5d9fbab2d1900fc=
d5c0.idx
>     =E2=94=94=E2=94=80=E2=94=80 pack-b7d425f1b01727d5f364f5d9fbab2d1900fc=
d5c0.pack
>
> This patch resolves this by adding a cleanup handler to the sigchain.
>
> Signed-off-by: Xia XiaoWen <haoyurenzhuxia@gmail.com>
> ---
>  midx.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 5f0dd386b0..6586051a62 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -17,6 +17,7 @@
>  #include "refs.h"
>  #include "revision.h"
>  #include "list-objects.h"
> +#include "sigchain.h"
>=20=20
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>  #define MIDX_VERSION 1
> @@ -41,6 +42,8 @@
>=20=20
>  #define PACK_EXPIRED UINT_MAX
>=20=20
> +static struct strbuf rev_filename =3D STRBUF_INIT;

Is the rest of this API thread safe, and no longer is because of this?
You're doing this because...

>  const unsigned char *get_midx_checksum(struct multi_pack_index *m)
>  {
>  	return m->data + m->data_len - the_hash_algo->rawsz;
> @@ -884,21 +887,29 @@ static uint32_t *midx_pack_order(struct write_midx_=
context *ctx)
>  	return pack_order;
>  }
>=20=20
> +static void remove_rev_file_on_signal(int signo)
> +{
> +	if (unlink(rev_filename.buf))
> +		die_errno(_("failed to remove %s"), rev_filename.buf);
> +
> +	sigchain_pop(signo);
> +	raise(signo);

We need to handle this signalling.

I wonder if we could (ab)use the lockfile.c/tempfile.c API instead here,
and get the signal handling, cleanup etc. for free.

Also, the commit message doesn't really say *why*, i.e. in cmd_repack()
we've suffered from this already, but don't we have "git gc" cleaning
these up? Maybe not (I didn't check), but maybe that was the previous
assumption...

I mean, I think it makes sense to clean these up, but are we doing the
same for the other X.* files for the X.pack? Should we?
