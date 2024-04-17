Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266F57895
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334602; cv=none; b=odLtIxmKuyrjSF9/BAhAzgZyz60KFTkygBqzLgZiViEYNnggHIZh+seixN1KjIFoPA7fIeaZfU9nEUM9Zgb4XAp1Q+cxTd4VZe1p/OdKyvmKesEEVtGQBoaYF5gONnTzMAuVsLIdPP4fe+gqDbUak4UNZ7fXvr0//iftUpESiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334602; c=relaxed/simple;
	bh=7gWJGEC3mZmFjNrJqZ5oVIxkmOyiLQjsMcFDe619Ks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZyUK1OXhKEeIt6UJrwTOUJ6EoBkYVk7LGBsjKBbKceWZ/+IYXqQrRwOkNQ+KQxb3jvNdbt+qQ/6sfWCLhkBmy8jWo7gdTNJKPv4xOEhw59VM/FeJuFDdnnBN9kY2u9jayHaZU9o3H0M+V6VkXYokEzgvy5U7+YQoP4z/g8+OE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iwMv5ig+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jUmWbaQh; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iwMv5ig+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jUmWbaQh"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B62F71C000BE;
	Wed, 17 Apr 2024 02:16:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 17 Apr 2024 02:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713334599; x=1713420999; bh=qVdZoDr1Vz
	BEMQdpYadBMCVWjm9b8Y6ofAvq2FGYnaA=; b=iwMv5ig+DBskYcJVtIwGaTZdtb
	fMx4K1epS4+Sb4gQ+zqpBOLhdoSWhpYWsNs4cAlVvXPvdfuSlceiaN56qgI74Ffm
	ORTco+5PFlXdFsRgbwu4vo/Lt0mmv9c1lZfFibDDZxWKW1V9Z30dFHjzcxZtXDFz
	Gd7D6J97BzcJNeBOniYtttcSHoZ29H7dyXltK0vFZXqjjVnEaFyXH1wl2/xgKxxH
	23p7AebERL1/HWkWzNKlD5EH3GYJIWSamjCsa/3658yBEm+noVLLtovRp3oJknvq
	ABUGzt6Q1q10w9vtX3oJ9i+QN4mQ7PAMd095dbNuhVTVLRhmvV6LEWw/tCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713334599; x=1713420999; bh=qVdZoDr1VzBEMQdpYadBMCVWjm9b
	8Y6ofAvq2FGYnaA=; b=jUmWbaQhV1jnbkoylOo3CCBJO9i8NFvMtg66AjhcElRV
	ZMOGB07TiYIrIQtZWy8/hwY9j/r04mmck1S/ZaDRhWXIjmbzgGfFxW6/bz5Sdo0L
	mrSLac0wPIhYySRut6ENvorM+Ff+kL1XY8QDJ2boW2RZfwvhwDxplN7g3AlQZRFj
	M4xRvnJwGMPgEbNqs07ZzSPxyKSZW2tenIaK7icxuw6Bel7LQqpMmdlVyDRsCRSr
	a4CxvBZHoH4ypBro0HCcKC7Zyw5BH2D3GyQ6GyoC5SgsW9/Vq3ggF8FrMWDSOXXq
	RwuPwVcXBOOInGLEFZ1RYkcbfqlteDNuvqw1oFwT/Q==
X-ME-Sender: <xms:R2kfZhaG-pelKBUA9aFnsNLciIDU-AO-iAg-I108NbDq4RilVt7Thg>
    <xme:R2kfZob3YMK-ovglU5micyRXe6HBgRaAWD4DhsmSn7pVA3MFbX_iFJApAF-XpPdV-
    rOG62dmHjD2VA3iRw>
X-ME-Received: <xmr:R2kfZj8glDxTbK2Rl5bbzLCey122MgMCd5kletiwg5AyLIX_d8pKFaA2eMQcW28YzjxWXt1Vqp0jhn4_PQjYLTr9u3P6xRjYdkhzjg0LJYtt7aNGbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:R2kfZvrAAYHAj7Ksipcysa0PK2QGMK2ZILEuSpo836TzWu7lTfjUzw>
    <xmx:R2kfZsqK22_Kbm1LahNVPGHem6Ivmo_Wb3_lLcJ5_Vxno562ebbgkQ>
    <xmx:R2kfZlQwSn6xNVYA5Rjhoe0RKIoLCa4053yXTosn0WzohSVE40FKzQ>
    <xmx:R2kfZkqdD0WqOp01sJfWbe7CqvarIAhSB1dQJGZePqKWe0ZUAtfLvw>
    <xmx:R2kfZnXMYGnIe7c9ikAfcAqNVlbnP3sN8mrnJPi0-zaPSXtMPgcOT92y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 02:16:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2dc95281 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 06:16:14 +0000 (UTC)
Date: Wed, 17 Apr 2024 08:16:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] builtin/receive-pack: convert to use git-maintenance(1)
Message-ID: <c7bcc83d3a96b613db4fba9edfbb6d964b338ed5.1713334241.git.ps@pks.im>
References: <cover.1713334241.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BXj0Qg+obuGweM12"
Content-Disposition: inline
In-Reply-To: <cover.1713334241.git.ps@pks.im>


--BXj0Qg+obuGweM12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 850b6edefa (auto-gc: extract a reusable helper from "git fetch",
2020-05-06), we have introduced a helper function `run_auto_gc()` that
kicks off `git gc --auto`. The intent of this function was to pass down
the "--quiet" flag to git-gc(1) as required without duplicating this at
all callsites. In 7c3e9e8cfb (auto-gc: pass --quiet down from am,
commit, merge and rebase, 2020-05-06) we then converted callsites that
need to pass down this flag to use the new helper function. This has the
notable omission of git-receive-pack(1), which is the only remaining
user of `git gc --auto` that sets up the proccess manually. This is
probably because it unconditionally passes down the `--quiet` flag and
thus didn't benefit much from the new helper function.

In a95ce12430 (maintenance: replace run_auto_gc(), 2020-09-17) we then
replaced `run_auto_gc()` with `run_auto_maintenance()` which invokes
git-maintenance(1) instead of git-gc(1). This command is the modern
replacement for git-gc(1) and is both more thorough and also more
flexible because administrators can configure which tasks exactly to run
during maintenance.

But due to git-receive-pack(1) not using `run_auto_gc()` in the first
place it did not get converted to use git-maintenance(1) like we do
everywhere else now. Address this oversight and start to use the newly
introduced function `prepare_auto_maintenance()`. This will also make it
easier for us to adapt this code together with all the other callsites
that invoke auto-maintenance in the future.

This removes the last internal user of `git gc --auto`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/receive.txt |  2 +-
 builtin/receive-pack.c           | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/receive.txt b/Documentation/config/receiv=
e.txt
index c77e55b1cd..36a1e6f2d2 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -8,7 +8,7 @@ receive.advertisePushOptions::
 	capability to its clients. False by default.
=20
 receive.autogc::
-	By default, git-receive-pack will run "git-gc --auto" after
+	By default, git-receive-pack will run "git maintenance run --auto" after
 	receiving data from git-push and updating refs.  You can stop
 	it by setting this variable to false.
=20
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56d8a77ed7..e8d7df14b6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2585,17 +2585,16 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
 		if (auto_gc) {
 			struct child_process proc =3D CHILD_PROCESS_INIT;
=20
-			proc.no_stdin =3D 1;
-			proc.stdout_to_stderr =3D 1;
-			proc.err =3D use_sideband ? -1 : 0;
-			proc.git_cmd =3D proc.close_object_store =3D 1;
-			strvec_pushl(&proc.args, "gc", "--auto", "--quiet",
-				     NULL);
-
-			if (!start_command(&proc)) {
-				if (use_sideband)
-					copy_to_sideband(proc.err, -1, NULL);
-				finish_command(&proc);
+			if (prepare_auto_maintenance(1, &proc)) {
+				proc.no_stdin =3D 1;
+				proc.stdout_to_stderr =3D 1;
+				proc.err =3D use_sideband ? -1 : 0;
+
+				if (!start_command(&proc)) {
+					if (use_sideband)
+						copy_to_sideband(proc.err, -1, NULL);
+					finish_command(&proc);
+				}
 			}
 		}
 		if (auto_update_server_info)
--=20
2.44.GIT


--BXj0Qg+obuGweM12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYfaUMACgkQVbJhu7ck
PpSUQQ/7Bpujk+cooESSHHD50HUOu3uxB2e2li+jVuJtI7VR1NhTjNef9lEiPcAl
sN14gXPajOG7A009gGd7wwWmT9KBmXPJC8NMtUia1feHopMwj98k5VUrLLJDfQzz
Ali1h1ZfZFN52ZZCeIzdArzMlRkYNoxnDPeim7rJ6b18yzOVRD0U72XdBuM/PjKt
yddp0dpC8SDy37tg2xYwBR06e2hzQ/X4iOB91ukd1Wk3JNum6ha0r0Qs3vUErKWv
NQwnKZ4d3jIs6shs7Q8eksQNNUe8q7bgY1ipizPlGPPixY9PbLNGHcS94f1tQKqV
byOE1NxrAB7XBQRGoJYwPoSXjZx7zdzMG697leagR9Y+S6r4tpRcYbSUfvN9dnYS
0wT20aHJ8iZCbE9y2MJep5K9O/lRDktBgzVl21NRYTqAG61LaLzqAE/lj3Ip/pLs
8QOc3on3a7xy9BVja25u5YdMm4kggBiAMqlpFjeWllFmr7J6GfJrIUXuCxZixsrJ
M5kYEwatB1Of3nlGELG16QEAvgIgLffJpzw9vgZjDNqYfqb98ev9tx9fxK2dS25e
TGlFjDUmFtynyXTmWaLW8niQ9V64OgoMyBsPU8EPLAUSBcZTjqKyche4wSNdAA1w
/2YQj813M6F4CQ/1Fk+53oZ0lK1zy40udNm1tEGf+5NWILOldCA=
=fchZ
-----END PGP SIGNATURE-----

--BXj0Qg+obuGweM12--
