Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD605DF05
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181386; cv=none; b=nyPn4mEDwHQdgp9Aqdxd+1HtPY12wFe02DzLKUSFcigOKLJPylg4A28ts1P2K3cjr+b+PvREGO2W/BFhB7W7kiW2ZkTdwwkfhq9k3WE2JZiKi3bdLABp5SaILNphpS4lsRb+EMKrQflnxmn7S9w/Ef/6VWUEWPmy7kg0nRFkk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181386; c=relaxed/simple;
	bh=czIbKH5Ii7f7SPSGQHQZk/pXX0U9b8JdWtKb+nQHVGs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2uCfYQ9lA6nbIBRZTWFNRA+3sEj5Fu12itQNcYn1K2EDjHs/gCuVBbIEujNWwDUbv724q5D0xWrRYuAAmMH3MWvO7mD1oqOsXjnAkjZxSt8I5UhqZg+gjucTb0ZlkuBim4wH/BHZDtI8PhCu9Y1DDCE3ASxKnFi4/E1hv8xqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mfwA6dcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwjR5E+f; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mfwA6dcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwjR5E+f"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9A5001380057
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:43:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Apr 2024 07:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713181384; x=1713267784; bh=6ToBiTKwNH
	RdXQQuUXQ8ef3g8wKL0raTJHDjiXjZg0M=; b=mfwA6dcPQtYz4P9g0tunn5+92C
	88cZ61KgaiRruW7sNNJe8FjDMLpTFo2ecDyLT/Red8yLZ+57jIxzKVTPguAIJC0y
	dKRvh4O54ujxPXU3DAvawwePUEBLZRmiZOI/yvzZ1s6sBdZY0yHVEKJJSyOJVDDX
	/+UMnRi7mMuDdhJPQU6wS7BVfI6uajEMOMDvBTIWdYXV+OcuazB59IRQ/H8AGjqA
	Q75NGI18stntbLS5j2I3oKnBe8WLUXDoavMaCdl5Ec1y/pmbv1tsggupu78z295C
	aLNt6+gk78ZW4tx0xXv1HHbl8e+Yn2s5rXDv8j2sd4nqXdRVGBWgTEt7FbFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713181384; x=1713267784; bh=6ToBiTKwNHRdXQQuUXQ8ef3g8wKL
	0raTJHDjiXjZg0M=; b=EwjR5E+fGYaI5aZjvGCgv6qCJKItLseMCwx9lbAOtawp
	Kcz4jsOV7H6ii9y2qVyqhkqLytFYFYjK5CUivONQg98hcamRlgXfFdELjsjXG8ne
	YkEhrwPLLhmdAF1GOlxL0FpoU6Ygl0CLKRyO5iig46rKl1cdMGzVpsL8CVgYTcd9
	wNNrLPuWHA1CeiOARoEob6iynw+qNyb3/1EFUkurqC8yu65+/YTpVJ30MhzEBAnk
	OHf1hn0ZCsZQjViDpfYxukO9i2q6um5Pnjc8k+fOz7BFX4uFr5WGdZudwztf/uAU
	5XRauX0QsP1rcSlmT7p1znfmaNUXkNlM5OYCoAoEpw==
X-ME-Sender: <xms:yBIdZiFB8yWXxJWguIH1pmw8ZyiTNbO9EY4UJMyleSuEczoW4DATkA>
    <xme:yBIdZjV9eKVyYVIWUQnjo-dfVWufLmlR7s_hiT9ECoD8uDWbeWV6yeO9Z7_mY9yXy
    Be0ZASBEwyi_lyrMg>
X-ME-Received: <xmr:yBIdZsJFBw8vV2dWwFg1JRoiAiULXd_ssh7XaqGui5qKP5Fl1GvebYGl3bRns_p8is5txOSYbqo_d2x4cbFwyqBlMB6-zpJTCVr7tfzEfwDFRS83EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yBIdZsFrgL5fBYzSVVriwlATpMy7JMEYvAhGVm_SI-08Hpjzx9Esrg>
    <xmx:yBIdZoULrW3uhwRDAtBPi3WOKvbC8zQ4na-SK8HaolpASgDWkknUSQ>
    <xmx:yBIdZvMBiqBbGHcgeY0TWZft4ue1VDZ41DjI7PIOBUT-N4_9ZQhIhg>
    <xmx:yBIdZv23JFEvt27g6p4Hy4VT6D_U4z6TPpM8ePNcRJqIw9kgEwKfrA>
    <xmx:yBIdZjfOtt7f3kO0u4Rn3R0XAOwhW9JvwCkBYzSjcQKE9Ud4_kheSC23>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Apr 2024 07:43:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 831ab970 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Apr 2024 11:42:43 +0000 (UTC)
Date: Mon, 15 Apr 2024 13:43:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/5] builtin/clone: stop using `the_index`
Message-ID: <881b6d2f7df61dc685939b83ab660bb741e9716c.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zf3tvrxfE7469dic"
Content-Disposition: inline
In-Reply-To: <cover.1713180749.git.ps@pks.im>


--zf3tvrxfE7469dic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert git-clone(1) to use `the_repository->index` instead of
`the_index`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 74ec14542e..93fdfc945a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,6 @@
  * Clone a repository into a different directory that does not yet exist.
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -731,8 +730,8 @@ static int checkout(int submodule_progress, int filter_=
submodules)
 	opts.preserve_ignored =3D 0;
 	opts.fn =3D oneway_merge;
 	opts.verbose_update =3D (option_verbosity >=3D 0);
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	init_checkout_metadata(&opts.meta, head, &oid, NULL);
=20
 	tree =3D parse_tree_indirect(&oid);
@@ -746,7 +745,7 @@ static int checkout(int submodule_progress, int filter_=
submodules)
=20
 	free(head);
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	err |=3D run_hooks_l("post-checkout", oid_to_hex(null_oid()),
--=20
2.44.GIT


--zf3tvrxfE7469dic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYdEsQACgkQVbJhu7ck
PpTo+g//RagAJKqFfqidtIPLCdDHdqRwNQM8j+v3asemEfCHIlKJku5q+PqtPttD
b4ZidceoHP2CcTji9ooyJCKrT1fvrTbCK7Jp3j72kQ1/cMtDIkle70CTXGgvAHKz
pnT1g3EYqxs5SVIYgFiAZ5o+vuN9CqLzbllZgCnNyOp+IAYO4EEGWqQTq0xs0fQC
/5mPYLARZVHxsbKyAVBZSNDXxIGAOD67eAlRkQxbksywdeFTgQrvfGm1WkAQD2/9
0f0wOyM9WNwSUxCtHIRxl11V8qAonGSRBPHzczZUSrURg8T82Av6+7SJfJvfnCX7
NaOZLlKUt0rBtDfx/1NGfJuArPSpDS2MJyZ2561GMwYhBZakBV2bskeCePTwxmDG
TaabHMkB3q9vSvqMhd4kfqXgDAE2ofapsddwsBp1+zrjTprqutpjNzo4jASE2p0p
19GE+zevdRuKnahFkygOQYL/dOdci1HwV812h3BThp5IvyOagtXYAuH00Qbq4OvP
pnbEnt/bZQsO39+N+xUBUwFZxowr3Z6MzlZBpyHjdpxlYlGafOf9vfwDCpNFftcR
fFhUU/D2BcPxK6qV7cx3XXhkcfFQW5sbE0r8tDRuLtxCrTAVE6Hb2lZl0kXzG3qy
Cd1iPr509SIdpWaekJOJObxl3a3kbIrp9pUkzJxBZar18poWwwY=
=E2WC
-----END PGP SIGNATURE-----

--zf3tvrxfE7469dic--
