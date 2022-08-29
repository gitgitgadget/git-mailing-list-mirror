Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB55ECAAA7
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiH2Ryc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 13:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiH2Rya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 13:54:30 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C77DF63
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661795666;
        bh=zv2nPCgeMpUDICDDhJCzMceZi4LxlWEKArDsjmloUWg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gC/5AKqltz3g/JJ3wNUyIPKF72dPG6l3/+397R9WuL2E73Jb+PD0G759H1aYQgVDO
         bECExbyWOn94+4WaNYidkDQUWm5Khw6VdKNVK5Oftvy2gMCvDON+qEjKn7XwKhco0v
         Pzeo+Xsi7g15EG5iplZwjvLgvFyGaBwK3I/Dn6ac=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Epu-1pWSjy0IyW-0143Br; Mon, 29
 Aug 2022 19:54:26 +0200
Date:   Mon, 29 Aug 2022 19:54:25 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20220829175425.cmbwtqpxrq4ppnnk@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220827085007.20030-1-tboegi@web.de>
 <0q921n79-sr17-2794-83r0-r59rnqq03pp2@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0q921n79-sr17-2794-83r0-r59rnqq03pp2@tzk.qr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Nxmf6k51UXlwt/jsiLSu0uPiRQpy/1sYEISXE42tlBL9cAW2RRV
 j+jkE1I4z2HJwDE5vG45vh8fS6m0e617Hfq0wRC2Vj99YuGsp3n35Md78pFuf9K78XtZ2iD
 cXF85jSgpcNend3zvDnqJ9urhiglatkZl2zUX7vT2jFiSYJfoWiyrym+JMCv45CKUct8kCv
 QSCikoqz4Ed58Qq5Oa7Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0qctKEDr+w0=:ZJ0G28LkbdvJOjtKHNai93
 1PVDJLpk1+YTM95yShMR647eSLoIe6h5eI5N9GhgsrPZPPKPedLvdVoAs4HODSmPJGFBpb1Vy
 U8oM3y027WFbN0vgp5nUiL4U2VtAyV5A5M/+7+BV++Y5Moi/Az6KSDq84mfb6hO3VAVuhM9Zy
 j1BSCZJGsvw4qosY6vqMGCNMK+1EA0CitIJXVkyy51rVz3g0vXNBjhzN3v1CNHZPaifP9TeKn
 kDZYJwh76NH4jVszy00h+eK3X15YWCWmYo26tLU+3i+cV2QpWUvvWHIq5qtm7iONb5zm04pSN
 q7nZDGsuO29aFtK90jqOocrqdaHgVDRXUHZe2Z/aMZCLg0ABgh2nW2URNkQyCSTXkYnqqhhhw
 wjTVhHu580VBHToXRniShvPw7pIRuraHe0SIumi+MN1dZPmIEq91X7i8ZF8/4SELd3dE6Ib2J
 xa9T3LFX4g/2GcPfNBVFDOP220YEjo3h9ZtipIJ6f7hrZ01cK19utRm6mHPc9uixVrzXTnNNY
 cMH2qGmx8Q2wWx8BCST/s2cVi9QPrIdUh8dSa2kkRJCmUGObAd+I/fA+0uu1LuXhRUH8Uk+5P
 XenKKAKS5Nd/piAFSnzux1ONS0ay2oQXUUeBs5YsStv54CMWS9sPBjcBgoDORzFaqpM8BWC1U
 yrOBt+iI+w58tkXuvH6RxjJSYpyqDGY5j6tD4lLBhpxj4sGyQ19N6ZUGgr9J7kx4rN+Eta0Eg
 5qJwyXRVMAYxrr7MCibyyIWE3G9IDs0XhZQP0kwR3Q2vOFz9MqOCWqqxELWIaMVD/y5x5eIGK
 h0Xe/dAtYdtVbAV3AILNCOz0Vy3W3gG/ScF0oLI4hyyRslPX7TLI5RDvPFy++Kp7XWCe4Qhmu
 42ALHLcvJ1cx+8R1JNarupmUKVQLQFsnSYaAM8aIld3FVnUim3NnjaAjwHNCW0scfde990CPQ
 6gk9fJOHkHLMscoDzSUIv3VIsW4FPTPc9Z9T0YyAhk3azaFg/K5cVxEMTpKbFvK2iR3epxTgu
 vgHYChQO7ADK184VxLpvHkls4UxCh059OA02lHFCvgIXRgRqHYWXwQ6FXjYjfcTOAeYR6uy8M
 ks2KzBWbCgHjzLILSY4vyS9WAk8I4zpLwzQox/i5t5Jrb9Ujv4WXYP2PA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 02:04:42PM +0200, Johannes Schindelin wrote:
> Hi Torsten,
> >
> > The choosen solution is to split code in diff.c like this
> >
> > strbuf_addf(&out, "%-*s", len, name);
> >
> > into something like this:
> >
> > size_t num_padding_spaces =3D 0;
> > // [snip]
> > if (len > utf8_strwidth(name))
> >     num_padding_spaces =3D len - utf8_strwidth(name);
> > strbuf_addf(&out, "%s", name);
> > if (num_padding_spaces)
> >     strbuf_addchars(&out, ' ', num_padding_spaces);
>
> ... this sounds like it would benefit from beinv refactored into a
> separate function, e.g. `strbuf_add_padded(buf, utf8string)`, both for
> readability as well as for self-documentation.

Yes, but:
All (tm) strbuf() functions use an unsigned size_t, and are not
tolerant against passing 0 as "do nothing".
A nicer solution (for this patch) could be a change like this:
Instead of

void strbuf_addchars(struct strbuf *sb, int c, size_t n)
{
        strbuf_grow(sb, n);
	memset(sb->buf + sb->len, c, n);
	strbuf_setlen(sb, sb->len + n);
}

We would find:
void strbuf_addchars(struct strbuf *sb, int c, ssize_t n)
{
        if (n <=3D 0)
	       return;
        strbuf_grow(sb, (size_t)n);
	memset(sb->buf + sb->len, c, (size_t)n);
	strbuf_setlen(sb, sb->len + (size_t)n);
}

I couldn't convince myself to do so.
Since it is mainly diff.c that needs this adjustment/padding of strings,
I coulnd't convince myself to write another function in strbuf.c


>
> Also, it is unclear to me why we have to evaluate `utf8_strwidth()`
> _twice_ and why we do not assign the result to a variable called `width`
> and then have a conditional like
>
> 	if (width < len) /* pad to `len` columns */
> 		strbuf_addchars(&out, ' ' , len - width);
>
> instead. That would sound more logical to me.

This is caused by the logic in diff.c:
  /*
   * Find the longest filename and max number of changes
   */
   for (i =3D 0; (i < count) && (i < data->nr); i++) {
       struct diffstat_file *file =3D data->files[i];
       [snip]
       len =3D utf8_strwidth(file->print_name);
       if (max_width < len)
          max_width =3D len;
// and later
    /*
     * From here name_width is the width of the name area,
     * and graph_width is the width of the graph area.
     * max_change is used to scale graph properly.
     */
    for (i =3D 0; i < count; i++) {
    /*
     * "scale" the filename
     */
     // TB: Which means either shortening it with ...
     // Or padding it, if needed, and here we need
     // another
     name_len =3D utf8_strwidth(name);

>
> Besides, since the simple change from `strlen()` to `utf8_strwidth()` is
> so different from changing `strbuf_addf(...)`, I would prefer to see the=
m
> split into two patches.

Hm, that is a possiblity. Seems to ease the burden for reviewers.

>
> >
> > Tests:
> > Two things need to be tested:
> > - The calculation of the maximum width
> > - The calculation of num_padding_spaces
> >
> > The name "textfile" is changed into "textfil=EB", both have a width of=
 8.
> > If strlen() was used, to get the maximum width, the shorter "binfile" =
would
> > have been mis-aligned:
> >  binfile   |  [snip]
> >  textfil=EB | [snip]
> >
> > If only "binfile" would be renamed into "binfil=EB":
> >  binfil=EB |  [snip]
> >  textfile | [snip]
> >
> > In order to verify that the width is calculated correctly everywhere,
> > "binfile" is renamed into "binf=EFl=EB", giving 2 bytes more in strlen=
()
> > "textfile" is renamed into "textfil=EB", 1 byte more in strlen(),
> > and the updated t4012-diff-binary.sh checks the correct aligment:
> >  binf=EFl=EB  | [snip]
> >  textfil=EB | [snip]
>
> I wonder whether you can change only _one_ name and still verify the
> correctness. When you make two changes at the same time, it is always
> possible for one change to "cancel out" the other one, and therefore it =
is
> harder to reason about the correctness of your patch.

Nee, I have a hard time to see how a +/- 1 can "cancel out" a +/- 2.
But I may improve the commit message, to make that more clear.

>
> Better keep it simple and change only one instance (personally,
> I would have changed two letters in the longer one).

That is certainly doable.


>
> >
> > Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
> > Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> > ---
> >  diff.c                 | 37 +++++++++++++++++++++++--------------
> >  t/t4012-diff-binary.sh | 14 +++++++-------
> >  2 files changed, 30 insertions(+), 21 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index 974626a621..cf38e1dc88 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2591,7 +2591,7 @@ void print_stat_summary(FILE *fp, int files,
> >  static void show_stats(struct diffstat_t *data, struct diff_options *=
options)
> >  {
> >  	int i, len, add, del, adds =3D 0, dels =3D 0;
> > -	uintmax_t max_change =3D 0, max_len =3D 0;
> > +	uintmax_t max_change =3D 0, max_width =3D 0;
>
> Why rename `max_len`, but not `len`? I would have expected (and agreed
> with seeing) `len` to be renamed to `width`, too.

That is a valid point.
There is, however, already a variable called "width".
And renaming this one into a new one as well ?

>
> >  	int total_files =3D data->nr, count;
> >  	int width, name_width, graph_width, number_width =3D 0, bin_width =
=3D 0;
> >  	const char *reset, *add_c, *del_c;
> > @@ -2620,9 +2620,9 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
> >  			continue;
> >  		}
> >  		fill_print_name(file);
> > -		len =3D strlen(file->print_name);
> > -		if (max_len < len)
> > -			max_len =3D len;
> > +		len =3D utf8_strwidth(file->print_name);
> > +		if (max_width < len)
> > +			max_width =3D len;
> >
> >  		if (file->is_unmerged) {
> >  			/* "Unmerged" is 8 characters */
> > @@ -2646,7 +2646,7 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
> >
> >  	/*
> >  	 * We have width =3D stat_width or term_columns() columns total.
> > -	 * We want a maximum of min(max_len, stat_name_width) for the name p=
art.
> > +	 * We want a maximum of min(max_width, stat_name_width) for the name=
 part.
> >  	 * We want a maximum of min(max_change, stat_graph_width) for the +-=
 part.
> >  	 * We also need 1 for " " and 4 + decimal_width(max_change)
> >  	 * for " | NNNN " and one the empty column at the end, altogether
> > @@ -2701,8 +2701,8 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
> >  		graph_width =3D options->stat_graph_width;
> >
> >  	name_width =3D (options->stat_name_width > 0 &&
> > -		      options->stat_name_width < max_len) ?
> > -		options->stat_name_width : max_len;
> > +		      options->stat_name_width < max_width) ?
> > +		options->stat_name_width : max_width;
>
> It is a bit sad that the diff lines regarding the renamed variable drown
> out the actual change (`strlen()` -> `utf8_strwidth()`). But the end
> result is nicer.
>
> Thank you for working on this!
> Dscho

Thanks so much for the review - let's see if I can make a better patch
the next days (better say weeks)
