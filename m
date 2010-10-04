From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/4] Introduce wholesame directory move detection in
 diffcore.
Date: Mon, 4 Oct 2010 02:28:50 -0500
Message-ID: <20101004072850.GJ24884@burratino>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Baz <brian.ewins@gmail.com>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:32:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fX6-0005M9-UX
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab0JDHcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 03:32:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46745 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab0JDHcO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 03:32:14 -0400
Received: by gwj17 with SMTP id 17so1565305gwj.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YahzD6kdL1FSqg8qKbSRfp7wMlXFj768cp6unFDtTE8=;
        b=vzMC8YtUqBfnZ/uFmaSlSr3Tm+ouOSerGA4VhDyXrjr4ZlUefD0ccnfLDtsIXuXcby
         dRA1QnE41jaRLxjwF3dS9k06J4vD9UVSWwWWejmexfZ40+f7q8QkVfAJ5D/W69vqV5kp
         MUibKXXe5FnYHA6XgloNfkZq+wrEhZ7E4m7ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cQsSiDT8OQAPEugQBWx6nLPA5xlEJqTEJSHiET+pXEg7X8QzWgPVVQBTfrCq96YdCL
         KHFSfb7ay+ECfRLS+RAzTpidLyRb409YQje7vGDGRkOcIOjGrt2w/dls47utlO6/PIkh
         GeFk+Lw7EJFAUg1XJP5Guum4AJ9TayiXv51oo=
Received: by 10.100.108.8 with SMTP id g8mr5149616anc.17.1286177526206;
        Mon, 04 Oct 2010 00:32:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x33sm8769646ana.13.2010.10.04.00.32.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 00:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286138529-6780-2-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157999>

(+cc: Duy and Baz, who commented before)

Yann Dirson wrote:

> This feature tries to group together files moving from and to
> identical directories - the most common case being directory renames.
>=20
> It is activated by the new --detect-dir-renames diffcore
> flag.
>=20
> This is only the first step, adding the basic functionnality and
> adding support to raw diff output (and it breaks unified-diff output
> which does not know how to handle that stuff yet).
[...]
>                                                For now both the resul=
t
> of "mv a b" and "mv a/* b/" are displayed as "Rnnn a/ b/", which is
> probably not what we want.  "Rnnn a/* b/" could be a good choice for
> the latter if we want them to be distinguished, and even if we want
> them to look the same.

Example?

> Other future developements to be made on top of this include:
> * extension of unified-diff format to express this
[...]
> ---

Oh, so this is for diff --raw only.

=46or the confused: the discussion from v3 perhaps explains why.  But:

 1. Just like --word-diff, this could be used as a user-facing feature
    for diffs that cannot be applied

 2. Even if no one agrees on the proper diff format, it would be good
    plumbing to have.

v3: http://thread.gmane.org/gmane.comp.version-control.git/99780/focus=3D=
99782
v2: http://thread.gmane.org/gmane.comp.version-control.git/99529/focus=3D=
99528
v1: http://thread.gmane.org/gmane.comp.version-control.git/94612/focus=3D=
96807

I kind of like the cover letter to v1:

 The idea is to add a new pass to diffcore-rename, to group file rename=
s
 looking like a full directory move, and then to hide those file
 renames which do not carry any additionnal information.

 Here is a sample run:

 $ ./git-diff-tree --abbrev=3D6 ee491 --factorize-renames -r=20
 [DBG] possible rename from arm/ to bar/
 [DBG] possible rename from ppc/ to moved/
 [DBG] discarding dir rename of arm/, mixing moved/ and bar/
 [DBG] ppc/* -> moved/* makes ppc/sha1ppc.S -> moved/sha1ppc.S unintere=
sting
 [DBG] ppc/* -> moved/* makes ppc/sha1.c -> moved/sha1.c uninteresting
 ee491a42190ec6e716f46a55fa0a7f4e307f1629
 :040000 040000 000000... 000000... R100	ppc/	moved/
 :100644 100644 9e3ae0... 9e3ae0... R100	arm/sha1.c	bar/sha1.c
 :100644 100644 395264... 395264... R100	arm/sha1.h	bar/sha1.h
 :100644 100644 c3c51a... c065ee... R099	ppc/sha1.h	moved/sha1.h
 :100644 100644 8c1cb9... 8c1cb9... R100	arm/sha1_arm.S	moved/sha1_arm.=
S

Presumably this patch takes care of the first step (grouping potential
full-directory moves) and not the second (hiding the redundant file ren=
ames).

Na=C3=AFve review:

> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -208,7 +208,8 @@ int run_diff_files(struct rev_info *revs, unsigne=
d int option)
>  						    ce_option, &dirty_submodule);
>  		if (!changed && !dirty_submodule) {
>  			ce_mark_uptodate(ce);
> -			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> +			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> +			    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
>  				continue;

Hm, why?

> @@ -338,7 +339,8 @@ static int show_modified(struct rev_info *revs,
[...]

Likewise.

[...]
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -11,6 +11,7 @@
>  static struct diff_rename_dst {
>  	struct diff_filespec *two;
>  	struct diff_filepair *pair;
> +	int i_am_not_single:1; // does not look for a match, only here to b=
e looked at
>  } *rename_dst;

What does single mean?

> @@ -49,9 +50,36 @@ static struct diff_rename_dst *locate_rename_dst(s=
truct diff_filespec *two,
[...]
> =20
> +static struct diff_rename_dst *locate_rename_dst_dir(struct diff_fil=
espec *dir)
> +{
> +	/* code mostly duplicated from locate_rename_dst - not sure we
> +	 * could merge them efficiently,though
> +	 */
> +	int first, last;
> +	int prefixlength =3D strlen(dir->path);
> +
> +	first =3D 0;
> +	last =3D rename_dst_nr;
> +	while (last > first) {
> +		int next =3D (last + first) >> 1;
> +		struct diff_rename_dst *dst =3D &(rename_dst[next]);
> +		int cmp =3D strncmp(dir->path, dst->two->path, prefixlength);
> +		if (!cmp)
> +			return dst;
> +		if (cmp < 0) {
> +			last =3D next;
> +			continue;
> +		}
> +		first =3D next+1;
> +	}
> +	/* not found */
> +	return NULL;
> +}

Binary search --- this is just a way to index into the sorted list
of rename_dsts, right?

At first I thought it was searching for a good rename destination.
A comment (or overview in the log message) could help clarify.

> @@ -386,8 +414,11 @@ static int find_exact_renames(void)
>  	for (i =3D 0; i < rename_src_nr; i++)
>  		insert_file_table(&file_table, -1, i, rename_src[i].one);
> =20
> -	for (i =3D 0; i < rename_dst_nr; i++)
> +	for (i =3D 0; i < rename_dst_nr; i++) {
> +		if (rename_dst[i].i_am_not_single)
> +			continue;
>  		insert_file_table(&file_table, 1, i, rename_dst[i].two);
> +	}

What is this code path for?  (Sorry for the tedious questions.  My
thinking is, if I cannot answer them without doing some legwork, how
could the person about to break your code who is only glancing for
a moment before plunging forward on an exciting new feature?)

> @@ -414,6 +445,180 @@ static void record_if_better(struct diff_score =
m[], struct diff_score *o)
>  		m[worst] =3D *o;
>  }
> =20
> +struct diff_dir_rename {
> +	struct diff_filespec *one;
> +	struct diff_filespec *two;
> +	int discarded;
> +	struct diff_dir_rename* next;
> +};

Okay.

> +// FIXME: prevent possible overflow
> +/*
> + * Copy dirname of src into dst, suitable to append a filename witho=
ut
> + * an additional "/".
> + * Only handles relative paths since there is no absolute path in a =
git repo.
> + * Writes "" when there is no "/" in src.
> + * May overwrite more chars than really needed, if src ends with a "=
/".
> + */
> +static const char* copy_dirname(char* dst, const char* src)
> +{
> +	char* lastslash =3D strrchr(src, '/');
> +	if (!lastslash) {
> +		*dst =3D '\0';
> +		return dst;
> +	}
> +	strncpy(dst, src, lastslash - src + 1);

memcpy?

> +	dst[lastslash - src + 1] =3D '\0';
> +
> +	// if src ends with a "/" strip the last component
> +	if (lastslash[1] =3D=3D '\0') {
> +		lastslash =3D strrchr(dst, '/');
> +		if (!lastslash)
> +			return strcpy(dst, ".");
> +		lastslash[1] =3D '\0';
> +	}

It might be easier to read like this:

/* Write name of the parent directory of src to dest. */
static char *remove_last_component(char *dst, const char *src)
{
	size_t len =3D strlen(src);
	const char *slash;

	if (len > 0 && src[len - 1] =3D=3D '/')
		/* Trailing slash.  Ignore it. */
		len--;

	slash =3D memrchr(src, '/', len);
	if (!slash) {
		*dst =3D '\0';
		return dst;
	}

	*mempcpy(dst, src, slash - src) =3D '\0';
	return dst;
}

Requires the glibc-specific function memrchr(), but that is easy to
implement.  Compare strchrnul() [in git-compat-util.h].

[...]
> +static struct diff_dir_rename* factorization_candidates =3D NULL;
> +static void diffcore_factorize_renames(void)

Maybe this could be refactored into multiple functions?

> @@ -451,13 +656,22 @@ void diffcore_rename(struct diff_options *optio=
ns)
>  				p->one->rename_used++;
>  			register_rename_src(p->one, p->score);
>  		}
> +		else {
[...]
> +			if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES)) {
> +				/* similarly, rename factorization needs to
> +				 * see all files from second tree, but we don't
> +				 * want them to be matched against single sources.
> +				 */
> +				locate_rename_dst(p->two, 1)->i_am_not_single =3D 1;

Huh?

> @@ -509,6 +723,8 @@ void diffcore_rename(struct diff_options *options=
)
> =20
>  		if (rename_dst[i].pair)
>  			continue; /* dealt with exact match already. */
> +		if (rename_dst[i].i_am_not_single)
> +			continue; /* not looking for a match. */

Oh, not single means "not seeking a new relationship".

> @@ -569,7 +785,28 @@ void diffcore_rename(struct diff_options *option=
s)
>  	/* At this point, we have found some renames and copies and they
>  	 * are recorded in rename_dst.  The original list is still in *q.
>  	 */
> +
> +	/* Now possibly factorize those renames and copies. */
> +	if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
> +		diffcore_factorize_renames();

Huh?  Factorize?

>  	DIFF_QUEUE_CLEAR(&outq);
> +
> +	// Now turn non-discarded factorization_candidates into real rename=
s
> +	struct diff_dir_rename* candidate;
> +	for (candidate=3Dfactorization_candidates; candidate; candidate =3D=
 candidate->next) {
> +		struct diff_filepair* pair;
> +		if (candidate->discarded) continue;
> +		// visualize toplevel dir if needed - FIXME: wrong place for this =
?
> +		if (!*candidate->one->path)
> +			candidate->one->path =3D "./";
> +		if (!*candidate->two->path)
> +			candidate->two->path =3D "./";
> +		pair =3D diff_queue(&outq, candidate->one, candidate->two);
> +		pair->score =3D MAX_SCORE;
> +		pair->renamed_pair =3D 1;
> +	}

Looks like I'll need to read diffcore_factorize_renames() after all. :(

Sorry, not much to say yet.  Hopefully some of that can be useful
nonetheless.

Jonathan
