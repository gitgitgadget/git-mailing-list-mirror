Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE45ECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 06:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiICGAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 02:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiICGAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 02:00:34 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FA63F17
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662184824;
        bh=vTfNZbb/Fo8Q4TPMzmPLt5pf7+CSO6j2dLxVhApwUBI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mjiFYU2UxEst8haxb16ucVOfOXjjq7tjqr6rGixlLuuciVnrBhimsKgXRQmPcLgXl
         v9JFJAGStKBjePS4UOyoHpOvXrATw0BhvTcLM1GIDVka4MgMfCQ5Rhq27G5qFInNZJ
         T0NSRNy7N2kr8eUfpC3aQNHTg9jjZL8B/ocQfh4c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.26.245]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2KQ-1ovCRi1tN0-00SVuc; Sat, 03
 Sep 2022 08:00:24 +0200
Message-ID: <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de>
Date:   Sat, 3 Sep 2022 08:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v2] diff --no-index: unleak paths[] elements
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqilm51gn6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KUOKeodFE2xfqa6xcoX00sw3agDJ4gQpcSTr57TA0h9kOB76FcE
 tvKl2BTIU6jdBBURjOFenD6DAyBzSqJreZBUiMbBQ1ngA/rDPC86M0KUiWq3KCEPwzqfWT5
 7/tLvcrSttRKMXQDitwbtvNTGkb/jNmoWntHquiTOCiZ0DlIr3B8jmeaIV9g4F6fn1OOPVv
 xOyPWlsZv2x2MbWOsLZiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7226zm3bAgY=:8D2EO6nHipIiWvE3mA75+Z
 oQn1MkkEXRWuTb+gpLTh15lkTuEjUkScUlyilkFAQPboxJ740yQbuslg06KbzmW8Kr6cqmXhR
 bvLeZUmQy82Rk/JQCiYHcSJw3uhj8TvrS+JHJXVqG3uEgYYZEyDqB5cCa8GHcaRq9G+clrD0H
 FsIF8HqZNk1ORpIFpLVSD1QDIQZGEEK1jYHHeXERzMarO34nBti9UGQ9MiN6z5lDnZQhuN6lr
 DK0j11in9UVdAiKhrnjC0nCR11v5V8VHi8dm6GMqwLtZ2IMKoIMSSTUel6thkYzKKPlGc3F1L
 bhNXxpBTyOZQ8Ey2cqjt3OaOwrIB90zNvnx9qPCY3C2s3GeawAXJlnX2+F+3w3beJCKDZOwJV
 exHV0Ite7MGxsH1vvqz3aE/57vThlJo00SNrMp7Zn0l61Bx7JIOC+IRvd6NcP0iUJ6JfMBV29
 e7qh3/P7gOiAdBdDybwq7sScytXVKwKo5yBgk25KFCdM93DqNYK7eXwnd0/ORvRwqt6xWvepN
 9C6MinjABS2vRHh1EU5isMLJ1cs3sNwKuC9ERmdkf/16wAGjpDnB6nz0Cz56Kbz2GvQGkeajD
 6Z1GSeWXoTF3j5SwdV5l32Nk/M25vUzm0ghWLkQtnTNd4f4L/Lcq75y0W8+KDyoSl+y0g5KQL
 9isr6uCwe4iwE3QA8bAw/T58760QLXGgBFOk8YQM2Ds5vGhR9B3C8hqAlU0EqXIZseLQNfoE8
 BzuVr6jfjB8cQnvocMdRk7XC4VbYxbK/3AGaQe7gbKN2+aQOZ5Nq7C21U1U+vGoq+AIwfd9Q9
 7fyEFeXCJ3o1N5kQV8pG8J95rZy0N7ivNcjKDetyoXeNV4Dq4PAeo6nXcT7f1WNNLnBqgWduE
 v0IpP9ydhEXtTwCYRLUbhi5smAdYKEPSpkk1T8VzQXF09WnbMw8wvgfD+pagYl6fq8e/ffRYQ
 ApKYw1E412RpKNvFQsXfV6Rk+6q1Ieh3nPPPcPhV1uaj0QL1aKWxdXHoOXqJvTN0AnzPoxqLM
 3FKQlFVHPw5bFKUINDMJS8I5h/jeIztULFppAEhsylegI217FWfCE9+GRyWkB8c8bZ2taWtMO
 dN6DONYFVi2DHxpAbU5exdppPAAfSC3K8IrKok1Gn1h5RxC+S0UsXqhVasVSylGJlKdioGnqX
 p8iLI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.09.22 um 01:49 schrieb Junio C Hamano:
> "git diff --no-index" codepath starts with the two elements in
> argv[] and munges them into two paths to be compared, stored in a
> separate path[] arrays.  The munging is implemented in a rather
> haphazard way, sometimes overwriting old version with a new copy,
> and sometimes a constant string assigned to path[], making it
> impossible to release the resources properly:
>
>  * A single dash "-" from the command line is a special signal that
>    the standard input is used for the side to be compared, and is
>    internally replaced with a copy of string "-" at a known address.
>
>  * When run in a subdirectory, full paths to the two paths are
>    allocated and placed in path[].
>
>  * After the above happens, when comparing a file with a directory,
>    the directory side is replaced with the path to a file in the
>    directory with the same name as the file.
>
> This was perfectly fine for just two strings that are pathnames used
> during the lifetime of the program and cleaned up upon program exit,
> but it gets in the way when leak sanitizer is in effect.  The third
> step can be losing the full path that was allocated in the second
> step, but it is not easy to tell if its input is an allocated piece
> of memory to begin with.
>
> Loosen the earlier two steps a bit so that elements of the path[]
> array that come to the directory/file comparison code are either the
> singleton "-" or an allocated piece of memory.  Use that knowledge
> in the third step to release an allocated piece of memory when it
> replaces the path to a directory with the path to a file in that
> directory, and also at the end to release the two elements of the
> path[] array as needed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * The previous one allowed strbuf_release() to free replacement.buf
>    which may be used in path[0] or path[1] potentially leading to
>    double freeing.  The kosher way may be to use strbuf_detach() in
>    fixup_paths(), but this is a simpler fix, it is getting late in
>    the day, and I am getting sick of fighting the leak-checker, so...
>
>  diff-no-index.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9a8b09346b..77a126469b 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -208,6 +208,14 @@ static void append_basename(struct strbuf *path, co=
nst char *dir, const char *fi
>  	strbuf_addstr(path, tail ? tail + 1 : file);
>  }
>
> +static void free_allocated_path(const char *path)
> +{
> +	if (!path ||

How can path be NULL?  And if it was, why shield free(3) from it?

> +	    (path =3D=3D file_from_standard_input))
> +		return;
> +	free((char *)path);
> +}
> +
>  /*
>   * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
>   * Note that we append the basename of F to D/, so "diff a/b/file D"
> @@ -226,9 +234,11 @@ static void fixup_paths(const char **path, struct s=
trbuf *replacement)
>  		return;
>  	if (isdir0) {
>  		append_basename(replacement, path[0], path[1]);
> +		free_allocated_path(path[0]);
>  		path[0] =3D replacement->buf;
>  	} else {
>  		append_basename(replacement, path[1], path[0]);
> +		free_allocated_path(path[1]);
>  		path[1] =3D replacement->buf;
>  	}
>  }
> @@ -274,6 +284,8 @@ int diff_no_index(struct rev_info *revs,
>  			p =3D file_from_standard_input;
>  		else if (prefix)
>  			p =3D prefix_filename(prefix, p);
> +		else
> +			p =3D xstrdup(p);

prefix_filename(NULL, p) is basically the same as xstrdup(p), so those
two conditional branches could be joined.

>  		paths[i] =3D p;
>  	}
>
> @@ -294,13 +306,21 @@ int diff_no_index(struct rev_info *revs,
>  	setup_diff_pager(&revs->diffopt);
>  	revs->diffopt.flags.exit_with_status =3D 1;
>
> -	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
> +	if (queue_diff(&revs->diffopt, paths[0], paths[1])) {
> +		free_allocated_path(paths[0]);
> +		free_allocated_path(paths[1]);
>  		return 1;
> +	}
>  	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
>  	diffcore_std(&revs->diffopt);
>  	diff_flush(&revs->diffopt);
>
> -	strbuf_release(&replacement);
> +	/*
> +	 * do not strbuf_release(&replacement), as it is in paths[]
> +	 * when replacement was actually used.
> +	 */
> +	free_allocated_path(paths[0]);
> +	free_allocated_path(paths[1]);
>
>  	/*
>  	 * The return code for --no-index imitates diff(1):

Perhaps avoid the need for that comment by moving that strbuf to where
it's used and have it spend its full lifecycle there?  Something like:

=2D--
 diff-no-index.c | 50 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 77a126469b..9f8b78f173 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -196,18 +196,6 @@ static int queue_diff(struct diff_options *o,
 	}
 }

-/* append basename of F to D */
-static void append_basename(struct strbuf *path, const char *dir, const c=
har *file)
-{
-	const char *tail =3D strrchr(file, '/');
-
-	strbuf_addstr(path, dir);
-	while (path->len && path->buf[path->len - 1] =3D=3D '/')
-		path->len--;
-	strbuf_addch(path, '/');
-	strbuf_addstr(path, tail ? tail + 1 : file);
-}
-
 static void free_allocated_path(const char *path)
 {
 	if (!path ||
@@ -216,12 +204,28 @@ static void free_allocated_path(const char *path)
 	free((char *)path);
 }

+/* append basename of F to D */
+static void append_basename(const char **dir, const char *file)
+{
+	const char *tail =3D strrchr(file, '/');
+	struct strbuf path =3D STRBUF_INIT;
+
+	strbuf_addstr(&path, *dir);
+	while (path.len && path.buf[path.len - 1] =3D=3D '/')
+		path.len--;
+	strbuf_addch(&path, '/');
+	strbuf_addstr(&path, tail ? tail + 1 : file);
+
+	free_allocated_path(*dir);
+	*dir =3D strbuf_detach(&path, NULL);
+}
+
 /*
  * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
  * Note that we append the basename of F to D/, so "diff a/b/file D"
  * becomes "diff a/b/file D/file", not "diff a/b/file D/a/b/file".
  */
-static void fixup_paths(const char **path, struct strbuf *replacement)
+static void fixup_paths(const char **path)
 {
 	unsigned int isdir0, isdir1;

@@ -232,15 +236,10 @@ static void fixup_paths(const char **path, struct st=
rbuf *replacement)
 	isdir1 =3D is_directory(path[1]);
 	if (isdir0 =3D=3D isdir1)
 		return;
-	if (isdir0) {
-		append_basename(replacement, path[0], path[1]);
-		free_allocated_path(path[0]);
-		path[0] =3D replacement->buf;
-	} else {
-		append_basename(replacement, path[1], path[0]);
-		free_allocated_path(path[1]);
-		path[1] =3D replacement->buf;
-	}
+	if (isdir0)
+		append_basename(&path[0], path[1]);
+	else
+		append_basename(&path[1], path[0]);
 }

 static const char * const diff_no_index_usage[] =3D {
@@ -254,7 +253,6 @@ int diff_no_index(struct rev_info *revs,
 {
 	int i, no_index;
 	const char *paths[2];
-	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
 	struct option no_index_options[] =3D {
 		OPT_BOOL_F(0, "no-index", &no_index, "",
@@ -289,7 +287,7 @@ int diff_no_index(struct rev_info *revs,
 		paths[i] =3D p;
 	}

-	fixup_paths(paths, &replacement);
+	fixup_paths(paths);

 	revs->diffopt.skip_stat_unmatch =3D 1;
 	if (!revs->diffopt.output_format)
@@ -315,10 +313,6 @@ int diff_no_index(struct rev_info *revs,
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);

-	/*
-	 * do not strbuf_release(&replacement), as it is in paths[]
-	 * when replacement was actually used.
-	 */
 	free_allocated_path(paths[0]);
 	free_allocated_path(paths[1]);

=2D-
2.37.2

