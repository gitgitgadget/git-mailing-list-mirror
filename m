Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4F91F453
	for <e@80x24.org>; Thu,  7 Feb 2019 04:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBGESR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 23:18:17 -0500
Received: from mout.web.de ([217.72.192.78]:54413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfBGESR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 23:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549513084;
        bh=E50iVPbx8cSptLfbiy2Sh6hHvtvvlGnO5uuP9tb68lI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VHmIQZCzuykflGlfdGoIjGcRqMQ579QqRw7OA8SGiU6rdBYL1Fi+CGb7w+CflfhmE
         9vDXH556jaCzJng0uOukQCpqNaHQcTUD2GE0gQo0wJrikwztSZO23WffAizcrEi1L9
         YFY/NMZxEEPJw8NqVXVPGU8Wjq/EPAw+bmr0Qeu4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzbDC-1hCvd80rbe-014lYq; Thu, 07
 Feb 2019 05:18:04 +0100
Date:   Thu, 7 Feb 2019 04:18:02 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE check
Message-ID: <20190207041802.ai25fc64sqfg2h66@tb-raspi4>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
 <20190206104243.GJ10587@szeder.dev>
 <20190207020022.GA29974@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190207020022.GA29974@sigill.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:uqH3i3A7aWdhdVG3Y5xlIUcG0iXMXay55hInIC1JL0vQXXC8J50
 GdhWg044dYG1jxzw+4MOesqoZTbLJrW9w3NglI9ni2BboLVTts2dKhztLVYSdoONnhGUvEE
 ighhk++GUrTjX+0puCx1kJD6sxUQDK9byzEKucEf9+F4RncJGbejyk4LkFJ45oN8lcnUdac
 nGJy43tSHqryY+y5XWgCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rHsoNLuEunk=:dH/e7frhGzoMPySDBQLPAH
 miw+r2pzXsiGZRg3jKv9He6gCLp8gCGZFCH34D+w8LmQiaENlOlvJqQuIeaALV0wmNTVAv8ml
 LlzMzxPE2Tni6CuFoJqFDRVkizQrCBNsYTumyl3lQXwFLbMFmVD4bD95wrudFQb+M1IS4nDJB
 qxUSHFr8/9rLt2Kq+9FPK7EtyBOoI1eo/O2+rEVP+ONTPUg0FpkF7aOmFmZnkRUzGMCqoyflL
 wSH9+5hmAmchCwFEKxGX/cgXONDoQPB3G4XL+x4qsjA2nKPU4KECej5+y7E+YGE/MgZzTqilH
 D3myEK49VXRIhsAztdSMIfGQJocWSoLIoBGC4y3gnJrbBIXAMBKRGqqhFxrQLDDjIGye5o8+a
 B05i/ZwYb7E+XQNffWIE9jrmgrZOUEf8VlRpLQFnI3uI8Ps7xrvdatAKR9S8b6Sv4LSBywVZQ
 wzu/s5Fy8jEf3+HBUznb9VzWfD8iQMhvyRCy7NeF+qLDZxWlxn3+fuAMvVrlo/QcGlzmJPmYo
 56XDFvX1KNjBoh4j0mjyxr2Dm1J7SkT0OtpRxOKw4VodKZfvtqJGNP747Nc7f9i9SG21PKhBI
 G6pp6zVKRjuU9cPjiq6reohQ/63swML/R3oJjmD+bEqUm1YRUZ0CkuvFLlMA63WPNdJHeU9cY
 sk8NqBZA8HRNgq7HFifNi3xrAh502bo80P0TjLi41j7LJdXirOYi1TJkTgLbl0oByuiOKRvTa
 moruKFSlEXYKSSKlvfQzJzJUn7ZUk9AcNCGGyWPZB4KA0IPoTZEqaxKhLbOV5+lW4XFApSN2S
 h9iAb+G0mcq2TR/S02ObleXYfv7FaUgvjE6CAq9BigJsdtR79qgzlJy3Xr0YXAPo/hbBGr664
 SCwOxeiLiAL+Fyyq2yHThMyka6uFwYu6Em80Bwe6/lS9Y75m5i6u+fXpCTECji
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 09:00:22PM -0500, Jeff King wrote:
> On Wed, Feb 06, 2019 at 11:42:43AM +0100, SZEDER G=E1bor wrote:
>
> > I reported this and Peff looked into it on the way to Git Merge, but
> > not working solution yet.
> >
> > https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.n=
et/T/#u
>
> Oof. Well, now I know why my attempts to fix the test failed. It was not
> my new test that was failing at all, but rather the existing test. Which
> implies that I severely bungled the actual code change.
>
> Armed with that knowledge, it was pretty easy to find said bungling. The
> fix is below.
>
> Junio, this should go on top of jk/add-ignore-errors-bit-assignment-fix
> as soon as possible, as the regression is already in master. And I'll go
> find a brown paper bag. ;)
>
> -- >8 --
> Subject: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE chec=
k
>
> Commit 9e5da3d055 (add: use separate ADD_CACHE_RENORMALIZE flag,
> 2019-01-17) switched out using HASH_RENORMALIZE in our flags field for a
> new ADD_CACHE_RENORMALIZE flag. However, it forgot to convert one of the
> checks for HASH_RENORMALIZE into the new flag, which totally broke "git
> add --renormalize".
>
> To make matters even more confusing, the resulting code would racily
> pass the tests!  The forgotten check was responsible for defeating the
> up-to-date check of the index entry. That meant that "git add
> --renormalize" would refuse to renormalize things that appeared
> stat-clean. But most of the time the test commands run fast enough that
> the file mtime is the same as the index mtime. And thus we err on the
> conservative side and re-hash the file, which is what "--renormalize"
> would have wanted.
>
> But if you're unlucky and cross that one-second boundary between writing
> the file and writing the index (which is more likely to happen on a slow
> or heavily-loaded system), then the file appears stat-clean. And
> "--renormalize" would effectively do nothing.
>
> The fix is straightforward: convert this check to use the right flag.
>
> Noticed-by: SZEDER G=E1bor <szeder.dev@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 9783c493a3..accc059951 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -746,7 +746,7 @@ int add_to_index(struct index_state *istate, const c=
har *path, struct stat *st,
>  	if (ignore_case) {
>  		adjust_dirname_case(istate, ce->name);
>  	}
> -	if (!(flags & HASH_RENORMALIZE)) {
> +	if (!(flags & ADD_CACHE_RENORMALIZE)) {
>  		alias =3D index_file_exists(istate, ce->name,
>  					  ce_namelen(ce), ignore_case);
>  		if (alias &&
> --
> 2.20.1.1122.g2972e48916
>

Ack, of course.

And trying to answer an older question:

>>>The reason appears to be wrong bit mask usage
>>>#define ADD_CACHE_IGNORE_ERRORS    4
>>>and
>>>#define HASH_RENORMALIZE  4

What if we had renamed "flags" like this ?

diff --git a/read-cache.c b/read-cache.c
index 5096e395ee..f93d291613 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -696,20 +696,20 @@ void set_object_name_for_intent_to_add_entry(struct =
cache_entry *ce)
 	oidcpy(&ce->oid, &oid);
 }

-int add_to_index(struct index_state *istate, const char *path, struct sta=
t *st, int flags)
+int add_to_index(struct index_state *istate, const char *path, struct sta=
t *st, int add_cache_flags)
 {
 	int namelen, was_same;
 	mode_t st_mode =3D st->st_mode;
 	struct cache_entry *ce, *alias =3D NULL;
 	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTR=
EE|CE_MATCH_RACY_IS_DIRTY;
-	int verbose =3D flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
-	int pretend =3D flags & ADD_CACHE_PRETEND;
-	int intent_only =3D flags & ADD_CACHE_INTENT;
+	int verbose =3D add_cache_flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND=
);
+	int pretend =3D add_cache_flags & ADD_CACHE_PRETEND;
+	int intent_only =3D add_cache_flags & ADD_CACHE_INTENT;
 	int add_option =3D (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 	int hash_flags =3D HASH_WRITE_OBJECT;

-	if (flags & ADD_CACHE_RENORMALIZE)
+	if (add_cache_flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |=3D HASH_RENORMALIZE;

 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
@@ -750,7 +750,7 @@ int add_to_index(struct index_state *istate, const cha=
r *path, struct stat *st,
 	if (ignore_case) {
 		adjust_dirname_case(istate, ce->name);
 	}
-	if (!(flags & HASH_RENORMALIZE)) {
+	if (!(add_cache_flags & HASH_RENORMALIZE)) {
 		alias =3D index_file_exists(istate, ce->name,
 					  ce_namelen(ce), ignore_case);
 		if (alias &&
