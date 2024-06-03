Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124188592A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408056; cv=none; b=Ej/+HkKJLU1R3rBY9H1gtE4Prwr0P8JjbGTUIyiI2Yvms+VTW63ub1QDgoUl+l0VR6kknDMICsMsyFOnA1OJwvfNW2lSPn2K45altBQIwrX/ovPbfYz4gOJ/RqJDrMfJrr+aVWx8rVBB2f4CGOGWXObDF7keswo8cfeuJMvr4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408056; c=relaxed/simple;
	bh=LkC14oqIHQvLc2X6lhBA6jNwGhREZdKCzkziC8KK4wQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnHZU7s3AsUjA02TXk0cunGfewFxfhimcKwWX2ic1PV8Eq93fSzbTd4tyvJDJPV15tRlNFIqFKeX+9LtuZ0fk/PTGBhUkyAdKDFwpm7HGzrE+hxYY0Xr0vkohlvz2GQlHk79wyH3/HqFz4Xbh2wqKI/vubwBa65faxiylwg27dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yuz7pIo+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VH+6hFKS; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yuz7pIo+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VH+6hFKS"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 632C91C000ED
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408053; x=1717494453; bh=JBoRb5aMJD
	6MUsYGw9NNcMZFlARemmIRyF9qoCitCsE=; b=Yuz7pIo+7Ho56RM2pC5q/x6wLF
	d55Pw2pARVjwM91aRlDvku41mCTJjlc0g+7IMM8OepZu1Cqe6WDSAVKZrUBUGrMX
	ylBhVQXnScVh11tU1seS1ok+Tq8pqhpbpIcPKk28VA/EJpcUWnucjkklgsRJZ9NO
	0CIJFKV+ZP0P9M+GrU8jGm/FZXFodzWCynBDNIjExi9OsYIT6ArtP6b4yV9t70H2
	Ov+1jQQJdjf16L3/dCXatZzi4tU+GMMzM72ULd4ePRtaBY1IPWlxO8pbV0WxyaXZ
	JH7h80NqogOvsOgM7KryOFgTrJKVdGUPtNayIo+BJZdybLT0dPPuKJsE73/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408053; x=1717494453; bh=JBoRb5aMJD6MUsYGw9NNcMZFlARe
	mmIRyF9qoCitCsE=; b=VH+6hFKSCl62miKy8uUtEy3D1yYMEKUaIYzYLxjvzTyp
	Z53Q7VuMtBqhG2CHVP39A3sgdDeWhE3taiBLWHZG33a/BSEdP0gubl6PmazOJJXD
	7YFjUDoIx/6Njek71TutlQ04S2iK08r3WFbGww6AlTF63ZTDu57u/+NDMqGnbS5J
	itp6lJKeA32vPf4MkRkQSIrQgLA/t8e1QCMpnHyWnWat1gHzl6vCFwxpm1Ldc4Nk
	BIwRXwZCQ6WYpdrWX9fG328OL5S2k/Kjy4llz2Xt3FwMscyFGhPdgiYgc2/8yvMS
	Mpo/rFvIDYtu0mTGqMQpKgGm3MMO2K7sCgIDdmrRZg==
X-ME-Sender: <xms:NZFdZmMiRY1_FI7p0RKhxsOADriQRl_70t5-8KYZD7qUZ7-17QmCXw>
    <xme:NZFdZk-yjhjDMwXKBVk1rB0rxDcw91mRKRPsZF6fZXjX9DugXrDq-dT1hJlFNiJ0j
    0JZBQ3tZ_QUCKNsIQ>
X-ME-Received: <xmr:NZFdZtQ9KYM2Fvf1VzcMzzqDq_4qoEyePoFNNKqKstlFsquMh4NrVtys3CTuiR2Jly5Hy7FbrLrbpY0gg68R7PFp2RitfoOdi_EDeM1IHUB19JUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NZFdZms3bwLy8-9viB8U9RtnYJ9L9C9KIuz3Nh_y95Mtiy7U-cYNMg>
    <xmx:NZFdZud-DBJ9Jz16xqnImceLgbs4-W4tbAnkwgZGPAX9jmLmGomjmQ>
    <xmx:NZFdZq0uMLmy14b6EcofThWlEvRUhApwd0F8OkElcSZP97AydpLKvw>
    <xmx:NZFdZi_fjKPXeziaZBpDhnynBetl68IMjaBgyz5pZfmdmNxFiR5HKw>
    <xmx:NZFdZiGlj_YtDBQejJ7pHxd7XcxLq-EEpM-zqsZXPL33OO57LFjFliwR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b5daa75a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:08 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/29] builtin/log: fix leaking commit list in git-cherry(1)
Message-ID: <3e3243f884abba99ea6143e92689c917937a5cbc.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y82gcFAzVEZvLPBp"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--Y82gcFAzVEZvLPBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're storing the list of commits that git-cherry(1) is about to print
into a temporary list. This list is never getting free'd and thus leaks.
Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c     | 6 +++---
 t/t3500-cherry.sh | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 37ecb3ff8b..b36fa9d155 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2675,16 +2675,16 @@ int cmd_cherry(int argc, const char **argv, const c=
har *prefix)
 		commit_list_insert(commit, &list);
 	}
=20
-	while (list) {
+	for (struct commit_list *l =3D list; l; l =3D l->next) {
 		char sign =3D '+';
=20
-		commit =3D list->item;
+		commit =3D l->item;
 		if (has_commit_patch_id(commit, &ids))
 			sign =3D '-';
 		print_commit(sign, commit, verbose, abbrev, revs.diffopt.file);
-		list =3D list->next;
 	}
=20
+	free_commit_list(list);
 	free_patch_ids(&ids);
 	return 0;
 }
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 78c3eac54b..61ca87512d 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -11,6 +11,7 @@ checks that git cherry only returns the second patch in t=
he local branch
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 GIT_AUTHOR_EMAIL=3Dbogus_email_address
--=20
2.45.1.410.g58bac47f8e.dirty


--Y82gcFAzVEZvLPBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkTIACgkQVbJhu7ck
PpRz8w/9EixQINiU1UM3n9wBnH2zRknqokNFByF6dS044/RqsOd3rfRQ9QgqoBSn
bqsCOx0RMUzGp43Pno7i+oMh7e3e9niqS9UK0LzGxTi+xrwKcG6nTs0WBKsvitnQ
kp5fmD74RGVW+TJE0iVN/tS4dzK2aQF9C3v+MtzISF7SEJAkcPamlKHc1OV/WDSO
X4qjmR5sBJME6g9Ni9A10XJKLIyY0ViTf2X/kiya/dLzssQynFl9LLPekqjNUkZR
JEOzxFGyBRcLG9+IACxQNpPS8VLalS8fqBTaB+0/Fk448qw0+/FJbBRiUsIqdJLl
hCe858q7vA1w23RZgbPHcAwyX4HBFiISSrniR6KBuHo+Xkx7JHYwyUUhmSKh/JlF
lcYqjTMT/XUzTib5LOazhcD9vucYHMv+GuNhSdNOLk3yUhWtiCYk/wPp5PDpRFWG
4rRBoHlrBzVPcCdHXLd2o/5Pyd0y94bFkSSeNAu4YTDq0zLcEskSdU2WFIPWj8RX
tJAXlV56dC6lsA0CxAAhWwBI8LgGe9bd0hveqbc5vM5mu5DCRGY6YrXZYajLEi6l
+472yQfrB9igCAXKA1epPssITxlZ0HJ2A2BBVcrgeBub0/6vVpD+RpSRxWesm/1D
WcsA6a9huFJn3qDqc41cM1TbWDeEc2ZaNJBndYx/H/3pYHvWlzM=
=+Sls
-----END PGP SIGNATURE-----

--Y82gcFAzVEZvLPBp--
