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
	by dcvr.yhbt.net (Postfix) with ESMTP id 714341F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 08:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfJIIPI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 04:15:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:37711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIIPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 04:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570608903;
        bh=OWCPNWSDoLCYRa6xEBYywXHEnXDkhWLJg5DpgTA4tKU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z7LwHeiEu5MC39X7aHjdBI3ewm4o/ax+5sdIUvFOd6jrwwHoJiTozpq2mSZIDhytb
         c+AF3JjUcGD7htm3P+og0r3cyGpKsSUmoJUQv5vU9FFNAIZCzM7C1IenUYL1khbcqE
         imh0PxJxR/t48jpUp5PfXJByWktDZZACED5qulZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1hg21241B0-00dGlS; Wed, 09
 Oct 2019 10:15:03 +0200
Date:   Wed, 9 Oct 2019 10:15:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
In-Reply-To: <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1910091011520.46@tvgsbejvaqbjf.bet>
References: <pull.378.git.gitgitgadget@gmail.com> <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com> <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aEyC+D6n01LLMoVJYMrQ2iNgZLbQlU1Ouc8lM+/YcQKoHat7uZG
 o3OSblPWz2/fbhv9lqeRGE73Nf0VsPXSz/GifOcxfDNw3lgObcBgD0KdkPBGR8tx2kcakmQ
 qDe1WflgSw6YGYhNAVReui4JstjqNovvhRphnqypLNDjn0Df59/wWjpz//AZd5vfead2Mnc
 mLY3n+pxmNubgAD4uILBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5zXwFsaHOVg=:7hysuc8Xgu8iQFlndAaCU6
 dQd9qJmwGrVR2sRl+8JiiSPsCw6i5cNcL15KjHiaOvSxy+8gsxrAp78nieHwNLACrzs2OMnoM
 t/KoK+augD3jFM8p68rqDN/DMJbR1wYI06sKrfmjqiXTnB0HcjE/brbcMwIcYeuB5o4y48tup
 pxNtBH5xN5sMUSjASnO2/mN8vrP5ROjQacWOz2l1zinP6ssvu10G7OOiLvRHRRm+gPnE4IZOR
 Ho2nVqCAX1tNAL4+LFdRYRXxpXk75AA9PfmnulGEVoQLgWJwO3kI4YGv4+2A7R1sg/Rd0vB7F
 75/o8zSYyyM2VflNFRBSLwLtyZYGheQjC5voojuviE7wJmgFgli1FQu+L2SH0euxSw1TZtG+K
 eGnEcRdNWTF7PFhsI4v4q8JmAu1lK/xJgC+mGDdPxUGpQcLSxfnKx+dRCo2x2475rn7Yb6KnN
 wAFe0g1hRY9aU1onm3Oz1ILOHpN2rel7DpVKR9sAzStRWoKjJill7nUOyw39yT78S5Ejm58x3
 sqd5b9RjyBEv+fyQ+9pqKlapku5Fo55pkm82HWfgRNBykqaO62pBOqUVvQ+Gg/h8RkTYASrJd
 DMsQpxM2hR5DH596AaBjXHdFNv5L4sjLg0LYjvbU9TUuDw3KjkaSBtgW4sEYhuq4JogfG4gTb
 11D056qROVWvpZNeD535XH8jQQe0wLTQwrzZmJ7BsxSSN6rI5aJXxiI6f7LZwMInX2Oy6z0fT
 KJ/VWx8JAGTRT72WmvqYiWC6eV0dZ42L64Adj3xl1XdrP3F0Q0Rb4cyJM+1KpbxyyI2nx8/Z0
 0nEaD7+Y7O9v5Jkqv+bklsK7JRKYvl/G6DSwo93k9XHil1xukF5yyoZ9BujHAivPXOQm7IyWI
 k0x+w6Bs1QLX4D7mq+cmBD2CfT/aiT8iV77YqpTgpRhlm8Rm7e5pMZfhnhag4TcBMbx5NrnBt
 FqNGx50hpc8HyVGnc4jljLDUyE1vIt51SkcFl1c8hmatiiDvOc7yxDN1y9CXSka1FpQrmrNXb
 87XkFx93J3DnPIRgHav0PMLgp9xVqm81IxhCjWrikXu6wAbCZ4bw2m45CZ5jj0H0q7Mx9jdb0
 j/ZoN0WHaVJDcNeiTLjo8kDjQZlYYjOZTi+4vELKjSJIZATpCpQtFYZD1JvaQ/5tytDgnrsgJ
 NkEk3MYPnpNPTMC42U2H44QtwIkfq/DNbC10K3HRKLriggfMoGUz1/OkbFkEIQZBkIgOqtlZC
 7Lzs0MMKYeGE9aa16taq0dzoxKvHjkUYrIwGzxwOPY0guCe4ilIzKena4XMQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 8 Oct 2019, Johannes Sixt wrote:

> Am 08.10.19 um 08:48 schrieb Johannes Schindelin via GitGitGadget:
> > We have just introduced the helper `index_pos_to_insert_pos()` to help
> > avoiding underflows when returning `-1 - pos` for cases where we want =
to
> > return an insert position, using the ones' complement (as `int`).
>
> We do not want to have it for *all* cases, where we return -1 - pos, but
> only for those cases, where the result was actually encoded by
> index_pos_to_insert_pos(). That excludes all cases where the argument is
> derived from index_name_pos(), and leaves just...
>
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -154,7 +154,7 @@ static struct rerere_dir *find_rerere_dir(const ch=
ar *hex)
> >  		rr_dir->status =3D NULL;
> >  		rr_dir->status_nr =3D 0;
> >  		rr_dir->status_alloc =3D 0;
> > -		pos =3D -1 - pos;
> > +		pos =3D insert_pos_to_index_pos(pos);
>
> ... this one...

This `pos` comes from that line (unfortunately not part of the diff
context):

        pos =3D sha1_pos(hash, rerere_dir, rerere_dir_nr, rerere_dir_hash)=
;

The `sha1_pos()` function was patched, as per Junio's suggestion, to...

        return index_pos_to_insert_pos(lo);

>
> >
> >  		/* Make sure the array is big enough ... */
> >  		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
> > diff --git a/sha1-name.c b/sha1-name.c
> > index 49855ad24f..bee7ce39ee 100644
> > --- a/sha1-name.c
> > +++ b/sha1-name.c
> > @@ -98,7 +98,7 @@ static void find_short_object_filename(struct disamb=
iguate_state *ds)
> >  		loose_objects =3D odb_loose_cache(odb, &ds->bin_pfx);
> >  		pos =3D oid_array_lookup(loose_objects, &ds->bin_pfx);
> >  		if (pos < 0)
> > -			pos =3D -1 - pos;
> > +			pos =3D insert_pos_to_index_pos(pos);
>
> ... and this one.

This `pos` comes from that `oid_array_lookup()` function that _is_ part
of the diff context. What you don't see is the definition of that
function:

	int oid_array_lookup(struct oid_array *array, const struct object_id *oid=
)
	{
		if (!array->sorted)
				oid_array_sort(array);
		return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
	}

There you go. `sha1_pos()` again.

So yes, both of these instances were changed to call that helper on
purpose.

Ciao,
Dscho

>
> >  		while (!ds->ambiguous && pos < loose_objects->nr) {
> >  			const struct object_id *oid;
> >  			oid =3D loose_objects->oid + pos;
>
> -- Hannes
>
