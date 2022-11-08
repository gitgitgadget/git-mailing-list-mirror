Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92440C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiKHSak (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKHSah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:30:37 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36DF54B21
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:30:36 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z15-20020a170903018f00b0018862d520fbso9978820plg.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSkibm1gVzWNfWJFKtwcFJ62hM+S5x48KJ72E9Qs+KQ=;
        b=r9iKBAX0OS32Myd8hs5iS67DJhLM3E6cqwSUSIgm08mdNbOyJSzk+YzQzQEZ2OBZ1y
         KVDZKIJPdqO5Hn7/mjIb9q2f7mwgz6XjVF2ZYN2Nio5xCb8uFzglQbu/49V6hZQIVWdE
         /tRaPKBZH0MCXaBo0xcv59n14ju8W75pZa5jVt3jtOYXhOKhJ4nJNufkPp3N6XmuGKWp
         Qc/6Cj50W9QmWd40LUz7oZ66AYmP6idDqE5jLxG43Buf4cjW6A1HxsUBkK8G9Gn7MfvV
         BVK2TZg0WymE7AtLH3hoJuITGlEdrbSXgtyuhFy54gChGlg/JEwo4lC+uzV5SnvXBqxj
         4Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XSkibm1gVzWNfWJFKtwcFJ62hM+S5x48KJ72E9Qs+KQ=;
        b=JmST0sKpAMyVHmo0wrH5k8oSjLTgv4jehPHcsvZfyVmqplqZ3qDrdtNxPnhPOoWXzo
         hPFZM+geyMTaxLkODz1AvLJFJwMq79ZHnzD0l5nSfvmOmXiCuGOyRYrHNTGTF5wOxc5s
         3eAdw59nPIfHwSVMcmfNx4E4VlFax3uxNNKZ2mbbsetzjCiVUo1EORA4zb1bhHIYprIe
         lRsVxVjWazj+5c/uA+dF4yyPoWv3e1exsFOifBNsP13d2a57+h0kcWcP3TC289yaL968
         sUUdSp1dT2yLvA4t6T8lLxxxJaXmSw+kRdcY9HV2KqGHwuXoyOxGJU8mBnvwNhroUp3c
         WGGA==
X-Gm-Message-State: ACrzQf2ugf6c0dWkte9wFjfnUg3AoiEDff9NPC22nlpou2ymAqmGYjbh
        7CcFstgfrSg+RgpX6yRkHjx3IB5nuLJ+sA==
X-Google-Smtp-Source: AMsMyM4akl52mYj4ZZp1KEsYI16jtnsYZDVtVA2NW+jrwBVMRlZ2zwObvnbki5K3rnPHKzJ3ggxZ6YAuQmeUfA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4585:b0:213:d08f:a483 with SMTP
 id v5-20020a17090a458500b00213d08fa483mr1001102pjg.21.1667932236130; Tue, 08
 Nov 2022 10:30:36 -0800 (PST)
Date:   Tue, 08 Nov 2022 10:30:34 -0800
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
Message-ID: <kl6lh6z947ud.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 0/9] submodule: tests, cleanup to prepare for built-in
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

> Changes since v1:
>
> * Noted the history of when "submodule--helper config" was last used,
>   per Glen's comment.
> * Re-titled the tests htat no longer use the now-removed
>   "submodule--helper config", per Glen's comment.
> * I removed _() from a string in what's left of "submodule--helper
>   config", which is now a test helper. We should not be translating
>   test helper strings.
> * Fixed a buggy for-loop in the t7422-submodule-output.sh test I'm
>   adding.
> * Fixed a trivial typo in a comment in that test & in another nearby
>   comment.
>

[...]

> Range-diff against v1:
>  1:  b2649f96715 !  1:  ca8f8b4bf63 submodule--helper: move "config" to a=
 test-tool
>     @@ Commit message
>          'ab/submodule-helper-prep', 2022-09-13) the "config" sub-command=
 was
>          only used by our own tests.
>     =20
>     +    It was last used by "git submodule" itself in code that went awa=
y with
>     +    a6226fd772b (submodule--helper: convert the bulk of cmd_add() to=
 C,
>     +    2021-08-10).
>     +
>          Let's move it over, and while doing so make it easier to reason =
about
>          by splitting up the various uses for it into separate sub-comman=
ds, so
>          that we don't need to count arguments to see what it does.
>     =20
>     +    This also has the advantage that we stop wasting future translat=
or
>     +    time on this command, currently the usage information for this
>     +    internal-only tool has been translated into several languages. T=
he use
>     +    of the "_" function has also been removed from the "please make
>     +    sure..." message.
>     +
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>     =20
>       ## builtin/submodule--helper.c ##
>     @@ t/helper/test-submodule.c: static int cmd__submodule_resolve_relat=
ive_url(int ar
>      +	/* Equivalent to ACTION_SET in builtin/config.c */
>      +	if (argc =3D=3D 3) {
>      +		if (!is_writing_gitmodules_ok())
>     -+			die(_("please make sure that the .gitmodules file is in the work=
ing tree"));
>     ++			die("please make sure that the .gitmodules file is in the workin=
g tree");
>      +
>      +		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
>      +	}
>     @@ t/helper/test-submodule.c: static int cmd__submodule_resolve_relat=
ive_url(int ar
>      +
>      +	if (argc =3D=3D 2) {
>      +		if (!is_writing_gitmodules_ok())
>     -+			die(_("please make sure that the .gitmodules file is in the work=
ing tree"));
>     ++			die("please make sure that the .gitmodules file is in the workin=
g tree");
>      +		return config_set_in_gitmodules_file_gently(argv[1], NULL);
>      +	}
>      +	usage_with_options(usage, options);
>     @@ t/helper/test-submodule.c: static int cmd__submodule_resolve_relat=
ive_url(int ar
>     =20
>       ## t/t7411-submodule-config.sh ##
>      @@ t/t7411-submodule-config.sh: test_expect_success 'error in histor=
y in fetchrecursesubmodule lets continue' '
>     - test_expect_success 'reading submodules config from the working tre=
e with "submodule--helper config"' '
>     + 	)
>     + '
>     +=20
>     +-test_expect_success 'reading submodules config from the working tre=
e with "submodule--helper config"' '
>     ++test_expect_success 'reading submodules config from the working tre=
e' '
>       	(cd super &&
>       		echo "../submodule" >expect &&
>      -		git submodule--helper config submodule.submodule.url >actual &&
>     @@ t/t7411-submodule-config.sh: test_expect_success 'error in history=
 in fetchrecur
>       	)
>       '
>      =20
>     - test_expect_success 'unsetting submodules config from the working t=
ree with "submodule--helper config --unset"' '
>     +-test_expect_success 'unsetting submodules config from the working t=
ree with "submodule--helper config --unset"' '
>     ++test_expect_success 'unsetting submodules config from the working t=
ree' '
>       	(cd super &&
>      -		git submodule--helper config --unset submodule.submodule.url &&
>      -		git submodule--helper config submodule.submodule.url >actual &&
>     @@ t/t7411-submodule-config.sh: test_expect_success 'error in history=
 in fetchrecur
>       		test_must_be_empty actual
>       	)
>       '
>     -@@ t/t7411-submodule-config.sh: test_expect_success 'unsetting submo=
dules config from the working tree with "sub
>     - test_expect_success 'writing submodules config with "submodule--hel=
per config"' '
>     +=20
>     +=20
>     +-test_expect_success 'writing submodules config with "submodule--hel=
per config"' '
>     ++test_expect_success 'writing submodules config' '
>       	(cd super &&
>       		echo "new_url" >expect &&
>      -		git submodule--helper config submodule.submodule.url "new_url" &&
>     @@ t/t7411-submodule-config.sh: test_expect_success 'unsetting submod=
ules config fr
>       		test_cmp expect actual
>       	)
>       '
>     -@@ t/t7411-submodule-config.sh: test_expect_success 'overwriting uns=
taged submodules config with "submodule--hel
>     +=20
>     +-test_expect_success 'overwriting unstaged submodules config with "s=
ubmodule--helper config"' '
>     ++test_expect_success 'overwriting unstaged submodules config' '
>       	test_when_finished "git -C super checkout .gitmodules" &&
>       	(cd super &&
>       		echo "newer_url" >expect &&
>  2:  cda36b5b6e0 !  2:  5508c27f653 submodule tests: add tests for top-le=
vel flag output
>     @@ t/t7422-submodule-output.sh (new)
>      +	git -C X pull &&
>      +	GIT_ALLOW_PROTOCOL=3Dfile git -C X submodule update --init &&
>      +
>     -+	# dirty p
>     ++	# dirty
>      +	for d in S.D X/S.D
>      +	do
>     -+		echo dirty >S.D/A.t || return 1
>     ++		echo dirty >"$d"/A.t || return 1
>      +	done &&
>      +
>      +	# commit (for --cached)
>     @@ t/t7422-submodule-output.sh (new)
>      +
>      +	for ref in A B C
>      +	do
>     -+		# Not different with SHA-1 and SHA-256, just (ab)usign
>     ++		# Not different with SHA-1 and SHA-256, just (ab)using
>      +		# test_oid_cache as a variable bag to avoid using
>      +		# $(git rev-parse ...).
>      +		oid=3D$(git rev-parse $ref) &&
>  -:  ----------- >  3:  a3529d7f9e0 submodule--helper: fix  a memory leak=
 in "status"
>  3:  0ed1fc7fdf8 =3D  4:  c14cc0e14b8 submodule tests: test for a "foreac=
h" blind-spot
>  4:  f7adfbc13ae =3D  5:  459ea25125b submodule.c: refactor recursive blo=
ck out of absorb function
>  5:  2b8afd73b9b =3D  6:  322a02c30fc submodule API & "absorbgitdirs": re=
move "----recursive" option
>  6:  91208241070 =3D  7:  d1f4ac20a4f submodule--helper: remove --prefix =
from "absorbgitdirs"
>  7:  77d4d5a6c09 =3D  8:  ac9ff05ef68 submodule--helper: drop "update --p=
refix <pfx>" for "-C <pfx> update"
>  8:  105853cd358 =3D  9:  cccd92a829c submodule--helper: use OPT_SUBCOMMA=
ND() API

Thanks! This addresses all of my comments from v1, and I didn't=20
spot any other issues during a quick 2nd pass.

  Reviewed-by: Glen Choo <chooglen@google.com>
