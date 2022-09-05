Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9940CECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 10:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiIEKDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiIEKDv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 06:03:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADAE53D00
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662372223;
        bh=o+uu58LtFupjEczlQB/EqXN9O8ncptI0Qx27x3atz+c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JT1AeLeFgXUSjSAXCAyYvm5QjaG1l1lPcVhab+G5dJnhas3EXShk8xxpVaAl1aLEJ
         xi/kUeAupgcg2zlWOH0Sx2eUssRpLCwTSq6PceBEIAY42zitG0sU7IrW3pIZ9rueIX
         4hYyHh6gYAXh14fmhzjvjDzwATxws0FQ+QJdbcd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1otJd10zxw-00X3aj; Mon, 05
 Sep 2022 12:03:43 +0200
Date:   Mon, 5 Sep 2022 12:03:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2] diff --no-index: unleak paths[] elements
In-Reply-To: <xmqqilm51gn6.fsf@gitster.g>
Message-ID: <01pn98p2-qppn-260p-8o80-n5483p41859o@tzk.qr>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0sv5+e8CUOUc62cotWJ77M6g1K8R+Ww2rZ8YkA7Fv9rne6SvlBE
 39/W0ZvYyM/AX7UPZjE8vPv7ZID3+ZB21USnd8nP5+PvkDiGr/9ab/0PWEHjuSI+LyjPeyv
 WfW1yDVM5NO3WHFAiE9ATul4K/grjLSJk2eH1/9BDPKXP5u3pqYHDnindhekdT2mJHt0NEI
 5zDjNKKjuV5gNQYq2nmWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVZiLi1agy8=:eXHT8Kc59zjV/WVwa6ay7y
 HoUaOdFkq02K9SyCSRQgLk7CQcwFkzyjbzZIQbF9ytHjGmQ1wlcrJpt//Pj4dYaygZYLfuY3z
 ib0j6w1N5JwmwxxI6Xy7di3Lk4ke9GX51gUtkP9lg6FooqkdlXtmvEZvAfQtDnGmWBEG5f5HN
 /BZZaoSPz0glMZcPnKJKdxJvDz9svLQCWGxko5Lz5GW736MIYY+x3tRyU7XtBFo7b9sXnmds9
 hyPuzsMbNbV4NotTdTI7yXLUNCL+//4io7VyN7kGvzOs/Po1lca1q33jnukcZ3cRCmTyb2rLI
 H0hFE0sxE3bFdRrEW6fMtxWN+yJq+K7hTrlBSsRD3dQM4kZwybQgEwpc5rIsLoB5TG5fT51nN
 OIIPxt3yz01TIHeybi3P2okEkvA4Sj3BCFvFTfFs/AZFol2RPiMQi++ccV4OS2I7FhCO+DCdi
 0i4ePN9OepjGoSeu54CKuaQQMO5HgaQ3qWzwD6RVoL9xJhFDGN0LgSsl7bM95/Zwif8tcVvO0
 /NMQzytugwRqZxrHQWhEsQi1QiCB9huLmDwq5Mv/mJjzehOpCBu7l0QWMb1i7FdGABcBvA+jE
 Bf8WeJ1GNck4GmUhm6XPrWXOwW8JBIAGZw4BNJWr76iAJaOQ8eOVn3rF9jb8pr3hkfNpuqRoF
 rqqjPkrsE/npjjvXu9gyZSiM/nxxSPxX2erdy5PQPd4ny+zb6CsgCGfzJE16xpKWesinXaP+H
 tG8pEciZPg7dmC3fRO/L2PS8BbprBIfjuDNDr6jWniXEhmeOUVzvhpayOFDEzTNYRr6NoJE/D
 M+JZhfd5miIKfzZeGS5U5CVbQXJm7r6efgpSLNDAKNqRA88FoKBoxEOkR1ANdHZCPtPRjlaox
 3j22bIIhWWoH5E5C2Ghc5BtuFZaIJ0nlyEwwDgAbXWBFf2V4dlhp92jvt6EPmdCpayaFd4O0f
 AcwVybNqERSGEyzXpG0beM4aYxdzstoRtPkYT70fIXswCAk/VeBcqcNhNS1zF+2pIIc8A9/z6
 WQvKxYsXa0xxvitvHb+Cca5a3Z7X2E3lKOYLeLClsx9l3hOmVv2Rhl1qOTS+chqR8JVA/eEyy
 R+OjkzyYUjA77qOMRvRElBlQMTv368b7Oq84W2D4qmlIAbWFrDc+JW00UDx6Dy2Z0Fb3k8din
 sksXL8NGIL5WElOLQhjD41LeZU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Sep 2022, Junio C Hamano wrote:

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

I wonder whether a much better way would be to first fix the code to
always release `replacement`, like so:

=2D- snip --
diff --git a/diff-no-index.c b/diff-no-index.c
index 9a8b09346bd..87047605385 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -242,7 +242,7 @@ int diff_no_index(struct rev_info *revs,
 		  int implicit_no_index,
 		  int argc, const char **argv)
 {
-	int i, no_index;
+	int i, no_index, ret;
 	const char *paths[2];
 	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
@@ -294,17 +294,23 @@ int diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status =3D 1;

-	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
-		return 1;
+	if (queue_diff(&revs->diffopt, paths[0], paths[1])) {
+		ret =3D 1;
+		goto out;
+	}
+
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);

-	strbuf_release(&replacement);
-
 	/*
 	 * The return code for --no-index imitates diff(1):
 	 * 0 =3D no changes, 1 =3D changes, else error
 	 */
-	return diff_result_code(&revs->diffopt, 0);
+	ret =3D diff_result_code(&revs->diffopt, 0);
+
+out:
+	strbuf_release(&replacement);
+
+	return ret;
 }
=2D- snap --

After that, the proposed diff could be replaced by this diff:

=2D- snip --
diff --git a/diff-no-index.c b/diff-no-index.c
index 87047605385..d350e4381bc 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -244,6 +244,7 @@ int diff_no_index(struct rev_info *revs,
 {
 	int i, no_index, ret;
 	const char *paths[2];
+	struct string_list to_release =3D STRING_LIST_INIT_DUP;
 	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
 	struct option no_index_options[] =3D {
@@ -274,6 +275,12 @@ int diff_no_index(struct rev_info *revs,
 			p =3D file_from_standard_input;
 		else if (prefix)
 			p =3D prefix_filename(prefix, p);
+		else {
+			char *dup =3D xstrdup(p);
+
+			p =3D dup;
+			string_list_append_nodup(&to_release, dup);
+		}
 		paths[i] =3D p;
 	}

@@ -310,6 +317,7 @@ int diff_no_index(struct rev_info *revs,
 	ret =3D diff_result_code(&revs->diffopt, 0);

 out:
+	string_list_clear(&to_release, 1);
 	strbuf_release(&replacement);

 	return ret;

=2D- snap --

That approach has the distinct advantage of making it very easy to reason
about the code.

What do you think?

Ciao,
Dscho

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
> --
> 2.37.3-661-g73a641a77a
>
>
