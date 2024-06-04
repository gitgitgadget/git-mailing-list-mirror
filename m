Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE2147C9E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504378; cv=none; b=n6xShtFO67wp5FF7nyRo4cxVErll7Kwsw8M4kkycYRVMQbWVL/SXhsNEZ0myfnd7NWYxpCpScYIcOg7XqgEJtCYctQUEnizYcjhyb6abL1YC1HTor91Gnpr5K9oUSZwLsv1ly1z13jgcFMcZt3CaWXSMEBpK0hc9y2LU02CyLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504378; c=relaxed/simple;
	bh=4992lzSV0IStGfrvlq/nrm3SQJkcFBF+MTcE52Fujz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esOC4DnGpKQwEqNSYtcLwXHEkLzOdNlZQbBhlxMtYhmfaN5nuCld3HvrXjKksg8eIkHDK5A80TQocPeB5XkJqjOKy65uJ/MZL8Is9nJqzR/oQdPrZ13QQr27gFfrIFHq1MftHZDahRZ1pGM2rkM9SCHUEZYEeC/6u380HT6Glqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WWRrVxu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8XRaaTo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WWRrVxu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8XRaaTo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 71843114010D;
	Tue,  4 Jun 2024 08:32:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Jun 2024 08:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504375; x=1717590775; bh=7PTPOcI2I1
	21Dpv5eEyKO4niO2MNQLeVdacb/z2x6NQ=; b=WWRrVxu9pmKXu5cJgTnlpe0rBx
	RcIgtKcWr3ssOjcf1iffBpjqVtVQ7wXf8v4yr5qfwAzrtecKBGe5xjK6EdW+Whm0
	e+8SJS0v1LwhreEp9p4SdKz71Hn8esbSEmQd0gjynf72Dkqlu6aABRlWbCbaQBR1
	muEBpoPfuM2hgFoWXCOYOGqerXWWZUsAts0Kze6nbI5buDsYAu5aT7B0AF706r8a
	chAAy42kPEgem3y/fa1ivUolHVYqiEZzWVxaxQB0A+GzXG6XmBR3QPnIAIfAk4mD
	DZo669vd0jkzXi6KF0NvG9gZaU5PWRNn9g54OTZWrW44nWhLDX5lCS75XnoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504375; x=1717590775; bh=7PTPOcI2I121Dpv5eEyKO4niO2MN
	QLeVdacb/z2x6NQ=; b=C8XRaaToEhmcAI/kkta1ZDY74gGqJG5TrQBKmlKRNyEg
	EoL+D6DBUvuhCizKRp0G/QAyszoohEafpggqR5j9NuhvXFokrmp2DoVqWLgWFUSW
	OHoDuTgQTX/YqWb9HFMFTnoCSYlcUnlbHINJH7kQDnM9CJonSgvqs23AhYBJND1C
	QjH2RDULUjz/FDaHEAsDoqeJ0lXEG1BD3UICGErhvF7pyyw0vrnVwR1f8XTFOllG
	9VQLvTU9svl7CG4o9JuWcE5enFB2De9hqzFy/NW3uxEAv80apTa+07VJ+fyxhZzk
	El83tQNt3EOrMgF0ylGUiaLFfj/4VsVcIoACzHui4A==
X-ME-Sender: <xms:dwlfZtutpc8Ql6ng_Kmfr44fZpgo_sSEuro94rQx7O90qvjVmgh97A>
    <xme:dwlfZmfkl7tdYCVCku3xRS5FZ_V3EsFGzaEpsYHAkjnoV5S4gyCeqpRP81kIxx4BS
    JEvGENjBPFWSJkd3g>
X-ME-Received: <xmr:dwlfZgwiNS_4JOYfyO4Y7ZA-bD19-A7FkB5-uoLtLvkiR6sJEaJtvLa9WwBxBnNe5ldF2ZlH6nwPoWMKW7tGhP6fMt6uIxxBsmePvs_mOqGfE0Rz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dwlfZkOzKeaJ4Gnkg6WF82AML53sDVLOgiuea5aGWqQewCsS_lllpQ>
    <xmx:dwlfZt9J1w7s4405sgtWjYz-kKhjFJTbHqaU5g64irff78CnwHwwhA>
    <xmx:dwlfZkVqg7qizmlXSnC8nOW7zy7mXwPH-yw1aLJgM2OuCNeVkykeRA>
    <xmx:dwlfZufOp7t1nqL6sSYFPz7yHPz-cbHwwMAgQUTcWUgdeCGDI9rZ0g>
    <xmx:dwlfZpSl4IuqmkSgsCP3eTomxnX3jkz1aDgOO5KxZhWv1noekHDKh19p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:32:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 334ce305 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:32:26 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:32:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v6 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
Message-ID: <4fafccc3b919d68c51f83b2cb0c04f8621c17426.1717504292.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Img3GNu1lMmVsnc"
Content-Disposition: inline
In-Reply-To: <cover.1717504292.git.ps@pks.im>


--6Img3GNu1lMmVsnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-checkout(1) command is seen by many as hard to understand
because it connects two somewhat unrelated features: switching between
branches and restoring worktree files from arbitrary revisions. In 2019,
we thus implemented two new commands git-switch(1) and git-restore(1) to
split out these separate concerns into standalone functions.

This "replacement" of git-checkout(1) has repeatedly triggered concerns
for our userbase that git-checkout(1) will eventually go away. This is
not the case though: the use of that command is still widespread, and it
is not expected that this will change anytime soon.

Document that all three commands will remain for the foreseeable future.
This decision may be revisited in case we ever figure out that most
everyone has given up on any of the commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index 9fb6d8c78a..0fd60a7776 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -114,3 +114,15 @@ Some features have gained newer replacements that aim =
to improve the design in
 certain ways. The fact that there is a replacement does not automatically =
mean
 that the old way of doing things will eventually be removed. This section =
tracks
 those features with newer alternatives.
+
+* The features git-checkout(1) offers are covered by the pair of commands
+  git-restore(1) and git-switch(1). Because the use of git-checkout(1) is =
still
+  widespread, and it is not expected that this will change anytime soon, a=
ll
+  three commands will stay.
++
+This decision may get revisited in case we ever figure out that there are
+almost no users of any of the commands anymore.
++
+Cf. <xmqqttjazwwa.fsf@gitster.g>,
+<xmqqleeubork.fsf@gitster.g>,
+<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
--=20
2.45.1.410.g58bac47f8e.dirty


--6Img3GNu1lMmVsnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCXIACgkQVbJhu7ck
PpSBmg/+KN/+tcqU67T30FZVrZo5+fb1l+ek0vvnd3giE/R98Qw1O/9xFd4d3S1e
hxX59vnM6E4bnK7Gvd8aSv78QhfIf0gYBT/jhzPInTdOUbTq+L+Vb1iEn3RIm1Nv
wnX+I6ldWMma5GE3uLgfrUVQaQYZ/jAY6iv7ULQNUAfR2YzXmVdZJ2I61xiibkBa
mQVpIGlOEfx3w/iF95O6lm4btoHZKy4+t7kwi7eLczq1JW5h2fDR7aZMPlrqQXb8
UQ8XsCUhVdukZX1oWCK41CZZnHWNO4pUMeNvaB1tM2qnfaPRKbHpoScp0l544mZC
xUbtopyDYyS3v+/HZa48CiL5IDN5hFfk/ucFVT3Ij+gr9o/wDHTXjxE3l67uc86F
eWObzjNcD6aUdNHThJPtvt7OCYRN967jUZvc/QB7SPZ9IPLvhaSTaDg6KbtzrV3z
p16GGujW3/VXTeIV5o44v9xtFBSuMb98gXvSYmtiyb2DcvQqbfzg5Jr6XDUL6m1d
J8S20ewm6sWzk+0FHjQJvlVE4AOjKXv5iC74qKPb2JDQEe64+8cz1k/3SSkEDv4P
/cRa3aOpCr28gJr0oTfb3v1oxuoCBlitrbC3/y0jXvWLsDSTQk1kyGZ6jeQTW++T
ZKaSEpXRI5Pqc8uwreOgG0wnJNY7bJd9ddHIHeGvGo8OQ6wwpCo=
=Ocer
-----END PGP SIGNATURE-----

--6Img3GNu1lMmVsnc--
