Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F8C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiBRTSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:18:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiBRTSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:18:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CDC25844C
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:18:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s24so10711031edr.5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bWDn+SgJOE7rcJotsnwSJee87dgRXlNYADu/pCAmsYI=;
        b=BQOhICBka/uKEtrFn5sI3HzMLzdd7L6fZcRcw5IdJ+PEh9UOdS09b5m+EwaacsReuW
         nF9k6Rrc0eQ4LCLmL+iJdHOgd0RInBQb7WKYUW9OsW5a5V6j/bMrCdjJqpMQn8C77ASP
         8DOHDVDya38wHcBAo+s0CoftiWP4aZqy32oahgcPdXvhVw0E6aCtpIHyRymVFZH1Krde
         bhLwx8Lovs0opI575cvN47lMnaP1+kFyo1jeShjcZzSOCiCWYrFRFnzeJBqj4KhVC/j1
         d9khLPOtOeyiPz24Gyoa12iJw+ZM8fkNt7xz1YsGg8OYzo6Qet4aWmEUEffF+Op8TFgf
         07Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bWDn+SgJOE7rcJotsnwSJee87dgRXlNYADu/pCAmsYI=;
        b=FFUVw8BiyzBnNYVkUYe9Acpp4vBIF369MYAogiwOtcq4lJTOHkwohKiZvCVurAcDnC
         UmZlihy4Sxwv50bXbTdoGmBD9fXI0nyqCZHJLlED1ShxxuizU3wYksbSibJQOXL7uYn6
         +Wf4hm3zNxI0oIqn1NzE3yIy6+iDn7Uf96p6K+YhPpslWhB7PKBUqqFaot736g3dshP4
         YI3h9iQeBZroCSKIZP2eNwUnzH+rtueZYBQg6H7WhDN8Zh093Pk3yme1V0S4VYBwkH3x
         IJap7bjGtAzA/GGWnvQF0xV8+TmHpYUiee2IczTySN3gh4AhZxYxIkwWyS8Xqx2xb3hq
         ZVWw==
X-Gm-Message-State: AOAM532s5jHsV86YRNXWnFiv8MA05MS8tyvX+52N20R8Py/+SKR36/7w
        TFqAac9JhXQxUbxo1g3QhEC5RRtwwkc=
X-Google-Smtp-Source: ABdhPJyBTDnaMjMp8KPJpIB3wM95sz0j8y683pK3xzP3tLsyAj6A9WXBjkGlWNoTw0w/I/B/DkeWxg==
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id i5-20020a50fc05000000b004084d185070mr9832261edr.365.1645211907375;
        Fri, 18 Feb 2022 11:18:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h5sm2498007ejo.124.2022.02.18.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:18:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL8lt-004LtR-Kt;
        Fri, 18 Feb 2022 20:18:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/3] reflog: call reflog_delete from reflog.c
Date:   Fri, 18 Feb 2022 20:15:18 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <e4c0047a17ca1b5f824acfb209884a59a93ea523.1645209647.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e4c0047a17ca1b5f824acfb209884a59a93ea523.1645209647.git.gitgitgadget@gmail.com>
Message-ID: <220218.86sfsggf0e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Now that reflog is libified into reflog.c, we can call reflog_delete
> from the reflog.c library.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/reflog.c | 42 ++----------------------------------------
>  1 file changed, 2 insertions(+), 40 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 65198320cd2..03d347e5832 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -316,12 +316,10 @@ static const char * reflog_delete_usage[] =3D {
>=20=20
>  static int cmd_reflog_delete(int argc, const char **argv, const char *pr=
efix)
>  {
> -	struct cmd_reflog_expire_cb cmd =3D { 0 };
>  	int i, status =3D 0;
>  	unsigned int flags =3D 0;
>  	int verbose =3D 0;
>=20=20
> -	reflog_expiry_should_prune_fn *should_prune_fn =3D should_expire_reflog=
_ent;
>  	const struct option options[] =3D {
>  		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
>  			EXPIRE_REFLOGS_DRY_RUN),
> @@ -337,48 +335,12 @@ static int cmd_reflog_delete(int argc, const char *=
*argv, const char *prefix)
>=20=20
>  	argc =3D parse_options(argc, argv, prefix, options, reflog_delete_usage=
, 0);
>=20=20
> -	if (verbose)
> -		should_prune_fn =3D should_expire_reflog_ent_verbose;
> -
>  	if (argc < 1)
>  		return error(_("no reflog specified to delete"));
>=20=20
> -	for (i =3D 0; i < argc; i++) {
> -		const char *spec =3D strstr(argv[i], "@{");
> -		char *ep, *ref;
> -		int recno;
> -		struct expire_reflog_policy_cb cb =3D {
> -			.dry_run =3D !!(flags & EXPIRE_REFLOGS_DRY_RUN),
> -		};
> -
> -		if (!spec) {
> -			status |=3D error(_("not a reflog: %s"), argv[i]);
> -			continue;
> -		}
> -
> -		if (!dwim_log(argv[i], spec - argv[i], NULL, &ref)) {
> -			status |=3D error(_("no reflog for '%s'"), argv[i]);
> -			continue;
> -		}
> -
> -		recno =3D strtoul(spec + 2, &ep, 10);
> -		if (*ep =3D=3D '}') {
> -			cmd.recno =3D -recno;
> -			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
> -		} else {
> -			cmd.expire_total =3D approxidate(spec + 2);
> -			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
> -			cmd.expire_total =3D 0;
> -		}
> +	for (i =3D 0; i < argc; i++)
> +		status |=3D reflog_delete(argv[i], flags, verbose);
>=20=20
> -		cb.cmd =3D cmd;
> -		status |=3D reflog_expire(ref, flags,
> -					reflog_expiry_prepare,
> -					should_prune_fn,
> -					reflog_expiry_cleanup,
> -					&cb);
> -		free(ref);
> -	}
>  	return status;
>  }


Maybe others will disagree, but per my comment on 1/2 I found reviewing
this locally much easier with this squashed into 1/2 (without the {}
changes I suggested).

I.e. the diff move/rename detection eats up this change & shows that the
combinatino of 1/3 and 2/3 is almost entirely just moving around
existing code (good!).

But without this squashed 1/3 has a reflog_delete() "addition", that we
later can see is mostly just moving things around.

I'll leave it to you to decide what you want to do there, just
suggestion on an otherwise very trivial-to-review change :)
