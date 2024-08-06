Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3461BD50E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934865; cv=none; b=rlCP4hZBwxspRSZDNSxY/4WuUoUyD+1LyOOduZ+mHJXPv7Urcz3ag915TVxQ7yIoS3YT3fUYuWdRVa5YnyuIjORpa6U2Ga8IYMEKVjoccTND+XmUd/NtkhKyvmtSc7qqjLr1Y23/gxGqEyy5aZ+j3Xqd9M9i0wqP3oD6YBLAu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934865; c=relaxed/simple;
	bh=LsXwKNb/SkPL9zjesth63lH7u1ReIYAqi3Y0jL4C9jc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecx4LK8QdSSWAkN+8ClJfrl+JYk07jDa7HLumLYCnqNU0ZapA2iMt+DzzGhXVdiAsX0a77tsLnbxaqvNM/q3/I0BNnr3qJnQ+mKhltt/boo8UfpY4G6mhFwnAqoyeIRt6C2jfl4g5SbfEXaGX7CcACe1vqN73p4QpDoI0ftbvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hHnAn6/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBQo+7Ur; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hHnAn6/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBQo+7Ur"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A26E51151B53
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:01:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 05:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934862; x=1723021262; bh=/Ep0ODalja
	yQuNxbjEheYxjWLMvAW8HsJVL2FPltV10=; b=hHnAn6/JiTTYMp9emu6Ra0/RIu
	F9E23IR2WDRxZJm4UqF1sJx3rsJ4ktmiBmWSwt9BWDJRmhQXB5AXKvJaRLm6HsKm
	eH+ZLvP08v7QOW+ZNGPrKZ/1xU1HEt77o2YIFTbtZ9swM11jfPX04ukZY6anqT2S
	AhGJU8R8lvKkE46JQpQOzS2nU+qYVxe/9LkzBKepqwYlYn+1XPGNWyDBlldxCrAW
	yL0bBAIreOyPH7U4GlCC8HnNIeiIgT2nAZVY4ZWHkZq1qZR+ojnQsqYKeWBAf4WT
	DNTAE6ifkn5saVv7NbmAf0gMnCB78C4AuC2thV7nnAEIijVlj8Bbp8eLl59A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934862; x=1723021262; bh=/Ep0ODaljayQuNxbjEheYxjWLMvA
	W8HsJVL2FPltV10=; b=kBQo+7UrtAjaVm41NF/Vd7RQA/IhgpNxETZQX3/bm9XK
	ub2F4BqIBp04rDX12PxfipBS/L+QTxh5Xajzar/wtYtPODeT9tJcdYeqkATJR8Ou
	vDP+wTg7hJMXxUrja2PGcdo6AUGjdzlYyab3VJqAKxA1t/EGVIAw4auNctgmsTNn
	EVAF3SYvG+h2Dbv7F8C/bIQLuzNK8v2ai97i5MRKh7Gj7cL4CmbkBVJgwpn6b6US
	zc5Oix755lJy1hnfrLTBdowElDDZE51QQbYwoxS5lmrRxGHD5nSpV8SbMsO8iraq
	fGuOo2HI6xStosCs8bJyxOaaF9Is3vK33p+Kj3L0vA==
X-ME-Sender: <xms:TuaxZqUVueU6MpyeH952eOfrDDmiihPL_OQg4XsMBX8cUXTvtiPoVw>
    <xme:TuaxZmmRUmupVI9pDdH_1pgnoEHJqApdkeVCBRZaT8VmW8XC83osaevJY4vPhQYN6
    z_R7-Qm-TNUDMUYPg>
X-ME-Received: <xmr:TuaxZuaX-PJq4NA5hK8iABVsLTbciBz5mFGBrz2lyoo9Isq8ymCT1C_8dVXM-rM3hf6DFS2LkjQr2eEUr2onudfoh5mi-e9Gd_fucJfWZhhq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeiiefhtedukefhieeukeejueeivdekudfhfe
    elhedvfeetgedtfeevgfeutdetfeenucffohhmrghinhepughifhhfohhpthdrnhhonecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:TuaxZhW9PI203vbiazLDg7-N5Gc4Rm7u9BVo0guiM18jG_JO_-ihKg>
    <xmx:TuaxZkkkXXYQ2BiSIDbrdd4RGlEms2yXs3Co8wzteT0lkQT_nJqXiw>
    <xmx:TuaxZmeldFa3wZ4hld_2xWONWXB01d6C0jNXe55hdJN_VRWl31m9nw>
    <xmx:TuaxZmGI1tuHyI0Ok1hiTX52ayGN7uj0sPIbqKw-5Gd9JZWE5I-shA>
    <xmx:TuaxZgt2pGiQm8VEi0GQR5jJsiesLmuEm3H7OXNxjJp9Ezc0N1S4Cox4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:01:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 483e40bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:59 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/22] builtin/format-patch: fix various trivial memory leaks
Message-ID: <bf818a8a79385af739345e22c74550acd5f31a0b.1722933643.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GdixcVZ0ev1XkFap"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--GdixcVZ0ev1XkFap
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
2.46.0.dirty


--GdixcVZ0ev1XkFap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5koACgkQVbJhu7ck
PpTE9A/6Al0Puz8789n0ArKPYT5gUv5JpnhmI/24zfBnKPkGicoA0zrAMFQiwsB4
zDkfruylCGgdeMSbi0Bk6CNH/qxOGTAJOECsDLnGLlrrXsJZnXSIEczUKGW1JCmX
McRm7IJNMgm5j4zRPdBZrkOQvRO5zhr+pLLkICBwBL/4FcVQorITrCMckfgp3IGV
yBoQfFH9DJxpEmGbjpeq33DtfrSEfhFryZ1qzQzh3eMuAtlLXgOPQUn2v2tG7gb9
L2a5ZE1ZnUrvzYg8UgPvVWDFoQgkSaw3VEYQ1ABxPwxWd1l7UYCuA7Z90sFAKCv3
HfbmlTUfR7Ivm/rFLFMg9k/B6ZPEm39DNLGoQo/adCeb4lQ9IV3cklhIPMhxwh26
AEc8wLyMz57r+TvrkY+HeUzqtB/cnyrVeOcrVgw08SrhpW9qtClTK70klHJ7p7hF
xg2WCNFD5wG61GvUaXBcATBy1sGL4lzmTxDsLUU5pCvc7qAKGt8PjSu2wuCryaOn
oVOoSdEMStq4dYiFHefw39j8QrcUYja6ueStkU368MAiQQv6I6ckkolcV5KAkN6i
20cQLWa/X3NhkvIlL1RnkpYJP9rJrwptGzApqqweMdZ5HMfme1q2YkNXGspXE2v5
UKc4FYN+i4AD1sosbuSXkYoqQT/TjcActbLNzfjp6L2ZCJ9I8FY=
=ecgd
-----END PGP SIGNATURE-----

--GdixcVZ0ev1XkFap--
