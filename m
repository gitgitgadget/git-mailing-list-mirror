Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1D18FC9B
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013870; cv=none; b=D42JeXd8sGAjLNTA3jUZok49ckXO9WZbCzgzpfEbrt6p2vTA6fVw+FqCQzostcpKlMghXy/dYHBUrnZ6VsG0sXhkBgYmlX5pwyRKJxmuvRFI20LFoj/Y2dG0z0To7l7Jt34pEEc05KO/ZW9An58A9Dks5YsPKhwHI9b74dOf39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013870; c=relaxed/simple;
	bh=MhrjKJd/5huM/D+019Oz9tw2A8ihO5UnIGLshPzTE28=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRhJl588rGdeVdZeY7Ypy7zzv5xx3H3MiIZz0AiPOQWRYcbxY1NYvQ3mBtEaOyynjBSWJ/ki+cN5eNmvfZ7kNn0stx/MrmdiWU+tA0SmSiIjXmtEY+tXnZSrMqwywLT1JZ674PC6qd1aUi+cO38xx6GpO3HNupfc+4ukg1faKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O0RqV0r7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApCU8gMp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O0RqV0r7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApCU8gMp"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3DDF81151AB2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013866; x=1723100266; bh=YmhYvFropu
	C0NDsbzNTvL+9aK3hj2+sCilCg4suKUzw=; b=O0RqV0r7PVPmHvCvg2wCRsR6Ku
	ilPfBGoDxrST4ftXkvluNyHTwcAbcrGtvYbp3JT1CbdwiV6W0DdQc6oCvX9xPP73
	21arQU9YtvT4NdiX1JDJqhy3U9Kt2MRQREUxNXytCMV/m8yWYBX9iOvQxVPLvYe3
	tQdNdt7ryZjnWPCysQhA/We15xLSnnMJUegepcixD7XfujQF2ZI47MSlQFtnpNrT
	grN3SRJgIi0lpHXOu3ngp39Tlg53UWYVZSuTB9Pjc3WUlvDMPHps0WlQAqUTJkL5
	NYTxM4c0oF1d2YOWUtUOPZB8MUC+Hu3+IRF7mrFdG42K8hLu2rsPYcmwXKhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013866; x=1723100266; bh=YmhYvFropuC0NDsbzNTvL+9aK3hj
	2+sCilCg4suKUzw=; b=ApCU8gMpJYIMq0Qvr2R8/c1ZlHkBUbygltfkHRV3y5u9
	W0rPFhxiXl2ygwwY9OVXQ8WBIgJPT2ap6kaeLu9iBbYhPcpmGPFb7cSs6nAnPKa+
	uZ3cDL/ZaWcaX44DoHtIK+OLbaQc1oXgb/roTb8O4h/GWkCtfVB2BSuLoPKs7Mts
	PeKnnANBXZvQxi63PQO9KOPc2Skp0COhODpTztroTEx5NDtVheW7AGlTyW4Etyu6
	NOe8g1f1SmJZq97pP2vlDWQ5FV4nAKPDD4CEZCB7JvCXMPA605GS+epm2d5zeVYd
	U/4a+ArWBFmQ0Yd0iCumMZj4qDeHBZhnVb5hSIRgMw==
X-ME-Sender: <xms:6hqzZqKXTP3Xt7lLIsAqWbxhRFyDq5W-TJfXTe1Ou3oP-9BboyT0Bw>
    <xme:6hqzZiI4Jje72o3rpwsWTLyX-bQJAI6vrSs-9QVPsk3pQeCNnIo6-wHNs_AesI2WR
    0I6ulCTz9tcjTM1mA>
X-ME-Received: <xmr:6hqzZqvKbARe57G_X6IP8APBlgJqJnksluQ0J3DdQ2sGyLHEIvlnHYMQyYAQ7CCLjYdaGFuWV03oBs9_AHzSKCCfB3YB-WnSiSjod030aHOQUf08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6hqzZvZY7wTAtHJ0tGVYZyFSucOVq5g5bLcODTg_2ZfHuWLBTk2lrA>
    <xmx:6hqzZhap4bao8yaTs-ey3oPtbIgt9xTOoJJ0R-a0q2_kIJnKcOmApg>
    <xmx:6hqzZrBeLREHUzitS47eVqO8brcm5heuSFRrvXteSbDR1xjl5_n8eQ>
    <xmx:6hqzZnYCQXBUwoiynx4XYAwrAU-3jafoPJepZQpXPpGb1RrByGdzIg>
    <xmx:6hqzZgxNAAzpqJ-c-4wteIAlAdJFVZOFUBCa9ixA-jm4jjwmO3UsZmzM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3db41196 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:40 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/20] config: pass repo to `git_config_get_expiry()`
Message-ID: <412cc514e8f4b40c45d1c80224bba72688c4c576.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8ZG5aCdDA895b813"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--8ZG5aCdDA895b813
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `git_config_get_expiry()` to accept a `struct repository` such
that we can get rid of the implicit dependency on `the_repository`.
Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 config.c     | 4 ++--
 config.h     | 2 +-
 read-cache.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2ca6288c6b..dc87c65906 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,9 +167,9 @@ static void gc_config(void)
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cruft_packs);
 	git_config_get_ulong("gc.maxcruftsize", &max_cruft_size);
-	git_config_get_expiry("gc.pruneexpire", &prune_expire);
-	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
-	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
+	repo_config_get_expiry(the_repository, "gc.pruneexpire", &prune_expire);
+	repo_config_get_expiry(the_repository, "gc.worktreepruneexpire", &prune_w=
orktrees_expire);
+	repo_config_get_expiry(the_repository, "gc.logexpiry", &gc_log_expire);
=20
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
diff --git a/config.c b/config.c
index f1d2fb6d4c..4138dc50ce 100644
--- a/config.c
+++ b/config.c
@@ -2766,9 +2766,9 @@ int git_config_get_pathname(const char *key, char **d=
est)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
=20
-int git_config_get_expiry(const char *key, const char **output)
+int repo_config_get_expiry(struct repository *r, const char *key, const ch=
ar **output)
 {
-	int ret =3D git_config_get_string(key, (char **)output);
+	int ret =3D repo_config_get_string(r, key, (char **)output);
 	if (ret)
 		return ret;
 	if (strcmp(*output, "now")) {
diff --git a/config.h b/config.h
index dd7127b8e9..7674617a1d 100644
--- a/config.h
+++ b/config.h
@@ -715,7 +715,7 @@ int repo_config_get_split_index(struct repository *r);
 int repo_config_get_max_percent_split_change(struct repository *r);
=20
 /* This dies if the configured or default date is in the future */
-int git_config_get_expiry(const char *key, const char **output);
+int repo_config_get_expiry(struct repository *r, const char *key, const ch=
ar **output);
=20
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestam=
p_t now);
diff --git a/read-cache.c b/read-cache.c
index 1e52db7f36..18394d7180 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3184,8 +3184,8 @@ static unsigned long get_shared_index_expire_date(voi=
d)
 	static int shared_index_expire_date_prepared;
=20
 	if (!shared_index_expire_date_prepared) {
-		git_config_get_expiry("splitindex.sharedindexexpire",
-				      &shared_index_expire);
+		repo_config_get_expiry(the_repository, "splitindex.sharedindexexpire",
+				       &shared_index_expire);
 		shared_index_expire_date =3D approxidate(shared_index_expire);
 		shared_index_expire_date_prepared =3D 1;
 	}
--=20
2.46.0.dirty


--8ZG5aCdDA895b813
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGuYACgkQVbJhu7ck
PpTY2RAAlk/HxibFV2IXC1pNs28Pv3VZ95AD+qrOFptBsymqHtzFX50G8LoVBjAI
q+WpY1n4ianmXtKXrUkAPTaKkMLDLtsF6vA/Jl1G/RIfaYtg4wPtzTlpsZA/9u9l
pMhI64OHRwSLgYIH60ZJAKXl0hMYgzQqsgW14OeW5rM61V9ki81AHQ5CAoujJpOk
F/u8OM8kxcvNxD05E+m+0YmNaJDXZlBdocaPU34Xj226Sq+H5lx5W8idmaLBBaok
HRA2sWhOZQ18uAX+caI51N92F4T3POnAR8T2Slc8YAkVqUBAPdNKm3rVA5ghiF2B
o0i22PC9GAmNwzd1hZ/r5Vf0HE3VbNfhe8F4D1rgBFeVB4DTykcvxQzpC3doM4hR
En2oeL+XtG6dv1JSnkEg2pTT74UEYOjKCpXQvbDTExvnD7jW4/DfPvDohCf/IMSG
khtk4AOjcqZPVx00FpIaXA4ryriJtNFXDH+um4vk3h29tw+kl6y250v/mUZc8psq
yAIYki8yI6/N6OLCjDQL+A5pnMS9bio9vPE9KWGREUm9GXzGllLXYtuYnPfeEU03
QABegxEDvAb8bK5xd0HDiO4uY9lqEKPXQscq4decMMaa29Tezm08/sVCxbdmv46/
S+bq/tqA3VQyA6LUnwrLbHqi+Lub0m7I9xpYLVuu2PTy9nXdvtc=
=fO9B
-----END PGP SIGNATURE-----

--8ZG5aCdDA895b813--
