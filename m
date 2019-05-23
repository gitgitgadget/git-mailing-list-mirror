Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590DA1F462
	for <e@80x24.org>; Thu, 23 May 2019 07:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfEWHMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 03:12:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:51381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWHMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 03:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558595547;
        bh=CfChwTEZPSzeyytdPlUbONLq2CjsdFCnHEnvFseauTs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ewvtpQGN6CrxCrPe1ba1NUgW3TAEEI8ieR3R53/iJBYPU5qcaolp+mQURnTOTMtEc
         LYoWZiSXmjC1qRFNuop1vxOxz6bX/Mn/cqke8QjrW6VPcj9Kya//xlcPnlM5JKqQtP
         +VkCDSXBKzkKUYNpq5hpii7bFcwfo3A15BRPiD/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgcTf-1hF4cm04gR-00NwmE; Thu, 23
 May 2019 09:12:27 +0200
Date:   Thu, 23 May 2019 09:12:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
In-Reply-To: <20190520121301.GD11212@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet>
References: <20190520120636.GA12634@sigill.intra.peff.net> <20190520121301.GD11212@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cG6wxpIlyt1B7QlTbrWri7j9uEn5RobehzlEKsG9g2hSeCFKcpA
 lJTQtYvCAPnb5vZKm7suFSxPXgint2c6cRbNMUpprVR5PjkprPGNgsEuXiZK0pAgiiWesoH
 FPVoVIbDRDJvlMvJUoiOEAT80CwuEcYE7wzMnJ2YVnLYA+ULBDZ+5N/vbjy0cL6yoQTJ9T4
 a3UMapHBZ3doE+5NobvFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GDdO5Ct8bnQ=:qQTQOmdTo94lHnYPLMVQZC
 JxBUahQpSx1ROag9rOLhePSy5AN6HIEneDsUqmisDepAihnGnrl2zqI+x7ElAD+fZhgpuovQj
 3/qbF2+JO538WZoE7Ypyvl9mr3JUiK/RjZ+WPOV+BXqCgDAtHkv9U7dAZF+KhsfNMtaUtppQC
 QM8FMuFQy5x7D92MoOqdouj8END1xBZKiqD+GRVF3bPa+JoK2a3nUS25YBYohmX2dEpLziLxp
 WliFzGWPgQGILtcNGpn+FvJ8eqTGh1UY5r3rVwXZkfL7vMbe6jTcSjvXHT/WLVvgyQ/wr6b4l
 1kMEAUJBBVyWcDQN3U7QOXQZpg/Hz8xhCm7G+3mjTVz5enAMv4Uisz21LPChWQDsmAy/pYWH5
 Tf1FV/uiZ9Iiw5XhgcrWYfdGmqTt+o83CAJikHEh2Dh9opN8ZHOjK0eBa49UlTMgllD4NuFD9
 vyhDCVJHZgPdB/E02xG8wzOrwX7rLaFj936ccxRpScY7VOL2kdEz8AUEc9z3g6K9HekRKbn+u
 ounc5ACIMdMUG+5imc6v99RDHyPxeeq4eHFAMHuuD5lYGFB0J2hfkLaVU9n7oCNbjYtWlN/2a
 4nDss+An054oNVv2ghdUKPMJi70vIyMNsXch1ZtDIMGQN3i7SzQ72dNsrin/1AMdP7lXbWIuZ
 NNh4uHWCdVAmfOwyzdq4p5yPUdSbOvsTztAXER/EP6aTgf3KsMvkrpN9K+8V5CPUN11Ax7War
 e+lx1APuMt7G+r6E9+mJYV16Za7j5AB97/OgOeORWKiT1i9HVatBedkAwRwdcHW+R+cWcWnVb
 tAeo4PDtjZRyXOmInXVvMzxn6awYq2G7W29duN5JwisuLNSEvcIthb//C3Tj6pbguDLUsI8AF
 OflWqSgBlTtAil4uNPbk89BazPiRKGn11Pk+ymF+Ej4iK4dG9irwFa7HBIOVAgj4gbU7wYL8A
 7x3KgJxHnTQIaZNw1qXUKg6y6ewboIi1yR+ez0iRlQTuaqbNSGn3q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 20 May 2019, Jeff King wrote:

> In interactive mode, "git am -i --resolved" will try to generate a patch
> based on what is in the index, so that it can prompt "apply this
> patch?". To do so it needs the tree of HEAD, which it tries to get with
> get_oid_tree(). However, this doesn't yield a tree oid; the "tree" part
> just means "if you must disambiguate short oids, then prefer trees" (and
> we do not need to disambiguate at all, since we are feeding a ref name).
>
> Instead, we must parse the oid as a commit (which should always be true
> in a non-corrupt repository), and access its tree pointer manually.
>
> This has been broken since the conversion to C in 7ff2683253
> (builtin-am: implement -i/--interactive, 2015-08-04), but there was no
> test coverage because of interactive-mode's insistence on having a tty.
> That was lifted in the previous commit, so we can now add a test for
> this case.
>
> Note that before this patch, the test would result in a BUG() which
> comes from 3506dc9445 (has_uncommitted_changes(): fall back to empty
> tree, 2018-07-11). But before that, we'd have simply segfaulted (and in
> fact this is the exact type of case the BUG() added there was trying to
> catch!).

What an old breakage! Thanks for analyzing and fixing it.

> diff --git a/builtin/am.c b/builtin/am.c
> index ea16b844f1..33bd7a6eab 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1339,9 +1339,17 @@ static void write_index_patch(const struct am_sta=
te *state)
>  	struct rev_info rev_info;
>  	FILE *fp;
>
> -	if (!get_oid_tree("HEAD", &head))
> -		tree =3D lookup_tree(the_repository, &head);
> -	else
> +	if (!get_oid("HEAD", &head)) {
> +		struct object *obj;
> +		struct commit *commit;
> +
> +		obj =3D parse_object_or_die(&head, NULL);
> +		commit =3D object_as_type(the_repository, obj, OBJ_COMMIT, 0);
> +		if (!commit)
> +			die("unable to parse HEAD as a commit");

Wouldn't this be easier to read like this:

		struct commit *commit =3D
			lookup_commit_reference(the_repository, &head);

> +
> +		tree =3D get_commit_tree(commit);
> +	} else
>  		tree =3D lookup_tree(the_repository,
>  				   the_repository->hash_algo->empty_tree);
>
> diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
> new file mode 100755
> index 0000000000..6989bf7aba
> --- /dev/null
> +++ b/t/t4257-am-interactive.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description=3D'am --interactive tests'
> +. ./test-lib.sh
> +
> +test_expect_success 'set up patches to apply' '
> +	test_commit unrelated &&
> +	test_commit no-conflict &&
> +	test_commit conflict-patch file patch &&
> +	git format-patch --stdout -2 >mbox &&
> +
> +	git reset --hard unrelated &&
> +	test_commit conflict-master file master base
> +'
> +
> +# Sanity check our setup.
> +test_expect_success 'applying all patches generates conflict' '
> +	test_must_fail git am mbox &&
> +	echo resolved >file &&
> +	git add -u &&
> +	git am --resolved
> +'
> +
> +test_expect_success 'interactive am can apply a single patch' '
> +	git reset --hard base &&
> +	printf "%s\n" y n | git am -i mbox &&

Since we want contributors to copy-edit our test cases (even if they do
not happen to be Unix shell scripting experts), it would be better to
write

	test_write_lines y n | git am -i mbox &&

here. Same for similar `printf` invocations further down.

> +
> +	echo no-conflict >expect &&
> +	git log -1 --format=3D%s >actual &&
> +	test_cmp expect actual

I would prefer

	test no-conflict =3D "$(git show -s --format=3D%s HEAD)"

or even better:

test_cmp_head_oneline () {
	if test "$1" !=3D "$(git show -s --format=3D%s HEAD)"
	then
		echo >&4 "HEAD's oneline is '$(git show -s \
			--format=3D%s HEAD)'; expected '$1'"
		return 1
	fi
}

> +'
> +
> +test_expect_success 'interactive am can resolve conflict' '
> +	git reset --hard base &&
> +	printf "%s\n" y y | test_must_fail git am -i mbox &&
> +	echo resolved >file &&
> +	git add -u &&
> +	printf "%s\n" v y | git am -i --resolved &&

Maybe a comment, to explain to the casual reader what the "v" and the "y"
are supposed to do?

> +
> +	echo conflict-patch >expect &&
> +	git log -1 --format=3D%s >actual &&
> +	test_cmp expect actual &&
> +
> +	echo resolved >expect &&
> +	git cat-file blob HEAD:file >actual &&
> +	test_cmp expect actual
> +'

After wrapping my head around the intentions of these commands, I agree
that they test for the right thing.

Thanks!
Dscho

> +
> +test_done
> --
> 2.22.0.rc1.539.g7bfcdfe86d
>
