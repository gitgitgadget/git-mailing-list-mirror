From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Fri, 14 Feb 2014 09:37:00 -0800
Message-ID: <xmqqppmpiojn.fsf@gitster.dls.corp.google.com>
References: <cover.1392299516.git.kirr@mns.spb.ru>
	<1dd9ca564e00ef235875aae4944675f53dcd25a3.1392299516.git.kirr@mns.spb.ru>
	<xmqqbnyalrk8.fsf@gitster.dls.corp.google.com>
	<20140214121529.GB3416@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 14 18:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEMhW-0006y1-R3
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 18:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaBNRhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 12:37:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaBNRhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 12:37:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3C156AEDD;
	Fri, 14 Feb 2014 12:37:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=x4U7RGQaxj0e
	kqYkChvO29V+dIc=; b=aKV5Kesu5hR2zsgNB15R5DXHHCMfv2LW42AMFliTpJ6w
	81IpfASuoZguQYu8K0U+3R+VsnzVc+N0rev1d54ir/MGT/DmLBi3XmjrRVx9W0hx
	sY9w/PiKbwXREG+/SZBy4XhKjevVAqQCQmxrNqLkjmf+iHrdaHT7f8mTvW33hPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o6H30G
	feccoa5RHCZHPMogNm8Zw0CP3/Xk8OBWZvB5wMGyvWU2KGipuZOP0h9OKo32NSHs
	3fiQ8HZed55zeu7cyy8zFIQTwJ3vz0ye7wwlbhwmjXeIyTsKrJNuHorUZjVfhXgY
	K1ZokLWDIgqxBhLFGImWNHMranmf83qGK0Nbs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D1B6AEDC;
	Fri, 14 Feb 2014 12:37:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8FD16AED7;
	Fri, 14 Feb 2014 12:37:03 -0500 (EST)
In-Reply-To: <20140214121529.GB3416@tugrik.mns.mnsspb.ru> (Kirill Smelkov's
	message of "Fri, 14 Feb 2014 16:15:29 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9DEF3A1A-959E-11E3-A355-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242115>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> ---- 8< ----
> From: Kirill Smelkov <kirr@mns.spb.ru>
> Subject: [PATCH v2 1/2] tree-diff: rework diff_tree() to generate dif=
fs for
>  multiparent cases as well
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit

The last three do not belong here.  Only From, Date and Subject are
relevant and taken as in-body headers.

=46or that matter, as the From and Subject above are exactly the same
as what you have on the e-mail header, you do not want any of them.

I'll strip them out here, so no need to resend.  Thanks.

> Previously diff_tree(), which is now named __diff_tree_sha1(), was

That name with two leading underscores is a rather unfortunate,
especially for a function that is not a file scope static.  No way
to rename this to something more sensible?

> That impedance mismatch *hurts* *performance* *badly* for generating
> combined diffs - in c839f1bd (combine-diff: optimize combine_diff_pat=
h

Please avoid referring to a commit that is not in 'master' by its
object name.  It can be reworked later and get a different name.

> That slowness comes from the fact that currently, while generating
> combined diff, a lot of time is spent computing diff(commit,commit^2)
> just to only then intersect that huge diff to almost small set of fil=
es
> from diff(commit,commit^1).

Good observation.

>    |a|   |b|    a < b   ->  a =E2=88=89 B   ->   D(A,B) +=3D  +a    a=
=E2=86=93
>    |-|   |-|    a > b   ->  b =E2=88=89 A   ->   D(A,B) +=3D  -b    b=
=E2=86=93
>    | |   | |    a =3D b   ->  investigate =CE=B4(a,b)            a=E2=
=86=93 b=E2=86=93

In both the "n-parallel" and "diff-tree", when an entry 'a' is a
tree, I take this "D(A,B) +=3D +a" to mean (recursively) adding all
the paths within 'a' to the result as addition.  Sounds sensible.

> D(A,B)
>
> is by definition the same as combined diff
>
> D(A,[B]),
>
> so if we could rework the code for common case and make it be not slo=
wer
> for nparent=3D1 case, usual diff(t1,t2) generation will not be slower=
, and
> multiparent diff tree-walker would greatly benefit generating
> combine-diff.

OK.

> What we do is as follows:
>
> 1) diff tree-walker __diff_tree_sha1() is internally reworked to be
>    a paths generator (new name diff_tree_paths()), with each generate=
d path
>    being `struct combine_diff_path` with info for path, new sha1,mode=
 and for
>    every parent which sha1,mode it was in it.
>
> 2) From that info, we can still generate usual diff queue with
>    struct diff_filepairs, via "exporting" generated
>    combine_diff_path, if we know we run for nparent=3D1 case.
>    (see emit_diff() which is now named emit_diff_p0only())

s/p0/first_parent_/; perhaps?

> 3) In order for diff_can_quit_early(), which checks
>
>        DIFF_OPT_TST(opt, HAS_CHANGES))
>
>    to work, that exporting have to be happening not in bulk, but
>    incrementally, one diff path at a time.

Good thinking.

> Some notes(*):
>
> 1) For loops,
>
>  i =3D 0; do { ... } while (++i < nparent);
>
> is used instead of
>
>  for (i =3D 0; i < nparent; ++i)
>      ...
>
> because for the former case, the compiler have to emit additional
> prologue code which checks for i >=3D nparent case before entering th=
e
> loop.
>
> As we require nparent must be >0, that additional overhead
> conflicts with the "runs not slower for nparent=3D1 case than before"
> goal.

Unfortunate.  I'd rather see us stick to more readable and familiar
form for maintainability if this were not measurable.

> 2) alloca(), for small arrays, is used for the same reason - if we ch=
ange
> it to xmalloc()/free() the timings get worse

Do you see any use of it outside compat/?

I thought we specifically avoid alloca() for portability.  Also we
do not use variable-length-arrays on the stack either, I think.

> 3) For every parent tree, we need to keep a tag, whether entry from t=
hat
> parent equals to entry from minimal parent. For performance reasons I=
'm
> keeping that tag in entry's mode field in unused bit - see S_IFXMIN_N=
EQ.

Unfortunate, but I do not see another place to keep this
information offhand (nor implement this approach without keeping
that piece of information).

> P.S. and combined diff is not some exotic/for-play-only stuff - for

No need to convince us about that ;-)

> example for a program I write to represent Git archives as readonly
> filesystem, there is initial scan with
>
>     `git log --reverse --raw --no-abbrev --no-renames -c`
>
> to extract log of what was created/changed when, as a result building=
 a
> map
>
>     {}  sha1    ->  in which commit (and date) a content was added
>
> that `-c` means also show combined diff for merges, and without them,=
 if
> a merge is non-trivial (merges changes from two parents with both hav=
ing
> separate changes to a file), or an evil one, the map will not be full=
,
> i.e. some valid sha1 would be absent from it.
>
> That case was my initial motivation for combined diffs speedup.

I wonder if this machinery can be reused for "log -m" as well (or
perhaps you do that already?).  After all, by performing a single
parallel scan, you are gathering all the necessary information to
let you pretend that you did N pairwise diff-tree.

> diff --git a/tree-diff.c b/tree-diff.c
> index ab61a0a..2b7c991 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -7,6 +7,25 @@
>  #include "tree.h"
> =20
>  /*
> + * internal mode marker, saying a tree entry !=3D entry of tp[imin]
> + * (see __diff_tree_paths for what it means there)
> + *
> + * it *must* not overlap with any valid modes, and we will update/us=
e/emit
> + * entry for diff only with it unset. Only non-overlapping to valid =
modes is
> + * required, because mode in tree_desc, comes here canonicalized via
> + * canon_mode().
> + *
> + * the definition assumes unsigned is at least 32 bits.
> + */
> +#define S_IFXMIN_NEQ	0x80000000

To allow better coordination across multiple codepaths that deal
with modes, I am wondering if this should be defined in cache.h
where made-up S_FIGITLINK and S_IFINVALID are defined (note the
comment that is there, as well).

> +static struct combine_diff_path *__diff_tree_paths(
> +	struct combine_diff_path *p, const unsigned char *sha1,
> +	const unsigned char **parents_sha1, int nparent,
> +	struct strbuf *base, struct diff_options *opt);

Most of our code do not name private helper functions with leading
underscores.

I do like the direction this is going, but it looks to me that
"struct combine_diff" is now misnamed, because it no longer is about
combined diff.  You are introducing a good framework for n-way diff,
and producing combined diff (i.e. -c or --cc) is now merely one way
to use that framework.  We may want to clean these names up after
this series settles---perhaps "struct nway_diff" or something.

> +
> +/*
>   * Compare two tree entries, taking into account only path/S_ISDIR(m=
ode),
>   * but not their sha1's.
>   *
> @@ -33,72 +52,152 @@ static int tree_entry_pathcmp(struct tree_desc *=
t1, struct tree_desc *t2)
>  }
> =20
> =20
> -/* convert path, t1/t2 -> opt->diff_*() callbacks */
> -static void emit_diff(struct diff_options *opt, struct strbuf *path,
> -		      struct tree_desc *t1, struct tree_desc *t2)
> +/*
> + * convert path -> opt->diff_*() callbacks
> + *
> + * emits diff to parent0 only.

Please call that "first parent".

> + */

"Returns 0 to tell the caller that we are done with p and it can be
freed" or something?

> +static int emit_diff_p0only(struct diff_options *opt, struct combine=
_diff_path *p)
>  {
> ...
> +
> +	return 0;	/* =3D no need to keep allocated combine_diff_path */

Curious; what is that equal sign in the comment?
