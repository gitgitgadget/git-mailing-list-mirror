Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967F7464
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102530; cv=none; b=JouGtr62AaZVM1F8AZnIo21VxE5Hlx43G/a0LVnW9gf4Vy054UPWA4NZ1NRN6oHOvPsT93XjDukrJg3OgnAd23//K4LEzd9lwxqEcyHMzK/0AYu1lHFjJMJNgy28J8BXj21wm7O+NNZOZZ7UuFD0TK479R3120Cpytf6Op/N/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102530; c=relaxed/simple;
	bh=HfHLwuAEZWPKqpak2WKZ6Y132n2WzT1WomPdsK+U2/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFpxEzFRP2R0xCDSBiHQwYjy7uLwXLU0GedxpQqOn6tNxZgPjJ+ap0MuHQOhKmKLkBrcnNxUwZyjBSSB2JBIori8AQwjmz5djZM2qLa3aMQTPuacp8STWbwh3r3RIfZSXNCjfwy4amR8vBGSvxThq+klnwH5HZLe+QcYG0KcsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VYVd2skH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DW7WcRUF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VYVd2skH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DW7WcRUF"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 149861151BAE;
	Thu,  8 Aug 2024 03:35:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Aug 2024 03:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102528; x=1723188928; bh=XKCrQ9PHad
	DSKtewgataac+qot8twtv+f8tln45QNHc=; b=VYVd2skHUBPbNhZeClX0G8/TM+
	ZuqEpldlSUXnUW6isrncGIDdnHKkhhpUgUbPSZlnQgYbyPl/DjcMwuKHlowYoW2D
	qkNPIeKshirl4MJepqqNhuQP5OlU/DS5rRnyaPiwMTPIrgtjcDDFNmHKMrVqukYR
	hw0nShD5La9WOdi+UrdUKoTxQ5bWGy+7ykWiT4MG16du/HRUjjUKWMBrPRa/UFfv
	AHi6KDDVqfI6kWsjn9Uo4nStTvk3GLW+ImIHGLSap8y4fW5BNVsC+xm0v3gpFG52
	v5Awwvx43gvSzVFbouC15J6t4TKVmn9I6964fC0SaYx9aYyIo8SfX6lXe4Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102528; x=1723188928; bh=XKCrQ9PHadDSKtewgataac+qot8t
	wtv+f8tln45QNHc=; b=DW7WcRUF587rz/TdTPIeC0qYhVkPWRTh/L6AOsnHMQhC
	L3xETWZQqSuC4Ftzkr/N8gLRcnCesI3UdJc1dj+NMAw7xFSGAn1HfqxZ1IVQfEX1
	X2m0tEIMUpGpJxPmkjoiBEOyvfjCT1Q9zfx03scb094w0OiwJSwdWxJFyqQLHAmX
	Qwk1oyih7UWExCCa8NjVuxrgGkflb2f3yUmJFLlS1YfzXXdho+HE/coBt2DkzNQw
	r2uJ016krFZCNjvtSBpN0PR1jLe1+OEBQ5BPXMxuaAlpJsa2sIxn3RELdk2LLKGv
	Duf4oicXYfcyvUeg/GJeVLfAXQrW2vreAW2VLG7xag==
X-ME-Sender: <xms:P3W0Zgmw6uZvzwqxC54amIR_w7gpdAFPgvJIYRy2GRqc9bPgYjCf0g>
    <xme:P3W0Zv0lV4q-cZykKqN9j00cFUyyH8EnMjDSYTM3Z3GsIG6QNwi69yW8z0rnbvFGx
    adbqhAgkqSsAnZMGg>
X-ME-Received: <xmr:P3W0ZurS2JWIrUwYdcNqOlpG5KJs2qH-pdCSzIWo-TxV0Sde4eNjyW5qouBJ-8VRATPL6mliM4yySs57yLrm6B7lMnw_agxcmK6ZDJN7framlvKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveej
    jedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepjhholhgrnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:P3W0Zsl1azvUV9BU3gocNzlPzGDKE4Q1-kqEkh-mAqwNpaaKk74NlA>
    <xmx:P3W0Zu2AI_g6zPjn5jnNA9zaoSmQUl3uGD6BC0KGTlhaUr9Co1ZRjQ>
    <xmx:P3W0ZjtvVW5Rj9F_hbVBs2-lTOVx6CDe83YvES4YM3umHru9PLzYbA>
    <xmx:P3W0ZqXvUOMmtVgS6awM2O28pm8vFwfuWb_DeNFQnEqCLMBYFr92KA>
    <xmx:QHW0ZhTuEAUHRVxvSJPU4Jj4YIYU-gL20g_XNsT5p8jWId-YQLHw554Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e90a98ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:18 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] Improvements for ref storage formats with submodules
Message-ID: <cover.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YBXpaiVE1xBVHtS9"
Content-Disposition: inline
In-Reply-To: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>


--YBXpaiVE1xBVHtS9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to improve
interaction of ref storage formats with submodules.

Changes compared to v1:

  - I noticed that `git submodule add` also used to fail when used with
    a preexisting repository that uses a different ref format.

  - Add a preparatory refactoring that wraps overly long command lines
    in "git-submodule.sh".

  - Wire up support for `--ref-format=3D` in `git submodule add`.

Notably not included is a change to make `git submodule add/clone` honor
the ref storage format of the parent repository. I think it is somewhat
orthogonal to the changes I do in this series, and it is not entirely
obvious whether it is a good idea or not. We can still do this in a
future patch series, if we ever hear good arguments for it.

Thanks!

Patrick Steinhardt (8):
  git-submodule.sh: break overly long command lines
  builtin/submodule: allow cloning with different ref storage format
  builtin/clone: propagate ref storage format to submodules
  refs: fix ref storage format for submodule ref stores
  builtin/submodule: allow "add" to use different ref storage format
  submodule: fix leaking fetch tasks
  submodule: fix leaking seen submodule names
  object: fix leaking packfiles when closing object store

 Documentation/git-submodule.txt        |  10 +-
 builtin/clone.c                        |  10 +-
 builtin/submodule--helper.c            |  46 +++++++-
 git-submodule.sh                       |  82 ++++++++++++--
 object.c                               |   9 ++
 refs.c                                 |   2 +-
 submodule.c                            |  18 ++--
 t/t5572-pull-submodule.sh              |   1 +
 t/t7418-submodule-sparse-gitmodules.sh |   1 +
 t/t7424-submodule-mixed-ref-formats.sh | 144 +++++++++++++++++++++++++
 10 files changed, 298 insertions(+), 25 deletions(-)
 create mode 100755 t/t7424-submodule-mixed-ref-formats.sh

Range-diff against v1:
-:  ---------- > 1:  6513c6b17d git-submodule.sh: break overly long command=
 lines
1:  a450759bd1 =3D 2:  e6cda43878 builtin/submodule: allow cloning with dif=
ferent ref storage format
2:  e5923c0b33 =3D 3:  ed314f5333 builtin/clone: propagate ref storage form=
at to submodules
3:  aaff9134ed ! 4:  f13356581e refs: fix ref storage format for submodule =
ref stores
    @@ Commit message
             $ git pull --recursive
             fatal: Unable to find current revision in submodule path 'path=
/to/sub'
    =20
    -    Fix the bug by using the submodule repository's ref storage format
    -    instead.
    +    The same issue occurs when adding a repository contained in the wo=
rking
    +    tree with a different ref storage format via `git submodule add`.
    =20
    -    Note that only the second added test fails without this fix. The o=
ther
    -    one is included regardless as it exercises other parts where we mi=
ght
    -    end up accessing submodule ref stores.
    +    Fix the bug by using the submodule repository's ref storage format
    +    instead and add some tests. Note that the test for `git submodule
    +    status` was included as a precaution, only. The command worked alr=
ight
    +    even without the bugfix.
    =20
         Reported-by: Jeppe =C3=98land <joland@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ t/t7424-submodule-mixed-ref-formats.sh: do
     +	# Some tests migrate the ref storage format, which does not work with
     +	# reflogs at the time of writing these tests.
     +	git config set --global core.logAllRefUpdates false
    ++'
    ++
    ++test_expect_success 'add existing repository with different ref stora=
ge format' '
    ++	test_when_finished "rm -rf parent" &&
    ++
    ++	git init parent &&
    ++	(
    ++		cd parent &&
    ++		test_commit parent &&
    ++		git init --ref-format=3D$OTHER_FORMAT submodule &&
    ++		test_commit -C submodule submodule &&
    ++		git submodule add ./submodule
    ++	)
      '
     =20
      test_expect_success 'recursive clone propagates ref storage format' '
-:  ---------- > 5:  4ce17e44a1 builtin/submodule: allow "add" to use diffe=
rent ref storage format
4:  8f8371c18a =3D 6:  d92770290f submodule: fix leaking fetch tasks
5:  732142aaa6 =3D 7:  e9421189ca submodule: fix leaking seen submodule nam=
es
6:  8dc7cc76d5 =3D 8:  d05737c75f object: fix leaking packfiles when closin=
g object store
--=20
2.46.0.46.g406f326d27.dirty


--YBXpaiVE1xBVHtS9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dTgACgkQVbJhu7ck
PpS5TQ//ZhHnaOsEeAVd2zsGdoRk2EoYcjJvKyPsC3STIWRbP/VP2yCvJg/PxgsK
EGI8Gyv32BaC1uEjEn4wbXSrjANEUiO684/A3BSo3iYc7muj8AjNszo1wcztAd9f
xf86zE+ZH2NT57cmGCBzAvLXczAExb/15vC5dtXsuPgkwKPfbQ5t3scmNXjhQFjj
8b2KvsOdyp4CpCepZlk16B8PTPwF8rqyOvP6cAA6ge1LeDDmvp/VpF23OBfILqIT
8zpz0Q8UPFNL8UVnzrTa/+nalrv95SrlHTV8NwkoIk5lHs7W47KRA0WYm1SvRoml
xb0HZigOx2rv6MvRKfYGUnzfHqUuq9SgyvUnyGzXIiekvO+xaf4z2i6dm2Pf4gtX
gIzl2+kyRAJTtyQAC8QKSjqLQmio+WPwFEp+hw5mZ+Tb40n/Rn7TX8uM8p/Clrdb
VCbib9eg6A4e0I8kIK60jrtuxc3QkFGYpkRMyoiM9D13v3X+yECU3s9Ioq5/3cl+
53m4p/NkcLrVybSwlp/Hf+HaT1b0dH2wa6uQ5h0jG6MZhpSUQoxqnIaj4aIqjDmE
JlOri31rPqaljQ9iOjvtrD8bKpX6b3SaTKcHzVZV+/HeV6t08f4NTdLJeH/cIP3w
RtFuWCWBySETOgvAlGds/D3Mrom1jxUIBzc/3eowVjp6suNE//A=
=3a4L
-----END PGP SIGNATURE-----

--YBXpaiVE1xBVHtS9--
