Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BF18FC9B
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013832; cv=none; b=aVqoH4MxG6lWn4l6q1x+m/ka2f0uo34ujQ+RKzMqalxW6VjqAlMaQy2f15uoLov1UPI4dcC6ishhVPrXNpMYuhQCwiT5+8BgjSU+avcE6meXtf5psSJ8YhGnBDjyhF2LuuinZaxGqaJYA0uJnpRLqLw4VvKro2OPMPT1H8Pfi2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013832; c=relaxed/simple;
	bh=hLHUHG+xLVWBrUUzBWhLUtIhK+Jy5AyY2kGyy2lCu4I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRJgJ+q7xKsRGSD6Ig1+Mrt0jGdW4kINqh+BUpM8mSdITl7EWJnAD5+zoeZB97Hh0g0cYIO0ggwd7VFtd5XvBl9OiEbN1MS9zRqhGCv76TkNO8aY+mCnPL45SWnSvug8eQpEFJtzgF1ilW6ThBxK2VodkoIKa0BeCQ264vr3Xxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D5wg89EB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G66mnE6X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D5wg89EB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G66mnE6X"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9C65D138CDF7
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 02:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013828; x=1723100228; bh=SPgZJxQFxI
	c28gww5uaHt5cddCHvIozZftOuKyR/nlI=; b=D5wg89EBezp/p1S5XRFLkLSliH
	eIn3ggWWcmMxAVywNNZgGR/CLicQ1UxAhVER+uoyh/OY2XzUwm0HxkJVnL28pQ7f
	/ng1qTcBB9bYk1ObBh92bJjHNUxidgjUU1JoAMeEXIp5516yhaN9yT0cnjuG9y7k
	dtvz6hDdTkxwsx5IESeXY9rzlZ1QKat+ef3WN2jjPu33ZwKPBGQ7xxWAefCnE9AN
	uVUtGK4oIwspFjtor4qLAoqGyYIu07jyNr8axRCcqQnJiZ5wSgGk/589h72uanu/
	U07d2rX1FXC+FIxrnGDs/1b95/itmUQGywn0oQYpBEx3hYGPS/14tOs4CTPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013828; x=1723100228; bh=SPgZJxQFxIc28gww5uaHt5cddCHv
	IozZftOuKyR/nlI=; b=G66mnE6Xd+k8CgigP8n5uHpa7xeGKErAp4AcXwA9r74J
	64vUPCtn3GKEPFmVoN8LRcJCPJ8qtIRFlaus6RdvGDFa8zDjG3kWXdAZxDkFHJP7
	hPmosDHzb4lDfDJxMWd8P4B+5z8b910cF9pzYsm3WEv/+lj+YfPpU8sWeP4RhBOX
	y1Qf2DVpcyt7bh7sEpaMeHMVf1hutb2c6JkImyWlzpRz3oDJ9vOph+t8A6lWXlSE
	LJfPsPMa19oPA/UT8wWINKCFwA9OxUkKBRFTtejO966jNx+JeWqqZJ98llKtkjfN
	TqvDswPR+5MwYR0v49jOwd8NV5PraOkNEmTz1z/+Wg==
X-ME-Sender: <xms:xBqzZosBhi1e0ojloZIcSodwz6rMZDUbWRR_iqLtnrjETxPRBDtz6Q>
    <xme:xBqzZlemiwUDfglMwwCzlFUb69U8g1XYZC37SrAJW85XEm5ZDM5hICfN0bFFBK0hQ
    _JvWfZZTFd2PMABkQ>
X-ME-Received: <xmr:xBqzZjxVfJURYPHjXMS3fXBS8yAePiiSORu3Y06TkKvCmK-aEDvFkPdgJOwtWVLCIUQFA_6IC5cygx38AC3pJxfKXl91y1u1qUfcWe4tPY9pl8-L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:xBqzZrOetzrwXAmiiSu70JY48JxFpuVr6njYOjTHyvVXncVwrSOkDg>
    <xmx:xBqzZo8oC7z7HgB5OQxFoFtERrVWyu_aO8NNbfess79e7N-pe3EuAA>
    <xmx:xBqzZjVb6_0vruRjkDj6BQwGCTdyrwUE1w6zq1tvjrrYdIK0XcsCRw>
    <xmx:xBqzZhcFoQ5NnpA7QkUdpC4yWB6ArL8MWgv0YqWbb4bMyov8P_6V7g>
    <xmx:xBqzZmmtctVrsaWo7zz8Vbcdl_-07pvQXcS2FfQkmytm3zbdqhc45Dew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c20f19e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:03 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/20] path: stop relying on `the_repository` when reporting
 garbage
Message-ID: <4368b32f6526b54faf50efaa8b4fb5db6ec31c50.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CHJ2VHkia+pFs2X7"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--CHJ2VHkia+pFs2X7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We access `the_repository` in `report_linked_checkout_garbage()` both
directly and indirectly via `get_git_dir()`. Remove this dependency by
instead passing a `struct repository` as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c | 2 +-
 path.c                  | 6 +++---
 path.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 2d4bb5e8d0..ec6098a149 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -113,7 +113,7 @@ int cmd_count_objects(int argc, const char **argv, cons=
t char *prefix)
 		usage_with_options(count_objects_usage, opts);
 	if (verbose) {
 		report_garbage =3D real_report_garbage;
-		report_linked_checkout_garbage();
+		report_linked_checkout_garbage(the_repository);
 	}
=20
 	for_each_loose_file_in_objdir(get_object_directory(),
diff --git a/path.c b/path.c
index bff98b255e..d6bdb992ba 100644
--- a/path.c
+++ b/path.c
@@ -365,15 +365,15 @@ static void update_common_dir(struct strbuf *buf, int=
 git_dir_len,
 		strbuf_addstr(buf, LOCK_SUFFIX);
 }
=20
-void report_linked_checkout_garbage(void)
+void report_linked_checkout_garbage(struct repository *r)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const struct common_dir *p;
 	int len;
=20
-	if (!the_repository->different_commondir)
+	if (!r->different_commondir)
 		return;
-	strbuf_addf(&sb, "%s/", get_git_dir());
+	strbuf_addf(&sb, "%s/", r->gitdir);
 	len =3D sb.len;
 	for (p =3D common_list; p->path; p++) {
 		const char *path =3D p->path;
diff --git a/path.h b/path.h
index 77eb0e6543..3d21b9cd16 100644
--- a/path.h
+++ b/path.h
@@ -158,7 +158,7 @@ int strbuf_git_path_submodule(struct strbuf *sb, const =
char *path,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
=20
-void report_linked_checkout_garbage(void);
+void report_linked_checkout_garbage(struct repository *r);
=20
 /*
  * You can define a static memoized git path like:
--=20
2.46.0.dirty


--CHJ2VHkia+pFs2X7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGsEACgkQVbJhu7ck
PpT9RBAApRRty/u1hzH3R/gNaMLHFDt3+2dSJncdWJ1ooYjsu1DotDJbBAj8j199
uUCejo4IItDJU5ewO+gYKm1xFQLr6LcVeXKswyoqE6xBsljq+0xCiUGxqcKXDpI/
Q+5lfrsvcc3Gas9fPl2+YTcTe/HYUT0+N1urS6kBCqpTsDnhU6sn7hhSqVKOI2P3
EQRtTMZTvSUA6Zj9AYncSl8N5sOgn6u3MwrQEMv1iNi8qwhHLqWFdZ236nEZMW1K
4AUQ/5cya0DLo9DLbvUer0AGkSxnrDNheGLiBRHjFXZeGITFEN5IyIxUICF1mrZY
8f365NX06xcs/A1GCsMTjV3DIeVsIN8v4twUPxqltS49tyUTJs0OTgnMQwRQ6c1B
JE5dbg4rm6X9c8viOsAS97+HWlwh6UL96D/DV1qs6DMjmJBrd7Bcoom5r+CkhjWt
s/oYNQLsAn83ThctUTNA+0qmvq79+j4uEGnOJysbNxqVM7+tYuScBpu+uAKJNSze
yQZvX3YjeKn0ZjLO1XmBuhcPAZwIqiRSD3joBF7lHXcib6r7+5Pmk8WponTVA3TU
GO5VOh592Drb/Txcz8iFy+kfYdCBVf2HxRRp1I7jGoh91LJLHlD/MZesEjy24dCP
+8N/1bk7aPsFSldcH/7qtaiTpIuxKEzXPw2+Tg8yJl0qDBjx3bY=
=gLw+
-----END PGP SIGNATURE-----

--CHJ2VHkia+pFs2X7--
