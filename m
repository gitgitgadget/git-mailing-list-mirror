Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743B18C333
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122360; cv=none; b=a5wRKZPON98nw+vSIhsb/huZxna2s3O4/sY2kvhgsBKc+bbAfh96TJKr3djExEPqBEJeKNj0NGrtRfY+kkzxKZ2yVfoeM41sHXnYq5/92Ze8E13GmDXzz8g5t3swRJGpQI96UR5MJxhwSQURhsni0juA2MacWFkY9uDEHGALA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122360; c=relaxed/simple;
	bh=C8HQKjGu/Wwze7Lp+IrkWZz2KZ1pzkYDi8CTT0Y8tmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGMaS5ci5NHVlBmJZYT0WvYZxhchdA7YYovaAY+soSP99ZRZB8KL87pH3Wu8noQUwvRxz+rqhB67KApQFGChZACFWZoGX2d88rVPN4RVIL/A3+bqvu6kx47jwqr4nq2Z1tnJZ4XTNz5UuwzPW9+7n46RHiR+4Ak/P7uNsiyW7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bt4/JGO5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=up0aWjDi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bt4/JGO5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="up0aWjDi"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7BBF11151AD8;
	Thu,  8 Aug 2024 09:05:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122358; x=1723208758; bh=FXlAYSkoXQ
	1x0B8hXh3SeaBGA+U1CdVN5noNTlVxTuQ=; b=Bt4/JGO5yflnfIk95tOniy0fTu
	DRqO5D/ok3GceA+zCpptV11ftBf4Oa0Nb/QDjT0Zg40FuQTSq0JJCLbcwQ7CoFH4
	i1QpvkG/U8sdEHM7hI1Sb+MuYGkLFEw159w1Yk/u7Q9PVT+p1yt1TqOsxYhVdDIQ
	woBGJh2VtyjYtqRErcCuMA0nqJyd+O/yUAK7YSAyLGO03ib5pzDIsZkJCbtq0i2a
	6SkeBe7iFpbcWy1P8rEvl2tizZiBYVz4qcFpglnzgQ9l13p/r1chjZnrHIH9+6M2
	W1njI9MKAVHijU4NlobQCyyYSH/v42TPCI9D0uHka+xzTr0xckXUA1gmNH5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122358; x=1723208758; bh=FXlAYSkoXQ1x0B8hXh3SeaBGA+U1
	CdVN5noNTlVxTuQ=; b=up0aWjDi7H1bI1/mwbuGwb29SnaApSI/sZTOT5iBd7u/
	gA8uSw1efrHZhokO2Xg9oT5+i4EHEKufenYSrxH23zm1R1kTKQfybY8nxAA+62hL
	iMpCPSKzzfr7quyft3a4YfDTyZ3Z40o/gOisXkUynMQKY4honi8wUzLPKaeP1oUe
	5yRAxli+C8R58j0SXWFcR06/03BwMHzsJeKCTG+7D09GLUfI7tJWU5E118j0mFKb
	A1untAIDsFVbsZc8CzFiUNrWZLlTnYXEFGyJ6kStmgd8qQ1ZFicHhLi1l1mogBNt
	P8yQKcGYa8rlzPGYA5T1GEH+04YENu8T9JBl1/LnRQ==
X-ME-Sender: <xms:tsK0Zlpe9M08rV_SL1DNBKuuUVS03rRvbXUjeiHA06wNLq_X57gFRg>
    <xme:tsK0Znokv4wC3dLSMySiDnz1lY0aAMAa5Ml_PcsN-Rm7yFys4BAqepawHkP36St0q
    rAA56NtO9EzUXeA7Q>
X-ME-Received: <xmr:tsK0ZiN8AAxxXO4L8oIT0xvkg8_7tA9gdB52jfqT0I64zJHjhQ0nrwn_WnTRGkrOGvZ11ViT3slTADyxhD-PmJb1z4MQufNaN4fG1T4-LNftAiW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeegieffjeekteeluefhteetheegueethfetuefgtdeuffdt
    hfekueekkeeuvdeileenucffohhmrghinhepughifhhfohhpthdrnhhonecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:tsK0Zg6545o8sVsCAoCq_6UcVzM_w4JFw5Mhdy1NwXP_34bj41Gk2g>
    <xmx:tsK0Zk4jZIRr8CpZw5K2FyWUG3bcTut5G5nBAHatqSVu8KdngFSoLA>
    <xmx:tsK0Zoi4KQedwHDn6_knXIM-KQkzDdH0Iw8a4imaGE4e70pWMU2_OA>
    <xmx:tsK0Zm5TiwjI9g1skFiHrC3YgFaawq0KBTcxIEZeF-cpGNxifwt1Dw>
    <xmx:tsK0ZimnTd8O66SBODoOOClkCvjpSnKGe-be7rSk9VznlL6lv8u2-gnq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab90a3e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:50 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 18/22] builtin/format-patch: fix various trivial memory
 leaks
Message-ID: <343e3bd4dffcde04d42ef005c715cada724bba91.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9g8Cp4MpIgPCWLgX"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--9g8Cp4MpIgPCWLgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are various memory leaks hit by git-format-patch(1). Basically all
of them are trivial, except that un-setting `diffopt.no_free` requires
us to unset the `diffopt.file` because we manually close it already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c           | 12 +++++++++---
 t/t4014-format-patch.sh |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a73a767606..ff997a0d0e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1833,6 +1833,7 @@ static struct commit *get_base_commit(const struct fo=
rmat_config *cfg,
 			}
=20
 			rev[i] =3D merge_base->item;
+			free_commit_list(merge_base);
 		}
=20
 		if (rev_nr % 2)
@@ -2023,6 +2024,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	const char *rfc =3D NULL;
 	int creation_factor =3D -1;
 	const char *signature =3D git_version_string;
+	char *signature_to_free =3D NULL;
 	char *signature_file_arg =3D NULL;
 	struct keep_callback_data keep_callback_data =3D {
 		.cfg =3D &cfg,
@@ -2443,7 +2445,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
=20
 		if (strbuf_read_file(&buf, signature_file, 128) < 0)
 			die_errno(_("unable to read signature file '%s'"), signature_file);
-		signature =3D strbuf_detach(&buf, NULL);
+		signature =3D signature_to_free =3D strbuf_detach(&buf, NULL);
 	} else if (cfg.signature) {
 		signature =3D cfg.signature;
 	}
@@ -2548,12 +2550,13 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			else
 				print_signature(signature, rev.diffopt.file);
 		}
-		if (output_directory)
+		if (output_directory) {
 			fclose(rev.diffopt.file);
+			rev.diffopt.file =3D NULL;
+		}
 	}
 	stop_progress(&progress);
 	free(list);
-	free(branch_name);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
=20
@@ -2565,11 +2568,14 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	strbuf_release(&rdiff_title);
 	free(description_file);
 	free(signature_file_arg);
+	free(signature_to_free);
+	free(branch_name);
 	free(to_free);
 	free(rev.message_id);
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
 	free(rev.ref_message_ids);
+	rev.diffopt.no_free =3D 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
 	return 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 884f83fb8a..1c46e963e4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -8,6 +8,7 @@ test_description=3D'various format-patch tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
--=20
2.46.0.46.g406f326d27.dirty


--9g8Cp4MpIgPCWLgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wrIACgkQVbJhu7ck
PpRCpg/+MVr8EHHmH3qQtxe+K0PWBTkPxkTQbPcrbPQW/nn3FVaRqr4vxOmmUrjs
M7ZLc9W0FPUdEld20kuGYDojpOzgHsg9tBPfrC41tuQ7saBpoXoty1wRPGelOgnK
r3ShoiXuT57ZRfDH5F3wFFszLHaxe3YCheDTz12rElcQZ/PI1og6pMoorefcr+Re
Klg5NuIMBT1h+FiOxIIlXl4kZ4qSSZ1m+JKMgw7sj86lOmlTTkbuOD/wnjok5s9W
Po1xh7KbwI4RYu1ABs6P51zH7Q4bJUoide+Zz5kLY8FoEtb4VRkqPj+M+hD1DAZo
sbOUQFw9mQmwCKS4p7USlDbmsjpdo9gs9QKWfJYv0/+8Wc5Eqf+MEJ+KMoT4Xdge
UbQil1iagbOewOcCedqFrUSa25aCWTuszt6JnSWSh+dAvB9QvgQpwqa6KMpRwFFW
36z7Icihyc/e5XPt8uwKU3CqSKWz2eab6PxSdhykdzD2ZVL3G/RhwKqVWshs51AY
BI9yIJqVzDfCDYEZoe9LcKpAOQ39Q49lt2F1D4cK823UjHribEnUYA6+IWS5RsPc
HtxuxCT0nV6Y1iGVEjB++5acpilL9ABo02IQpsNWu9PuI2S3NS/M5ytgBk3GC/wB
SltUdTJzYJ+DkEoWQbVIq6CaI2F8N0Uu2xW4ssPChCo2lD/hyh8=
=KNHD
-----END PGP SIGNATURE-----

--9g8Cp4MpIgPCWLgX--
