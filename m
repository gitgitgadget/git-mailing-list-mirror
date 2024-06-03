Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D557F47B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406924; cv=none; b=Ozi0Bc+zrnPdeUg55u5TRTzB1YhSsWkMIEuWTlck06sK34URbZu2W4Kf8o9knsHKnCAvftptF93171lsgVtc2AadqOKcqJMXrBJTu80ZodVzJBKkbjROSv1gidPilsEWh8HCJRB8HwFpUNnP32EPeoYpvP73P28LuXxlL2MHAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406924; c=relaxed/simple;
	bh=QqD3eWy2jBSipHhaZwC+v2erCMONzaXBqJBWTxEIdRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaJg8ABKHz3SbLEOEpW2/HGpwPrmhChx6NDB19u/L9JfEeIi2v/C658Tg5QoK0zdFfYQ9n81IR1rxZV4hDekWMvl0Vx3AWk97ZLzWqIM2D/gVHs739ZiKCiyOXzocIiddQKdlplsuUDvrH2gTk4CwCYwyZfBm//tJ8Ev1wy5T6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fF7N+dOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1/1cQzn; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fF7N+dOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1/1cQzn"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7756A1800070;
	Mon,  3 Jun 2024 05:28:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717406921; x=1717493321; bh=rHo+uVAXxp
	WZtKvXTs0uoYbSdI0kiduOYfkf/bIo+Lw=; b=fF7N+dOIGVdonAab7hLXJQO2ix
	CqcOFMQFV76cXTzHId76Tj5kUPjXQvF+qYci3vktDQggUfro6VDRiFuKWGrHPlC3
	eIkr/N5ft4UYidPszneRUj31a0mDAklyULelCArxRIa0QR/bhkZskDx6aeUhHAl2
	EjZi5WkY7TsmnsSTGcTCLnGofg1d0yACdGDS2Zf3+tLG5j/AmH9GEVH1zI8HQEr6
	H2ac5n8d/XDpq414gugzgYzXS5bpJs1DKscr36qF77smTf3QQa2I+1WiQJDkfZUI
	3qE91qxMSYPflznI0of7+zQ8yr6FkUWH2CyIVOX4xhPyyL08vd+ARw7V5Ehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717406921; x=1717493321; bh=rHo+uVAXxpWZtKvXTs0uoYbSdI0k
	iduOYfkf/bIo+Lw=; b=R1/1cQznTsdpKazFbjmMhlxnt+wzZ5ic4fFVpRSSTkKU
	AUm3W1fVKMWTo1jVDtoCHq+2G0K7yv2k8jglJVGCCTiJXpxo3xD09w+VeoAeOD0E
	Cg/KnONG9qb/aoqNAMXpXQWe57HNwtGzNOsrBRzT1R42HUncZR9R24BVUf1XInp3
	cK95EBI7Q/HEgjw4FifqcwAcuwkWHrfvUJ6WCN5UE33NYiDxyGLtB/bliV4KTFZ4
	eIo5DpvjnSUkaVndUrIeHgexRYi1xfaBeVfc3x6P2wWD9sCbkVl23tuBu3gLnpqL
	3biwmJkvtc9VGldxP5zQPg8/cIFY7lDtSsK/xUYmAA==
X-ME-Sender: <xms:yIxdZve2BTFgicy1zPcQZYgz1X_zRLxq2A7rL6HE3FZ7dzXKugNCaA>
    <xme:yIxdZlPteif4HwG8z4bctvxjgOYHRb969GdZ-2g5q0hte6EC_q14im8q4gxPYs0VQ
    N5gUUJ1DmhiUpjRVg>
X-ME-Received: <xmr:yIxdZoj2c_pAd8khaaABZlkZjQVN392cjfj-7WaCg_E21g-u-h_7EBgXLCWgTtmuRdcm2TwlvtosjKlwRjxfJ9kKwAqlT1gpihzXk7sMq86kmdtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yIxdZg-UIU3aTSysZYczaB-p9l0me9BTiqVcgUQKOhOZpaML-1eTiQ>
    <xmx:yIxdZrtIab6ygBIZxf9tIbV-E7D0emj3NwwJkCFRpRB-3uPfgO8Njg>
    <xmx:yIxdZvGVdmFzWD41EKbHLKjFItZgDvBkz9PhpyLvU8xZWid2LPVsGw>
    <xmx:yIxdZiPv_bSCRH-dmPy8YVnMcG1d9myqZrHOei63VnFJ_0OHBP-vtQ>
    <xmx:yYxdZhCRrWzgYcfqLmbfGT_eeOJNIuWzP0mHFsKRBofzy1i0XVhQbclu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:28:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bcd2b9b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:28:15 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:28:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
Message-ID: <9ff94b6f320d76e6b7c767e855038f33b69f4155.1717402497.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EDZBlZL+VaQgYXv+"
Content-Disposition: inline
In-Reply-To: <cover.1717402497.git.ps@pks.im>


--EDZBlZL+VaQgYXv+
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
index b5088dcce2..3c38676f49 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -101,3 +101,15 @@ Some features have gained newer replacements that aim =
to improve the design in
 certain ways. The fact that there is a replacement does not automatically =
mean
 that the old way of doing things will eventually be removed. This section =
tracks
 those features with newer alternatives.
+
+* git-restore(1) and git-switch(1) have been introduced as a replacement f=
or
+  git-checkout(1). As git-checkout(1) is quite established, and as the ben=
efit
+  of switching to git-restore(1) and git-switch(1) is contended, all three
+  commands will stay.
++
+This decision may get revisited in case we ever figure out that there are
+almost no users of any of the commands anymore.
++
+Cf. <xmqqttjazwwa.fsf@gitster.g>,
+<xmqqleeubork.fsf@gitster.g>,
+<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
--=20
2.45.1.410.g58bac47f8e.dirty


--EDZBlZL+VaQgYXv+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjMQACgkQVbJhu7ck
PpTBfQ/9Ha9E/oyMwRmsvOETUgYFmVo5xDdtTRGvTfzK4SJ69nO5wI5nC2GWx13l
l3rEwjfBLqJOjYMthSft89T0SqAl68KRjxRvABY3tdA35TVh1+t1qfy7Civ1rB55
/yevGwaMUDn3vs0wjKUBZWQLa+UtDgxtseJpd4GE3jEMM1c8R826TWxn7Z3EPV08
ESaAfeLWJ7TTYtbCyG5xmbIakLyFJfEh3YZYb0j8WydWBASv7oQnvqaDbVwHx46J
jtE4FgYQdSL82d+cjJwZmnVuHjHZNoFP4fS3hJFO47Cw7v1by20vxboCHPzzhKxD
qmYD+E0m+e5HqFnl3HWy4If4gCNqv4l0rz1MyDcPeTgdoDj4dtEVIGcIwsSbNDm8
PWzWeI5FXFiPOMbRvSe5ql27uFMHZ+d8PFF+iETFHv/X8OLJE2lUtHOtz+XSREXO
IpARXRqyst6zN9FAZOgCbOoRUA5QzTBGfAKnW4utDA20pKoHcVU3EvO7Zh+2rUFV
JueAp0RdByOGT677yqcLCEypi00UUpL1nGwh6VTl8pZusPBUiYgJlWFl5brpVFcS
hDIyBACnYq9zg3CCq7sXThsWvbb1FNM08USSNR1zXf3/gDR2yK9ACOfAEVEeq4nF
MZUOOx2QkEsgJW8qUOibIaNuLK4LGuzQm6ge1IxI3oPOCdxa4Nk=
=u1TQ
-----END PGP SIGNATURE-----

--EDZBlZL+VaQgYXv+--
