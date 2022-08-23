Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38D8C32793
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 23:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiHWXij (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHWXih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 19:38:37 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D67FE5B
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 16:38:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x7-20020aa79407000000b00536368f1a07so4418648pfo.13
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=qgTUPvmvv8M0wEcli2Nof0rGSj17vjHKJs7lQ6TpB68=;
        b=ZhPydcgxdUNu+GqikB9d2nnMPzbBJysT5SSeBAhjTdiJshfk4+mmNgnCusTQp10OKH
         P7g2HmFIHWn+I319vpGPrsNc0Ee4AO+nBjn7BTd2Ny7TfEZe0MtKrooyRBAmzc7Sk46l
         wpXXWLpvB0CMrRq+zHKMTzNIKXtYMqOCssg703TCVftkXuxd8YaFue7O6EFG/nS+wYyk
         F25WMrSKHwc3oQpeJbgA5UkMzcIBGbUepic8x8g5oTU4qBkSLa6Lh3fQGJDAQ9L20PwC
         aIO5jMAyl8aYl8yQVo0snJ+pQi/aSk2IbUzaMcboppUgcftIdrxiKj3cvmXnnuqcXSw6
         IBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=qgTUPvmvv8M0wEcli2Nof0rGSj17vjHKJs7lQ6TpB68=;
        b=MXXvcxUO1JksxIpi5jlpoeAd1cbgPJlpmuamo+kELgwJPoArlsWTaoZGCV6nwTBBeW
         B0BNXGtTQ4wtxi2x1g60f7i18bNLx5PHEo91c1gxuJTfvf5AFKqYRdSTMLT+TYtpBU9x
         hMBmtxNLmEfpOXSTSs9rF4t6+wUlNwdGWdB0LPLidzonptXNuSzOpIo+2hIQZ3pnFNzv
         ak1XqHetPvs4Ho1IRUjX6gLWkyYAp/ooJGGk7TwiN5/9SLdiSqTJUo1ayQwKU5k4P59h
         CN3rtp+zySXwlqnoCJDPtajaB6rRVIR9RKOSgGpkYm6LH46uAOBLJo3FwPlwnHBEFh2J
         5XFw==
X-Gm-Message-State: ACgBeo2ppr79yLf7nAbFyDi/DxSqy4BChCIg1y1SxnyUKdBIIRhzf0lN
        LTnBqc0Gz6mQy5FdMziP3Qm566Q3+x4fWg==
X-Google-Smtp-Source: AA6agR43Ca6V6KPtmhV83flHoUtjuqBKD1brAnysJBI0KE4WrdLlH7gHJAuBVwnfZGNIG8N0WXU/VqzBO2LTsg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1803:b0:536:e9a4:89d4 with SMTP
 id y3-20020a056a00180300b00536e9a489d4mr6557973pfa.28.1661297915814; Tue, 23
 Aug 2022 16:38:35 -0700 (PDT)
Date:   Tue, 23 Aug 2022 16:38:34 -0700
In-Reply-To: <patch-v3-29.32-d4b55f07a30-20220821T130231Z-avarab@gmail.com>
Message-Id: <kl6lh7224jk5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <patch-v3-29.32-d4b55f07a30-20220821T130231Z-avarab@gmail.com>
Subject: Re: [PATCH v3 29/32] submodule--helper: check repo{_submodule,}_init()
 return values
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

> Fix code added in ce125d431aa (submodule: extract path to submodule
> gitdir func, 2021-09-15) and a77c3fcb5ec (submodule--helper: get
> remote names from any repository, 2022-03-04) which failed to check
> the return values of repo_init() and repo_submodule_init(). If we
> failed to initialize the repository or submodule we could segfault
> when trying to access the invalid repository structs.

Yes, this sounds correct. repo_init() and repo_submodule_init() are pure
initialization and have no intended side effects, so there's no reason
to not check the return value.

>
> Let's also check that these were the only such logic errors in the
> codebase by making use of the "warn_unused_result" attribute. This is
> valid as of GCC 3.4.0 (and clang will catch it via its faking of
> __GNUC__ ).
>
> As the comment being added to git-compat-util.h we're piggy-backing on
> the LAST_ARG_MUST_BE_NULL version check out of lazyness. See
> 9fe3edc47f1 (Add the LAST_ARG_MUST_BE_NULL macro, 2013-07-18) for its
> addition. The marginal benefit of covering gcc 3.4.0..4.0.0 is
> near-zero (or zero) at this point. It mostly matters that we catch
> this somewhere.

I'm not familiar enough with attributes and the requistie compiler
versions, so I won't comment on this bit.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 9 +++++++--
>  git-compat-util.h           | 3 +++
>  repository.h                | 3 +++
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5f109d422ea..88fc01320f3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -63,7 +63,10 @@ static char *get_default_remote_submodule(const char *=
module_path)
>  {
>  	struct repository subrepo;
> =20
> -	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
> +	if (repo_submodule_init(&subrepo, the_repository, module_path,
> +				null_oid()) < 0)
> +		die(_("could not get a repository handle for submodule '%s'"),
> +		    module_path);
>  	return repo_get_default_remote(&subrepo);
>  }
> =20
> @@ -1483,7 +1486,9 @@ static int add_possible_reference_from_superproject=
(
>  		struct strbuf err =3D STRBUF_INIT;
>  		strbuf_add(&sb, odb->path, len);
> =20
> -		repo_init(&alternate, sb.buf, NULL);
> +		if (repo_init(&alternate, sb.buf, NULL) < 0)
> +			die(_("could not get a repository handle for gitdir '%s'"),
> +			    sb.buf);
> =20
>  		/*
>  		 * We need to end the new path with '/' to mark it as a dir,
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 36a25ae252f..01d88650ba3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -568,8 +568,11 @@ static inline int git_has_dir_sep(const char *path)
>  /* The sentinel attribute is valid from gcc version 4.0 */
>  #if defined(__GNUC__) && (__GNUC__ >=3D 4)
>  #define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
> +/* warn_unused_result exists as of gcc 3.4.0, but be lazy and check 4.0 =
*/
> +#define RESULT_MUST_BE_USED __attribute__ ((warn_unused_result))
>  #else
>  #define LAST_ARG_MUST_BE_NULL
> +#define RESULT_MUST_BE_USED
>  #endif
> =20
>  #define MAYBE_UNUSED __attribute__((__unused__))
> diff --git a/repository.h b/repository.h
> index 797f471cce9..24316ac944e 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -1,6 +1,7 @@
>  #ifndef REPOSITORY_H
>  #define REPOSITORY_H
> =20
> +#include "git-compat-util.h"
>  #include "path.h"
> =20
>  struct config_set;
> @@ -186,6 +187,7 @@ void repo_set_gitdir(struct repository *repo, const c=
har *root,
>  void repo_set_worktree(struct repository *repo, const char *path);
>  void repo_set_hash_algo(struct repository *repo, int algo);
>  void initialize_the_repository(void);
> +RESULT_MUST_BE_USED
>  int repo_init(struct repository *r, const char *gitdir, const char *work=
tree);
> =20
>  /*
> @@ -197,6 +199,7 @@ int repo_init(struct repository *r, const char *gitdi=
r, const char *worktree);
>   * Return 0 upon success and a non-zero value upon failure.
>   */
>  struct object_id;
> +RESULT_MUST_BE_USED
>  int repo_submodule_init(struct repository *subrepo,
>  			struct repository *superproject,
>  			const char *path,
> --=20
> 2.37.2.1279.g64dec4e13cf
