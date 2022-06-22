Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88665C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 18:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiFVS2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiFVS2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 14:28:06 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A565B3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:28:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id h11-20020a17090a130b00b001eca05382e7so92932pja.9
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=MHjJXZB47jRrw9OXrbnkYVzHV7vKVFJpkssADwKo3ww=;
        b=Pu/5vz3qL06GnfsTstReetA3SI6GGVqqiWzfEfSG5Tf8n8nub9UMQdQWVEFJg9aPyM
         PtYGkrjIPyhqUW32tVlTDPTQYJFnmR5rARuYoz/fiAaQf4ODCl35lMd9zrZr71BNQopR
         PxVVtN91t+kIlzo1A0+jJSNEojzy4ueRkIoW4ioPSJXHqgKBXQECjI09OvVRMxlaiQ4Y
         hqYF9FEpii2dGk36SIIz7dkTkI/wR9hNTPJiW30TNXEzYE65NNxWsQ95qOrwutgO5czc
         4hTqB+Uo6rQKi9J2RUo8fsiWcZlUQYHeDE4KA75UhLDn2ov2xoZs12lBNMWyMXwHMJvX
         zJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=MHjJXZB47jRrw9OXrbnkYVzHV7vKVFJpkssADwKo3ww=;
        b=e+ibJ3DlPfoLPw2vffr9egIdkxWy+1q5j1qmEgBebePekYkSUXsNg5PBAIAbjaeBBY
         xSKee8E3nMB9kkJxqf3OtcnVNzprjRRANWNRU6JERg9y23Hwy7rFItpJSUrTacrgcyJy
         KvdA64NSqvChurcawUSmGQCuwfpo2JDPQMSMHudGnI+yWB40Qtfxrkxrcf+gTmoOoOf9
         W+tPEInC94ZGNpsVc6hZO4InZ9LOMFowZKqy1GiaYtD24XkL5dE2wgqQ7fERFtPMo45N
         ZSwDbFyQGZyWi8hjLhWMSKi//QsJX5t6hfMpcuele67jjnw8WyI1HU7G6+fbrRC/7tY5
         HeRg==
X-Gm-Message-State: AJIora+vgbW8aYNMLngFTSMI18EalMEXBSQxzbQSF0YADoyV1JZie6kx
        kgwjME6Gi0uCzJQkFEvA8Jgxa0Lxx7ImDA==
X-Google-Smtp-Source: AGRyM1v3iznFR9215sGEGut7MO4N2xFGSt5YDQ+/Wxhcs13xCJc32BOjTpzKZZFJKyqDdb4XBnckuHVAMxYrIA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:2a8d:0:b0:40c:9b5f:13d3 with SMTP id
 q135-20020a632a8d000000b0040c9b5f13d3mr4003857pgq.465.1655922482026; Wed, 22
 Jun 2022 11:28:02 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:28:00 -0700
In-Reply-To: <patch-v3-08.12-bb1310b9abe-20220622T142012Z-avarab@gmail.com>
Message-Id: <kl6l4k0ck0y7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <patch-v3-08.12-bb1310b9abe-20220622T142012Z-avarab@gmail.com>
Subject: Re: [PATCH v3 08/12] submodule--helper: report "submodule" as our
 name in some "-h" output
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change the user-facing "git submodule--helper" commands so that
> they'll report their name as being "git submodule". To a user these
> commands are internal implementation details, and it doesn't make
> sense to emit usage about an internal helper when "git submodule" is
> invoked with invalid options.
>
> Before this we'd emit e.g.:
>
> 	$ git submodule absorbgitdirs --blah
> 	error: unknown option `blah'
> 	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]
> 	[...]
> And:
>
> 	$ git submodule set-url -- --
> 	usage: git submodule--helper set-url [--quiet] <path> <newurl>
> 	[...]
>
> Now we'll start with "usage: git submodule [...]" in both of those
> cases. This change does not alter the "list", "name", "clone",
> "config" and "create-branch" commands, those are internal-only (as an
> aside; their usage info should probably invoke BUG(...)). This only
> changes the user-facing commands.
>
> The "status", "deinit" and "update" commands are not included in this
> change, because their usage information already used "submodule"
> rather than "submodule--helper".

I enumerated over all of the commands just to be sure:

- The commands named here and the changed commands cover all of the uses
  of the usage_*/parse_options API.

- We still mention "submodule--helper" in two internal facing commands
  ("is-active" and "push-check"), but those call die() (should be BUG()
  I assume?) instead of usage_*().

- The other two commands ("resolve-relative-url-test" and "check-name")
  are internal facing commands that never print usage information.

So this covers all of the cases. Great!

> I don't think it's currently possible to emit some of this usage
> information in practice, as git-submodule.sh will catch unknown
> options, and e.g. it doesn't seem to be possible to get "add" to emit
> its usage information from "submodule--helper".
>
> Though that change may be superfluous now, it's also harmless, and
> will allow us to eventually dispatch further into "git
> submodule--helper" from git-submodule.sh, while emitting the correct
> usage output.

Makes sense.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a298d8d0c12..6af09d78d4b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv=
, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <comman=
d>"),
> +		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
>  		NULL
>  	};
> =20
> @@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, c=
onst char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper init [<options>] [<path>]"),
> +		N_("git submodule init [<options>] [<path>]"),
>  		NULL
>  	};
> =20
> @@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **ar=
gv, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]=
"),
> +		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
>  		NULL
>  	};
> =20
> @@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv,=
 const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
> +		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
>  		NULL
>  	};
> =20
> @@ -2788,7 +2788,7 @@ static int absorb_git_dirs(int argc, const char **a=
rgv, const char *prefix)
>  	};
> =20
>  	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
> +		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
>  		NULL
>  	};
> =20
> @@ -2893,7 +2893,7 @@ static int module_set_url(int argc, const char **ar=
gv, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> +		N_("git submodule set-url [--quiet] <path> <newurl>"),
>  		NULL
>  	};
> =20
> @@ -2932,8 +2932,8 @@ static int module_set_branch(int argc, const char *=
*argv, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path=
>"),
> -		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branc=
h> <path>"),
> +		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
> +		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path=
>"),
>  		NULL
>  	};
> =20
> @@ -3277,7 +3277,7 @@ static int module_add(int argc, const char **argv, =
const char *prefix)
>  	};
> =20
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper add [<options>] [--] <repository> [<path>]")=
,
> +		N_("git submodule add [<options>] [--] <repository> [<path>]"),
>  		NULL
>  	};
> =20
> --=20
> 2.36.1.1239.gfba91521d90
