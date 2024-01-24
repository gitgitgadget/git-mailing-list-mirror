Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A316E2C9
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099506; cv=none; b=hoMKFyvHlS3behZOhPhCfrraBRavjln5R5/LAT4uqoYE8J6Lu9fTJ4+9+tV3cN3VUPIUFxYwFgE0MS41mpIpQR5BjBurp1vfIqgvAXMJXr26y7AWmvXtG8T+hRIpRMm42qFYBolO2nf6VKo7gwwvREyVxITbw5su1MCWNjWrWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099506; c=relaxed/simple;
	bh=ZYl6rOFwiyVcXmVHa/WPtRFnbzM7EwkPFgLkutKDqWg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAyNXclhwgjZr9T1/bc4GVeHIMRaTL/9wptpaN9maZ+nfDuql296AKW7bKbVZjTc7Kxm/LVu1PZnV/yGP7kkUgh85F7DOS5uhoT3TOqD0GOyFqonI9KDsmtJIjsC60IhpMXLv7HZVJufpJshQnyA9kdyMG5HE8/A5t1g+eI5vZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fbsk871Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEBHEy1C; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fbsk871Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEBHEy1C"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 035323200B05
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:31:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 07:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706099503; x=1706185903; bh=pA2GQV2EXS
	8oDUKryKfkR99t59ozY1mdz5CBDDCUsxs=; b=fbsk871Qlca+xESw7qG0pOMD67
	d/1As9ENiDLtHbTC1BNBCbE1/nmI5MEujBlhspj045KrKrTMaDb12IAtQwJK0j4l
	UUtuwYJW5XxDLssUQKfCbLmEqDW1sLz5qjpCTOLTCd2Mt1MwkiA88XoFKgSH6dkh
	wplJ8W5PVlDy2sOoa9YumRPd0dcqpLbGtHjNbNq5z788n2UP1SYa7T9CyyU67DcZ
	64coiWKuKbatp1kjyBvIcfGByZVCE8palHNmZkcuzjgHPbuODWnXCfJWW8r+vmKP
	TP8FAEoBq4/ebX5z33hKWnyOQrlIk3e/Zpirw2vAk3eZprWZQoGefbUQNpZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706099503; x=1706185903; bh=pA2GQV2EXS8oDUKryKfkR99t59oz
	Y1mdz5CBDDCUsxs=; b=PEBHEy1ChL06XvzqkliIW8srDHgAQzarhs3HMf7NmkVz
	vIoHopwFwhMZ4lnSpMZI6EJAzJc+AA+q+xrhlprA2PvHbettF7DoMSvb9PFwuBrH
	6kG6q6B8rF9dZx8F/cnjFr3UZelyZCY/ZilYN0pcsKCff2Q+XZ+U0p01WDwAJ1Yb
	sZrazdLenqoxmD9Iwl8BSonKWwPCleTDI7plNtlS4J+O4wlbUs7Ke+GZQuaw8ZJh
	gkPaNQGA771K4lacIz6diEUXGb4+tCPxhEbEMfu/Q/GWHG5bkuNmvdZFRWNalfSh
	ONCGKjNm2g9OMyfAXYi8epnE6l/Vtb7I7CQfTTLUcA==
X-ME-Sender: <xms:LwOxZTfOTXwi0zFGLTjCRb3dmc688Jfjt4t45OE7_YoZk6I-Dxo1OA>
    <xme:LwOxZZNTEOkJ2FbzyPrUnQt1pnSItZzUeIBDPtTtQt9ts8QsCpZRFcfwZEnRc5voO
    RhJgLbzinSYfq0KjA>
X-ME-Received: <xmr:LwOxZcj_7WMWXfTTcJ3vgRoFmR7jtDAY3ttwgdKCQL_bTUEPFB--BaCx4Xf5Tv1PpAzczrXNwg5_c0G-_86UHBrkfYWNHDBVXTIZQ3PcVCgUzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LwOxZU8EZ-HAnF39fmIu9INFyIOnbYEhZ4Yi6qNSkhxdbqQtcPNCPA>
    <xmx:LwOxZfuT0z34jQWRPAXsTg4R1842m-AtbUxNpW_SWrrGjXqHmfckYg>
    <xmx:LwOxZTEgVABVC6TExkcuUSWOEueWD5nvcbKct2TU7N-CSX3QAW5t-w>
    <xmx:LwOxZc5FBgAe-yJHUeookveDRk3JWHqAWL9S7sDkSHj_ADsHej_VDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jan 2024 07:31:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9844f6e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jan 2024 12:28:36 +0000 (UTC)
Date: Wed, 24 Jan 2024 13:31:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/2] reftable/stack: adjust permissions of compacted tables
Message-ID: <cd5172193660a334ae6ec022dd0b54457d06f25c.1706099090.git.ps@pks.im>
References: <cover.1706099090.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QbcUEkJmzcmNnBJm"
Content-Disposition: inline
In-Reply-To: <cover.1706099090.git.ps@pks.im>


--QbcUEkJmzcmNnBJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating a new compacted table from a range of preexisting ones we
don't set the default permissions on the resulting table when specified
by the user. This has the effect that the "core.sharedRepository" config
will not be honored correctly.

Fix this bug and add a test to catch this issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      |  6 ++++++
 reftable/stack_test.c | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index c6e4dc4b2b..27cc586460 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -731,6 +731,12 @@ static int stack_compact_locked(struct reftable_stack =
*st, int first, int last,
 	strbuf_addstr(temp_tab, ".temp.XXXXXX");
=20
 	tab_fd =3D mkstemp(temp_tab->buf);
+	if (st->config.default_permissions &&
+	    fchmod(tab_fd, st->config.default_permissions) < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
+
 	wr =3D reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
=20
 	err =3D stack_write_compact(st, wr, first, last, config);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 289e902146..2e7d1768b7 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -443,15 +443,16 @@ static void test_reftable_stack_add(void)
 	int err =3D 0;
 	struct reftable_write_options cfg =3D {
 		.exact_log_message =3D 1,
+		.default_permissions =3D 0660,
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	struct reftable_ref_record refs[2] =3D { { NULL } };
 	struct reftable_log_record logs[2] =3D { { NULL } };
+	struct strbuf scratch =3D STRBUF_INIT;
+	struct stat stat_result;
 	int N =3D ARRAY_SIZE(refs);
=20
-
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 	st->disable_auto_compact =3D 1;
@@ -509,12 +510,32 @@ static void test_reftable_stack_add(void)
 		reftable_log_record_release(&dest);
 	}
=20
+#ifndef GIT_WINDOWS_NATIVE
+	strbuf_addstr(&scratch, dir);
+	strbuf_addstr(&scratch, "/tables.list");
+	err =3D stat(scratch.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+
+	strbuf_reset(&scratch);
+	strbuf_addstr(&scratch, dir);
+	strbuf_addstr(&scratch, "/");
+	/* do not try at home; not an external API for reftable. */
+	strbuf_addstr(&scratch, st->readers[0]->name);
+	err =3D stat(scratch.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+#else
+	(void) stat_result;
+#endif
+
 	/* cleanup */
 	reftable_stack_destroy(st);
 	for (i =3D 0; i < N; i++) {
 		reftable_ref_record_release(&refs[i]);
 		reftable_log_record_release(&logs[i]);
 	}
+	strbuf_release(&scratch);
 	clear_dir(dir);
 }
=20
--=20
2.43.GIT


--QbcUEkJmzcmNnBJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWxAywACgkQVbJhu7ck
PpQHEBAAhoIIZDgTM2tZ/Qo2uFHL9um4oaIujDZ/5qj2EQxT3p+Er4LPU8s/TZKo
KrEHVsf9fPbDgjWf9qV2EivYohtxr2JdVs/EKq75rkn/msJ34LNBhFF3q/hwF0LY
2Z9vCOzudhdezii6lsUQGCWNOrXFfsFUq8b0HRfp4Qk/J87nvhRl4c5aWp4lryTP
cuRnuBtzf2p0rHSHq8yZE5OIpL5UDPvxiVq+E+oDTWnJ9oiu8XlP09qFd9yAIgF2
JgrY7eWxqW0YquBZMNOptoHCpcjMEWqt7lx83+WchKN2y230D3udt96RLl+iiqXU
XpWPRqk81iknWku32yH4et7UwfpnYgsk9FRgo90M1UsKArPjVvUIPXXyVXQ1i1JW
bPFp89e8+KLRBHzkcFRdn0QIQaru83dbO2NIMZH5wKD0tDb1KGFzFHcLHQawEgYt
CkGiI58mFn5z/KnWaADeSYnaRXjKV0r9zSob/1VbUHjguPqd+M7jIcvmS+n6NPBZ
NUyj1diqGxfIg/sHCfHQ0/pLzMD1G+N1Au1bMq7iz36eLU9zgkSaJ8JTpSiF+W4T
RvVoPiDOLl10YSzZuDtAaX03UGJiU5tKIv4Tnefzz+3/ppMY+G/QJ72nRV0WmHL8
/lKe+yuvLHoFNB881aHQk7tB8u44ukOMLIARkWARDxgO5JRwT18=
=K+p4
-----END PGP SIGNATURE-----

--QbcUEkJmzcmNnBJm--
