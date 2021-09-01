Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26566C4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AECD60231
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbhIANKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:10:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41391 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244182AbhIANKi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:10:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E12F35C0200;
        Wed,  1 Sep 2021 09:09:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/1RpOEwJMrWz1nb/3Eg9Z84/a4I
        iIz+XEbkRA4d+bMg=; b=czcMyoa9L28fciqBG8uYLwNGfbeCQd7PkSAe2RApgJM
        fIdJE4XgdATv0fmx0tOKMyPdFakZc+j1PRCCoMYimDzNMvCt72OrySN8qBXhIAGf
        dYEg8eScnWQ7sm50eJYuXvNI8Mr8xHN/y48jj0RG4OlGAiPV4ipadrn4WWruNGka
        XPMwv2veipWps6RM2zVEbesxxg9LZmTPIrkimJFu1ddMkqQUEYV6sD93Bj+9Ga93
        1KwGYFP9KxuwmXj2vEu8YZ08JObeYKY6z6ecQJm1fV6i11RXnU0SyVJiOr/q2xZw
        1ehwrzsSiQogw1qNokvIKuRQtjqpVq1qHdKTSRCqEAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/1RpOE
        wJMrWz1nb/3Eg9Z84/a4IiIz+XEbkRA4d+bMg=; b=Nx0rp0eF3foSyNXSMM/9k0
        gbgp6utxmFWB8hnBrA72JtTjMRQRZbl6QZU+K32WfnY6qouyecums8Ub+C/RHY/4
        59HeAuc5Wh1At590bOnidm6+6qJaSs7/0Cj96djWWPJ5DX0SACGC32OD9W1Bw+e6
        F74GmhrPHNhGcE1byU1pBFgkYkvjdhL2LdTnQPdF3vn+ufC8JM2cU8mVDqBNlydN
        WRb2Kw1WK7phWyMC94jAvv9MP9CvEicIYQfZSxZ4sGflrbNUTC/r8rpC3za6shWr
        LPvGPsSD2A5v20Mv0QZRppAwzWhmESKUvsqff0IeJCXkW1FaeV4TVqUZRNvXJEZQ
        ==
X-ME-Sender: <xms:k3svYaSGglLNhnsiV86-6Oeg_EQJi_n4_iiHRkcRiPfKVCWNLQsdqw>
    <xme:k3svYfzHsAUll6VqBhZryVs1-uFSha9bwkCJuakRZC4zLo4tZIdrbBzaHQk2ULaP_
    7Xv4t5VOkvH7OCUjA>
X-ME-Received: <xmr:k3svYX3moRu9SjYUzbXD1YN3zXbXWyRydwAaa9q4PqGkP0zwqPxfp1cz7fEIDHpp8dxoFAllEWrCHSPTzeSBz-YA2oc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:k3svYWDdIl98czuNftA-7vgOJWIKcYOqNeRs3XW9bIzTdaGU9hGgaw>
    <xmx:k3svYThGgGUXZkH9CrdMds4VHJTMgWosLIlqwDkjTokTS4ahMKPC5Q>
    <xmx:k3svYSrSOkPhn5WZ8hQUUTVM0bpJffLNeulUIcECiqh8ZLRPYU3lDg>
    <xmx:lHsvYTcdnXDmKGqeZEXhWGXnNPyk0b7zGxmrOvIo1XXv7ruGpeLigg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:09:38 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d65b90a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:09:37 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:09:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 0/7] Speed up mirror-fetches with many refs
Message-ID: <cover.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6k0fQn6RnDIkAjJ"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e6k0fQn6RnDIkAjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to speed up mirror-fetches
with many refs. This patch series applies on top of master with
ps/connectivity-optim merged into it.

There's only some smallish changes based on Stolee's feedback (thanks
for that!):

    - A small typo in 1/7.

    - A confict fix in 4/7 required now because it's based on master
      instead of directly on my merged topic.

    - I've adjusted patch 5/7 such that I don't have to re-touch the
      logic in 6/7.

Patrick

Patrick Steinhardt (7):
  fetch: speed up lookup of want refs via commit-graph
  fetch: avoid unpacking headers in object existence check
  connected: refactor iterator to return next object ID directly
  fetch-pack: optimize loading of refs via commit graph
  fetch: refactor fetch refs to be more extendable
  fetch: merge fetching and consuming refs
  fetch: avoid second connectivity check if we already have all objects

 builtin/clone.c        |  8 ++---
 builtin/fetch.c        | 74 +++++++++++++++++++++++-------------------
 builtin/receive-pack.c | 17 ++++------
 connected.c            | 15 +++++----
 connected.h            |  2 +-
 fetch-pack.c           | 12 ++++---
 6 files changed, 67 insertions(+), 61 deletions(-)

Range-diff against v2:
1:  4a819a6830 ! 1:  8214f04971 fetch: speed up lookup of want refs via com=
mit-graph
    @@ Commit message
         that we repeatedly need to unpack object headers for each of the
         referenced objects.
    =20
    -    Speed this up by opportunistcally trying to resolve object IDs via=
 the
    +    Speed this up by opportunistically trying to resolve object IDs vi=
a the
         commit graph. We only do so for any refs which are not in "refs/ta=
gs":
         more likely than not, these are going to be a commit anyway, and t=
his
         lets us avoid having to unpack object headers completely in case t=
he
2:  81ebadabe8 =3D 2:  991a27cb82 fetch: avoid unpacking headers in object =
existence check
3:  98e981ced9 =3D 3:  ba834803ab connected: refactor iterator to return ne=
xt object ID directly
4:  6311203f08 ! 4:  99d3316d48 fetch-pack: optimize loading of refs via co=
mmit graph
    @@ fetch-pack.c: static struct commit *deref_without_lazy_fetch(const s=
truct object
     =20
      	while (1) {
      		if (oid_object_info_extended(the_repository, oid, &info,
    -@@ fetch-pack.c: static struct commit *deref_without_lazy_fetch(const =
struct object_id *oid,
    - 	}
    -=20
    - 	if (type =3D=3D OBJ_COMMIT) {
    --		struct commit *commit =3D lookup_commit(the_repository, oid);
    -+		commit =3D lookup_commit(the_repository, oid);
    - 		if (!commit || repo_parse_commit(the_repository, commit))
    - 			return NULL;
    - 		return commit;
5:  56a9158ac3 ! 5:  d64888e072 fetch: refactor fetch refs to be more exten=
dable
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *re=
f_map)
      		trace2_region_enter("fetch", "fetch_refs", the_repository);
      		ret =3D transport_fetch_refs(transport, ref_map);
      		trace2_region_leave("fetch", "fetch_refs", the_repository);
    -+		if (ret) {
    -+			transport_unlock_pack(transport);
    -+			return ret;
    -+		}
    ++		if (ret)
    ++			goto out;
      	}
     -	if (!ret)
     -		/*
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *re=
f_map)
     -		 * time to update refs to reference the new objects.
     -		 */
     -		return 0;
    --	transport_unlock_pack(transport);
    --	return ret;
     +
     +	/*
     +	 * Keep the new pack's ".keep" file around to allow the caller
     +	 * time to update refs to reference the new objects.
     +	 */
    -+	return 0;
    ++	return ret;
    ++
    ++out:
    + 	transport_unlock_pack(transport);
    + 	return ret;
      }
    -=20
    - /* Update local refs based on the ref values fetched from a remote */
6:  31d9f72edf ! 6:  56ecbfc9c3 fetch: merge fetching and consuming refs
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *re=
f_map)
     =20
      	/*
     @@ builtin/fetch.c: static int fetch_refs(struct transport *transport,=
 struct ref *ref_map)
    - 		trace2_region_enter("fetch", "fetch_refs", the_repository);
    - 		ret =3D transport_fetch_refs(transport, ref_map);
    - 		trace2_region_leave("fetch", "fetch_refs", the_repository);
    --		if (ret) {
    --			transport_unlock_pack(transport);
    --			return ret;
    --		}
    -+		if (ret)
    -+			goto out;
    + 			goto out;
      	}
     =20
     -	/*
     -	 * Keep the new pack's ".keep" file around to allow the caller
     -	 * time to update refs to reference the new objects.
     -	 */
    --	return 0;
    +-	return ret;
    +-
    +-out:
    +-	transport_unlock_pack(transport);
    +-	return ret;
     -}
     -
     -/* Update local refs based on the ref values fetched from a remote */
7:  84e39c847f =3D 7:  c342fc0c69 fetch: avoid second connectivity check if=
 we already have all objects
--=20
2.33.0


--e6k0fQn6RnDIkAjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve48ACgkQVbJhu7ck
PpTfjA//WeUqcfClwMvfERLI3NCXr052EVEY0misFj8pE/Xg9PiVIrhRRbvoiOPz
zIjquEo+ZFjlBrmS0E5nJ37fQ/ubPjzhz5G1uqFI6NEFl2qWXnPTG5Gy1bMvniis
fjg0eqSY58taZf5kg/eRIY0VLS+tO+jn1PqMkx3skj9UsyUBtgf6GAXxk3CemXPq
ISYg1I5LsGWYsoF2VbQNPAf8eNLtgHcVs2WXi8YwnQp0k4mFC1zOrpwlGEMryulf
3EIT1UuDXBRwn+UemB3siu5ZDTgRTOd/V1I83Lalj9Ife1dNlBn/+u6FLWFY/IA+
eyNpk650RVXK1prv+uR+Bzvh6oXmCWulRKsBQxZr0VE0/hn417tI9eNaS/3WE2f/
M/sPEIlmNFt6luDKjg8+vzLZUBXa5l9ZWoOhXVusKPikfr/BVwCzuOIcetTdPbZK
L+AdKjj9upLH8OQcQoVY+Qh4g/W+QLC3piuI7+a5OOpJ/O+fQLYWCW6E9Dhria0n
JwNoUAPEfR6Gvuzs/3p4OkbLs7Ip8L+WmqBrrd5xJw+BtMSzJVH5UK1wa0m+d6R+
1J/CbVFEoWh4n6Ol7pd69ZCo9JPnsrm+q//eNKCr/wA4N3VgYTYPidtpkB0lrilT
X4yfBAH+TJsYXMM+pLqI3nua89dlrUciQlj0Hm8uDjHLdikiH7U=
=R2UF
-----END PGP SIGNATURE-----

--e6k0fQn6RnDIkAjJ--
