Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A34C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17904601FD
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 13:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbhHDN4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:56:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50773 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236659AbhHDN4e (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Aug 2021 09:56:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 967B4320070D
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 09:56:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 04 Aug 2021 09:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=eTbQLDSwxthFcgNX1a2OFe51tWkpT2hDVnWN+M4JM7o=; b=aSrz8F/YfUcC
        TcYz6F4Zm4b8TS0puZ1UNoMcBM1rM3on2nrp7bxVVtlEAeAvrkBn7VjpSGJ4iIJU
        MUeTTGzbew3Cqki7TkKVyQcBuo5pjqJGWtBl6xQvIj8hc8IWHgaHgKFiP44hvm+U
        IEXZedPEK9eBdOv8RhImQaLp5EM7Q55D1D3KJAS7Z22WVDRr+4I2Ux8GVuWb1BNy
        lpRfyPmon+CpmnWwI9yjGhoVcTpbd5DJvcak8U5swvwC6Wf2KFiQ892dTk5eZaf0
        OwQqD/+YaP1Smm7abmVF3fZNHnX7s5crw3/irjA2u+6DKKUMoIiJYb6MR2qihAMT
        xmkSXgxsaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=eTbQLDSwxthFcgNX1a2OFe51tWkpT
        2hDVnWN+M4JM7o=; b=a2ZU3PwP4evFvcRbYBRosmQSdvkowtpAJost/kpddq31G
        tmk9Ig6Lxiuyqu7H/s6U0IPxJ/pzb9TW3jqkwFeTNVRq8F+gNmdao4o04NaSV1hb
        XF1ESUlFKgNEne4ITbtWOIfHxMyLztk9iXpSx/PqqbivCXiknJVKzYjSwomfORx4
        wWGEESZmzzMLTigDCzUcbQvKA/PlWJuj3zX2kbFl7Mfobg7SCqbyR/8Afsw05vPR
        EvTBC3RtYeHyFrrR3hZGXrlli5rwQ6QjHfL5wdHa+ycmW/R5Pg+w8aVbBHqap4QD
        6fdA2BZ0o+4PMd3a2kYH0UfiB8ALUV74xr50ZRUrw==
X-ME-Sender: <xms:hJwKYV1y8Q5RUFKn6e5wMYePNPZsY3-H_1nSV3olx2wPGi_tkQ7qmw>
    <xme:hJwKYcFbP6VpFp8XXXVUIOmVWvzeURLpsWzlxkXt9KFyDUh0iJaa598MpFTek6Hsr
    mxMt1FY0UEhUaD-Cw>
X-ME-Received: <xmr:hJwKYV7PtTMGXYYhUUgS_Ov5eGSKu9d-OloRbR_BW3Z5Kshy6K4XdwYe9xSnl10MU5vW5DNPDwHjTBSgbH964li0aXni8Ir2TQj2YClKkmDzakcxqdJBlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieejgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejtdefffetudfgvedvjedtheejgfdtvddvteehie
    etudeutdetieelteekhfefueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:hJwKYS0rQ1CyuxbixeRbvi_BHqjdlJjhfZOms4ywQWW1KMgiqBwcrQ>
    <xmx:hJwKYYGUI5U_BtM1yVb4YARqLHCzBeaNvE3caiI1_RddpvDtqPT5jA>
    <xmx:hJwKYT-9ZL3wIptZ2znpDIFetipkU848TIwc0x9DzWwXNyKiRumw1g>
    <xmx:hZwKYbzl0Dj_n0Nn82qBApFYVqYtx_yW2UeCBWpPxqCHNDX7yXCIYg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Aug 2021 09:56:20 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3169b472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 4 Aug 2021 13:56:12 +0000 (UTC)
Date:   Wed, 4 Aug 2021 15:56:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9F7sNZDdcEYJm8DX"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9F7sNZDdcEYJm8DX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing reference negotiation, git-fetch-pack(1) is loading all refs
=66rom disk in order to determine which commits it has in common with the
remote repository. This can be quite expensive in repositories with many
references though: in a real-world repository with around 2.2 million
refs, fetching a single commit by its ID takes around 44 seconds.

Dominating the loading time is decompression and parsing of the objects
which are referenced by commits. Given the fact that we only care about
commits (or tags which can be peeled to one) in this context, there is
thus an easy performance win by switching the parsing logic to make use
of the commit graph in case we have one available. Like this, we avoid
hitting the object database to parse these commits but instead only load
them from the commit-graph. This results in a significant performance
boost when executing git-fetch in said repository with 2.2 million refs:

    Benchmark #1: HEAD~: git fetch $remote $commit
      Time (mean =C2=B1 =CF=83):     44.168 s =C2=B1  0.341 s    [User: 42.=
985 s, System: 1.106 s]
      Range (min =E2=80=A6 max):   43.565 s =E2=80=A6 44.577 s    10 runs

    Benchmark #2: HEAD: git fetch $remote $commit
      Time (mean =C2=B1 =CF=83):     19.498 s =C2=B1  0.724 s    [User: 18.=
751 s, System: 0.690 s]
      Range (min =E2=80=A6 max):   18.629 s =E2=80=A6 20.454 s    10 runs

    Summary
      'HEAD: git fetch $remote $commit' ran
        2.27 =C2=B1 0.09 times faster than 'HEAD~: git fetch $remote $commi=
t'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b0c7be717c..0bf7ed7e47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -137,8 +137,14 @@ static struct commit *deref_without_lazy_fetch(const s=
truct object_id *oid,
 			break;
 		}
 	}
-	if (type =3D=3D OBJ_COMMIT)
-		return (struct commit *) parse_object(the_repository, oid);
+
+	if (type =3D=3D OBJ_COMMIT) {
+		struct commit *commit =3D lookup_commit(the_repository, oid);
+		if (!commit || repo_parse_commit(the_repository, commit))
+			return NULL;
+		return commit;
+	}
+
 	return NULL;
 }
=20
--=20
2.32.0


--9F7sNZDdcEYJm8DX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEKnHoACgkQVbJhu7ck
PpQjOxAAlsX3PIRj04t/0YyZ4TQAzP7CF6K04mEtr5fEv0n6G65O4YZNWXrLTufw
Dwp9+KKJyQdrRwzU410iIeScL3fOXXt7qHZoZIGSWmLGxt/oBN75QsL0gojjKRGU
mXQPvY+ptJxGy2epD2Ww0vsHSgHF5wjAsaTSppK+MWn7d2xY3xbXj6Bz8gW2DzZw
k+SwGCEkEJso+nF+E1cyFFJE5ANgbMLKYlJkG1sjjWsnGZhcY5hJgjunUkzDSef8
Ve44X3TVZfMEsPcJfF2kOP0fEmhb7cAQ94vTnMXxp7B4VMAuP1L9XbuX7gsVflbl
0/fMvZykqVI1tdLuAwVntZ1pifJdYhdQS5XMK7nB7O87B3+kB8I87QiD2yHNybSy
Ym7tWxPQxcPl2gbXUWVIYJtz5rpS8++DsT11sjFoi2nLA45RaNVKaWYvM+e5SuQ8
3LfIeVgifEpHBxXu8q3MxzvJVHcmdKgBv33L2CIUOYFgHhCM2qU44YiJUhIPHUKD
60MwiBo9+AiM92k3yB12ge7kj7hk5eiA7Fem4HGbeK91z2eTdwdgst4esLC+XDSi
FWkn/uNY9mmu5ljh8bqB3xZIh557wCN0t9ftcSop6BI4iGFks2ovZNZLDiP3dBMp
dCPJoumqxloPKiM0I9RCM7iqe934mdJURPAEs2KE/wC+9xK1wBI=
=HJkR
-----END PGP SIGNATURE-----

--9F7sNZDdcEYJm8DX--
