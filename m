Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF463CF56
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660804; cv=none; b=Ua4RjGvSmEK8VCmotkHEsGg/sLdPlkYxSNSbvgIjL7L+utB1Jew2ur+w3JfSlOeDfM1+INGhoMOJrKvr+lpwaPULDGDS6jGgAXGFWr/a/4pdQ13DF3eDiXFApGXTC7fm6tm6Ep7elM9cWVbkkuYv52gPy0z+mv94nUTV6ASQHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660804; c=relaxed/simple;
	bh=KPeJ2PraJQkza9+6uaOE8VRJftn6fl/2uGtLQQkasiE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7EWMHgOcg2r4G2wjYaWZGCTpLNpDK70z08PAZ1I8/U36sKg3Sq6sOJ8mPsGf6Y6qr8b8L8MA304wp3n572PbXxDyheJYD5edysovlybh1f9hM2QU2wNtBo5tAgSxb+KXtwDHW7a6P1xcFRD7js3z7Agu4ZsVbr/jHRyOup75kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RQb2wEt6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQZ9Cdrz; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RQb2wEt6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQZ9Cdrz"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C46D93200A6C
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Jan 2024 05:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660801; x=1705747201; bh=KMNcFvDjxz
	6TDXL6LpuuikpF/kOjZyfV34pwwTlaw04=; b=RQb2wEt6okEZ+RlLZsGMaaJ1zK
	dQnQjcsUJI1uV5NAE9Y1PnfaK7e7b/LGNA2NxNLAD30S57cECLQzHFmb3fp0YO22
	eLc2hlAUtOO9VATwPdVO0yf6OCDv6BqDtfL4ry/ySqZOcAfU9DkMIoxCC1IOkRwc
	3d5bSiGUSJE2YMXXZgbgsyvCACy7QEZP4EV7BrSbP2pV+rXPHuY5n1KE+hDO5M+V
	bLsxa2uxiu7VmdeSpkBkAzTHcaxZyCL5JNzCaJerIfJ/zlvUJCOemSnxyp/XL++b
	SZPWZTme6JQ/RSGhdriVVE7m422Iy/CrUQ1xviAYJCbuXn/Vnsc1C8XrTm2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660801; x=1705747201; bh=KMNcFvDjxz6TDXL6LpuuikpF/kOj
	ZyfV34pwwTlaw04=; b=aQZ9CdrzvIEXP1OEA7f6CV8FjsFaJ6xPC+3VHSAXLpeC
	gLnvm+ZuMyCpw67a1VOKepYl+L+xVIc34XvMBVyC5Z6dJuznGhdHHTOJVq+/3cw+
	k71UiwtxWHtpTz9HG8VkojXO+YMDVswgnpqx55vzwtrBSpXusCEBDr1jXFIAfF9S
	OV6IS3f7iqTZT8CBx1rC8uEDpvdAMaPwtfMxGWEXDVN6rluPEW38iuT6Ur4rubNA
	+HmwvCaNLoYZXKS0m2r5Xdr+FH2B7nvPqRS7GHOgae0OC7Dlfe8NeYKETHhOZ7Qm
	u2EbLVPAWEF7CJIw6wLrX6Zcb3bSwwU8o/JEV+LhYg==
X-ME-Sender: <xms:gVGqZX2wU7abgvaXZ9D7MKz86j2f0hIfWOuBkVAZZezwC3DDarsLyQ>
    <xme:gVGqZWGPZDMR0I3XmTh8VoZty0BeRIHVjgSvhfNGIISTFxbeDNkzL1fMyAZE2L6gk
    4z75fUWe0OqFyfnHA>
X-ME-Received: <xmr:gVGqZX6Kbn0E-KW2vj4SLOlgChjA11qq1kDWSsSxdnIYlcN7abb_2CceeYD0w3r-qvHuTlZudMP0YCbg0PxiZNuxrF01EboNtPswfPiJbb993qCFZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gVGqZc2Xie2u3j7mSdhNMRLeGJ2iI7XEWsyDUlmrPjkFNiyGxnNBtQ>
    <xmx:gVGqZaGUN7VqFTxKDjqVMQre6bA3_pw9282dr0s--XgIDWgaWdbt-w>
    <xmx:gVGqZd-KhTvVIIObzMduX87AMGCHwz5gDefOrWgdGuY-tcDeOgoQsA>
    <xmx:gVGqZVztzHy-jrfkz70HGxO-2RsfhgGWE0fZzcJ8VHG9LvzEyL6vyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6bec964 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:03 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:39:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] sequencer: clean up pseudo refs with REF_NO_DEREF
Message-ID: <48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WAWDNqyH3ax4PSyP"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--WAWDNqyH3ax4PSyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When cleaning up the state-tracking pseudorefs CHERRY_PICK_HEAD or
REVERT_HEAD we do not set REF_NO_DEREF. In the unlikely case where those
refs are a symref we would thus end up deleting the symref targets, and
not the symrefs themselves.

Harden the code to use REF_NO_DEREF to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3cc88d8a80..b9cbc290ea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -474,7 +474,7 @@ static void print_advice(struct repository *r, int show=
_hint,
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, 0);
+				NULL, REF_NO_DEREF);
 		return;
 	}
=20
@@ -1667,7 +1667,7 @@ static int do_commit(struct repository *r,
 		strbuf_release(&sb);
 		if (!res) {
 			refs_delete_ref(get_main_ref_store(r), "",
-					"CHERRY_PICK_HEAD", NULL, 0);
+					"CHERRY_PICK_HEAD", NULL, REF_NO_DEREF);
 			unlink(git_path_merge_msg(r));
 			if (!is_rebase_i(opts))
 				print_commit_summary(r, NULL, &oid,
@@ -2406,7 +2406,7 @@ static int do_pick_commit(struct repository *r,
 	} else if (allow =3D=3D 2) {
 		drop_commit =3D 1;
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, 0);
+				NULL, REF_NO_DEREF);
 		unlink(git_path_merge_msg(r));
 		unlink(git_path_auto_merge(r));
 		fprintf(stderr,
@@ -2802,7 +2802,7 @@ void sequencer_post_commit_cleanup(struct repository =
*r, int verbose)
=20
 	if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD")) {
 		if (!refs_delete_ref(get_main_ref_store(r), "",
-				     "CHERRY_PICK_HEAD", NULL, 0) &&
+				     "CHERRY_PICK_HEAD", NULL, REF_NO_DEREF) &&
 		    verbose)
 			warning(_("cancelling a cherry picking in progress"));
 		opts.action =3D REPLAY_PICK;
@@ -2811,7 +2811,7 @@ void sequencer_post_commit_cleanup(struct repository =
*r, int verbose)
=20
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
 		if (!refs_delete_ref(get_main_ref_store(r), "", "REVERT_HEAD",
-				     NULL, 0) &&
+				     NULL, REF_NO_DEREF) &&
 		    verbose)
 			warning(_("cancelling a revert in progress"));
 		opts.action =3D REPLAY_REVERT;
@@ -4116,7 +4116,7 @@ static int do_merge(struct repository *r,
=20
 		strbuf_release(&ref_name);
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, 0);
+				NULL, REF_NO_DEREF);
 		rollback_lock_file(&lock);
=20
 		ret =3D run_command(&cmd);
@@ -5108,7 +5108,7 @@ static int commit_staged_changes(struct repository *r,
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") &&
 		    refs_delete_ref(get_main_ref_store(r), "",
-				    "CHERRY_PICK_HEAD", NULL, 0))
+				    "CHERRY_PICK_HEAD", NULL, REF_NO_DEREF))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
 		if (unlink(git_path_merge_msg(r)) && errno !=3D ENOENT)
 			return error_errno(_("could not remove '%s'"),
--=20
2.43.GIT


--WAWDNqyH3ax4PSyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUX4ACgkQVbJhu7ck
PpRYiA//SBaJJX3757Ro7Kb51/HrAhRW2UJrI5zx+PGUu4HwzQRunaYBsVVB5rkB
VAJPVywk5sepS+L+5Pm0koPuApfoulpMXb25iOT4aKtVUtFTCKSnRKO6vXQl31o2
dh8sYSaE62qoCnR/3bu0JSx9LDq+vo6py2P/AMOuwG5jylWyUNoYzHQ5PqtLIyfd
onNUTksgw3ohmVMBkv8Ctfu6bfM6IVC6ssUo9eZAUwN/x7GCNPjYT7nb5H3nYMdu
URLaL96SUr3UxAdTByuBsZmTRR3FRA5bpQvSOHkO72i44Nd8GaxVZoGn7awdNeUq
Xnu1DkTesOVTJOPu4Ib+JIvUowScAkPkt5ND+lQnRmP8EO/H3RN/oilYULmG5ROH
ueS4PninBFnEHvlpI2HbD7OjHZqFlsUes5npCtlNGXP/dUQ1aKs1BeYeYfqhO2Jf
y9qVh/DDtge3wDOm7lWYNcjfnd5HUp9A04lBn2zzmsOpM1+Z5sPu1fQzP5eG5S+d
7xX9HGKlG0qcV8Ikstc4F5/rA7rZ9VBdPJSrq3ZAl8Y6eescr5e7sVqfhMv1+l/l
vUlmfEi6HPqpjhqishWMsfmkZUC0jCz2KJJHCTxnrMb9x+0bgOxif98vJDyUyEHp
Er3x5e5jAbSd/K0DCF/OIkxhw4Ivg1SbxdkkP2aMFTTaljY0NDU=
=TzcY
-----END PGP SIGNATURE-----

--WAWDNqyH3ax4PSyP--
