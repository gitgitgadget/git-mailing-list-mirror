Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC7C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiAUTEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiAUTEH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:04:07 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B4C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:04:06 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k25so2602077ejp.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZAjZCTFOxJVjWCDtl0O4IGAThCZGJ+VHYD+GwrZgQys=;
        b=aViU0hwhfiLVegLkT1kbUes3JMIei1yidLdsoO5OIJBl17efE+qCtBcIAi1PzPRtjk
         UALCezC9HOolQ7PglgeunFI3wux15F6NyuS+A73baDTpvF7fylaErjnVmy5AoCxcJYbT
         lb5cNfv0dFo31BFxgSAhnfZmbHSeBjwArlsKUs/dCDSKnU2P0sBzcSGV/2GJkdEytZ8k
         wMJ/CBZLPUdzbHHBksxfs5fbf1V8D3pU8Jj7P5irVPN/K/dFuThQOs09QPoeUl4OyFI5
         xymdTzTGEwrzPfyqomfAOOZVUzLaVnx6LFUsKrAeesWQbxq4r9KgBgkikTNzTOeRdt8Z
         v1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZAjZCTFOxJVjWCDtl0O4IGAThCZGJ+VHYD+GwrZgQys=;
        b=oNbicHgUQlG5sdPADb83YPRuJvwBFuMxOQvV11xPFdHXm667gvtufONwgma//FYRSr
         hzc+dRWY4BR1CfI2lKsallcZq0N4ADpDdUHyRiv7gVLO7fKO5LMaQ1ZrCr7lNeh/tUkS
         4tq0jzekB3WpHznRYNVe5oQYafZ6vI72vzJBgnB+IoaHmUKMTxFKT++3GqbcSd9uyV5c
         Ol3uD32tNfYBfNHbxVd+IkkyCfi7GXA4wMfowqxIZckLxi9CYkWtlUzImANh56se5uR5
         MgUQA6boESEmnKJShHx1tmM49iFEu4WxYYggmRIDdGpTODD/SDTGPm7g1/LGzid3CIHp
         VB2A==
X-Gm-Message-State: AOAM5326LQ8e1+o4IlIgLkcvcglq9zvKg7AmTgufyPGjoncdE4zBWNO5
        360S+vQFMu83U0bhrV5vYQe9TOG0sATqGw==
X-Google-Smtp-Source: ABdhPJzPjTIJ856SguJmw0TNQPgT7vbIcvIB9WdoIcUgnngkk/Rg0Aoc/x0Gwq/ff+pEu7BeuXpRbg==
X-Received: by 2002:a17:907:a41f:: with SMTP id sg31mr4304759ejc.640.1642791845023;
        Fri, 21 Jan 2022 11:04:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a14sm2859391edx.96.2022.01.21.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:04:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAzCe-002Fcl-4G;
        Fri, 21 Jan 2022 20:04:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jabolopes@google.com
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
Date:   Fri, 21 Jan 2022 19:48:46 +0100
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <20220121174441.3991963-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220121174441.3991963-1-jonathantanmy@google.com>
Message-ID: <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 21 2022, Jonathan Tan wrote:

> When creating the sparse-checkout file, Git does not create the leading
> directory, "$GIT_DIR/info", if it does not exist. This causes problems
> if the repository does not have that directory. Therefore, ensure that
> the leading directory is created.
>
> This is the only "open" in builtin/sparse-checkout.c that does not have
> a leading directory check. (The other one in write_patterns_and_update()
> does.)
>
> Note that the test needs to explicitly specify a template when running
> "git init" because the default template used in the tests has the
> "info/" directory included.
>
> Helped-by: Jose Lopes <jabolopes@google.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Changes from v1:
>  - made test simpler

This partial application of the fix-up I suggested in
https://lore.kernel.org/git/220120.86mtjqks1b.gmgdl@evledraar.gmail.com/
leaves the now-unused "blank-template"

>  - added attribution to Jose Lopes for finding and making the first
>    draft of this patch (after confirming with them)
>
> =C3=86var mentioned "git sparse-checkout add" but I think that that is a
> different problem - in the "git sparse-checkout init" case, we could get
> into this case with a template that does not have .git/info, but in the
> "git sparse-checkout add" case, the user would have had to explicitly
> remove the info directory. So I'll limit this patch to the "init" case,
> for now.
> ---
>  builtin/sparse-checkout.c          | 3 +++
>  t/t1091-sparse-checkout-builtin.sh | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 679c107036..2b0e1db2d2 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -471,6 +471,9 @@ static int sparse_checkout_init(int argc, const char =
**argv)
>  		FILE *fp;
>=20=20
>  		/* assume we are in a fresh repo, but update the sparse-checkout file =
*/
> +		if (safe_create_leading_directories(sparse_filename))
> +			die(_("unable to create leading directories of %s"),
> +			    sparse_filename);
>  		fp =3D xfopen(sparse_filename, "w");
>  		if (!fp)
>  			die(_("failed to open '%s'"), sparse_filename);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index 42776984fe..3189d3da96 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -79,6 +79,12 @@ test_expect_success 'git sparse-checkout init' '
>  	check_files repo a
>  '
>=20=20
> +test_expect_success 'git sparse-checkout init in empty repo' '
> +	test_when_finished rm -rf empty-repo blank-template &&
> +	git init --template=3D empty-repo &&
> +	git -C empty-repo sparse-checkout init
> +'

I agree that it's a slightly different problem, but I was just
advocating for us testing what happened in these cases.

The below fix-up does that. I think we should use warning_errno() there
instead of some specutalite "file may not exist", but with/without this
patch these tests show that only the "init" case was broken.

As a more general issue I don't understand why "add" and "init" need to
be conceptually different operations. If what defines a sparse checkout
is just that it has that file and the 2 default patterns, which unless
I'm missing something is the case. Why isn't "add" merely an "init"
that'll optimistically add whatever pattern you asked for, in addition
to doing an "init" if you didn't already?

Then "add" and "init" will share the same error recovery behavior, and
you won't needlessly have to run "init/add x" just to start using
sparse-checkout with a pattern of "x".

But I've never *actually* used this command, so maybe I'm just missing
something obvious...

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-b=
uiltin.sh
index 3189d3da965..6b56d9d177f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -80,11 +80,37 @@ test_expect_success 'git sparse-checkout init' '
 '
=20
 test_expect_success 'git sparse-checkout init in empty repo' '
-	test_when_finished rm -rf empty-repo blank-template &&
+	test_when_finished rm -rf empty-repo &&
 	git init --template=3D empty-repo &&
 	git -C empty-repo sparse-checkout init
 '
=20
+test_expect_success 'git sparse-checkout add -- info/sparse-checkout missi=
ng' '
+	test_when_finished "rm -rf empty" &&
+	git init --template=3D empty &&
+	git -C empty sparse-checkout init &&
+	rm -rf empty/.git/info &&
+
+	cat >expect <<-\EOF &&
+	fatal: unable to load existing sparse-checkout patterns
+	EOF
+	test_expect_code 128 git -C empty sparse-checkout add bar 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git sparse-checkout list -- info/sparse-checkout miss=
ing' '
+	test_when_finished "rm -rf empty" &&
+	git init --template=3D empty &&
+	git -C empty sparse-checkout init &&
+	rm -rf empty/.git/info &&
+
+	cat >expect <<-\EOF &&
+	warning: this worktree is not sparse (sparse-checkout file may not exist)
+	EOF
+	git -C empty sparse-checkout list 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
