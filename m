Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23ABE215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeD3Wyd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:54:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38422 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeD3Wyc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:54:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id i3so16643387wmf.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NNihhm59eUYnp99dHIQeRxCxyHc/Tq6R44Kvw7DoXSw=;
        b=UUknWogy6HOm34JbcFBl2SxJ+iO43+btyAOYdkG9/ljhSXt21qKrZYCZIM+t70Nlol
         8dUcCM8fO6jHB5mGrv3phGuScxOHv2XvhglZf684okJ63Ep1ieX7z4FmJMPoMeWib2hV
         8Aepxc8yXKd+BInWRswuGplX0MpklAHxsVeZWLf3h2qpwnRuGJWF/5gTTArNFzDXjpwN
         fLIh4O4tplWsq656DO1Ec6wSMerfFEzLq90SCkpiiq3ZKpgMefAGjc5y7+2Kcj/veROO
         PNGSoj23UzZvS8ltL4QkyJbikp6T1EnSqJAbEt1mca/GTVhjxCjctTaaEWmt1ptjg230
         /ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=NNihhm59eUYnp99dHIQeRxCxyHc/Tq6R44Kvw7DoXSw=;
        b=Q2W8mOBYiploOAELvy/ZzKGy7qCJUQX0JbzCf8D+OJge6io4574HjgyepiEpPImBHl
         3SiBxL0RJ5MOJ/DEe9Ycu4xehXyqSJvqr++9rXYqgsWJgKMNOrYwLbs1nysxdLj1ID4o
         tuRtEuoClSyyE5rsalT/ekZMMXIjXk8SwUHC8NvlSdqS7Zr6KiVinZhC4l7CICkEHDHK
         LH14JQ+AVKDoYL4lMk1kPQdBMEPVCds13xm8/kfxfvg2Y319CG4LzKoyL7A45oyJNK/2
         55PxL8rpLMDOxsasoUjshoypad8k3GaUa1+jKKrkq3pHbdtJEktX562nOnnp3sRRnXJ8
         0fQQ==
X-Gm-Message-State: ALQs6tDcS/1eRgxQOkeb+V0+Ka/A4FMESiBKJHZ/cC3cGS0hiPpoSTUL
        tN0xh5XuebNmbo7zoTaDNPU=
X-Google-Smtp-Source: AB8JxZrPbyNr+U2frmx7rckwHFSxCpjn0c6234yp3cOv4oqMeL395NlfvK16gL4pKovehRIM0J7Z5w==
X-Received: by 10.28.93.202 with SMTP id r193mr8156000wmb.95.1525128871376;
        Mon, 30 Apr 2018 15:54:31 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abqa10.neoplus.adsl.tpnet.pl. [83.8.68.10])
        by smtp.gmail.com with ESMTPSA id k126sm10878510wmg.6.2018.04.30.15.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 15:54:29 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 09/10] merge: check config before loading commits
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-10-dstolee@microsoft.com>
Date:   Tue, 01 May 2018 00:54:26 +0200
In-Reply-To: <20180425143735.240183-10-dstolee@microsoft.com> (Derrick
        Stolee's message of "Wed, 25 Apr 2018 14:38:02 +0000")
Message-ID: <86po2gfgpp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Now that we use generation numbers from the commit-graph, we must
> ensure that all commits that exist in the commit-graph are loaded
> from that file instead of from the object database. Since the
> commit-graph file is only checked if core.commitGraph is true, we
> must check the default config before we load any commits.
>
> In the merge builtin, the config was checked after loading the HEAD
> commit. This was due to the use of the global 'branch' when checking
> merge-specific config settings.
>
> Move the config load to be between the initialization of 'branch' and
> the commit lookup.

Sidenote: I wonder why reading config was postponed to later in the
command lifetime... I guess it was to avoid having to read config if
HEAD was invalid.

>
> Without this change, a fast-forward merge would hit a BUG("bad
> generation skip") statement in commit.c during paint_down_to_common().
> This is because the HEAD commit would be loaded with "infinite"
> generation but then reached by commits with "finite" generation
> numbers.

I guess this is because we avoid re-parsing objects at all costs; we
want to avoid re-reading commit graph too.

>
> Add a test to t5318-commit-graph.sh that exercises this code path to
> prevent a regression.

I would prefer if this commit was put earlier in the series, to avoid
having broken Git (and thus a possibility of problems when bisecting) in
between those two commits.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/merge.c         | 7 ++++---
>  t/t5318-commit-graph.sh | 9 +++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5e5e4497e3..b819756946 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1148,14 +1148,15 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
>  	branch =3D branch_to_free =3D resolve_refdup("HEAD", 0, &head_oid, NULL=
);
>  	if (branch)
>  		skip_prefix(branch, "refs/heads/", &branch);
> +
> +	init_diff_ui_defaults();
> +	git_config(git_merge_config, NULL);
> +
>  	if (!branch || is_null_oid(&head_oid))
>  		head_commit =3D NULL;
>  	else
>  		head_commit =3D lookup_commit_or_die(&head_oid, "HEAD");
>=20=20
> -	init_diff_ui_defaults();
> -	git_config(git_merge_config, NULL);
> -

Good.

>  	if (branch_mergeoptions)
>  		parse_branch_merge_options(branch_mergeoptions);
>  	argc =3D parse_options(argc, argv, prefix, builtin_merge_options,
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index a380419b65..77d85aefe7 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -221,4 +221,13 @@ test_expect_success 'write graph in bare repo' '
>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare comm=
its/8 merge/1
>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare comm=
its/8 merge/2
>=20=20
> +test_expect_success 'perform fast-forward merge in full repo' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git checkout -b merge-5-to-8 commits/5 &&
> +	git merge commits/8 &&
> +	git show-ref -s merge-5-to-8 >output &&
> +	git show-ref -s commits/8 >expect &&
> +	test_cmp expect output
> +'

All right.  (though I wonder if this tests catches all problems where
BUG("bad generation skip") could have been encountered.

> +
>  test_done

Best,
--=20
Jakub Nar=C4=99bski
