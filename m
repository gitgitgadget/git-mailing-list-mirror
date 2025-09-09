Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8F255F31
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408305; cv=none; b=FrMbtF23p6yYGCv+eVX93UjV2ADj663gfFB0oHCtsxmSI28Or878pph8pc1V/CtUnrAyj4xjWmRRpKzW0CW+RaXVedSjrTjN00sJgwcdL76Vpoup7xfcDcYXQDpb2GXn4NODzZgFAl5D6nn5N3hJy/zdrvGtzT+GKPAo7h9/VV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408305; c=relaxed/simple;
	bh=r5Utcrw4z5cQPsC5wmn1BC5S29DrWBDAlrnEe9OuGIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYxst+fnp2AmWowoE198hrKeJ0MOgWRo0nxLOy+SF/hS/0NS67gTH4jxmgL0DdIAOjZ70XhqfJCA6i15yxjrJcqChk+vLlhIlinTd+rqZCDb2uRLlGabzaFgS8Wu6ZHPymAwnLA/RAu6+2VBXHU0cEej8ViJll0l+hFeDt8vGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIl9t1De; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIl9t1De"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-410c884decfso5735215ab.2
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408302; x=1758013102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EGzV3Y3Ddt9tPeEjnLC85GevWG0Ep82q71a4M01Gk8=;
        b=UIl9t1DeGilXAido+n3nLtZvxKBP1BN5olKin9H01SGsHR7Bo8iBixHqxZXsndjGj4
         9LksmWCYOnNx+wmWtc3FpBZsTRg01/jqfpOJ6ZXu6V3GE6zPP0PMZAPuU8rYHbIloTqk
         PKZSCttcSn/XzW7R2/5XkOgdAp7nGoSnEfTvtXWMRuUef8xwRKLwb40UlUYymR+UNNWd
         emx2ZV3Ls70fLE7LC1XxicgOWaC5pwx1d/02OeGgv+sJGTrpW3KyV0n+AT57MA+r4TJw
         Gbx0ugHUIUD5A3zrJZg2cmafkWRkTW+B+EyjYo7CnH0H8KktT2FIr1uoNzNYL6iymJl0
         tZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408302; x=1758013102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EGzV3Y3Ddt9tPeEjnLC85GevWG0Ep82q71a4M01Gk8=;
        b=PkMsGSlToIbbABUGbvQTa7oroY/lX3VdwmkBhMi3lMNQ6Wn4SwZnNcCGrWFHUEQmrN
         o1VOkKuIiJh6ZEgYrpd+IFGPiiN0SLcxi7tbt8ODJAY5COxhuu5TmSwQr4x2BVgNXNfG
         6JLS7YNaj8eOIVycQLX9Tor25LSnb+ams5mVRp/69C1pe87NHETCCK46WqnhJLM0uHJu
         G98dd9uwhYw5TFjtjmpAEmCuz5rm1UQzHfOXqosB8cqrBGd8rXk4cnfGBhEQmzFRaPay
         Au4VQNv48NJEqNPieQ1gcTe+MSS71NCQoCvNid8WsOPOC/pa+T+x0TZcQDOKFk0sv1PJ
         TMcA==
X-Gm-Message-State: AOJu0Yw9XpnDIUYva6CAcGYp1bCP13BaoH+XbmMk1+Ph46dnd7I4V1Iw
	o9BrZIudg6zQL4Zqoy7qnFPytxdQJQuF155obq+ZMWL4Otq6QXJ33HQSB18HDtmpvMUWK2eqn1X
	1CtaFrSC79mHa03Y4DZAHgp5o+UnWd++sCg==
X-Gm-Gg: ASbGncspyAilg4gcNNI+aoJfACPsuwsrmGeziO9RwVHuPzRVkdU2S2S327bM8q21sx4
	qe6/RPuU3sxQhNmf0MVmxAQkBe7/oY9WmSXBl7pH21Hw+LOsgXkWIO2fmZkbD0xw7O5JrnpjQvG
	RzN4QrHWXq5292Pw3j87456070DTjeBnYQ/0Gw3KWnVBwE++jR7YaCDG/MHSPXkJ4ROu8YqJZ+L
	iP8MDWoKDAAcalScqQBHunJXD0Ps4eIzMzRlBs=
X-Google-Smtp-Source: AGHT+IH8mbOe8NEzMzaQD1bC99gy5HYy11bArrdArSAnz6cj1PBHKfEHo9WEps2iZNJoCxVG8PLWj/IA4CbW8GGBDTg=
X-Received: by 2002:a05:6e02:3781:b0:3f6:54d1:451e with SMTP id
 e9e14a558f8ab-3fd8cdbe2b1mr161139625ab.1.1757408302145; Tue, 09 Sep 2025
 01:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <e7d1933d1c470528de94118fe9c58b47bcc67aca.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <e7d1933d1c470528de94118fe9c58b47bcc67aca.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:58:11 -0700
X-Gm-Features: Ac12FXwueZHZQX6Q4BYY597b4_5IMT8nj0Vptg0YifcOyQTwH--GqaxQlqPXrjs
Message-ID: <CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
Subject: Re: [PATCH 08/17] xdiff: delete chastore from xdfile_t, view with --color-words
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:46=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>

My personal bias is that things like "view with --color-words" makes
more sense to include near the end of the commit message, just before
the sign-offs.  Not sure if others agree on that.

> The chastore_t type is very unfriendly to Rust FFI. It's also redundant
> since 'recs' is a vector type that grows every time an xrecord_t is
> added.

The second sentence seems to presume the reader knows what chastore_t
type is for, and about the confusing dual layering between it and
recs.its confusing dual layering.  I liked your more extended
explanation in https://lore.kernel.org/git/7ea2dccd71fc502f20614ce217fc9885=
d1b17413.1756496539.git.gitgitgadget@gmail.com/;
could some of that be used here?

>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xdiffi.c     | 24 ++++++++++----------
>  xdiff/xemit.c      |  6 ++---
>  xdiff/xhistogram.c |  2 +-
>  xdiff/xmerge.c     | 56 +++++++++++++++++++++++-----------------------
>  xdiff/xpatience.c  | 10 ++++-----
>  xdiff/xprepare.c   | 19 ++++++----------
>  xdiff/xtypes.h     |  3 +--
>  xdiff/xutils.c     | 12 +++++-----
>  8 files changed, 63 insertions(+), 69 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 11cd090b53..a66125d44a 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -24,7 +24,7 @@
>
>  static unsigned long get_hash(xdfile_t *xdf, long index)
>  {
> -       return xdf->recs[xdf->rindex[index]]->ha;
> +       return xdf->recs[xdf->rindex[index]].ha;
>  }
>
>  #define XDL_MAX_COST_MIN 256
> @@ -489,13 +489,13 @@ static void measure_split(const xdfile_t *xdf, long=
 split,
>                 m->indent =3D -1;
>         } else {
>                 m->end_of_file =3D 0;
> -               m->indent =3D get_indent(xdf->recs[split]);
> +               m->indent =3D get_indent(&xdf->recs[split]);
>         }
>
>         m->pre_blank =3D 0;
>         m->pre_indent =3D -1;
>         for (i =3D split - 1; i >=3D 0; i--) {
> -               m->pre_indent =3D get_indent(xdf->recs[i]);
> +               m->pre_indent =3D get_indent(&xdf->recs[i]);
>                 if (m->pre_indent !=3D -1)
>                         break;
>                 m->pre_blank +=3D 1;
> @@ -508,7 +508,7 @@ static void measure_split(const xdfile_t *xdf, long s=
plit,
>         m->post_blank =3D 0;
>         m->post_indent =3D -1;
>         for (i =3D split + 1; i < xdf->nrec; i++) {
> -               m->post_indent =3D get_indent(xdf->recs[i]);
> +               m->post_indent =3D get_indent(&xdf->recs[i]);
>                 if (m->post_indent !=3D -1)
>                         break;
>                 m->post_blank +=3D 1;
> @@ -752,7 +752,7 @@ static inline int group_previous(xdfile_t *xdf, struc=
t xdlgroup *g)
>  static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
>  {
>         if (g->end < xdf->nrec &&
> -           recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
> +           recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
>                 xdf->rchg[g->start++] =3D 0;
>                 xdf->rchg[g->end++] =3D 1;
>
> @@ -773,7 +773,7 @@ static int group_slide_down(xdfile_t *xdf, struct xdl=
group *g)
>  static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
>  {
>         if (g->start > 0 &&
> -           recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1])) {
> +           recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1]))=
 {
>                 xdf->rchg[--g->start] =3D 1;
>                 xdf->rchg[--g->end] =3D 0;
>
> @@ -988,16 +988,16 @@ static void xdl_mark_ignorable_lines(xdchange_t *xs=
cr, xdfenv_t *xe, long flags)
>
>         for (xch =3D xscr; xch; xch =3D xch->next) {
>                 int ignore =3D 1;
> -               xrecord_t **rec;
> +               xrecord_t *rec;
>                 long i;
>
>                 rec =3D &xe->xdf1.recs[xch->i1];
>                 for (i =3D 0; i < xch->chg1 && ignore; i++)
> -                       ignore =3D xdl_blankline(rec[i]->ptr, rec[i]->siz=
e, flags);
> +                       ignore =3D xdl_blankline(rec[i].ptr, rec[i].size,=
 flags);
>
>                 rec =3D &xe->xdf2.recs[xch->i2];
>                 for (i =3D 0; i < xch->chg2 && ignore; i++)
> -                       ignore =3D xdl_blankline(rec[i]->ptr, rec[i]->siz=
e, flags);
> +                       ignore =3D xdl_blankline(rec[i].ptr, rec[i].size,=
 flags);
>
>                 xch->ignore =3D ignore;
>         }
> @@ -1021,7 +1021,7 @@ static void xdl_mark_ignorable_regex(xdchange_t *xs=
cr, const xdfenv_t *xe,
>         xdchange_t *xch;
>
>         for (xch =3D xscr; xch; xch =3D xch->next) {
> -               xrecord_t **rec;
> +               xrecord_t *rec;
>                 int ignore =3D 1;
>                 long i;
>
> @@ -1033,11 +1033,11 @@ static void xdl_mark_ignorable_regex(xdchange_t *=
xscr, const xdfenv_t *xe,
>
>                 rec =3D &xe->xdf1.recs[xch->i1];
>                 for (i =3D 0; i < xch->chg1 && ignore; i++)
> -                       ignore =3D record_matches_regex(rec[i], xpp);
> +                       ignore =3D record_matches_regex(&rec[i], xpp);
>
>                 rec =3D &xe->xdf2.recs[xch->i2];
>                 for (i =3D 0; i < xch->chg2 && ignore; i++)
> -                       ignore =3D record_matches_regex(rec[i], xpp);
> +                       ignore =3D record_matches_regex(&rec[i], xpp);
>
>                 xch->ignore =3D ignore;
>         }
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 2161ac3cd0..b2f1f30cd3 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -25,7 +25,7 @@
>
>  static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdem=
itcb_t *ecb)
>  {
> -       xrecord_t *rec =3D xdf->recs[ri];
> +       xrecord_t *rec =3D &xdf->recs[ri];
>
>         if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) =
< 0)
>                 return -1;
> @@ -110,7 +110,7 @@ static long def_ff(const char *rec, long len, char *b=
uf, long sz)
>  static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, lon=
g ri,
>                            char *buf, long sz)
>  {
> -       xrecord_t *rec =3D xdf->recs[ri];
> +       xrecord_t *rec =3D &xdf->recs[ri];
>
>         if (!xecfg->find_func)
>                 return def_ff(rec->ptr, rec->size, buf, sz);
> @@ -150,7 +150,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t =
const *xecfg,
>
>  static int is_empty_rec(xdfile_t *xdf, long ri)
>  {
> -       xrecord_t *rec =3D xdf->recs[ri];
> +       xrecord_t *rec =3D &xdf->recs[ri];
>         long i =3D 0;
>
>         for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index 040d81e0bc..4d857e8ae2 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -86,7 +86,7 @@ struct region {
>         ((LINE_MAP(index, ptr))->cnt)
>
>  #define REC(env, s, l) \
> -       (env->xdf##s.recs[l - 1])
> +       (&env->xdf##s.recs[l - 1])
>
>  static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
>  {
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index af40c88a5b..fd600cbb5d 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -97,12 +97,12 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1,=
 xdfenv_t *xe2, int i2,
>                 int line_count, long flags)
>  {
>         int i;
> -       xrecord_t **rec1 =3D xe1->xdf2.recs + i1;
> -       xrecord_t **rec2 =3D xe2->xdf2.recs + i2;
> +       xrecord_t *rec1 =3D xe1->xdf2.recs + i1;
> +       xrecord_t *rec2 =3D xe2->xdf2.recs + i2;
>
>         for (i =3D 0; i < line_count; i++) {
> -               int result =3D xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
> -                       rec2[i]->ptr, rec2[i]->size, flags);
> +               int result =3D xdl_recmatch(rec1[i].ptr, rec1[i].size,
> +                       rec2[i].ptr, rec2[i].size, flags);
>                 if (!result)
>                         return -1;
>         }
> @@ -111,7 +111,7 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1,=
 xdfenv_t *xe2, int i2,
>
>  static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count,=
 int needs_cr, int add_nl, char *dest)
>  {
> -       xrecord_t **recs;
> +       xrecord_t *recs;
>         int size =3D 0;
>
>         recs =3D (use_orig ? xe->xdf1.recs : xe->xdf2.recs) + i;
> @@ -119,12 +119,12 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *=
xe, int i, int count, int nee
>         if (count < 1)
>                 return 0;
>
> -       for (i =3D 0; i < count; size +=3D recs[i++]->size)
> +       for (i =3D 0; i < count; size +=3D recs[i++].size)
>                 if (dest)
> -                       memcpy(dest + size, recs[i]->ptr, recs[i]->size);
> +                       memcpy(dest + size, recs[i].ptr, recs[i].size);
>         if (add_nl) {
> -               i =3D recs[count - 1]->size;
> -               if (i =3D=3D 0 || recs[count - 1]->ptr[i - 1] !=3D '\n') =
{
> +               i =3D recs[count - 1].size;
> +               if (i =3D=3D 0 || recs[count - 1].ptr[i - 1] !=3D '\n') {
>                         if (needs_cr) {
>                                 if (dest)
>                                         dest[size] =3D '\r';
> @@ -160,22 +160,22 @@ static int is_eol_crlf(xdfile_t *file, int i)
>
>         if (i < file->nrec - 1)
>                 /* All lines before the last *must* end in LF */
> -               return (size =3D file->recs[i]->size) > 1 &&
> -                       file->recs[i]->ptr[size - 2] =3D=3D '\r';
> +               return (size =3D file->recs[i].size) > 1 &&
> +                       file->recs[i].ptr[size - 2] =3D=3D '\r';
>         if (!file->nrec)
>                 /* Cannot determine eol style from empty file */
>                 return -1;
> -       if ((size =3D file->recs[i]->size) &&
> -                       file->recs[i]->ptr[size - 1] =3D=3D '\n')
> +       if ((size =3D file->recs[i].size) &&
> +                       file->recs[i].ptr[size - 1] =3D=3D '\n')
>                 /* Last line; ends in LF; Is it CR/LF? */
>                 return size > 1 &&
> -                       file->recs[i]->ptr[size - 2] =3D=3D '\r';
> +                       file->recs[i].ptr[size - 2] =3D=3D '\r';
>         if (!i)
>                 /* The only line has no eol */
>                 return -1;
>         /* Determine eol from second-to-last line */
> -       return (size =3D file->recs[i - 1]->size) > 1 &&
> -               file->recs[i - 1]->ptr[size - 2] =3D=3D '\r';
> +       return (size =3D file->recs[i - 1].size) > 1 &&
> +               file->recs[i - 1].ptr[size - 2] =3D=3D '\r';
>  }
>
>  static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
> @@ -334,22 +334,22 @@ static int recmatch(xrecord_t *rec1, xrecord_t *rec=
2, unsigned long flags)
>  static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xd=
merge_t *m,
>                 xpparam_t const *xpp)
>  {
> -       xrecord_t **rec1 =3D xe1->xdf2.recs, **rec2 =3D xe2->xdf2.recs;
> +       xrecord_t *rec1 =3D xe1->xdf2.recs, *rec2 =3D xe2->xdf2.recs;
>         for (; m; m =3D m->next) {
>                 /* let's handle just the conflicts */
>                 if (m->mode)
>                         continue;
>
>                 while(m->chg1 && m->chg2 &&
> -                     recmatch(rec1[m->i1], rec2[m->i2], xpp->flags)) {
> +                     recmatch(&rec1[m->i1], &rec2[m->i2], xpp->flags)) {
>                         m->chg1--;
>                         m->chg2--;
>                         m->i1++;
>                         m->i2++;
>                 }
>                 while (m->chg1 && m->chg2 &&
> -                      recmatch(rec1[m->i1 + m->chg1 - 1],
> -                               rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
> +                      recmatch(&rec1[m->i1 + m->chg1 - 1],
> +                               &rec2[m->i2 + m->chg2 - 1], xpp->flags)) =
{
>                         m->chg1--;
>                         m->chg2--;
>                 }
> @@ -381,12 +381,12 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfe=
nv_t *xe2, xdmerge_t *m,
>                  * This probably does not work outside git, since
>                  * we have a very simple mmfile structure.
>                  */
> -               t1.ptr =3D (char *)xe1->xdf2.recs[m->i1]->ptr;
> -               t1.size =3D xe1->xdf2.recs[m->i1 + m->chg1 - 1]->ptr
> -                       + xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - t1.=
ptr;
> -               t2.ptr =3D (char *)xe2->xdf2.recs[m->i2]->ptr;
> -               t2.size =3D xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
> -                       + xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.=
ptr;
> +               t1.ptr =3D (char *)xe1->xdf2.recs[m->i1].ptr;
> +               t1.size =3D xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
> +                       + xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.p=
tr;
> +               t2.ptr =3D (char *)xe2->xdf2.recs[m->i2].ptr;
> +               t2.size =3D xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
> +                       + xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.p=
tr;
>                 if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
>                         return -1;
>                 if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < =
0 ||
> @@ -440,8 +440,8 @@ static int line_contains_alnum(const char *ptr, long =
size)
>  static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>  {
>         for (; chg; chg--, i++)
> -               if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
> -                               xe->xdf2.recs[i]->size))
> +               if (line_contains_alnum(xe->xdf2.recs[i].ptr,
> +                               xe->xdf2.recs[i].size))
>                         return 1;
>         return 0;
>  }
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 77dc411d19..bf69a58527 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -88,9 +88,9 @@ static int is_anchor(xpparam_t const *xpp, const char *=
line)
>  static void insert_record(xpparam_t const *xpp, int line, struct hashmap=
 *map,
>                           int pass)
>  {
> -       xrecord_t **records =3D pass =3D=3D 1 ?
> +       xrecord_t *records =3D pass =3D=3D 1 ?
>                 map->env->xdf1.recs : map->env->xdf2.recs;
> -       xrecord_t *record =3D records[line - 1];
> +       xrecord_t *record =3D &records[line - 1];
>         /*
>          * After xdl_prepare_env() (or more precisely, due to
>          * xdl_classify_record()), the "ha" member of the records (AKA li=
nes)
> @@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int l=
ine, struct hashmap *map,
>                 return;
>         map->entries[index].line1 =3D line;
>         map->entries[index].hash =3D record->ha;
> -       map->entries[index].anchor =3D is_anchor(xpp, map->env->xdf1.recs=
[line - 1]->ptr);
> +       map->entries[index].anchor =3D is_anchor(xpp, map->env->xdf1.recs=
[line - 1].ptr);
>         if (!map->first)
>                 map->first =3D map->entries + index;
>         if (map->last) {
> @@ -246,8 +246,8 @@ static int find_longest_common_sequence(struct hashma=
p *map, struct entry **res)
>
>  static int match(struct hashmap *map, int line1, int line2)
>  {
> -       xrecord_t *record1 =3D map->env->xdf1.recs[line1 - 1];
> -       xrecord_t *record2 =3D map->env->xdf2.recs[line2 - 1];
> +       xrecord_t *record1 =3D &map->env->xdf1.recs[line1 - 1];
> +       xrecord_t *record2 =3D &map->env->xdf2.recs[line2 - 1];
>         return record1->ha =3D=3D record2->ha;
>  }
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 6f1d4b4725..92f9845003 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -131,7 +131,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
>         xdl_free(xdf->rindex);
>         xdl_free(xdf->rchg - 1);
>         xdl_free(xdf->recs);
> -       xdl_cha_free(&xdf->rcha);
>  }
>
>
> @@ -146,8 +145,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_=
t *mf, long narec, xpparam_
>         xdf->rchg =3D NULL;
>         xdf->recs =3D NULL;
>
> -       if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < =
0)
> -               goto abort;
>         if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
>                 goto abort;
>
> @@ -158,12 +155,10 @@ static int xdl_prepare_ctx(unsigned int pass, mmfil=
e_t *mf, long narec, xpparam_
>                         hav =3D xdl_hash_record(&cur, top, xpp->flags);
>                         if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, nare=
c))
>                                 goto abort;
> -                       if (!(crec =3D xdl_cha_alloc(&xdf->rcha)))
> -                               goto abort;
> +                       crec =3D &xdf->recs[xdf->nrec++];
>                         crec->ptr =3D prev;
>                         crec->size =3D (long) (cur - prev);
>                         crec->ha =3D hav;
> -                       xdf->recs[xdf->nrec++] =3D crec;
>                         if (xdl_classify_record(pass, cf, crec) < 0)
>                                 goto abort;
>                 }
> @@ -263,7 +258,7 @@ static int xdl_clean_mmatch(char const *dis, long i, =
long s, long e) {
>   */
>  static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfi=
le_t *xdf2) {
>         long i, nm, nreff, mlim;
> -       xrecord_t **recs;
> +       xrecord_t *recs;
>         xdlclass_t *rcrec;
>         char *dis, *dis1, *dis2;
>         int need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
> @@ -276,7 +271,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, x=
dfile_t *xdf1, xdfile_t *xd
>         if ((mlim =3D xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
>                 mlim =3D XDL_MAX_EQLIMIT;
>         for (i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->dstart]; i <=
=3D xdf1->dend; i++, recs++) {
> -               rcrec =3D cf->rcrecs[(*recs)->ha];
> +               rcrec =3D cf->rcrecs[recs->ha];
>                 nm =3D rcrec ? rcrec->len2 : 0;
>                 dis1[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim && !need_min=
) ? 2: 1;
>         }
> @@ -284,7 +279,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, x=
dfile_t *xdf1, xdfile_t *xd
>         if ((mlim =3D xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
>                 mlim =3D XDL_MAX_EQLIMIT;
>         for (i =3D xdf2->dstart, recs =3D &xdf2->recs[xdf2->dstart]; i <=
=3D xdf2->dend; i++, recs++) {
> -               rcrec =3D cf->rcrecs[(*recs)->ha];
> +               rcrec =3D cf->rcrecs[recs->ha];
>                 nm =3D rcrec ? rcrec->len1 : 0;
>                 dis2[i] =3D (nm =3D=3D 0) ? 0: (nm >=3D mlim && !need_min=
) ? 2: 1;
>         }
> @@ -320,13 +315,13 @@ static int xdl_cleanup_records(xdlclassifier_t *cf,=
 xdfile_t *xdf1, xdfile_t *xd
>   */
>  static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
>         long i, lim;
> -       xrecord_t **recs1, **recs2;
> +       xrecord_t *recs1, *recs2;
>
>         recs1 =3D xdf1->recs;
>         recs2 =3D xdf2->recs;
>         for (i =3D 0, lim =3D XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
>              i++, recs1++, recs2++)
> -               if ((*recs1)->ha !=3D (*recs2)->ha)
> +               if (recs1->ha !=3D recs2->ha)
>                         break;
>
>         xdf1->dstart =3D xdf2->dstart =3D i;
> @@ -334,7 +329,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xd=
f2) {
>         recs1 =3D xdf1->recs + xdf1->nrec - 1;
>         recs2 =3D xdf2->recs + xdf2->nrec - 1;
>         for (lim -=3D i, i =3D 0; i < lim; i++, recs1--, recs2--)
> -               if ((*recs1)->ha !=3D (*recs2)->ha)
> +               if (recs1->ha !=3D recs2->ha)
>                         break;
>
>         xdf1->dend =3D xdf1->nrec - i - 1;
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 85848f1685..3d26cbf1ec 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -45,10 +45,9 @@ typedef struct s_xrecord {
>  } xrecord_t;
>
>  typedef struct s_xdfile {
> -       chastore_t rcha;
> +       xrecord_t *recs;
>         long nrec;
>         long dstart, dend;
> -       xrecord_t **recs;
>         char *rchg;
>         long *rindex;
>         long nreff;
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 444a108f87..332982b509 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -416,12 +416,12 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_=
t const *xpp,
>         mmfile_t subfile1, subfile2;
>         xdfenv_t env;
>
> -       subfile1.ptr =3D (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
> -       subfile1.size =3D diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
> -               diff_env->xdf1.recs[line1 + count1 - 2]->size - subfile1.=
ptr;
> -       subfile2.ptr =3D (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
> -       subfile2.size =3D diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
> -               diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.=
ptr;
> +       subfile1.ptr =3D (char *)diff_env->xdf1.recs[line1 - 1].ptr;
> +       subfile1.size =3D diff_env->xdf1.recs[line1 + count1 - 2].ptr +
> +               diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.p=
tr;
> +       subfile2.ptr =3D (char *)diff_env->xdf2.recs[line2 - 1].ptr;
> +       subfile2.size =3D diff_env->xdf2.recs[line2 + count2 - 2].ptr +
> +               diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.p=
tr;
>         if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>                 return -1;
>
> --
> gitgitgadget

You weren't kidding with the --color-words callout; there's an awful
lot of places where you only change one or two characters (e.g. '->'
becoming '.'); that's much easier to see when viewing the diff with
that flag.

Anyway, looks good.
