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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F19A1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfJLTsK (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 15:48:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:55099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfJLTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 15:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570909682;
        bh=iMZVF+PYWTrddNCNjFF4eDorBSrN2FqhJjBN0JHzjIk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AiatM9AdNpO2lsBZv0wCywKxGOzET/zB0nxrmcq0gsUXmvCiOj/Ih2I7VQPNWIV2u
         jaXsV/oZ9Mfor7J2ExJfLaaNPDkDMJdkI24/KZi29MI57AgRw6YI1pn0VaG6bOos9a
         I5Fs4SFO7HKVF1qh1iW3gAuHU7YnzajFdgYyv9pY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1iGsO11mpf-00GKOW; Sat, 12
 Oct 2019 21:48:02 +0200
Date:   Sat, 12 Oct 2019 21:47:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] merge-recursive: clean up
 get_renamed_dir_portion()
In-Reply-To: <8ae78679c9066a206610465e1da91a5f575fced2.1570826543.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910122147070.3272@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <8ae78679c9066a206610465e1da91a5f575fced2.1570826543.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lSEkolYySLQSM4qYSDwPLYWgtITJoiEfiXrusMaaBjF96mIY6XR
 sM3Xbuuzg/Z7Ye25JNr7fIznZyJaEyndMbk0QQIb3ftF2BxpgX1Ex/VK5cYHfbnjfyh2LTK
 ba74uWoc4OGX/TDmHgVAp/isUOp9z5A+/aE6XhEkwgSUGXS3Bq5qAS8wr2oR381wtU4IUCz
 WxIkaNSJmhlllbFbmc9XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZAVHD5HSu+I=:cGgtvkKG4AKvURGODiH2en
 ZbTpjITDNgJMCF2owCn1aamqKOrBbepv6+SVB5fAN4axNQcmr0JpNJRcl/qQIf1gouD/fEVv2
 76INnau/x2CfK4+PN5Po60bklroDujEOBMoBQdnPeMZkOwJPuw7KQtB+p7z6rT0VF8biRMx3G
 F7Qt64tzhxHAW/Q8Q62ll0XtVX7wR/X95LA9ZnTzolYQsYg29H7KBXnm7JJQhqe06oxn7jGdz
 S8yZfxlzeL0t/YyELStMLCErPU/EdFFkHFzTHxEBsfZqidh+KAV+vkj8PzW0Xo/VVFZaXK5On
 j6tVCQebViQHf33T4LL0SzCZnxUq9DWdp1dw2dPe+8UOnsDSqekLTd8oJD+tfs6bwUJH/Y/u+
 d97mpnPFNAB8RqeKNkt+eCYsscEVLvBEgg84ZtQbvA4NXFFgFoR5HnVOw/4HGZPrYodrxHjMk
 lQb/G7U5UxNPH2fHk0SgZRiJLfsYjKswo74isidJ0H4zICulkjLrrY0AtAkkaKeLhicz0ETIS
 jKS0lcIDTTN15Mlxk6VwmoRRIbI8wxmpslRJ1/smybzRlFq60ito+sbhy/J8C1M9Y975LGL23
 2BcXkdaStJgHq5AKzwApZ8PapHZP3GxXOK3/zApk0a3My2OFyM3nUGknhGLcKweZnYnDC+fGD
 oZS2WgrTFtWiZSHMB/vC7mOnei60fSe7waHIXpCYiDHn9HLE16AFVsEA8gZN9ILPj2yKCtlEV
 PjcUEpnZ6vQ8HP7iKLK0kixdzZTFvCUamNcs0/DNpgfCp6jsS1WZSHf5GLX/H3h9qqyt1ZCrA
 Rt8JAagZ/ZZ5Fm/bEd9oNV2yGZZbcBXHi+3O07oZZ3Vs2ZUvTRlJ1Iro+pP195YyMxW8C2gyY
 3Io2kQ+U1V5rF4QHN5qMTfHd+B9As6rlzwGrxsGEMlsl1ZqZmvTG7dHCzTNPLtoJYuggrUGUw
 mXMJO7YsXmklh/S1PG7RtE1uJrrzy6JOtHVJkXX4GmimRq98lWSPi+AvwGLmgWPnSwLZUVD3s
 EhoQyshEGVazOvL/k5GOiTdv+wOfWOyXGraF5ZUtcxNaC6ZbZj7+Sfbi0FywXhma1H4bYYaPY
 f0A+yXR6sbbkYO4sp6NDbIxkBcgIIJCnHgeA+mPHPvNOiT9c7AatkhHj/WsXKMG2hc9dxdN0J
 JCAZRqCt2lL0Sga1g9iynl/KxhsCRzFvgSYGlGdknhtC7DHiq3OT5lqu4JMam1pVllcEgakv2
 NnYfB1DkzX4esI2nR52wkMf0mhYJAOlgX0fOPMWGcGTgt+NFrPynH0uKTJ1s=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 11 Oct 2019, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Dscho noted a few things making this function hard to follow.
> Restructure it a bit and add comments to make it easier to follow.  The
> restructurings include:
>
>   * There was a special case if-check at the end of the function
>     checking whether someone just renamed a file within its original
>     directory, meaning that there could be no directory rename involved.
>     That check was slightly convoluted; it could be done in a more
>     straightforward fashion earlier in the function, and can be done
>     more cheaply too (no call to strncmp).
>
>   * The conditions for advancing end_of_old and end_of_new before
>     calling strchr were both confusing and unnecessary.  If either
>     points at a '/', then they need to be advanced in order to find the
>     next '/'.  If either doesn't point at a '/', then advancing them one
>     char before calling strchr() doesn't hurt.  So, just rip out the
>     if conditions and advance both before calling strchr().
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This commit message, as well as the patch, make a lot of sense to me.
Thank you for doing this!

Ciao,
Dscho

> ---
>  merge-recursive.c | 60 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 24 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 22a12cfeba..f80e48f623 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1943,8 +1943,8 @@ static void get_renamed_dir_portion(const char *ol=
d_path, const char *new_path,
>  				    char **old_dir, char **new_dir)
>  {
>  	char *end_of_old, *end_of_new;
> -	int old_len, new_len;
>
> +	/* Default return values: NULL, meaning no rename */
>  	*old_dir =3D NULL;
>  	*new_dir =3D NULL;
>
> @@ -1955,43 +1955,55 @@ static void get_renamed_dir_portion(const char *=
old_path, const char *new_path,
>  	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
>  	 * so, for this example, this function returns "a/b/c/d" in
>  	 * *old_dir and "a/b/some/thing/else" in *new_dir.
> -	 *
> -	 * Also, if the basename of the file changed, we don't care.  We
> -	 * want to know which portion of the directory, if any, changed.
> +	 */
> +
> +	/*
> +	 * If the basename of the file changed, we don't care.  We want
> +	 * to know which portion of the directory, if any, changed.
>  	 */
>  	end_of_old =3D strrchr(old_path, '/');
>  	end_of_new =3D strrchr(new_path, '/');
> -
>  	if (end_of_old =3D=3D NULL || end_of_new =3D=3D NULL)
> -		return;
> +		return; /* We haven't modified *old_dir or *new_dir yet. */
> +
> +	/* Find the first non-matching character traversing backwards */
>  	while (*--end_of_new =3D=3D *--end_of_old &&
>  	       end_of_old !=3D old_path &&
>  	       end_of_new !=3D new_path)
>  		; /* Do nothing; all in the while loop */
> +
>  	/*
> -	 * We've found the first non-matching character in the directory
> -	 * paths.  That means the current directory we were comparing
> -	 * represents the rename.  Move end_of_old and end_of_new back
> -	 * to the full directory name.
> +	 * If both got back to the beginning of their strings, then the
> +	 * directory didn't change at all, only the basename did.
>  	 */
> -	if (*end_of_old =3D=3D '/')
> -		end_of_old++;
> -	if (*end_of_old !=3D '/')
> -		end_of_new++;
> -	end_of_old =3D strchr(end_of_old, '/');
> -	end_of_new =3D strchr(end_of_new, '/');
> +	if (end_of_old =3D=3D old_path && end_of_new =3D=3D new_path &&
> +	    *end_of_old =3D=3D *end_of_new)
> +		return; /* We haven't modified *old_dir or *new_dir yet. */
>
>  	/*
> -	 * It may have been the case that old_path and new_path were the same
> -	 * directory all along.  Don't claim a rename if they're the same.
> +	 * We've found the first non-matching character in the directory
> +	 * paths.  That means the current characters we were looking at
> +	 * were part of the first non-matching subdir name going back from
> +	 * the end of the strings.  Get the whole name by advancing both
> +	 * end_of_old and end_of_new to the NEXT '/' character.  That will
> +	 * represent the entire directory rename.
> +	 *
> +	 * The reason for the increment is cases like
> +	 *    a/b/star/foo/whatever.c -> a/b/tar/foo/random.c
> +	 * After dropping the basename and going back to the first
> +	 * non-matching character, we're now comparing:
> +	 *    a/b/s          and         a/b/
> +	 * and we want to be comparing:
> +	 *    a/b/star/      and         a/b/tar/
> +	 * but without the pre-increment, the one on the right would stay
> +	 * a/b/.
>  	 */
> -	old_len =3D end_of_old - old_path;
> -	new_len =3D end_of_new - new_path;
> +	end_of_old =3D strchr(++end_of_old, '/');
> +	end_of_new =3D strchr(++end_of_new, '/');
>
> -	if (old_len !=3D new_len || strncmp(old_path, new_path, old_len)) {
> -		*old_dir =3D xstrndup(old_path, old_len);
> -		*new_dir =3D xstrndup(new_path, new_len);
> -	}
> +	/* Copy the old and new directories into *old_dir and *new_dir. */
> +	*old_dir =3D xstrndup(old_path, end_of_old - old_path);
> +	*new_dir =3D xstrndup(new_path, end_of_new - new_path);
>  }
>
>  static void remove_hashmap_entries(struct hashmap *dir_renames,
> --
> gitgitgadget
>
>
