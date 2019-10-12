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
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C821F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfJLUhs (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 16:37:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:33695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbfJLUhr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 16:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570912662;
        bh=RM9fKlP6NcDlLfKyvk0jbJ9PdcWzYJ4tZNO2cAm9AtQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X8SotETDSe4zn6ZyhidhxVntOXfBlb2FpdB8Rax8BzD+96zTvgJVDwa6iapT5EqlQ
         qqDaZKeTayLzkCzgVw9fQ+Pe847D9eTtPl7aBY5bRZRK9VuIGzfRTrlCbbHh6ETK/9
         Q+p589ctf/WbxgKfhcUb3xoms2kj7Sf1UZgmLTxk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1iYFTQ02d0-00XaC8; Sat, 12
 Oct 2019 22:37:42 +0200
Date:   Sat, 12 Oct 2019 22:37:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into
 the root directory
In-Reply-To: <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ofLgLm8vKi8g4T2tK0NWs+OV3Idm7CsWvezZBtHCDS6AE0kwC3X
 UjFUlSWwtUAYEUHzhc8NuBgHghChDLuG36oJ4U8p5s+U3l+d3sNzmSjUxSq0aNbEeJtFBU0
 gFhS6ZzNe6Fi7HwlOLFjp17VFv61RGlb4KI8w0moNpW8a+zhULLKZfYVKxltR9W30ihwuvu
 itDq2nC30BnB5+kdlRdyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SGQJEykr2u4=:y9vi7jFSoH/NVHTMdDFNP0
 kGlMLAT++fcft2MycSJlU9rGeBrwQiUlulzUv43CioPjy2gOZMG30wAbxLPPQvvk5Vvh04pTz
 eadVGRJBsPSlD7UhhmnwZekBSh8CEV0NsiW9V52sKEQAThhsuBluiEwChiLbMdJcJH8ZCLcYD
 VSqeImDJBd2nw6jSAwH2i7EAACRUQH1jJ6tPZnnaiCLqE3hwVVY3XGpdMTCdHe/c/TegrfLFn
 e5LYCLa12jI4Sz48344dOCv8YvYA9obb7mfM+ZP4Lr96kS/BoU9xSJLLj1N5G+LSFXyA4oV43
 2vFXgkCnDUAqbJmvlze3ChQyA3co6HaDJdpbm2rosaowLtCHXJ9ciedilyhe2oWz/sYeHx+4F
 KIDx5hERVxrvu9qZHs4ZrAMExtQgHG/RbzGfel4C0RRly8lz7Av/XDmIzxn22mC6sw6ONsJkr
 qHr299dSGkGaMuzhIFqYSCbpUYfU0xCgzLWkMuli7bLXDXR/R7y8vTOfeRMYpgsjsDs4tIvr3
 dXHmU3woOoPcDs/ugEbEU3OXFzclC+kqSxOu5xG3T95nRlUu2BVkqxIZgo/ZL1OIb8QLjOOe4
 oMkoeYtEqr3+3zb7ad00psEWby6TswMizw3BeFLp9yNoDkpRSLNlOqrTp3CKUfIqhW/2TzFEr
 7jPhbjihARZ+LHaNPP+0LHptdyQjVylEySPnA403+hlokNHWm9FX/H56mYWAKAh3Vh9RR8f+n
 eQWohQ4OERVOzvyL2sfGoT3XZxx3Vrqc5bXzqLSMu9AWPWywxrr3Ms4QbJt6NHYJou0DhwO+z
 xamZA6RU2UTPDX2BrGN6uDNfNHa/5LXvUgYgeR+ObuK5cmSvH/5uAf9HeOy29Of1sTSqZ2KL9
 BAqDRyMPVzaPhMQepMZrJive8rrody1turOwg5/sO5gkV/i5d46Isj6mgU1S6Z4G1IHRith62
 RH+sqLmKzn7EGH+KVnzoEjXqOgIKtimlrHPseSgwbIE4c8iv1yOyKCKorP2CU7QsBqo3PxuNs
 Ijjx51Yp+NDy1yFje7Zij7omMgxKny4hha9R0wafL5rRx64piyNnte7lfmUVqWlEn0nV84X3B
 u1CXIhSruY9Qx9Y6wc+y3hZL4OmtVxxbugW/2bmbyXH9IQadgvfzIbPyA41CnhJHxT9ysvXKd
 4fjwjKgHHvg2P1itOdfYoYrYUIhQ0GywjZV2n7aK9XJOUNXTXMe3IOptWKgfAp7//v3bx3WoD
 QEunG7Vh+SC69EiENkip0HEtfEqI+qpt+lIMqLrZFRiK/Goibce21p98j9k4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 11 Oct 2019, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> We allow renaming all entries in e.g. a directory named z/ into a
> directory named y/ to be detected as a z/ -> y/ rename, so that if the
> other side of history adds any files to the directory z/ in the mean
> time, we can provide the hint that they should be moved to y/.
>
> There is no reason to not allow 'y/' to be the root directory, but the
> code did not handle that case correctly.  Add a testcase and the
> necessary special checks to support this case.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This makes sense.

> ---
>  merge-recursive.c                   | 29 +++++++++++++++
>  t/t6043-merge-rename-directories.sh | 56 +++++++++++++++++++++++++++++

It is good to have a test case verifying this!

FWIW I frequently run into those same issues because I have to use --
quite often! -- `contrib/fast-import/import-tars.perl` in the Git for
Windows project (in the MSYS2 part thereof, to be precise), and the
`pax_global_header` and I will probably never become friends, so I often
have to move files into the top-level directory...

> diff --git a/merge-recursive.c b/merge-recursive.c
> index f80e48f623..7bd4a7cf10 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1931,6 +1931,16 @@ static char *apply_dir_rename(struct dir_rename_e=
ntry *entry,
>  		return NULL;
>
>  	oldlen =3D strlen(entry->dir);
> +	if (entry->new_dir.len =3D=3D 0)
> +		/*
> +		 * If someone renamed/merged a subdirectory into the root
> +		 * directory (e.g. 'some/subdir' -> ''), then we want to
> +		 * avoid returning
> +		 *     '' + '/filename'
> +		 * as the rename; we need to make old_path + oldlen advance
> +		 * past the '/' character.
> +		 */
> +		oldlen++;

This makes sense to me.

>  	newlen =3D entry->new_dir.len + (strlen(old_path) - oldlen) + 1;
>  	strbuf_grow(&new_path, newlen);
>  	strbuf_addbuf(&new_path, &entry->new_dir);
> @@ -1980,6 +1990,25 @@ static void get_renamed_dir_portion(const char *o=
ld_path, const char *new_path,
>  	    *end_of_old =3D=3D *end_of_new)
>  		return; /* We haven't modified *old_dir or *new_dir yet. */
>
> +	/*
> +	 * If end_of_new got back to the beginning of its string, and
> +	 * end_of_old got back to the beginning of some subdirectory, then
> +	 * we have a rename/merge of a subdirectory into the root, which
> +	 * needs slightly special handling.
> +	 *
> +	 * Note: There is no need to consider the opposite case, with a
> +	 * rename/merge of the root directory into some subdirectory.
> +	 * Our rule elsewhere that a directory which still exists is not
> +	 * considered to have been renamed means the root directory can
> +	 * never be renamed (because the root directory always exists).
> +	 */
> +	if (end_of_new =3D=3D new_path &&
> +	    end_of_old !=3D old_path && end_of_old[-1] =3D=3D '/') {
> +		*old_dir =3D xstrndup(old_path, end_of_old-1 - old_path);
> +		*new_dir =3D xstrndup(new_path, end_of_new - new_path);

However, here we write something convoluted that essentially amounts to
`xstrdup("")`. I would rather have that simple call than the convoluted
one that would puzzle me every time I have to look at this part of the
code.

While at it, would you mind either surrounding the `-` and the `1` by
spaces, or even write `--end_of_old - old_path`?

> +		return;
> +	}
> +
>  	/*
>  	 * We've found the first non-matching character in the directory
>  	 * paths.  That means the current characters we were looking at
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-=
directories.sh
> index c966147d5d..b920bb0850 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -4051,6 +4051,62 @@ test_expect_success '12c-check: Moving one direct=
ory hierarchy into another w/ c
>  	)
>  '
>
> +# Testcase 12d, Rename/merge of subdirectory into the root
> +#   Commit O: a/b/{foo.c}
> +#   Commit A: foo.c
> +#   Commit B: a/b/{foo.c,bar.c}
> +#   Expected: a/b/{foo.c,bar.c}
> +
> +test_expect_success '12d-setup: Rename (merge) of subdirectory into the=
 root' '
> +	test_create_repo 12d &&
> +	(
> +		cd 12d &&
> +
> +		mkdir -p a/b/subdir &&
> +		test_commit a/b/subdir/foo.c &&

Why `.c`? That's a little distracting.

> +
> +		git branch O &&

Might be simpler just to use `master` subsequently and not "waste" a new
ref on that.

> +		git branch A &&

Might make more sense to create it below, via the `-b` option of `git
checkout`.

Or, for extra brownie points, via the `-c` option of `git switch`.

> +		git branch B &&

Likewise, this might want to be created below, via replacing `git
checkout B` with `git switch -c B master`.

> +
> +		git checkout A &&
> +		mkdir subdir &&
> +		git mv a/b/subdir/foo.c.t subdir/foo.c.t &&
> +		test_tick &&
> +		git commit -m "A" &&
> +
> +		git checkout B &&
> +		test_commit a/b/bar.c
> +	)
> +'
> +
> +test_expect_success '12d-check: Rename (merge) of subdirectory into the=
 root' '

For the record: I am still a huge anti-fan of splitting `setup` test
cases from the test cases that do actual things, _unless_ it is _one_,
and _only one_, big, honking `setup` test case that is the very first
one in the test script.

Splitting things into two inevitably leads to unnecessary churn when
investigating test failures.

And that's really what test cases need to be optimized for: when they
report breakages. They need to help as much as they can to investigate
why things break. Nobody cares when test cases succeed. The ~150k test
cases that pass on every CI build: nobody is interested. When a test
case reports failure, that's when people pay attention. At least some,
including me.

The most common case for me (and every other lazy person who relies on
CI/PR builds) is when a build breaks, and then I usually get to the
trace of the actually failing test case very quickly. The previous test
case's trace, not so easy. Clicks involved. Now I lose context. Not
good.

A less common case for me is when I run test scripts locally, with `-i
-v -x`. Still, I need to scroll back to get context. And then, really, I
already lost context.

> +	(
> +		cd 12d &&
> +
> +		git checkout A^0 &&
> +
> +		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 &&
> +
> +		git ls-files -s >out &&
> +		test_line_count =3D 2 out &&

Isn't this a bit overzealous?

> +
> +		git rev-parse >actual \
> +			HEAD:subdir/foo.c.t   HEAD:bar.c.t &&
> +		git rev-parse >expect \
> +			O:a/b/subdir/foo.c.t  B:a/b/bar.c.t &&
> +		test_cmp expect actual &&

Likewise?

> +
> +		git hash-object bar.c.t >actual &&
> +		git rev-parse B:a/b/bar.c.t >expect &&
> +		test_cmp expect actual &&

Likewise?

> +
> +		test_must_fail git rev-parse HEAD:a/b/subdir/foo.c.t &&
> +		test_must_fail git rev-parse HEAD:a/b/bar.c.t &&
> +		test_path_is_missing a/

Makes sense, but the part that I am missing is

		test_path_is_file bar.c.t

I.e. the _most_ important outcome of this test is: the rename was
detected, and the added file was correctly placed into the target
directory of the rename.

Thanks,
Dscho

> +	)
> +'
> +
>  #######################################################################=
####
>  # SECTION 13: Checking informational and conflict messages
>  #
> --
> gitgitgadget
>
