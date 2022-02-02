Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31901C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 12:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbiBBMvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:51:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46931 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbiBBMvu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Feb 2022 07:51:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D54D5C013A;
        Wed,  2 Feb 2022 07:51:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 07:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=F7iFXmbgAK1JaXvx26yhzNB1lHVT+oAEYqezXJ
        daO0c=; b=CAD23dyzbe4HVLrljdLnQX5ujdka4hWzhRLqxdyUkC65wq/7ZDmO15
        4MtKmsXWWMv8J1kt2jUStp5eeuaNEYo4MFrThsuQ8r+yhksjFGK3+Az45K93iNyo
        U4J/E+pdAPnkDrr0JjNMEGjfsuu3rkcf5QD4auwEddIAe7VULhCQ+rd4sY1+mh+K
        /x5vsuEWVl3rNu26bGyYtu3bsSLiWBF/MqtLpbo2yXWAA0+rdc4kqdb/JgA6+rZS
        AFy/G72Kqk9UTIR9aBTM6o1PnqeMG7ZTaXijpGC9f9U005mtl7dv3HCG/cAsqX4Z
        qUeTNjkFYT9xI78Yn3ukNLgEnWuK6lPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=F7iFXmbgAK1JaXvx2
        6yhzNB1lHVT+oAEYqezXJdaO0c=; b=ldFfItrL2f+rzy4GzjHGeesp3tz2E6v9I
        4KakZ+ITecRDiGlL6EaYcunxiwicl7Sjs+A3p8GSo3ZhKE5mrlZVrvh1KrxEKkyL
        hb8dD2mgESMKEEKlGT7tQOm52VxQ4Tr1Gss675XmQsRpComUAxgmkhBN9QWfUU+n
        xjBIn+VbX+HBJR36FiLbe4c0icAgkCnrjMV6KpSGMqDjx8YcI8mt4+7k5k8JlsZl
        ryzAjAQEfqO3NnX/wkDmyp4+nJHKLdwGXbCXgm+eWoKF4zO7NuwCcrJOI2Vw9EcO
        2TLy1sZXdqqZVm0nFzGUGwAmKx9kEO6X1ORwG+vW/Q0MYcsTR7WMQ==
X-ME-Sender: <xms:Zn76YeV15tAs3JmdIRr_WbSVrON_mfcuo7DTBalj8VDwQQOyFJQsLw>
    <xme:Zn76YakMHo0brVtzXqCpdVrpxhLVntJsXenvbUDHio-tjp9by-cQLCflog-HK2dda
    jhf0Cx9XpbTx4jMew>
X-ME-Received: <xmr:Zn76YSaSV0YR4X4l2LJB1ku00YnjdKh7gLb6amfd0D39R5zuT1BYw2zcF_tYSqUqmpV6OX6fJHqu-oFdCRDCxiWlLUi6s_Yk7XNuvQmRV9wsUUz_yzpa9r58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Zn76YVXKgpRszTMmaxh_gVVLcrorEJ_RZtzOZB5synWjh1fzISD3fQ>
    <xmx:Zn76YYlIGDauD2y2Vei2LC7fifw1eLGZgZhKnny_7ckE3VqalsQt8w>
    <xmx:Zn76YaeUtAbV37Ca6DsqBs2WJF1148-erfAEJztYb7xXzsG4aN9sgg>
    <xmx:Zn76YUvrJoXC6l4zzyVOD0Nh1wFImOp1mgWgDw4HKMm0mRMcg7ZG8Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 07:51:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9e8b8c8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Feb 2022 12:51:49 +0000 (UTC)
Date:   Wed, 2 Feb 2022 13:51:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 1/2] fetch-pack: use commit-graph when computing cutoff
Message-ID: <6fac914f0fe77df4c3058340642bea2a45a850cd.1643806143.git.ps@pks.im>
References: <cover.1643364888.git.ps@pks.im>
 <cover.1643806143.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OfSfQT0dWZwQYuEe"
Content-Disposition: inline
In-Reply-To: <cover.1643806143.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OfSfQT0dWZwQYuEe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

During packfile negotiation we iterate over all refs announced by the
remote side to check whether their IDs refer to commits already known to
us. If a commit is known to us already, then its date is a potential
cutoff point for commits we have in common with the remote side.

There is potentially a lot of commits announced by the remote depending
on how many refs there are in the remote repository, and for every one
of them we need to search for it in our object database and, if found,
parse the corresponding object to find out whether it is a candidate for
the cutoff date. This can be sped up by trying to look up commits via
the commit-graph first, which is a lot more efficient.

Benchmarks in a repository with about 2,1 million refs and an up-to-date
commit-graph show a 20% speedup when mirror-fetching:

    Benchmark 1: git fetch --atomic +refs/*:refs/* (v2.35.0)
      Time (mean =C2=B1 =CF=83):     75.264 s =C2=B1  1.115 s    [User: 68.=
199 s, System: 10.094 s]
      Range (min =E2=80=A6 max):   74.145 s =E2=80=A6 76.862 s    5 runs

    Benchmark 2: git fetch --atomic +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):     62.350 s =C2=B1  0.854 s    [User: 55.=
412 s, System: 9.976 s]
      Range (min =E2=80=A6 max):   61.224 s =E2=80=A6 63.216 s    5 runs

    Summary
      'git fetch --atomic +refs/*:refs/* (HEAD)' ran
        1.21 =C2=B1 0.02 times faster than 'git fetch --atomic +refs/*:refs=
/* (v2.35.0)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2..c5967e228e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -696,26 +696,30 @@ static void mark_complete_and_common_ref(struct fetch=
_negotiator *negotiator,
=20
 	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NU=
LL);
 	for (ref =3D *refs; ref; ref =3D ref->next) {
-		struct object *o;
+		struct commit *commit;
=20
-		if (!has_object_file_with_flags(&ref->old_oid,
+		commit =3D lookup_commit_in_graph(the_repository, &ref->old_oid);
+		if (!commit) {
+			struct object *o;
+
+			if (!has_object_file_with_flags(&ref->old_oid,
 						OBJECT_INFO_QUICK |
-							OBJECT_INFO_SKIP_FETCH_OBJECT))
-			continue;
-		o =3D parse_object(the_repository, &ref->old_oid);
-		if (!o)
-			continue;
+						OBJECT_INFO_SKIP_FETCH_OBJECT))
+				continue;
+			o =3D parse_object(the_repository, &ref->old_oid);
+			if (!o || o->type !=3D OBJ_COMMIT)
+				continue;
+
+			commit =3D (struct commit *)o;
+		}
=20
 		/*
 		 * We already have it -- which may mean that we were
 		 * in sync with the other side at some time after
 		 * that (it is OK if we guess wrong here).
 		 */
-		if (o->type =3D=3D OBJ_COMMIT) {
-			struct commit *commit =3D (struct commit *)o;
-			if (!cutoff || cutoff < commit->date)
-				cutoff =3D commit->date;
-		}
+		if (!cutoff || cutoff < commit->date)
+			cutoff =3D commit->date;
 	}
 	trace2_region_leave("fetch-pack", "parse_remote_refs_and_find_cutoff", NU=
LL);
=20
--=20
2.35.1


--OfSfQT0dWZwQYuEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmH6fmMACgkQVbJhu7ck
PpSMig//TxDYLpSsrV8NJp133T/lmj8eRYXvnCq5m8hk/RJmKI9SDBHWyzQRlxRR
yNDR94V2E3XeVfRzphpkwfukH8CTKkj/VoMiHHNI/9jN4wZH2/9oI0qiP8AnTZxe
6JN6KoZ6kFCHauJoy0cSaKWGS3XyyjmbEk7syuj9Bu4DNdyNEizxGY2F33ANCHN5
vbXt1SbWMeRReyuTcUOdBXTLeflei+mC9Eq68c3C6ckLmHH+jfZBPS7SWepI1JiR
QMoZ+vOCv46zvfIKlG6CJq33qdbBRRfdxxJkFwoo9cQsqj9DLIFKnAKo+Bt8orI2
5ga722zd1JlFzjfc1ZnAgztusK5iu4GExywBahveY3rYOxYkS5y9nGcNXCjow6t+
/RPt6EcDim3VbY0TbhILyf8LD20usWuCvDRlU5fmqyY2LJCcN4lDPYY4AyAIJNXX
33p7i/tFXQPR7QAEVWsedOwnz3+pkYILcTJAt84+TIbet4dR3nj853ebq+vjdC3t
TDiIu8mrSSglMXfDDXlm7g8hQqasVm+m7pjaIAO7DRybb9P10o9xbi7p1SK2UhWM
lE7+zLi/+Ze2QXWFAnHT6REvZkJwmkWahLHr9Ftc0JDM/wTZ6MM6jg/EqVX/TYe/
Xhwx59K+iXonVjKJWv7Ys541NSb6YbDz0n+6s5F0YXe917sletk=
=CPRb
-----END PGP SIGNATURE-----

--OfSfQT0dWZwQYuEe--
