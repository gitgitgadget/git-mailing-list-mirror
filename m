Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45DC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiGYXQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGYXQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:16:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1710FE4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:15:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f4450c963so4987747b3.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=k36ovnWCiY2zr53HZYy4uY0oj0Vo98e4SFbV5Gwya8s=;
        b=rQY8seEnoBQBRKyKM1kNLYQaglGMdUnS+ZCT9zBv8ccLSNNriGONqFXBKOhnnJIhej
         tgEVrs0BehZ1q4Uspvav2EArC9tGy+31XcZRFGi/PB8pb3PZhu6qqZkWJTishKGmRqQX
         nhtX11yaqtSGYfomImt7kQF8++a2iV2RAWOAFQM2RHDR2yb96me+UoYFj+GFzZYq/HNO
         oe/4kn4WmNXx7lE/SBtYYqAsfHys7VqY5ccYjSkEN1A4/QnWVtyiW/7hTL+UCoZz7nPh
         xCFlmf1Wf4VCd2Uj86bMWbtzHXLpNCeshWBGzFjUXXeqBp+5KaNTqIUBY6er+QBXIkDK
         RIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=k36ovnWCiY2zr53HZYy4uY0oj0Vo98e4SFbV5Gwya8s=;
        b=VYQveH+Tex/hlpoKLTdZQO1aWdtheM0VvvwadYL7hmZZg0H0Q+apU3rs5Hov4EOaRv
         Pk84cSCGZPS5BLu7LeMBdBXpgIQbjBr0Wih9+SGxI27ncfSddJhRrWObobF7iHNZCqFX
         JCsY7+2AW84ybQCHoE6ftPKzWmVQq89/Xv989o4wK8+zftxGm+b0ZEM7LjrdTwCn+e5q
         e4K5KT9GOlY4kmWB1q5kMODhKodOGkTn94sHjwaEWB1jX9Met2X6BM9S2RhAEJ6Ys89F
         bmFoEeY4d8r1O9S0xnMvz7Fnmi2ZbzJTJDDY2Og5yxnAhwKxBFrhutf+UtSsm3UV2zo7
         lvRQ==
X-Gm-Message-State: AJIora/wf35zPYEP/C4dyfxGDNtv8JsTi2HIaqi1ab26diuK03D4X8gU
        oLHfcbYJR4r3BBNf7dhgQhY3UgBxujrS2w==
X-Google-Smtp-Source: AGRyM1sNnUVN2qPn9pme5FDvje+iA6QGP00ZNqY+Wt2iQmyjzpaB40nO4HV0yn+bdsXR4FAfpX3LX6ouDwr9cg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:fe44:0:b0:31f:1b47:9e6f with SMTP id
 o65-20020a0dfe44000000b0031f1b479e6fmr4566351ywf.392.1658790958394; Mon, 25
 Jul 2022 16:15:58 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:15:56 -0700
In-Reply-To: <patch-v3-11.26-feec1f20bf9-20220721T191249Z-avarab@gmail.com>
Message-Id: <kl6lwnc0ss0j.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <patch-v3-11.26-feec1f20bf9-20220721T191249Z-avarab@gmail.com>
Subject: Re: [PATCH v3 11/26] submodule--helper: refactor "errmsg_str" to be a
 "struct strbuf"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Refactor code added in e83e3333b57 (submodule: port submodule
> subcommand 'summary' from shell to C, 2020-08-13) so that "errmsg" and
> "errmsg_str" are folded into one. The distinction between the empty
> string and NULL is something that's tested for by
> e.g. "t/t7401-submodule-summary.sh".
>
> This is in preparation for fixing a memory leak the "struct strbuf" in
> the pre-image.
>
> Let's also pass a "const char *" to print_submodule_summary(), as it
> should not be modifying the "errmsg".
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 21b3abb7b40..f794d2b588b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -866,7 +866,7 @@ static char *verify_submodule_committish(const char *=
sm_path,
>  	return strbuf_detach(&result, NULL);
>  }
> =20
> -static void print_submodule_summary(struct summary_cb *info, char *errms=
g,
> +static void print_submodule_summary(struct summary_cb *info, const char =
*errmsg,
>  				    int total_commits, const char *displaypath,
>  				    const char *src_abbrev, const char *dst_abbrev,
>  				    struct module_cb *p)
> @@ -924,7 +924,7 @@ static void generate_submodule_summary(struct summary=
_cb *info,
>  {
>  	char *displaypath, *src_abbrev =3D NULL, *dst_abbrev;
>  	int missing_src =3D 0, missing_dst =3D 0;
> -	char *errmsg =3D NULL;
> +	struct strbuf errmsg =3D STRBUF_INIT;
>  	int total_commits =3D -1;
> =20
>  	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
> @@ -1024,23 +1024,21 @@ static void generate_submodule_summary(struct sum=
mary_cb *info,
>  		 * submodule, i.e., deleted or changed to blob
>  		 */
>  		if (S_ISGITLINK(p->mod_dst)) {
> -			struct strbuf errmsg_str =3D STRBUF_INIT;
>  			if (missing_src && missing_dst) {
> -				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and =
%s\n",
> +				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commits %s and %s\n=
",
>  					    displaypath, oid_to_hex(&p->oid_src),
>  					    oid_to_hex(&p->oid_dst));
>  			} else {
> -				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
> +				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commit %s\n",
>  					    displaypath, missing_src ?
>  					    oid_to_hex(&p->oid_src) :
>  					    oid_to_hex(&p->oid_dst));
>  			}
> -			errmsg =3D strbuf_detach(&errmsg_str, NULL);
>  		}
>  	}
> =20
> -	print_submodule_summary(info, errmsg, total_commits,
> -				displaypath, src_abbrev,
> +	print_submodule_summary(info, errmsg.len ? errmsg.buf : NULL,
> +				total_commits, displaypath, src_abbrev,
>  				dst_abbrev, p);
> =20
>  	free(displaypath);

Ah, this is mostly the same as what I sent out, but with the length
check in the same function (instead of in print_submodule_summary()).
This makes it easier to tell that the caller is still doing the same
thing.

Looks good.
