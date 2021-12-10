Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B631C43217
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 14:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbhLJObR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:31:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:40877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242149AbhLJObQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 09:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639146446;
        bh=HNbSP6zCsnjbQPRDYtC8Ot0W7Q88nXKOx1W5Bxj68cY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iuciDEF/jd+HfKlYmWl+omtEXsOHHPLox4lq1JWMhWfEe47vfmj/By5PL9Nrf9RuZ
         xQZNBSRoU2ZOwiaFHzMqq93LfW4DMzk2gmXiOZulhDvF13HPWlYO8BCRcquzwKPcAg
         2F2iPTjVF9SBPyu/qlgymV+64gsIdwkUiULGL3ks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1mVKGM2ZYe-00zl0L; Fri, 10
 Dec 2021 15:27:26 +0100
Date:   Fri, 10 Dec 2021 15:27:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
In-Reply-To: <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com> <YbLL/YWbjc/sPRyH@coredump.intra.peff.net> <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
 <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1793197666-1639146446=:90"
X-Provags-ID: V03:K1:uZB+cWoonbWO9LCfbIGsfkKjXVNFmhEAToznPZ5UuzMrfglxtG0
 2/dcsU4m99nv3CMy6W7dxR1vVrooaPjUBLpfnsdXn1tUY8XOUbCWsphUntDIpQhmEcVW+VI
 Zq365ODrM7qpKsOs6db84VdFvf4dNK38zzYISkvyw9wMFZp+PN4fHoSYp3VvQejmlrlG/hG
 wM54IVUHzkKdaUd8lUaBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xfb0DyJW3/A=:L/APNLzT2yp+uNNl4dC0WQ
 HDgCvkpViwxel/0qp8oDY78jZgccWqViYg6sSUXpEO/3QhzhOWWBqt4uSbWOYT9D3w2WFQaP2
 Ry8jQfzvTmLsUOn7aDYiUzufPqBG4cl1ga+Tb88KND1dqjXc2XC2ohVJrhWln9RMUcDeHKJoY
 5xlMG0PpPnnksIWj1CoceM0zQ15QiQNJoOgnIu2bUGjKRB78NDUor3M2Of5cToJM6wkh95bmn
 ohF1JI7BsGbXc+RPEtxJiLjn/F8PlyELBPEqy12iBBfl1lhHlRMXxZd1enLuO9vo6QdYaFqQ5
 A6Y4HBdIWjIcbQMfHL+Jy/kVOEn2h+S8yzEGtAFrLxZagr6YVfvewu4qnDIuhO4dXizH80tBH
 kz+wXG+XuJ2SYZinrq3noGevVmQH4Lm0J6DZpLnuj529erapFXPkwQS/4buLfb3iNaxH8bfk8
 u5XkMlQU5TaUSK12N52ynsEWKmu8+W2j76gg58Du0RgJD7xhPD+H9DZYqK7Gs/zzCNLLSSb/7
 OhJkUuE3siItRR714yJAy4GK0u8ODJUB4gYKOnt+/EsdbNtLv9zOBU/N90etiovCx9DAhKYL9
 WjBeA2+IOkQL+a1CdBTxknudTaJnZBJE4XXIIby6nI3jsu1ORira8L6//5Lu7bR5kBfkvkXd9
 Cv9jHuUBjDUK34SpUTkwLWb8ZswoQjqJP8PIsjY9npQoSKL+1qobNCCi579LtcG5Bf4ya6WvT
 TJG/+VcFGZNhj1O8b2QOZPetNZ5Yln5lF1+fPmjxebC6mXHw+UYFzBqn9GpkLTckVSSjyhuDR
 qfIcfohzH4sPclePihbjp+WowSiFn1L7styLyuw9aW2qd57qu6B+jXqH6jyROz8KQW6SDOS3x
 d/6cgE77XwbOpJaaW/WA2nwTWg5rh9f7pX19jB5+ONeIjhQZPNoXFA18QGrnU7jRhhI6+iy5/
 aZEze4rfMunlup/2dR00bUAZAsw43rnFsaBSx+KkZkvyfLxJ9aD9mK2tVPD0Fqibdx3hN5Hgx
 TnX2a6mb1DvYl6zeNVlZFYxswkRhIg9o2rk8jSa0nrHRLkDBBCldAzE8r9cEqIKesGScccDGC
 jKAhinKyZ6vWEs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1793197666-1639146446=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Fri, 10 Dec 2021, Jeff King wrote:

> On Fri, Dec 10, 2021 at 11:22:59AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>
> > > Dropping the st_mult() does nothing to fix the actual problem (which=
 is
> > > that this function should use a more appropriate type), but introduc=
es
> > > new failure modes.
> >
> > Yes you're entirely right. I had some stupid blinders on while writing
> > this. FWIW I think I was experimenting with some local macros and
> > conflated a testing of the overflow of n*n in gdb with the caste'd
> > version, which you rightly point out here won't have the overflow issu=
e
> > at all. Sorry.
>
> I'm not sure if this is helpful or not, but this is the minimal fix I
> came up with that runs the testcase I showed earlier. It's basically
> just swapping out "int" for "ssize_t" for any variables we use to index
> the arrays (though note a few are themselves held in arrays, and we have
> to cross some function boundaries).
>
> I won't be surprised if it doesn't hit all cases, or if it even hits a
> few it doesn't need to (e.g., should "phase" be dragged along with "i"
> and "j" in the first hunk?). I mostly did guess-and-check on the
> test-case, fixing whatever segfaulted and then running again until it
> worked. I didn't even really read the code very carefully.
>
> I think you _did_ do more of that careful reading, and broke down the
> refactorings into separate patches in your series. Which is good. So I
> think what we'd want is to pick out those parts of your series that end
> up switching the variable type. My goal in sharing this here is just to
> show that the end result of the fix can (and IMHO should) be around this
> same order of magnitude.

I am in favor of this patch. Will you have time to submit this with a
commit message?

Thank you,
Dscho

>
> ---
> diff --git a/linear-assignment.c b/linear-assignment.c
> index ecffc09be6..3efa30c50b 100644
> --- a/linear-assignment.c
> +++ b/linear-assignment.c
> @@ -13,11 +13,11 @@
>   * i is `cost[j + column_count * i].
>   */
>  void compute_assignment(int column_count, int row_count, int *cost,
> -			int *column2row, int *row2column)
> +			ssize_t *column2row, ssize_t *row2column)
>  {
>  	int *v, *d;
>  	int *free_row, free_count =3D 0, saved_free_count, *pred, *col;
> -	int i, j, phase;
> +	ssize_t i, j, phase;
>
>  	if (column_count < 2) {
>  		memset(column2row, 0, sizeof(int) * column_count);
> @@ -31,7 +31,7 @@ void compute_assignment(int column_count, int row_coun=
t, int *cost,
>
>  	/* column reduction */
>  	for (j =3D column_count - 1; j >=3D 0; j--) {
> -		int i1 =3D 0;
> +		ssize_t i1 =3D 0;
>
>  		for (i =3D 1; i < row_count; i++)
>  			if (COST(j, i1) > COST(j, i))
> @@ -51,7 +51,7 @@ void compute_assignment(int column_count, int row_coun=
t, int *cost,
>  	/* reduction transfer */
>  	ALLOC_ARRAY(free_row, row_count);
>  	for (i =3D 0; i < row_count; i++) {
> -		int j1 =3D row2column[i];
> +		ssize_t j1 =3D row2column[i];
>  		if (j1 =3D=3D -1)
>  			free_row[free_count++] =3D i;
>  		else if (j1 < -1)
> @@ -74,13 +74,13 @@ void compute_assignment(int column_count, int row_co=
unt, int *cost,
>
>  	/* augmenting row reduction */
>  	for (phase =3D 0; phase < 2; phase++) {
> -		int k =3D 0;
> +		ssize_t k =3D 0;
>
>  		saved_free_count =3D free_count;
>  		free_count =3D 0;
>  		while (k < saved_free_count) {
>  			int u1, u2;
> -			int j1 =3D 0, j2, i0;
> +			ssize_t j1 =3D 0, j2, i0;
>
>  			i =3D free_row[k++];
>  			u1 =3D COST(j1, i) - v[j1];
> @@ -130,7 +130,7 @@ void compute_assignment(int column_count, int row_co=
unt, int *cost,
>  	ALLOC_ARRAY(pred, column_count);
>  	ALLOC_ARRAY(col, column_count);
>  	for (free_count =3D 0; free_count < saved_free_count; free_count++) {
> -		int i1 =3D free_row[free_count], low =3D 0, up =3D 0, last, k;
> +		ssize_t i1 =3D free_row[free_count], low =3D 0, up =3D 0, last, k;
>  		int min, c, u1;
>
>  		for (j =3D 0; j < column_count; j++) {
> @@ -192,7 +192,7 @@ void compute_assignment(int column_count, int row_co=
unt, int *cost,
>  		/* augmentation */
>  		do {
>  			if (j < 0)
> -				BUG("negative j: %d", j);
> +				BUG("negative j: %"PRIdMAX, (intmax_t)j);
>  			i =3D pred[j];
>  			column2row[j] =3D i;
>  			SWAP(j, row2column[i]);
> diff --git a/linear-assignment.h b/linear-assignment.h
> index 1dfea76629..7005521d61 100644
> --- a/linear-assignment.h
> +++ b/linear-assignment.h
> @@ -14,7 +14,7 @@
>   * row_count).
>   */
>  void compute_assignment(int column_count, int row_count, int *cost,
> -			int *column2row, int *row2column);
> +			ssize_t *column2row, ssize_t *row2column);
>
>  /* The maximal cost in the cost matrix (to prevent integer overflows). =
*/
>  #define COST_MAX (1<<16)
> diff --git a/range-diff.c b/range-diff.c
> index cac89a2f4f..f1e1e27bf9 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -308,9 +308,10 @@ static int diffsize(const char *a, const char *b)
>  static void get_correspondences(struct string_list *a, struct string_li=
st *b,
>  				int creation_factor)
>  {
> -	int n =3D a->nr + b->nr;
> -	int *cost, c, *a2b, *b2a;
> -	int i, j;
> +	size_t n =3D a->nr + b->nr;
> +	int *cost, c;
> +	ssize_t *a2b, *b2a;
> +	size_t i, j;
>
>  	ALLOC_ARRAY(cost, st_mult(n, n));
>  	ALLOC_ARRAY(a2b, n);
>

--8323328-1793197666-1639146446=:90--
