Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A248BC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 22:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCWaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKCWaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 18:30:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D7222A7
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:30:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z15-20020a170903018f00b0018862d520fbso367419plg.11
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9jQD+GmHZaHqQkq7CdGZwRs+XA8gheN0MEN/7Iiofo=;
        b=iuUSGXdUGNF7nwWdGPh+6QtOGec/jb200uQ2IUwqimAnrcjLakVfTAaZz2yAIok9CM
         RKJvRMO6vcw5k72n31F1p5WamXmoZndDR5ESWGNECw/0cByVjGb5wCJUA1XXjfe0w6FM
         USj54ISMqptv9ZE0AsMXEO+XSH3RNfOAY3qVEX7iYLpXLr7lAahNSSydGCancXKre/RC
         OBvJNPbR4w7r21gk29tdontz7uqinq258d4Ox6t1VyvXDX4Yt7Svjf79l5Jp6sf6JYkY
         mPztGpGgFC9EJyJw0Tnbqcb9fhFODeg3ET5KJoBYz7PlLg6nLKHb5VofgA1XN+XNlAMr
         IaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9jQD+GmHZaHqQkq7CdGZwRs+XA8gheN0MEN/7Iiofo=;
        b=NBlBUV/9b1KxoChojxDlg7rf/kCsfdXCU6z2VQ2ZirWGBYa24QjFgRN0iPtdQmN+NP
         LxocAHtm8Gs+4+VE4Sq3JEi5z6KqKfOGuR0L7qokTt3FTEF8f6U5TV0QZ6a0vtnIEWo0
         u1MlOvv1t9kj8W8R6VLfXPcaje4FCXcm5DbZWn9kB57JJvtavMTITtfoY+yH66Rjh+Qe
         Jbqa/ksh4TMjQsX17XNbomAflB9vkshuP14xeztJDISyqva3JOOMILEo8VNEqPyrmBf6
         fiikOYnWLqb/8mhhM7Rc9hQ/vBMGCQ9zCqHFnoGmLDQKiQ1JCTp4/BrWQdbzP9xVPMXk
         6IUQ==
X-Gm-Message-State: ACrzQf26/kwFoUC3xkffspbmpt6ZMBm/werxH9P5+N9evmoxenP+brSu
        aJ9DOKjXd4tiZ6ay7uuFRdU7pbqLEYfdSQ==
X-Google-Smtp-Source: AMsMyM5zUBjjY8d5DYxlLKV8z50Z0fyatF4XAJ1tp5jfdnT9V7CHhCSkqzEtR5wsHbMIERuahQeg8CZJPLhxVg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4643:0:b0:437:e9f3:8add with SMTP id
 v3-20020a634643000000b00437e9f38addmr213380pgk.438.1667514617614; Thu, 03 Nov
 2022 15:30:17 -0700 (PDT)
Date:   Thu, 03 Nov 2022 15:30:16 -0700
In-Reply-To: <patch-2.8-cda36b5b6e0-20221102T074148Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <patch-2.8-cda36b5b6e0-20221102T074148Z-avarab@gmail.com>
Message-ID: <kl6lcza3oemf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/8] submodule tests: add tests for top-level flag output
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Exhaustively test for how combining various "mixed-level" "git
> submodule" option works. "Mixed-level" here means options that are
> accepted by a mixture of the top-level "submodule" command, and
> e.g. the "status" sub-command.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t7400-submodule-basic.sh  |  10 +++
>  t/t7422-submodule-output.sh | 169 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
>  create mode 100755 t/t7422-submodule-output.sh
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index a989aafaf57..eae6a46ef3d 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -579,6 +579,16 @@ test_expect_success 'status should be "modified" aft=
er submodule commit' '
>  	grep "^+$rev2" list
>  '
> =20
> +test_expect_success '"submodule --cached" command forms should be identi=
cal' '
> +	git submodule status --cached >expect &&
> +
> +	git submodule --cached >actual &&
> +	test_cmp expect actual &&
> +
> +	git submodule --cached status >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'the --cached sha1 should be rev1' '
>  	git submodule --cached status >list &&
>  	grep "^+$rev1" list
> diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
> new file mode 100755
> index 00000000000..3ac56c23f72
> --- /dev/null
> +++ b/t/t7422-submodule-output.sh
> @@ -0,0 +1,169 @@
> +#!/bin/sh
> +
> +test_description=3D'submodule --cached, --quiet etc. output'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-t3100.sh
> +
> +setup_sub () {
> +	local d=3D"$1" &&
> +	shift &&
> +	git $@ clone . "$d" &&
> +	git $@ submodule add ./"$d"
> +}
> +
> +normalize_status () {
> +	sed -e 's/-g[0-9a-f]*/-gHASH/'
> +}
> +
> +test_expect_success 'setup' '
> +	test_commit A &&
> +	test_commit B &&
> +	setup_sub S  &&
> +	setup_sub S.D &&
> +	setup_sub S.C &&
> +	setup_sub S.C.D &&
> +	setup_sub X &&
> +	git add S* &&
> +	test_commit C &&
> +
> +	# recursive in X/
> +	git -C X pull &&
> +	GIT_ALLOW_PROTOCOL=3Dfile git -C X submodule update --init &&
> +
> +	# dirty p
> +	for d in S.D X/S.D
> +	do
> +		echo dirty >S.D/A.t || return 1
> +	done &&

I think this was meant to be replaced by the loop labelled # dirty ?
This doesn't look like it will work, e.g. $d isn't used.

> +
> +	# commit (for --cached)
> +	for d in S.C* X/S.C*
> +	do
> +		git -C "$d" reset --hard A || return 1
> +	done &&
> +
> +	# dirty
> +	for d in S*.D X/S*.D
> +	do
> +		echo dirty >"$d/C2.t" || return 1
> +	done &&
> +
> +	for ref in A B C
> +	do
> +		# Not different with SHA-1 and SHA-256, just (ab)usign
> +		# test_oid_cache as a variable bag to avoid using
> +		# $(git rev-parse ...).
> +		oid=3D$(git rev-parse $ref) &&
> +		test_oid_cache <<-EOF || return 1
> +		$ref sha1:$oid
> +		$ref sha256:$oid
> +		EOF
> +	done
> +'
> +
> +for opts in "" "status"
> +do
> +	test_expect_success "git submodule $opts" '
> +		sed -e "s/^>//" >expect <<-EOF &&
> +		> $(test_oid B) S (B)
> +		>+$(test_oid A) S.C (A)
> +		>+$(test_oid A) S.C.D (A)
> +		> $(test_oid B) S.D (B)
> +		>+$(test_oid C) X (C)
> +		EOF
> +		git submodule $opts >actual.raw &&
> +		normalize_status <actual.raw >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
> +for opts in \
> +	"status --recursive"

We don't test "--recursive status" or "--recursive" because we don't
parse the top level "--recursive" flag, right?

> +do
> +	test_expect_success "git submodule $opts" '
> +		sed -e "s/^>//" >expect <<-EOF &&
> +		> $(test_oid B) S (B)
> +		>+$(test_oid A) S.C (A)
> +		>+$(test_oid A) S.C.D (A)
> +		> $(test_oid B) S.D (B)
> +		>+$(test_oid C) X (C)
> +		> $(test_oid B) X/S (B)
> +		>+$(test_oid A) X/S.C (A)
> +		>+$(test_oid A) X/S.C.D (A)
> +		> $(test_oid B) X/S.D (B)
> +		> $(test_oid B) X/X (B)
> +		EOF
> +		git submodule $opts >actual.raw &&
> +		normalize_status <actual.raw >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
> +for opts in \
> +	"--quiet" \
> +	"--quiet status" \
> +	"status --quiet"
> +do
> +	test_expect_success "git submodule $opts" '
> +		git submodule $opts >out &&
> +		test_must_be_empty out
> +	'
> +done
> +
> +for opts in \
> +	"--cached" \
> +	"--cached status" \
> +	"status --cached"
> +do
> +	test_expect_success "git submodule $opts" '
> +		sed -e "s/^>//" >expect <<-EOF &&
> +		> $(test_oid B) S (B)
> +		>+$(test_oid B) S.C (B)
> +		>+$(test_oid B) S.C.D (B)
> +		> $(test_oid B) S.D (B)
> +		>+$(test_oid B) X (B)
> +		EOF
> +		git submodule $opts >actual.raw &&
> +		normalize_status <actual.raw >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
> +for opts in \
> +	"--cached --quiet" \
> +	"--cached --quiet status" \
> +	"--cached status --quiet" \
> +	"--quiet status --cached" \
> +	"status --cached --quiet"
> +do
> +	test_expect_success "git submodule $opts" '
> +		git submodule $opts >out &&
> +		test_must_be_empty out
> +	'
> +done
> +
> +for opts in \
> +	"status --cached --recursive" \
> +	"--cached status --recursive"
> +do
> +	test_expect_success "git submodule $opts" '
> +		sed -e "s/^>//" >expect <<-EOF &&
> +		> $(test_oid B) S (B)
> +		>+$(test_oid B) S.C (B)
> +		>+$(test_oid B) S.C.D (B)
> +		> $(test_oid B) S.D (B)
> +		>+$(test_oid B) X (B)
> +		> $(test_oid B) X/S (B)
> +		>+$(test_oid B) X/S.C (B)
> +		>+$(test_oid B) X/S.C.D (B)
> +		> $(test_oid B) X/S.D (B)
> +		> $(test_oid B) X/X (B)
> +		EOF
> +		git submodule $opts >actual.raw &&
> +		normalize_status <actual.raw >actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
> +test_done
> --=20
> 2.38.0.1280.g8136eb6fab2
