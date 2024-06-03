Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB182C6B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408018; cv=none; b=hYEa4eqQaeNYJJONOK8XT7jageLm+JaFRPG2tB9Jg23Mssgh1PrvvZQ0wqM7sR+MTYU/VAjk3MnKYcCX/+QHbn7cY8885d7nlhUmu6NXTAD6sdBRcZY26W6Fw+fu3XuoeY/QF9N1Dwllj6bJ+qEqcwu7UpW6eaJJKEuyfqNnIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408018; c=relaxed/simple;
	bh=zlMKIdk9BwM8VNhJCEquRroadmTYOVjjcdkoeIb+i9M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhBYzOtVqjUAVn3X4UIgVwjjSBCoBD2nIWQUz/LVGySZqkEDWLSFkEAqQ/XRSo1NqZBAvAXqtD69OIDc09GwHMZ/4tJ/rBAQfscz9J/d0JuGf4aTMOR994wpdT5xSY60TMw/zNj4aIWS34cI+zkGOT8tVxCAVAa8Fxi2vfJukD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MU8IYvkg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gms5E/P3; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MU8IYvkg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gms5E/P3"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3068D180009A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 05:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408015; x=1717494415; bh=xzutLe5ERk
	8xX/ucs5Ni9Z1FSspwcYJYWf4iLyrp3Is=; b=MU8IYvkgE/+sLlAAxU5XGXOYFl
	qPTmI9uBzk9KukIGv1suuVM25745KOfXzk12FTbKCvrqWWq8oHSWzt2jBRxCHrtb
	S0ZYrXm1L0Cocq15qoihiWUMaACCQUVyzNXv3RcvkvGd7aRnPzXYw4p56VnC4Ye7
	+K4d8K9SpxWXLGkeA93DjkBmh1+huhKR1rwsOo5RQ4xtU0SH+7cwIBl99Ob9PhDP
	De71eTCCr586TqfXG6poEGTQcIQukUz6IR9YRHHEa6Mlnz4hlnf5Pj0Qm4UAVAbx
	TLZPg516mZCiuNGgiIeyLaYfY4i8ROz+0eSUSEA8T+otSXS9VgmrS+mZNiUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408015; x=1717494415; bh=xzutLe5ERk8xX/ucs5Ni9Z1FSspw
	cYJYWf4iLyrp3Is=; b=gms5E/P3O85eOtx5vANbcCmpVqYo1+9Eml1jWNq5SwP/
	sRgr0lQFem9WevDu1M6C14y9VgjOPZVv+rh7O2nDTvrdlhhgkggi3kZy5Sx1IkUd
	a91qbUxhoEAHRzaZPuv28+dBGbZ7TETYE2YY5E5O1LIeuoz1G8QlQNmSJ1fBKcb/
	+dhwF7EC9fwz6/kdacJTQl3X+Kn/Y/fBgzt+UvLPGO47EtwyD4CxYCZBM18Ps6nw
	tlKc4pxbSiVMqcYyEo1Cv1Y3ixe6dcKyEdVv3a1bcE24RzlW8LH1XjHuwcq5q8Xm
	hfDpusqzoRRFU7x+6l86jY16MFu4AsEdD7BkTnJM/g==
X-ME-Sender: <xms:D5FdZgq5pvx0D3Cc5Dk3lamFuOGQ78JbHcCO4ddBAOmp1Re_HN2OVg>
    <xme:D5FdZmrhaebQyziZNdVr7j52oGPhSYxWyWM5kBLz125U-0_6zkqTedPIgz7iWC6SK
    crnUClHM2WucnFgNQ>
X-ME-Received: <xmr:D5FdZlOOsuwUsykqKtnJasFFKeAjbVtpF4bnkglnwLowivGE94AxP9bVec1p4myPeHCkJH9LrlzVQcX006XaRuK2mPGMpZU230xED2U5uhEGxXFS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:D5FdZn6XTKfTSjV08xkQO6U__JZl1M-hSWqSOFWlzXtgjs8q3JNd6Q>
    <xmx:D5FdZv54IzQ3_fcuktYozXpLmUSBio-h1sCSsSm1dc3OUgref7ToKg>
    <xmx:D5FdZnhU3WBpDivN_7xZ3CiKwaOaM7xTZdOvZEuGmHkYxOjW7IOnMg>
    <xmx:D5FdZp5YXnkYMyFdfUxEgesoiuDrrigqqQg0bckDlC-a8slTZi18iQ>
    <xmx:D5FdZpTUg2Uq8dtZRd60KRYAHzJw_zV1Wsv1ILru9bYZX3U9l4dKBv5C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 003dab4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:30 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/29] merge-recursive: fix leaging rename conflict info
Message-ID: <0052d60ee889981f2ba92c9781e1659e961eace4.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nTGnxwJps+PwnKzd"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--nTGnxwJps+PwnKzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When computing rename conflicts in our recursive merge algorithm we set
up `struct rename_conflict_info`s to track that information. We never
free those data structures though and thus leak memory.

We need to be a bit more careful here though because the same rename
conflict info can be assigned to multiple structures. Accomodate for
this by introducing a `rename_conflict_info_owned` bit that we can use
to steer whether or not the rename conflict info shall be free'd.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-recursive.c                  | 8 +++++++-
 t/t3401-rebase-and-am-rename.sh    | 1 +
 t/t4153-am-resume-override-opts.sh | 1 +
 t/t7201-co.sh                      | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8ff29ed09e..8c8e8b4868 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -239,7 +239,8 @@ enum rename_type {
 struct stage_data {
 	struct diff_filespec stages[4]; /* mostly for oid & mode; maybe path */
 	struct rename_conflict_info *rename_conflict_info;
-	unsigned processed:1;
+	unsigned processed:1,
+		 rename_conflict_info_owned:1;
 };
=20
 struct rename {
@@ -308,6 +309,7 @@ static inline void setup_rename_conflict_info(enum rena=
me_type rename_type,
=20
 	ci->ren1->dst_entry->processed =3D 0;
 	ci->ren1->dst_entry->rename_conflict_info =3D ci;
+	ci->ren1->dst_entry->rename_conflict_info_owned =3D 1;
 	if (ren2) {
 		ci->ren2->dst_entry->rename_conflict_info =3D ci;
 	}
@@ -3055,6 +3057,10 @@ static void final_cleanup_rename(struct string_list =
*rename)
 	for (i =3D 0; i < rename->nr; i++) {
 		re =3D rename->items[i].util;
 		diff_free_filepair(re->pair);
+		if (re->src_entry->rename_conflict_info_owned)
+			FREE_AND_NULL(re->src_entry->rename_conflict_info);
+		if (re->dst_entry->rename_conflict_info_owned)
+			FREE_AND_NULL(re->dst_entry->rename_conflict_info);
 	}
 	string_list_clear(rename, 1);
 	free(rename);
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename=
=2Esh
index f18bae9450..328c1d3a3f 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git rebase + directory rename tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
=20
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-overrid=
e-opts.sh
index 4add7c7757..6bc377b917 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git-am command-line options override saved options'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 42352dc0db..189d8e341b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -23,6 +23,7 @@ Test switching across them.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_tick
--=20
2.45.1.410.g58bac47f8e.dirty


--nTGnxwJps+PwnKzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkQsACgkQVbJhu7ck
PpTfzg//dcDXwdAeAmJZtbu0o1h5g9Zqa+c0T1CY+xccqfipykpExL76mB9cd7CP
eQcTDt6i87sOskVQO9H9FycjYygDKOfm6GxmmiVbmpDz+vm2n5p60BUU+Ea0a63d
QNFpVviUJcfEktgKfBRuojO69hqZorCq5uok1YsJI0ZZcK3NsZHCIdZ9KzJ8ci1J
H4qumk9N8IaIGuonyC3zQ+DGQiozFfo+pMsIJvzV0gB1mnJxMzN3WhusfUhm8Hm0
ab0E3vZ0colT7h1jhdEc6EnSV9YLfvkND2ZvVzxGer1EVKzDqfbqw4DW19paO5eF
24pPGiYSsQS5ET7fl9Fw9LLfCZPXFNUTXlDHwkE1IRLkdKvWIu1xirsODjK348O2
xc7bsss1tqNEgldeV8+5SuDOsTA51deJyrEWKfkB6xjkEHk508zkYj6JLvBE2N9I
hjRtXN/mmgkTz8wUwXN+4Qa+z43EELdXpmKwx7d3vdFDFjPT/6+Pqsn7p4Ua02m1
OBgNjXpb2RWYW/BlbfJIAOnowDQkBIcu35pMS8xH5pCwH5gMMjOS4EBcyI70HR83
bywclsix5mJ+jZOvmPdypwp0axPEoZ303kC+nFLDduyLbcTPMGEsfXqAiaOUQzL8
UyXUO+p5SIFjAsHO2LRzae4mmTmwV6QRUO6LfcK8Xft8lfC5o+g=
=6ESq
-----END PGP SIGNATURE-----

--nTGnxwJps+PwnKzd--
