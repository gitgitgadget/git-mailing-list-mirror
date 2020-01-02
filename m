Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E2EC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A52F21655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WhTshqaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgABUwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:52:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:41301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgABUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 15:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577998354;
        bh=H3Y8HawPDw/cwE7NRu73W5+5UV/SlRasCyN1xX5TvY0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WhTshqaWRNYE1r+MhjUZ+u6usPJuVtP+CXLdNBW80SIfLre3zJ6nZYg3epd0PcAoW
         +SwCPc4DeeJ67Ti6T/flAs6OIgYhl32o7GC8iQbSvN7nzGXDpA3pXHQnyb+v0jHqmT
         m4finLAopFZsCcIRKhrfJTB0uy21hhgnUOHmzcm0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1iv8Lf2GrV-00AJ2V; Thu, 02
 Jan 2020 21:52:34 +0100
Date:   Thu, 2 Jan 2020 21:52:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/1] merge-recursive: remove unnecessary oid_eq
 function
In-Reply-To: <c653a9b8d3863b3484eff224bbfbde65c250eaf0.1577856057.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001022151490.46@tvgsbejvaqbjf.bet>
References: <pull.685.git.git.1577856057.gitgitgadget@gmail.com> <c653a9b8d3863b3484eff224bbfbde65c250eaf0.1577856057.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nG4qE9xy4WxoNOsUEFtkEymy+aHTX3/wKfwP9xX9wlgyhBJ6QJx
 YcpSKM2ZGfO7mqb7uj3YJ7tnWia9eMdrPUJAWTxOPh5jy2RcUzxaSShpj/9vZJI4mF4L1Wp
 mP7lIGpSxVZOmWWI1wfIaPV5aHIY9zCc0g+vQXwgBvTVpvn6xYLd1vhL9jqSFIMmKReibO3
 rfqS+yM9WmLeLclJsu7hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:er6Kdn6y9No=:8zeGHKtvrGChTvcEpki6eL
 0nJzE/1KB93SbgmzRVULQcjDtuCEKGvqXiuDVQtjNPsbnEO4u6Rzm8uprZCkCTUj41+AxMugs
 WOnhJ6HlGejcs/T+O8AtjSgwmghzzI+l+URYkfNUO7foz/C6bI64s/RcqchsQEWLwiiN9vLBC
 Jb+/pzoC9j5JrpYLvE6uYpG+JpF0JcC5KmfNdQXd0uoRS8hCzh5yanw1lvDUvgTbsZK36/+8X
 f6n+2WcrXr/JhVwb8rZ71kjPRW2lwQzWZvrkHlGiMjzkSPeEnQ5AHmM7J01GJnr9NTwLmj4p+
 DdDbfICYuFvPSy/v+JRtARPVyxgZCqxneNBMKwuCwB7Oy4uDN3KOszWhrXSr+YQBhc/y6abcR
 VETAZO68gGENmvi8dfy6CIi4/XuTcv1g77GsxHHyyduJb3N/nfQzO734VvHCPsmbem2EChHfp
 4A6BtagtwxDQ53nWua7j2/ujo9EHlG0KwAJ/615YRJK/eFKLwpnxr+GvWT3DKdxSA3NunV/+y
 46r/Db4yU5/Sn9pNdyev//04D6V7Bx9sorePj260cWRvlrU8V7jrczTXRA8roqc0NIql1qBHV
 81tf1VEn9vwiCsD9STfeer4bthyreaLuHje2BFOpyM9+GpCShVS6VZdPfAkNHBWn+wOMfpliM
 qEuX/r1f1D4+uI80rmZy9KNwBrR/WpAStlth4VPaEW1uT6Qf+vjM8qot5yAmI98Pne/+hB6bD
 sPo3wqtew3eMcprz7eUOc3RWhv71SDbuZLuOBYfPnqhtL3GfAAgTUo4lLlsj8B6jFk4xrUywg
 aDO1xUfC+0pGwKoxZQDd5HT9TKNnI3G6SEEF61FbWip9dNX83Ux62YtrXEoe5eFFO69wTTX0p
 GMt4lV3WWc9bHn2GQvQSA9+ibUy7jWvxfmBlLm4c97XJYUYwGho7ntf0PEoQytSEg8j9NA8yD
 /85isgFPelexnaQ4CdFJMa1b7Mp/tK5PW+7c3zQ5OEMPiBgW8n4KAKMHhvPp9yc9QtXPBXG/A
 WspJzs8UL2gHd1D1Sk5Imu3b6q66Z533ltRaZIJpRrVGuJ80wKIJGHfcICGJpYpnNebu12Bf1
 bLJu48lDFi5Npc/rM+uNgcGxbMv4vJe3IaAUUBEikPjkp80+4GoS30zSPN9Csjzco/GKb1NSa
 n5GgjsrGtn2pEbhjgM1thAozJuyjwKZpkzk7BCqV4VTY7G4xVFXt7fcwIgCLE88go6zDIUTtv
 Rez+fvcLgb5xjPmIELbUr5K9HP5Bt2yb9u63xS3bSzhqLjsEUXh48LJq/G6E=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 1 Jan 2020, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Back when merge-recursive was first introduced in commit 6d297f8137
> (Status update on merge-recursive in C, 2006-07-08), it created a
> sha_eq() function.  This function pre-dated the introduction of
> hashcmp() to cache.h by about a month, but was switched over to using
> hashcmp() as part of commit 9047ebbc22 (Split out merge_recursive() to
> merge-recursive.c, 2008-08-12).  In commit b4da9d62f9 (merge-recursive:
> convert leaf functions to use struct object_id, 2016-06-24), sha_eq() wa=
s
> renamed to oid_eq() and its hashcmp() call was switched to oideq().
>
> oid_eq() is basically just a wrapper around oideq() that has some extra
> checks to protect against NULL arguments or to allow short-circuiting if
> one of the arguments is NULL.  I don't know if any caller ever tried to
> call with NULL arguments, but certainly none do now which means the
> extra checks serve no purpose.  (Also, if these checks were genuinely
> useful, then they probably should be added to the main oideq() so all
> callers could benefit from them.)
>
> Reduce the cognitive overhead of having both oid_eq() and oideq(), by
> getting rid of merge-recursive's special oid_eq() wrapper.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

The patch and the commit message look good to me!

Thanks,
Dscho

>  merge-recursive.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 11869ad81c..10dca5644b 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -224,17 +224,6 @@ static struct commit *make_virtual_commit(struct re=
pository *repo,
>  	return commit;
>  }
>
> -/*
> - * Since we use get_tree_entry(), which does not put the read object in=
to
> - * the object pool, we cannot rely on a =3D=3D b.
> - */
> -static int oid_eq(const struct object_id *a, const struct object_id *b)
> -{
> -	if (!a && !b)
> -		return 2;
> -	return a && b && oideq(a, b);
> -}
> -
>  enum rename_type {
>  	RENAME_NORMAL =3D 0,
>  	RENAME_VIA_DIR,
> @@ -805,7 +794,7 @@ static int was_tracked_and_matches(struct merge_opti=
ons *opt, const char *path,
>
>  	/* See if the file we were tracking before matches */
>  	ce =3D opt->priv->orig_index.cache[pos];
> -	return (oid_eq(&ce->oid, &blob->oid) && ce->ce_mode =3D=3D blob->mode)=
;
> +	return (oideq(&ce->oid, &blob->oid) && ce->ce_mode =3D=3D blob->mode);
>  }
>
>  /*
> @@ -1317,7 +1306,7 @@ static int merge_mode_and_contents(struct merge_op=
tions *opt,
>  			oidcpy(&result->blob.oid, &b->oid);
>  		}
>  	} else {
> -		if (!oid_eq(&a->oid, &o->oid) && !oid_eq(&b->oid, &o->oid))
> +		if (!oideq(&a->oid, &o->oid) && !oideq(&b->oid, &o->oid))
>  			result->merge =3D 1;
>
>  		/*
> @@ -1333,9 +1322,9 @@ static int merge_mode_and_contents(struct merge_op=
tions *opt,
>  			}
>  		}
>
> -		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &o->oid))
> +		if (oideq(&a->oid, &b->oid) || oideq(&a->oid, &o->oid))
>  			oidcpy(&result->blob.oid, &b->oid);
> -		else if (oid_eq(&b->oid, &o->oid))
> +		else if (oideq(&b->oid, &o->oid))
>  			oidcpy(&result->blob.oid, &a->oid);
>  		else if (S_ISREG(a->mode)) {
>  			mmbuffer_t result_buf;
> @@ -1368,7 +1357,7 @@ static int merge_mode_and_contents(struct merge_op=
tions *opt,
>  			switch (opt->recursive_variant) {
>  			case MERGE_VARIANT_NORMAL:
>  				oidcpy(&result->blob.oid, &a->oid);
> -				if (!oid_eq(&a->oid, &b->oid))
> +				if (!oideq(&a->oid, &b->oid))
>  					result->clean =3D 0;
>  				break;
>  			case MERGE_VARIANT_OURS:
> @@ -2836,15 +2825,15 @@ static int process_renames(struct merge_options =
*opt,
>  			dst_other.mode =3D ren1->dst_entry->stages[other_stage].mode;
>  			try_merge =3D 0;
>
> -			if (oid_eq(&src_other.oid, &null_oid) &&
> +			if (oideq(&src_other.oid, &null_oid) &&
>  			    ren1->dir_rename_original_type =3D=3D 'A') {
>  				setup_rename_conflict_info(RENAME_VIA_DIR,
>  							   opt, ren1, NULL);
> -			} else if (oid_eq(&src_other.oid, &null_oid)) {
> +			} else if (oideq(&src_other.oid, &null_oid)) {
>  				setup_rename_conflict_info(RENAME_DELETE,
>  							   opt, ren1, NULL);
>  			} else if ((dst_other.mode =3D=3D ren1->pair->two->mode) &&
> -				   oid_eq(&dst_other.oid, &ren1->pair->two->oid)) {
> +				   oideq(&dst_other.oid, &ren1->pair->two->oid)) {
>  				/*
>  				 * Added file on the other side identical to
>  				 * the file being renamed: clean merge.
> @@ -2859,7 +2848,7 @@ static int process_renames(struct merge_options *o=
pt,
>  						      1, /* update_cache */
>  						      0  /* update_wd    */))
>  					clean_merge =3D -1;
> -			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
> +			} else if (!oideq(&dst_other.oid, &null_oid)) {
>  				/*
>  				 * Probably not a clean merge, but it's
>  				 * premature to set clean_merge to 0 here,
> @@ -3037,7 +3026,7 @@ static int blob_unchanged(struct merge_options *op=
t,
>
>  	if (a->mode !=3D o->mode)
>  		return 0;
> -	if (oid_eq(&o->oid, &a->oid))
> +	if (oideq(&o->oid, &a->oid))
>  		return 1;
>  	if (!renormalize)
>  		return 0;
> @@ -3478,7 +3467,7 @@ static int merge_trees_internal(struct merge_optio=
ns *opt,
>  					       opt->subtree_shift);
>  	}
>
> -	if (oid_eq(&merge_base->object.oid, &merge->object.oid)) {
> +	if (oideq(&merge_base->object.oid, &merge->object.oid)) {
>  		output(opt, 0, _("Already up to date!"));
>  		*result =3D head;
>  		return 1;
> --
> gitgitgadget
>
