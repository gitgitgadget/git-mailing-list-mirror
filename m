Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96793C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347121AbiDRRgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241994AbiDRRgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:36:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C492E9F6
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:33:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u18so18227210eda.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xU+Ms2S6xdHuOIszDxVf3l+qtsMbXkKY65H5CX6m2l0=;
        b=UoeRU6ZgVvDAq+Ioo7ukjopBYznELU/9i3i4tKVty1dXkO02FFyVbzyZiOCfKjwCzF
         gdL15m4LSJp4wOohuxA038J7zNOPeFgEj/pJQ210f++cpJ3DlgIaE+5vbTsCw6l7ZTCe
         En4YdQJ9D+R9RQVfjgCyqn25fXq34zue/c2ClrtJatOgkhiIVJf2bbqDf+hkRJlWdE5t
         +9nUAZSTJrEqKIWlQq4KO4/uQz0kbzrcreLFNVKALa9gOv7ZrYVCy2NsXmisFtjF8AFs
         Qon/6xe/HAyIMxNhC0QU2UF8Z+aqwzyH9o9ePfO/MBbKGij7uh/9ZnbLrmzlfj3OjiBO
         jCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xU+Ms2S6xdHuOIszDxVf3l+qtsMbXkKY65H5CX6m2l0=;
        b=rBjlemAI2TcPG9sk+E6JBkcpoEiAu9MY/xeQQ40qNM59FOrSupzI7F3OLeN7l2Ru/a
         2+9r/x/VDO50oNrg3avgyArijTOYze4hrH1T/K96hL/5BhqR8jEhZuOPo4Py2lAqLIFk
         SiA3bZt64/lYU36gEn2nclpepbowt45Mj3oQ6f9hN0NlnNUQxQNF3pGyBFrT7Ubs7H0w
         MMr01hP2EnwlTWGvmti2CIH0O3f7Q+88IBRXKTw2duixCUj2Osjrp1/wFH2emUkcUR5W
         Rlp7qD2qSttzZqjV7YXyKWokIb2csSVsoCakudyEJqIlkNzgHGL3FTQDO+fWwgSIJNKl
         XvTQ==
X-Gm-Message-State: AOAM531FnmHK/YlanpMOVySPz8YPloUE69Esk38JLucLn6plP3dRgA8o
        nNE9ifHKxWC6xkG1ZehwQko=
X-Google-Smtp-Source: ABdhPJyk6N5mXA4sSiNr9gcNUWtRWpQDL4CvPhZ7onJkZuq28iy4R/iNtk/oVESqquRXKJ+3fKKGEQ==
X-Received: by 2002:a05:6402:298b:b0:41d:675f:8b44 with SMTP id eq11-20020a056402298b00b0041d675f8b44mr13181657edb.377.1650303210179;
        Mon, 18 Apr 2022 10:33:30 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm7248515edt.89.2022.04.18.10.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:33:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ngVFg-006jRL-Uk;
        Mon, 18 Apr 2022 19:33:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] clone: ignore invalid local refs in remote
Date:   Mon, 18 Apr 2022 19:30:35 +0200
References: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
Message-ID: <220418.86zgki8ffb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 18 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When cloning directly from a local repository, we load a list of refs
> based on scanning the $GIT_DIR/refs/ directory of the "server"
> repository. If files exist in that directory that do not parse as
> hexadecimal hashes, then the ref array used by write_remote_refs()
> ends up with some entries with null OIDs. This causes us to hit a BUG()
> statement in ref_transaction_create():
>
>   BUG: create called without valid new_oid
>
> This BUG() call used to be a die() until 033abf97f (Replace all
> die("BUG: ...") calls by BUG() ones, 2018-05-02). Before that, the die()
> was added by f04c5b552 (ref_transaction_create(): check that new_sha1 is
> valid, 2015-02-17).
>
> The original report for this bug [1] mentioned that this problem did not
> exist in Git 2.27.0. The failure bisects unsurprisingly to 968f12fda
> (refs: turn on GIT_REF_PARANOIA by default, 2021-09-24). When
> GIT_REF_PARANOIA is enabled, this case always fails as far back as I am
> able to successfully compile and test the Git codebase.
>
> [1] https://github.com/git-for-windows/git/issues/3781
>
> There are two approaches to consider here. One would be to remove this
> BUG() statement in favor of returning with an error. There are only two
> callers to ref_transaction_create(), so this would have a limited
> impact.
>
> The other approach would be to add special casing in 'git clone' to
> avoid this faulty input to the method.
>
> While I originally started with changing 'git clone', I decided that
> modifying ref_transaction_create() was a more complete solution. This
> prevents failing with a BUG() statement when we already have a good way
> to report an error (including a reason for that error) within the
> method. Both callers properly check the return value and die() with the
> error message, so this is an appropriate direction.
>
> The added test helps check against a regression, but does check that our
> intended error message is handled correctly.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     clone: ignore invalid local refs in remote
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1214%2Fderrickstolee%2Frefs-bug-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1214/derrickstolee/refs-bug-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1214
>
>  refs.c                 | 6 ++++--
>  t/t5605-clone-local.sh | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 1a964505f92..f300f83e4d4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1111,8 +1111,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	if (!new_oid || is_null_oid(new_oid))
> -		BUG("create called without valid new_oid");
> +	if (!new_oid || is_null_oid(new_oid)) {
> +		strbuf_addf(err, "'%s' has a null OID", refname);
> +		return 1;
> +	}
>  	return ref_transaction_update(transaction, refname, new_oid,
>  				      null_oid(), flags, msg, err);
>  }
> diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
> index 7d63365f93a..21ab6192839 100755
> --- a/t/t5605-clone-local.sh
> +++ b/t/t5605-clone-local.sh
> @@ -141,4 +141,13 @@ test_expect_success 'cloning locally respects "-u" for fetching refs' '
>  	test_must_fail git clone --bare -u false a should_not_work.git
>  '
>  
> +test_expect_success 'local clone from repo with corrupt refs fails gracefully' '
> +	git init corrupt &&
> +	test_commit -C corrupt one &&
> +	echo a >corrupt/.git/refs/heads/topic &&
> +
> +	test_must_fail git clone corrupt working 2>err &&
> +	grep "has a null OID" err
> +'
> +
>  test_done
>
> base-commit: 11cfe552610386954886543f5de87dcc49ad5735

If I change this test to clone from "$PWD/corrupt" instead we get as far
as dying in "not our ref" in upload-pack", after the "client" said "want
0000....".

I don't see anything wrong with this narrow fix, but I wonder how close
we are to just doing something useful here for the user. I.e. if we
can't parse_object() what we're about to "copy" to e.g. error() on that,
but carry on cloning the rest if possible.

We should probably always return a non-zero at the end, suggesting the
user omit the bad ref with a refspec. But if we did all that we could
usefully recover partially corrupt-repos in this state...
