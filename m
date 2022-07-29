Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA690C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiG2VbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiG2VbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:31:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887362CCB6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:31:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r6-20020a17090a2e8600b001f0768a1af1so4859811pjd.8
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=fY1qBM10muawTGVmjcmYGNy3HZ+ji8I4xo0MGUN9NO4=;
        b=hh5gcDkqpK0eO5bOHaDQgl8Eob8LLWLOGPjEPsprHETw+xMFxssF5ZTJdvsrH6AYvj
         l2iYC0YfOjMqiwkxJD7fQ2CkN/WWeEEGi3sdW1iYcWhnJItiGBMMfUhpOwgMwVSQ6g2p
         ScFqZagjIbhrVSsDWrYJRlnD78x5cQDacaVrLkDoGptn6eS9ae5km8xpkImVxlgtz3K6
         Nfgx4HIMWD1ZiU7pQi6WQpk/ICtt8HXRkaaA+ZyY0Egf6fk0RbdX1sz28ZiFZIcPopJe
         L+M4MKUQeqVUA1dAqIGmrMqpXrUplDE4Mak7VMc0j5PD8YP09PNFLdbXPjbaBVrssFD4
         +uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=fY1qBM10muawTGVmjcmYGNy3HZ+ji8I4xo0MGUN9NO4=;
        b=8F/kvvm/zO75LTjGEBrJzC0GYXpXm6+cofADQT48okzCmJvXVBLDlnQv3vfLkUa1Sb
         jQqPspUCC4tAP8KE+dVY95bEOAS7q/89qy1FaRd0TIKIGLju0TYowYiqhCc7p+FAibHf
         RDkT6JHCrhq/L7aaSIW5YQLKSrXFlhbpEpd5jzl+hTbtpHj/TL6gWdBcDRtehH9TLZoz
         woalYLriN5vliFJ787ZlimvSBJQh6H2TNX7VtHePD5CBgE7yv6bHcLQQAMmO7VCa9Ptw
         tU+/JHt5LfdYcYmV1MHddc3PenI36TCduazVLLblp3VGx3QXklVjcrWR2n7Ib7heDzxv
         CI5w==
X-Gm-Message-State: AJIora8njTTTiseuebCTYVqhddZyuVgGggG1unZIwdZzs8xoLrD8RLVt
        9jXW8tODZ3LDeIXrtnzCSiwCKX3DPceS7A==
X-Google-Smtp-Source: AGRyM1uZO5s4Av7rU4SzL5OmIQ2ZFKq8i7XULdUej4dPnaT9PFaf2avOFwpnNaBghhEU6/EWkAmv73WtpyyjWA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:188e:b0:52a:af7f:e715 with SMTP
 id x14-20020a056a00188e00b0052aaf7fe715mr5320506pfh.2.1659130269617; Fri, 29
 Jul 2022 14:31:09 -0700 (PDT)
Date:   Fri, 29 Jul 2022 14:31:00 -0700
In-Reply-To: <patch-04.20-27df2efe718-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6ly1wbr4h7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-04.20-27df2efe718-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 04/20] submodule--helper: remove unused "list" helper
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

> Remove the "submodule--helper list" sub-command, which hasn't been
> used by git-submodule.sh since 2964d6e5e1e (submodule: port subcommand
> 'set-branch' from shell to C, 2020-06-02).
>
> There was a test added in 2b56bb7a87a (submodule helper list: respect
> correct path prefix, 2016-02-24) which relied on it, but the right
> thing to do here is to delete that test as well.
>
> That test was regression testing the "list" subcommand itself. We're
> not getting anything useful from the "list | cut -f2" invocation that
> we couldn't get from "foreach 'echo $sm_path'".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 40 -------------------------------------
>  t/t7400-submodule-basic.sh  | 25 -----------------------
>  2 files changed, 65 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ac2553ba9d3..47ed24c6a60 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -266,45 +266,6 @@ static char *get_up_path(const char *path)
>  	return strbuf_detach(&sb, NULL);
>  }
> =20
> -static int module_list(int argc, const char **argv, const char *prefix)
> -{
> -	int i;
> -	struct pathspec pathspec;
> -	struct module_list list =3D MODULE_LIST_INIT;
> -
> -	struct option module_list_options[] =3D {
> -		OPT_STRING(0, "prefix", &prefix,
> -			   N_("path"),
> -			   N_("alternative anchor for relative paths")),
> -		OPT_END()
> -	};
> -
> -	const char *const git_submodule_helper_usage[] =3D {
> -		N_("git submodule--helper list [--prefix=3D<path>] [<path>...]"),
> -		NULL
> -	};
> -
> -	argc =3D parse_options(argc, argv, prefix, module_list_options,
> -			     git_submodule_helper_usage, 0);
> -
> -	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> -		return 1;
> -
> -	for (i =3D 0; i < list.nr; i++) {
> -		const struct cache_entry *ce =3D list.entries[i];
> -
> -		if (ce_stage(ce))
> -			printf("%06o %s U\t", ce->ce_mode,
> -			       oid_to_hex(null_oid()));
> -		else
> -			printf("%06o %s %d\t", ce->ce_mode,
> -			       oid_to_hex(&ce->oid), ce_stage(ce));
> -
> -		fprintf(stdout, "%s\n", ce->name);
> -	}
> -	return 0;
> -}
> -

Hooray for nuking dead code! Thanks :)

I'm happy that we're taking a sh -> C path that's catching little things
like this.

>  static void for_each_listed_submodule(const struct module_list *list,
>  				      each_submodule_fn fn, void *cb_data)
>  {
> @@ -3340,7 +3301,6 @@ struct cmd_struct {
>  };
> =20
>  static struct cmd_struct commands[] =3D {
> -	{"list", module_list, 0},
>  	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
>  	{"add", module_add, 0},
>  	{"update", module_update, SUPPORT_SUPER_PREFIX},
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 6a77d817a82..b50db3f1031 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1255,31 +1255,6 @@ test_expect_success 'submodule add clone shallow s=
ubmodule' '
>  	)
>  '
> =20
> -test_expect_success 'submodule helper list is not confused by common pre=
fixes' '
> -	mkdir -p dir1/b &&
> -	(
> -		cd dir1/b &&
> -		git init &&
> -		echo hi >testfile2 &&
> -		git add . &&
> -		git commit -m "test1"
> -	) &&
> -	mkdir -p dir2/b &&
> -	(
> -		cd dir2/b &&
> -		git init &&
> -		echo hello >testfile1 &&
> -		git add .  &&
> -		git commit -m "test2"
> -	) &&
> -	git submodule add /dir1/b dir1/b &&
> -	git submodule add /dir2/b dir2/b &&
> -	git commit -m "first submodule commit" &&
> -	git submodule--helper list dir1/b | cut -f 2 >actual &&
> -	echo "dir1/b" >expect &&
> -	test_cmp expect actual
> -'
> -
>  test_expect_success 'setup superproject with submodules' '
>  	git init sub1 &&
>  	test_commit -C sub1 test &&
> --=20
> 2.37.1.1167.g38fda70d8c4
