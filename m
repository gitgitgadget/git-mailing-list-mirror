Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CF179950
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996059; cv=none; b=SI4KDgCKBocvkpX364hd5uQzfRqJpyrOqdSFHeDJo4W3Nufq88cBWq9zip8KTzAGksU4wsKqDOougMJK3SDySwopZ6wMwEY4a/1SOaNKGsoJkRlnbWO2NMCrQzkqTv0273KF/YM6XqhAqHPecffsC/1dL+FKgjL9uzxBMkrD6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996059; c=relaxed/simple;
	bh=CYL2nIhUuoX11nLiCJF9sVpTTkby1xJzR7eWzM0mh6w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGflXG5p5JnDyLcjfDQMQKFZHM82dSXy9Sx9lebGkBsb3lu/9gWKrOMzXbmRpj/J1epGASFWbKKy8VbteIZQWm3Aa/k/51827dvB85ZGyqaSUSQA/LBEFV3kMbv5fdebKkLmRl3gDefvXDKYVPwvW117gfeElScIrT8FWpoVjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oR1kY96o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfLf8uOG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oR1kY96o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfLf8uOG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EC31A11401F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 Jul 2024 08:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996055; x=1722082455; bh=de/Tqk5T35
	p/Rvsk8vjQivE5hrs4kAlD+4fYL6eD5Ck=; b=oR1kY96opQ3S3L1dFk16ryUp3Y
	WoIZWsp7sUrgZ04UYeCuFZLuU6VjpXxXCQpG8cegRaDj7L76Uce1wEF8uEF7HlCC
	Y9EhdM+vAtoKlt+4Ac0PDV+/w3JoSwncs00E+XP69pm8MiZH+AUcNDE5Z3u94OyX
	lxlU4VJQyW0bjroWYtUzNwGN9r8DX2tgL7cf0V3sBoWGWUg9UYGv41vKsN5BXcJd
	77Q0dBk3HvdD7apJJXVKyz+z8ENEwINmuRcSCzTmFBEriLfD1NbYxvT8V5u+4eG+
	K1MGKCzGNGFrQ9bY2Jpp2BEfQLvtqmJr9yU6Hxce/w08jspxGLeiNRG4YEVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996055; x=1722082455; bh=de/Tqk5T35p/Rvsk8vjQivE5hrs4
	kAlD+4fYL6eD5Ck=; b=gfLf8uOGzpj4EfAGsYKAq+nuPOspUk2I7X6lx4llBdr7
	ycEs2pPJGYv7ZKqDBARRgO9gx9CAy3FPtb30xwE3CA6cFmMa0jpu/nPVi921WPBp
	dKXoljKgzx8tKS4lziuxa3K7S/q4iyRWEQG1W4v46Ym+TFrijJ9DBk/ueBEY9tTd
	Sg1tzsbwmiBhvC9yTwsYzpAY+mpP7coujZTxzw0OJ46rsptl0IB1ozZtMCPqC1tX
	Izj8TJGSbCKjWmRz/aXyNgolRWOkPzqGGp4IxyyJdJ3v6DWefwJubGM8M2GNoxTg
	D9IlghUi9M3I+WGX3Mt63vvV3/SrNPuPcM3A3T0hQg==
X-ME-Sender: <xms:F5OjZkBb15KJDQzluPNobjXs9X7dpYHjvUXeiPgfHCD68SF6UEksRg>
    <xme:F5OjZmh2o-jW060JiE9TUmJ_SccR2io_v5d8dAJS6_wUbIg67x-ZTNN5kp8EiLrRU
    5BOAK-5ruL2B96OjA>
X-ME-Received: <xmr:F5OjZnkyOzni1bYjz8pCVE7aaOso3AAujaoQAXlTQlW8o7k1nwZ_DJXuEaa71-1TZGrvz2THb795Hp0FLfFo4mNSZ_ICk-qBZ-Ok7nALpZQqdPLy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:F5OjZqyf_EfEEdyDISF-W45mqJ0lne7uzTBngaJyyBBl-vq3gV3onQ>
    <xmx:F5OjZpRI2DS0yLp9H6_U_NuWMs96UQVQalS-8H-1BgJN5rJQQAKklg>
    <xmx:F5OjZlZ7opL95JaV0xGWiGFca2piOgGwafs_mYz05je5E13VjKAONg>
    <xmx:F5OjZiRZ4yN4SYGXkD9bmstVa3fgjGbb2FbOCIiwwa8J22cQd-yTQw>
    <xmx:F5OjZoJ07zGFal2-HHvM28NDUoLox6Kzy-Os8HXWt8lg3QZoxddOmI32>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9471a9c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:12:54 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:14:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/23] builtin/log: fix leaking branch name when creating
 cover letters
Message-ID: <4daae88877f2355d6a3960883e7b3f15cf738cb5.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UC1BtgFApLLBuDmH"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--UC1BtgFApLLBuDmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `make_cover_letter()` without a branch name, then we try to
derive the branch name by calling `find_branch_name()`. But while this
function returns an allocated string, we never free the result and thus
have a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c         | 4 +++-
 t/t3206-range-diff.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4d4b60caa7..a73a767606 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1434,6 +1434,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	int need_8bit_cte =3D 0;
 	struct pretty_print_context pp =3D {0};
 	struct commit *head =3D list[0];
+	char *to_free =3D NULL;
=20
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
@@ -1455,7 +1456,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	}
=20
 	if (!branch_name)
-		branch_name =3D find_branch_name(rev);
+		branch_name =3D to_free =3D find_branch_name(rev);
=20
 	pp.fmt =3D CMIT_FMT_EMAIL;
 	pp.date_mode.type =3D DATE_RFC2822;
@@ -1466,6 +1467,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 			   encoding, need_8bit_cte, cfg);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
=20
+	free(to_free);
 	free(pp.after_subject);
 	strbuf_release(&sb);
=20
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index a767c3520e..973e20254b 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -5,6 +5,7 @@ test_description=3D'range-diff tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Note that because of the range-diff's heuristics, test_commit does more
--=20
2.46.0.rc1.dirty


--UC1BtgFApLLBuDmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkxEACgkQVbJhu7ck
PpR57Q//Zh0aTCL+fufM7EWm0q/ULMqMblQ/M/PnKXmpxqRFBSBOl1rlWjWKrSM1
+jkADRKqoNcmRv9k+h5JTjeotODhLuUSSZGke+BELBQ5+I129PIzvsW3nZ2SWnkq
HYJeUxPyxCYA+JGF3zK6/CqOIxL89tQxZ6RPqQAFhYJ4ksnoGDgrx8VB9RjrVHhH
/eMt1ISaGg/fGReU/QSMizm2mVgISXGjCwvLw9MAUOTHBqUSAperDmMA0c2jU0qH
X653WwHq351Kc0tI87l95KvMExIbkhv062D5tYNu7YbD4K7Uy3STJd9UlTPtgcBQ
mml7ztbcd76FBGLnjW+/1uVyN7FBAO+6or/x488udyUMhYilbhXRTs61mizHNOua
OmMDC62owmaW/VCT+46AzxrPnD/TRNLCkMVcJfcXKXZrzLKMbPc8CL0gVQq9rVXo
UEB48ntWDMobiojYXUYkPPXkcCkwwyzmYR9/SGVV7tXQK6aDh/OG6brs7MtMZJ5b
4H0nOvAA0PhTSYyoJqCLwonQTSK8eT3HXy3co+AaArFCQfHKPpzRWxmru6J4uH0J
xiXIBt8rh4Gk5w6n+MHpQM/yVj9gCj/swYNa5rBP/yZs6swPFmg3Uy9bIic+wvUD
F7HST+k2FQAx8iyD9pbqY2DEl/8wmzbbs89N9rHBb9sc3qCwEIw=
=Q2MH
-----END PGP SIGNATURE-----

--UC1BtgFApLLBuDmH--
