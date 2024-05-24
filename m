Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9A84E09
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545086; cv=none; b=u7SVipF2+LAwrVFueeI218YXXMD+koIuNwn1t+tioK4hjtIW0AGFNbPeLostBL0Ie8rxjaK1pBsaFDnp7P0HvQmJVNTxWLsMKeQivOwCl+OX53d3MbTh7D2lj1sZsMmykGHFAiYm4uVRcXmDT5t3ORvfF14QTgblB5oh9LIFvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545086; c=relaxed/simple;
	bh=tOxNMGEpmwHDkua7F95l0T2dyLB9Q4/JjJQQTksg4n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCVVXlGOFS5rnnbgYvqNdkSaXkNKehAGo05DVLtMlhBhzYYm3r47KLJzQ2Ix8nzHJ3PmzzxRbNWyLIjtaENmh55NvfGc3FsV+JMpxTKtdBigcm4PiHMT6B5TVEbINZa2oFwpY7o3ORiXELFt5bN4HkasW0YSS+xhP5b/x8rKwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rb9dwGuK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CXh5PJ+X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rb9dwGuK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CXh5PJ+X"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B8C351380128;
	Fri, 24 May 2024 06:04:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 06:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545084; x=1716631484; bh=ipkRLEswhI
	XjKTjeP13Ml4/rTVIwOqd0g/d5rxJejsA=; b=Rb9dwGuK0/65jAn/+ORb3U28NN
	Ufctp3eWWZZXY56WkIuAsfYY3NiifpeA7qzKHjnGV2+0EwgFDoDuKgVuWyaz5Ei/
	xCXsZVb6NyOgTmiqF+KDi06DBLOvg9LFC6SBBTNO1kwvmOAdUf6v0DrHh5WjojxC
	klFJZg9x/3pT6L5k3VfYZzH7+pb+SshE/Y/jYIzX/LJVaf41zK27yJWXF4uemoZ7
	SevyZv5uKAxOtvFN79ujOJvtSdVUR2Dzs7y5+DIwyZS+2VJh6fHs3x/TmT2PxPny
	f7DGjTlpp5dMMCV4omYM/Iu5yR0QwaJ54CMBZnwC5KJOtHGvSpsQnb7JfwXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545084; x=1716631484; bh=ipkRLEswhIXjKTjeP13Ml4/rTVIw
	Oqd0g/d5rxJejsA=; b=CXh5PJ+XK7IgNLzXnUIzK0FSQFJDDFhsd6RVXNcymm4f
	e+Bsk5YTgxgPtFGw12dK4wVQFtiM3QwUN2Po5Ghbbk2Zw7GUfCk0GgG9rRk0XH2h
	9ztSOKtb47VAPreaHkVT2fYWXAIwKao61mROet6SyFxN9HsoMrNzaZ1gcm9idN/i
	QVvO+CbTyTp1N0lu/m7vMDUFmMsVF4O/mAekVUb1Xf8pgR9lRNe1FFguxiVaMiLt
	YzoZOL/y3EW+H0RVezaQOg2nGc/MLoSdpr/QblzBnpTAw+mjhoojb8E+iumW6iTz
	N9q+E+5OnHNcKS8n1OHv++0Qu53BnNEoXTIeud9D3w==
X-ME-Sender: <xms:PGZQZrJWexnimHMKvDBH1q0h-JOQ3VKtH2jZDK879euwuXifROW4Uw>
    <xme:PGZQZvLxdTkXkTn2527mhKkGldGnBU8usimWjxlB0yh59Adrf4sayrqQ_90Vo6Pf7
    ZgPSB446lgJYLuQ1A>
X-ME-Received: <xmr:PGZQZjvID01YZDprb5rcOunoFQLApP_afaJR_rBH-NhFxch0a8WHRXQQbJ4wVkljw1TK4AlfPFQHAOCtoPh8MQgT263vtGmSYsGGmbsd0hwx8L4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PGZQZkav5AI9UfL8aDoumHz6TPMmsEb46lmcC2zGXH2pVv_Xve2pkA>
    <xmx:PGZQZiZJozWnunJnnHo5CSNpAShKAQ1pWNdeknPbGhMUTXJb99DUIg>
    <xmx:PGZQZoDlLG4DBEUWKc9phk4NNtQ-jgKkd0jrXcY3zsINXU6zYWFsbQ>
    <xmx:PGZQZgZJ7EPcNTe9tiG_WMyCxuMmYFCUrpykzQjVabgX1kDwqwsLXQ>
    <xmx:PGZQZiF7fKcINtFsg0t81ps6TrSu0cjrR_ACOfGisV1t0TJkmblI6Q4d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 43781825 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:40 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/21] builtin/mv duplicate string list memory
Message-ID: <d4fef9825a955de9b076646c8d4864791d299ae5.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HhrY8Heq70yk1TEI"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--HhrY8Heq70yk1TEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

makes the next patch easier, where we will migrate to the paths being
owned by a strvec. given that we are talking about command line
parameters here it's also not like we have tons of allocations that this
would save

while at it, fix a memory leak

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 9f4c75df04..12dcc0b13c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -183,11 +183,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 	struct strbuf a_src_dir =3D STRBUF_INIT;
 	enum update_mode *modes, dst_mode =3D 0;
 	struct stat st, dest_st;
-	struct string_list src_for_dst =3D STRING_LIST_INIT_NODUP;
+	struct string_list src_for_dst =3D STRING_LIST_INIT_DUP;
 	struct lock_file lock_file =3D LOCK_INIT;
 	struct cache_entry *ce;
-	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_NODUP;
-	struct string_list dirty_paths =3D STRING_LIST_INIT_NODUP;
+	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_DUP;
+	struct string_list dirty_paths =3D STRING_LIST_INIT_DUP;
+	int ret;
=20
 	git_config(git_default_config, NULL);
=20
@@ -440,8 +441,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
=20
 	if (only_match_skip_worktree.nr) {
 		advise_on_updating_sparse_paths(&only_match_skip_worktree);
-		if (!ignore_errors)
-			return 1;
+		if (!ignore_errors) {
+			ret =3D 1;
+			goto out;
+		}
 	}
=20
 	for (i =3D 0; i < argc; i++) {
@@ -566,12 +569,16 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
=20
+	ret =3D 0;
+
+out:
 	free(dst_w_slash);
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
+	string_list_clear(&only_match_skip_worktree, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
 	free(submodule_gitfile);
 	free(modes);
-	return 0;
+	return ret;
 }
--=20
2.45.1.216.g4365c6fcf9.dirty


--HhrY8Heq70yk1TEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZjgACgkQVbJhu7ck
PpTF6w/+LqWnciD1zw0/NlnMusafguiYLMlELDWg2SfL6pgOp+ykICPjMicw2Oqn
OZoe33mYQ5wApTpw0n+azlUw8ba2fS+8awFVa5vQ/EoxGGU0eck1bP1SQW6R06IX
onVFmlV3JI8517DSF+/yFQ/z3mrt8KmS3PDjUFaO0m8/v52ik0r13mUZDUAHS3Oc
iIpQPkjpR7/ppput6ALKnt9+R+uRPNLb0ciAGxp0bqJOWG4Lo1PQNUhL0RiQP2Er
0ZlO8jOy3D6bwSMTqNKp7epEzSCiWMq6rrnqc5zPime4eS6o85r5hP7vBZcv4A3Y
hh32cUON3pg7/5JTj6DelIQkV7XbkW9mlkYf4we4V06+qLT6/rPCCP7dO16489Sy
c37/hMDsncDYFASy2mnUT9BRhlyb3OUBVdB4LSLNk1aMnxL4MvkhkFnkbVSbKuYd
UUNJVpu7dsnAjb5Z1TeSzcklVICprF6xwp50RWnW8RzVaNCed2d2dLrvfCrIeuxW
ErPY4pYLfRVYx+rLKfFEhDATRhQDdIfHhOJmjLI/1k5N71H8WMrfd9pl7ubQwuLV
yI6e8FrtdeFP6KqueKlHiduHl9/o1ga8V5G2Ae+aGA/JfMoAaZMYx53AE/6jj5jB
oPOs9uhEr8s3j+oXTDFscpJu9hyFFFXcUY9vjw7P2tFN1tfGaNc=
=/nZg
-----END PGP SIGNATURE-----

--HhrY8Heq70yk1TEI--
