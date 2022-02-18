Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF64C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiBRTPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:15:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiBRTPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:15:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44217EC15
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:15:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f17so17153538edd.2
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Df7uZh6rS2bOdAVgmXMIuuQqR+9doF9nHK7F8iEu1Ho=;
        b=kiel+sOEz7Kp6OaTJGq2Lsk/OluOddBb1D/ViRu1LA0ayAi5vABhy++3+83gzL3sQY
         gYmUd4Df5d1Dv289nrpd/MidDxP9Vq+QfNOD7k1yxSV8FCBvLhIyXqpGSSVbPXPPQUDI
         s8BhTAlXZly/ygjLXpICVHN2nhZtqRmyq8HQFVfIpejdWUCMXbMCc4ivFMsgqpAapFJI
         Kj0wIaElIoGfCr82dDUwcU2Ih8oxwu8DAZMAHSrTl3B7Njdr66LJsPjGZCGJHI9MGtWW
         Wsu9dxZHHX//52zUpr9UQpXwPxFINDpNUVCfK4U+gtYPsDTayUd7k+QCvBytO6Hb/wid
         1lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Df7uZh6rS2bOdAVgmXMIuuQqR+9doF9nHK7F8iEu1Ho=;
        b=MyFV5YVqETndIzkUIAlnOiSR9GxQbCWGusob70E2TddFKwEfuJnCahVquE0yx8N//v
         +p4+HsA4lMHtUN+m6F9oV/BTvEBgmZAgNIACMFADzg4c2uA3PjmFz7xE9n9m7ki7Jlom
         ZPzXGUIAqN0f8ctqs259d2cToIB+PfSY42Vm0SwOsNfsMaPTaW2TtQo2MGeP9tlXsMZp
         2HAYUl3zZyXuBG9SUbD4p6N0LP2pZn2riu1rhwKqyo3b+7zObZPd5XwCWDu8oeNjt12H
         u+Jx5+NC0u9WvI6nbApebItA9MFwapaDakAyPA5RHb71AYfReIp+RoY+I6sgf8a+xYDY
         zZxw==
X-Gm-Message-State: AOAM530x2Afy5JHW+kNGW+JsOWUGEjrXav9pNnAwFsfHtk9buHjrV/SK
        BumOOx/hkhSNc1inGFWHyOLvgpgM4x8=
X-Google-Smtp-Source: ABdhPJxCk9aihz5ksld5c3Ae80hSckd5BMs+phb9zPPq7eakXMKbv+QaPwccfBQ3pph9sPI9rJkucQ==
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr9590623edx.0.1645211717546;
        Fri, 18 Feb 2022 11:15:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o12sm392526ejg.105.2022.02.18.11.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:15:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL8iq-004LkN-FU;
        Fri, 18 Feb 2022 20:15:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Date:   Fri, 18 Feb 2022 20:10:07 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
Message-ID: <220218.86wnhsgf5n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Currently stash shells out to reflog in order to delete refs. In an
> effort to reduce how much we shell out to a subprocess, libify the
> functionality that stash needs into reflog.c.
>
> Add a reflog_delete function that is pretty much the logic in the while
> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
> builtin/reflog.c and builtin/stash.c can both call.
>
> Also move functions needed by reflog_delete and export them.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>

Yay! This looks great. Even though I'll need to deal with some conflicts
locally .. :)

> +int reflog_delete(const char *rev, int flags, int verbose)
> +{
> +	struct cmd_reflog_expire_cb cmd =3D { 0 };
> +	int status =3D 0;
> +	reflog_expiry_should_prune_fn *should_prune_fn =3D should_expire_reflog=
_ent;
> +	const char *spec =3D strstr(rev, "@{");
> +	char *ep, *ref;
> +	int recno;
> +	struct expire_reflog_policy_cb cb =3D {
> +		.dry_run =3D !!(flags & EXPIRE_REFLOGS_DRY_RUN),
> +	};
> +
> +	if (verbose)
> +		should_prune_fn =3D should_expire_reflog_ent_verbose;
> +
> +	if (!spec) {
> +		status |=3D error(_("not a reflog: %s"), rev);
> +	}
> +
> +	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
> +		status |=3D error(_("no reflog for '%s'"), rev);
> +	}

For these let's follow our usual style of not having braces for
single-line if's.

Buuuut in this case doing so will make the diff move detection less
useful for 1..2.

So probably best to leave it, or do some post-cleanup at the end maybe.

> +int reflog_delete(const char*, int, int);
> +void reflog_expiry_cleanup(void *);
> +void reflog_expiry_prepare(const char*, const struct object_id*,
> +			   void *);
> +int should_expire_reflog_ent(struct object_id *, struct object_id*,
> +				    const char *, timestamp_t, int,
> +				    const char *, void *);
> +int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
> +		const char *email, timestamp_t timestamp, int tz,
> +		const char *message, void *cb_data);
> +int should_expire_reflog_ent_verbose(struct object_id *,
> +				     struct object_id *,
> +				     const char *,
> +				     timestamp_t, int,
> +				     const char *, void *);
> +#endif /* REFLOG_H */

Just a style preference, but I for one prefer the style where we retain
the parameter names, it helps to read these, especially when we add API
docs here.

Some of these are mis-indented. We align with the opening "(" with "\t"
=3D 8 chars, so e.g. 2x \t + 5 SP for the count_reflog_ent() arguments
etc.
