Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFACC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 12:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiBJM2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:28:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiBJM2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 07:28:11 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E3AE36
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 04:28:12 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C6A3A5C01B9;
        Thu, 10 Feb 2022 07:28:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 10 Feb 2022 07:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=8XhV+N4YcpiPPi42QnP52B/EntfnSiaJA2NtGu
        J6kvY=; b=oseMiXJPFusm4fF+sOeweLpBWPg2CouuJ2QR9UQE2VZSZ385BtWZpx
        CrVNDyHVcAb19qMGzbIATse5ix150cEixf8eDQaVxck6p2/GTSpHfEMUBXT2IZuY
        4a+3pD6BJaimnJZQvnmBWd3NEMUteS6s5dujxpsR/zl2rhxpHXQ3T39HJneqVCRQ
        zbXi1WMvOXee9rcNSwYvo8p4WYRQPPZxr89xDFQP3yL5EfBMEUHPA8HChsgjirZe
        NMZ8BklYheULldIaYXzYxiQV3nlSo9iKWLQFpKVUTk6uZtZfaKHLU7RoNrD7eenu
        W4mYRTh8TV4YCLXpXdx4807MeL0yrg8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8XhV+N4YcpiPPi42Q
        nP52B/EntfnSiaJA2NtGuJ6kvY=; b=KLe+jr3N99KWsNvWwc2BCwAbXPJztVOs+
        v7mVB7av2tocK5Rnu27oC/dYAuMTtxOsJOzlVI4YyJCwUaszecet4GBJVI3bdwUT
        68GHNNpfKRz5zuZxnWSGrqzuTcHktgnYSo7Pf6B9j1Ywd2qwWx8jJVo247zqvOfD
        JJ9vBarz3zrM8wdDejhNcgV5vqqJHlqZfMjgSF8J1MArIonGB1RJdoFuslJKblds
        dpWXoIP2UmbjMbIG1kGZP/nWS2q6GaAsSj4/6RxPpROg2nLuo9Idi5+KOhcvY2Hi
        goHfNcsiMARJbbfOoWkxEn9j6sX1gwZlFOUX0psXapm/cCt9o2bYw==
X-ME-Sender: <xms:2wQFYr3BqpL-2aRYiOPiY2Ue8oFeW7QOQjOK1Mq1sB0GXnxSnFw8ww>
    <xme:2wQFYqFn9qQbe0A6KBiO71YzX1lqzmxKBBoKMwmmhaUGZxwbj72pEi4F2T8N5gdTZ
    gyqz6MGfm5X9SVnFA>
X-ME-Received: <xmr:2wQFYr4d0btqFe6V2HrRI_8D1bTTv2EmfXT4wF2GqTRaSIRYn2XSFo7WJ6DF4DcIJj83B4nU61N6SkqAOjdcsJQE1n9Wi3mbWqkT6t7041vkKWWtO1SCz9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:2wQFYg3KzUyB1YFP8DUFMUxCtaxXNcjgm8kK8gDRxjP7GkdEdYMuUQ>
    <xmx:2wQFYuF5Zl03x-Z2Y1PVJ4OjjnI-iVY_2O0QzRBALYTZsmymORIYYg>
    <xmx:2wQFYh-ndNCtKRPk7FZscM2arL747kR5M3NoqgeWwQ9-D7pUz6XLSw>
    <xmx:2wQFYjSCOMl_qDGAM-hffB8W0JDtpIvIlyELV-LbeL4GNH7sMDvJlw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 07:28:10 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d9219af4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Feb 2022 12:28:10 +0000 (UTC)
Date:   Thu, 10 Feb 2022 13:28:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 1/2] fetch-pack: use commit-graph when computing cutoff
Message-ID: <077d06764cafde470ea0589072d387d7737bb91e.1644495978.git.ps@pks.im>
References: <cover.1643806143.git.ps@pks.im>
 <cover.1644495978.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="voi47ibQv+wnAfzc"
Content-Disposition: inline
In-Reply-To: <cover.1644495978.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--voi47ibQv+wnAfzc
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
commit-graph show an almost 20% speedup when mirror-fetching:

    Benchmark 1: git fetch +refs/*:refs/* (v2.35.0)
      Time (mean =C2=B1 =CF=83):     115.587 s =C2=B1  2.009 s    [User: 10=
9.874 s, System: 11.305 s]
      Range (min =E2=80=A6 max):   113.584 s =E2=80=A6 118.820 s    5 runs

    Benchmark 2: git fetch +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):     96.859 s =C2=B1  0.624 s    [User: 91.=
948 s, System: 10.980 s]
      Range (min =E2=80=A6 max):   96.180 s =E2=80=A6 97.875 s    5 runs

    Summary
      'git fetch +refs/*:refs/* (HEAD)' ran
        1.19 =C2=B1 0.02 times faster than 'git fetch +refs/*:refs/* (v2.35=
=2E0)'

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


--voi47ibQv+wnAfzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIFBNgACgkQVbJhu7ck
PpQjKQ/9HfzvULptvPVdFI63tBFJndggF09sPbj3eBDt2xrJkdsSh8xbrajVezcJ
G/40ctcbI+GN1Ij6tX/ndXJFdmaPMwJposK60ODFkbrR4r9irmO9loRJvSph9dsC
qvfc+KrGIkIQQ6ObO6hxiiJZ6PPwdBeBmnOyuHBbOrvoCfUS4thL8WEraAYtJv3t
KhC+ohTW4+HRMLyQq49EY7GoEV+py/gDgPkU8x4MhmkTeb5LEAO61ngaSRRuZU8U
QF4ZcpCRpSMAy1bG5+jRrTrh+Rbo2UAK+HIXW23Pmfwtw7VzgHieIHhi4I/LfSzY
cjqLp40l6yw9yicwZLI5wQvCe9QRMTc2VD7BavkSmvmnQInZmyoEdVRcbOSwQs4P
A4Hw1RiPzRXBRXJbqExDqg+rR35nxfRPNuG87Roi8GBwAJFlLMamDF+ERPMmPbIr
JQcYmhxAPCv25Aqz6DutuhroAknI0bF8DmjDfmqErOAxgzb/uRTqK+y02Qp9Evfe
1IfI05bVkIGVhnHDdz2SeELlWyBpzq3z8traQ+XEDoyIdhAj8nZHelgq0m3iLgMp
1Q+lKpaQ4ZjlFeNjuW41XkqOjhU5Na+RzcFRNjegC++RrSqDTZ8WrrJmQ09V4ago
D3J9rFWU4JcVvNH/vI6++WS3BNqAKC6qZCCIcsQOwbufLfKkJ/0=
=E2Kt
-----END PGP SIGNATURE-----

--voi47ibQv+wnAfzc--
