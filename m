Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03024C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhLGSUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhLGSUp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:20:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05218C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:17:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r25so60225484edq.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jXpmO6QA8TIZneUybUBt+9kd3sxaNrrAeoYy6LvY4yA=;
        b=aSTQsW+0aRWdA/I0ej3Bgn1O7e/LgJaURNENkzkC6J3gX5d3zMFyR6wn3KgpyDbgTM
         f61dD07Wdy6ouhxNCUo3DdZSBQKeJ8FXe8aLF4SLxw2pegdy1XNmd82BFJuX03U1kx2Q
         QBswV+tO0fVzolKOVoZ/YPv5yz4S4wFjDl1bnJkHkEITP2e95ODqg5Y9TpWUbQ+N11pU
         WHL6lakq9xiZnxlbUQWPn4CZ1gQYk3mboG+NZH3c7kUVHSrCZbo9Jqco4qa5IWYjeVue
         38Qsyp9LIkeE1PbG6b8lrKBa8iapJ9e2C5znj+68kzFVTvFuStKUKCKOoo8QzC6UcBOj
         6vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jXpmO6QA8TIZneUybUBt+9kd3sxaNrrAeoYy6LvY4yA=;
        b=O0n+ZdvaJfdtl6AFMdzKQWIhilvYOT0GBB91V8qAXheY/iqM8Si9AUr2OJLlS+m4iW
         CVrx05v0FKCGXtnl6jz4pW7hNFveb6rNSgIBvjT0m+f7IKICbyGLTsoR8RHvpjS7/Ryh
         9ploNWVA0PohdOLCZ3aw5w/xTn/byMGeuwnZC8Wj6eu8+omQAHRYa0HlbWKfnxjMhIB1
         Ub8+znPRFJDO8k+k3H9jXY+MuK47Q25O1+olSDDZdK9qrbXNB5b5db+x40lH+M1VJ+Eb
         YkmkMeRYJOLaAy24uEl3OuNEnWJ4oYkyOhTiR3+o1eiUNYmcDA5QPWvEMZWTEi+OTSBE
         3AZQ==
X-Gm-Message-State: AOAM530s+EW/lsuicB45jttEPeRiEqyA/Z1R1LDlG0ER3Z/o+nxhcrHg
        5mtx1hfTfJeiy10I0kjOf5Dw/PcItnFLnA==
X-Google-Smtp-Source: ABdhPJxRYzDYz0Gcrh7KIBA7Rat0wgYgD2HOdR5cs6l6VOSruprj8R3UwLSFrbepBQMz/64GqP7mng==
X-Received: by 2002:a17:907:6eaa:: with SMTP id sh42mr1162689ejc.556.1638901033361;
        Tue, 07 Dec 2021 10:17:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m22sm292865eda.97.2021.12.07.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:17:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muf1c-001FLS-82;
        Tue, 07 Dec 2021 19:17:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 08/10] i18n: refactor "unrecognized %(foo) argument"
 strings
Date:   Tue, 07 Dec 2021 19:15:40 +0100
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <4c2df4522a10163946d3d63821dcceffb4a312bc.1638514910.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <4c2df4522a10163946d3d63821dcceffb4a312bc.1638514910.git.gitgitgadget@gmail.com>
Message-ID: <211207.86y24wmg9j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  ref-filter.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 08a3f839c97..554c2ba1b17 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -341,7 +341,7 @@ static int objectsize_atom_parser(struct ref_format *=
format, struct used_atom *a
>  		else
>  			oi.info.disk_sizep =3D &oi.disk_size;
>  	} else
> -		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectsize) argumen=
t: %s"), arg);
> +		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"),=
 "objectsize", arg);
>  	return 0;
>  }
>=20=20
> @@ -374,7 +374,7 @@ static int subject_atom_parser(struct ref_format *for=
mat, struct used_atom *atom
>  	else if (!strcmp(arg, "sanitize"))
>  		atom->u.contents.option =3D C_SUB_SANITIZE;
>  	else
> -		return strbuf_addf_ret(err, -1, _("unrecognized %%(subject) argument: =
%s"), arg);
> +		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"),=
 "subject", arg);
>  	return 0;
>  }
>=20=20
> @@ -428,7 +428,7 @@ static int contents_atom_parser(struct ref_format *fo=
rmat, struct used_atom *ato
>  		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
>  			return strbuf_addf_ret(err, -1, _("positive value expected contents:l=
ines=3D%s"), arg);
>  	} else
> -		return strbuf_addf_ret(err, -1, _("unrecognized %%(contents) argument:=
 %s"), arg);
> +		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"),=
 "contents", arg);
>  	return 0;
>  }
>=20=20
> @@ -440,7 +440,7 @@ static int raw_atom_parser(struct ref_format *format,=
 struct used_atom *atom,
>  	else if (!strcmp(arg, "size"))
>  		atom->u.raw_data.option =3D RAW_LENGTH;
>  	else
> -		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s")=
, arg);
> +		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"),=
 "raw", arg);
>  	return 0;
>  }
>=20=20
> @@ -531,7 +531,7 @@ static int align_atom_parser(struct ref_format *forma=
t, struct used_atom *atom,
>  		else if ((position =3D parse_align_position(s)) >=3D 0)
>  			align->position =3D position;
>  		else {
> -			strbuf_addf(err, _("unrecognized %%(align) argument: %s"), s);
> +			strbuf_addf(err, _("unrecognized %%(%s) argument: %s"), "align", s);
>  			string_list_clear(&params, 0);
>  			return -1;
>  		}
> @@ -557,7 +557,7 @@ static int if_atom_parser(struct ref_format *format, =
struct used_atom *atom,
>  	} else if (skip_prefix(arg, "notequals=3D", &atom->u.if_then_else.str))=
 {
>  		atom->u.if_then_else.cmp_status =3D COMPARE_UNEQUAL;
>  	} else
> -		return strbuf_addf_ret(err, -1, _("unrecognized %%(if) argument: %s"),=
 arg);
> +		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"),=
 "if", arg);
>  	return 0;
>  }

Maybe too big a refactoring, but doesn't the parent function here know
the "name" and could just pass it along?

Or actually not pass it at all and just have all of these be say:

    return -2;

And we'd do the error one caller above this if we get a return code of
-2.
