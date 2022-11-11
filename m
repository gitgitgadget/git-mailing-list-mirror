Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401D0C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 00:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKKAMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKAMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 19:12:14 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9592F2612C
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 16:12:13 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id v10-20020a17090a7c0a00b00215deac75b4so1888730pjf.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 16:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29NdwCTH/6TajoJtuv54CjI+vZql0d/hOoygLiexOvs=;
        b=UQwzYzhKJV17SaroCB/jGfQO48Vs/muis2lWzhJqqqroUst2vDwXiG2pbUvJppOrF0
         TlzuPTL0vcBca7gqRZlHAIYVcOSoi913VVfYO6lTfq1Kuv6jdVIMka9EarfB/u0kbMP9
         JDtoDEoScuVgKEqNXsDKYHtBKH7Dm+/1lrhSGIjtr6PHGmb8iVGLItoElrnH3XyIkvR3
         7X0Ne0ByBS2Np7aPnDEDr8l5RX1DPdjopJw/6UJJRMgJLtS/oCkASS0YV1hoyCLD9vxK
         caG/s82QrJSr27W3tFG1gcQYY1OH1AGYb8u2W8gQgNNBuY4KE861upcIxv1maY3djtsu
         xFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=29NdwCTH/6TajoJtuv54CjI+vZql0d/hOoygLiexOvs=;
        b=i23sd2LpFHu3ijntZAS6K4WfOROkjsQXO8V5G5QVmvQUXZmp3emfXgRD2/mI8UxiAq
         eWEG9RrYPodtdVFtrWK7TUwqbZRtGIwXlNa4SOclboadjEHdoyze8S+EnM+QUlUk9eZC
         vaGvMRM68gHRoYhEUNG3f9+mGMGcNBDKdfhN3DCnfm++56Tj9LsBjHfqbtQSqbSTrF0s
         O9Y4WfgzpeSSFrE3hiQv6tW+LIIOVl7EkAkGbiD+K/UnrbNYe5Yn5WZn1My44ZLdkdi7
         si3Ggg8y9sVShfZeixGmG4/C668/ljMezgpy6JEAdr+j0o7e3GpB8Mmq2Asb1pQIpEHm
         PTgQ==
X-Gm-Message-State: ACrzQf20q97MqEieKGeYzMNAzDMPERm4Ax24J6++g2131MIoneSGCRFG
        vfgmUDmXRZhL4vhxXNteDnB1bXCb87IW5A==
X-Google-Smtp-Source: AMsMyM4QILXrQBO+8voOBd7qjwmUR1kH8vr97HE9YvKceEIwJM8Nc/5OaOGXkzLCwjhrR6tOibxMEQKWUev2GQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:10c4:b0:56b:f16d:4997 with SMTP
 id d4-20020a056a0010c400b0056bf16d4997mr4111424pfu.49.1668125533051; Thu, 10
 Nov 2022 16:12:13 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:12:11 -0800
In-Reply-To: <RFC-patch-1.8-ad0356b596f-20221109T192315Z-avarab@gmail.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <RFC-patch-1.8-ad0356b596f-20221109T192315Z-avarab@gmail.com>
Message-ID: <kl6ledua2vtw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 1/8] submodule--helper: don't use global
 --super-prefix in "absorbgitdirs"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But in the case of "absorbgitdirs" it only needed "--super-prefix" to
> invoke itself recursively, and we'd never have another "in-between"
> process in the chain. So we didn't need the bigger hammer of "git
> --super-prefix", and the "setenv(GIT_SUPER_PREFIX_ENVIRONMENT, ...)"
> that it entails.

I also thought this was the case, but in the proces of reviewing this, I
I'm not sure any more. More below..

> Eventually (as with all other "--super-prefix" users) we'll want to
> clean this code up so that this all happens in-process. I.e. needing
> any variant of "--super-prefix" is itself a hack around our various
> global state, and implicit reliance on "the_repository". This stepping
> stone makes such an eventual change easier, as we'll need to deal with
> less global state at that point.

Yes, I 100% agree. I am not optimistic that we can clean all of these up
any time soon, but I can buy the argument that we will have to remove
the extra global state at some point, so we should just bite the bullet
now.

> diff --git a/parse-options.h b/parse-options.h
> index b6ef86e0d15..50d852f2991 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -369,6 +369,10 @@ int parse_opt_tracking_mode(const struct option *, c=
onst char *, int);
>  	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
>  	  N_("use <n> digits to display object names"),	\
>  	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
> +#define OPT__SUPER_PREFIX(var) \
> +	OPT_STRING_F(0, "super-prefix", (var), N_("prefix"), \
> +		N_("prefixed path to initial superproject"), PARSE_OPT_HIDDEN)
> +
>  #define OPT__COLOR(var, h) \
>  	OPT_COLOR_FLAG(0, "color", (var), (h))
>  #define OPT_COLUMN(s, l, v, h) \
> diff --git a/submodule.c b/submodule.c
> index c47358097fd..d9fd0af81b6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2268,7 +2268,8 @@ int validate_submodule_git_dir(char *git_dir, const=
 char *submodule_name)
>   * Embeds a single submodules git directory into the superprojects git d=
ir,
>   * non recursively.
>   */
> -static void relocate_single_git_dir_into_superproject(const char *path)
> +static void relocate_single_git_dir_into_superproject(const char *path,
> +						      const char *super_prefix)
>  {
>  	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_git_d=
ir =3D NULL;
>  	struct strbuf new_gitdir =3D STRBUF_INIT;
> @@ -2302,7 +2303,7 @@ static void relocate_single_git_dir_into_superproje=
ct(const char *path)
>  	       real_old_git_dir[off] =3D=3D real_new_git_dir[off])
>  		off++;
>  	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\=
n"),
> -		get_super_prefix_or_empty(), path,
> +		(super_prefix ? super_prefix : ""), path,
>  		real_old_git_dir + off, real_new_git_dir + off);
> =20
>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);

When this gets cleaned up post-RFC, I think we should have
OPT__SUPER_PREFIX handle this "default to empty" behavior for us.

> diff --git a/submodule.h b/submodule.h
> index b52a4ff1e73..e5ee13fb06a 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -164,7 +164,12 @@ void submodule_unset_core_worktree(const struct subm=
odule *sub);
>   */
>  void prepare_submodule_repo_env(struct strvec *env);
> =20
> -void absorb_git_dir_into_superproject(const char *path);
> +void absorb_git_dir_into_superproject_sp(const char *path,
> +					 const char *super_prefix);
> +static inline void absorb_git_dir_into_superproject(const char *path)
> +{
> +	absorb_git_dir_into_superproject_sp(path, NULL);
> +}

Since absorb_git_dir_into_superproject() is called by
submodule_move_head() (the function that handles submodule changes in
unpack_trees()), it can be called from "git read-tree".

So we really do end up mixing the different values of --super-prefix;
invoking "absorbgitdirs" directly would print the relative path from
cwd, but invoking it indirectly via "read-tree" would print the path
from the root of the superproject tree. I guess that result makes sense,
since "read-tree" and friends print paths from the root of the tree, but
it feels a bit odd.

I'll propose a test for this after I finish reading through the series.
To avoid masking this behavior, I think we'll have to avoid going down
the *_sp() path and just plumb super_prefix everywhere.

> =20
>  /*
>   * Return the absolute path of the working tree of the superproject, whi=
ch this
> --=20
> 2.38.0.1467.g709fbdff1a9
