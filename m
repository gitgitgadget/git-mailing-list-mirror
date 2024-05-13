Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728791474B2
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588329; cv=none; b=ajXpxAfS4fOtWtplzqlHnGA9TaTjzxMn2hW+n+gwOc5/0Jhn98hnky6EgFiP1lq9eoAdO5S0yI2XXcMutQrqxGwijHLueO5wv2mEPm275mVyPx4RlPwTKBMo1UqNkuEeqcEzSTMHxydkohjg9o9ExTHO6Op0a+8g8WaDgO3M61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588329; c=relaxed/simple;
	bh=k6e/2/IBhxAA7U0D/CthDDygadEBwAGOhuk6/p1zfgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRSWZFcpZRaD57LARA9Xa83tuZF4QKMoy/YUOK7Hs8vFDGUHNfsLpb2O/bcni7QC2+qDyMev8gUhQizzYD0yyw8aRyx3i+O6CnX82HkPGk1nG9qemw1wzBymue/mHRfIulMyqiVjX0qyCCMmceNWN1kHcnscdz0WaqOSWeO+K7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqXERvLx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Udgw9/1f; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqXERvLx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Udgw9/1f"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 84A3A18000F9;
	Mon, 13 May 2024 04:18:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 May 2024 04:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588327; x=1715674727; bh=t/9n/5hHQ9
	ZfixrsQP9qPiFZzutCIWwSTnIdZRNZ3bA=; b=IqXERvLxHG1rOglrDQxmM7ELWz
	QjnmrhGOqSBf8Ufl28VSkQ7Ro47NrOGPRMO2Xxd5uk99YWmoiCbp6V4+hyeohtKs
	UZJaVE8xRF6Fj2UX3ZuU5aN3+0tHDle6mYkXOKY7oIYXd/ShLkpYeeJ0eLUIv2ls
	B4AdxsMTBo7wlJ+61wfh4PYDo7Z3FbDRqzi90sbEIPjhtIKD97dr94ZTsdSi69XZ
	yojfohk6QXxWT50O0byTlW3rBMkzwoFSkRaws7HNVJFoRWMvidr9XLRGedYWCcZP
	rtXJUoP3yb+gl0L4umA+ZCxKmhUwM98D/H6svdcF5vPObzkbUBUezy7H++ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588327; x=1715674727; bh=t/9n/5hHQ9ZfixrsQP9qPiFZzutC
	IWwSTnIdZRNZ3bA=; b=Udgw9/1fW3eJnu6NU81QyzgpwxZ81eBZzIRFF8WVzTb5
	QZagGc7zeE1vn7THM/3Po4q+UH9EpGBXsgrLWkvFd/3NmLP8K59j+UfYT0e8o0Vr
	PYChNeehoDROxyW9TYK1DLSLZQcEFlqDdRzA3hVCVIRyKwXSqZAWdc5A1SXv1vqq
	nOWQ8oiT8UEs0Ck69MCK7pmxvWQyzFpfAIE0VZmVc8EMYRZu10i90t8NkGH5XYCd
	dCeE5e9jxYbTWo49c/nWejhv4L4VfHKBP2v8zB3ixOBj3/6lhbheb/4YclLd+ElI
	/zap4n0tejz1+5l987g7UkXOWkB0Q5hwnxQhmzCL5A==
X-ME-Sender: <xms:5sxBZj9C_KH28S7GPkezjlBoLU5sLf-BIgi8AX5_n_tA-PduMinOfg>
    <xme:5sxBZvvq9pfer4m75OdHHb2f72HoN76PXtQpxufHBpSSG6k0HEukTuWNiu-IB97TO
    WNfb528wOWa7pfB8A>
X-ME-Received: <xmr:5sxBZhDnA8xxIf07EJlVzqAnukM3yD-30FsjsFj8lNC4K6X8yJGIaY0z6_Xf4vRjYlero7QsUt-ISwc-H5vKScM7I2ne-NjTJCMdAvjtlb5VHYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:58xBZvct5YbLUFO9dc_AJMx-MWPdY3AATyq3YxY38dst_P05MftqpA>
    <xmx:58xBZoNA2CS6obrLiluQUJA91SWBoSnRlAc6E4JQC1nMaMsw5hZ0rQ>
    <xmx:58xBZhnGs40INWFxFmy9qPO_nd0DOvo_LMal3F9GKA2QBZ6ZXzYSMQ>
    <xmx:58xBZitgL5nbr0KGA9JtIGdIYd8sH05KXiG_n5IP-lp2PbvrWtyGqw>
    <xmx:58xBZlqp_hs5lAeowqakgRpw6IxWrjHzd7p1kDURvVkeMnHhK6S_jOdD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2ba60a04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:18:26 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/11] refs/reftable: allow configuring geometric factor
Message-ID: <d341741eb079633c6020020166b3fcfe667a6ac7.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z4pP3gCVTXL9C3S1"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--Z4pP3gCVTXL9C3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allow configuring the geometric factor used by the auto-compaction
algorithm whenever a new table is appended to the stack of tables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt | 10 ++++++++++
 refs/reftable-backend.c           |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index 68083876fa..0515727977 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -36,3 +36,13 @@ reftable.indexObjects::
 	are a reverse mapping of object ID to the references pointing to them.
 +
 The default value is `true`.
+
+reftable.geometricFactor::
+	Whenever the reftable backend appends a new table to the stack, it
+	performs auto compaction to ensure that there is only a handful of
+	tables. The backend does this by ensuring that tables form a geometric
+	sequence regarding the respective sizes of each table.
++
+By default, the geometric sequence uses a factor of 2, meaning that for any
+table, the next-biggest table must at least be twice as big. A maximum fac=
tor
+of 256 is supported.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5ffb36770a..da620fd598 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -247,6 +247,11 @@ static int reftable_be_config(const char *var, const c=
har *value,
 		opts->restart_interval =3D restart_interval;
 	} else if (!strcmp(var, "reftable.indexobjects")) {
 		opts->skip_index_objects =3D !git_config_bool(var, value);
+	} else if (!strcmp(var, "reftable.geometricfactor")) {
+		unsigned long factor =3D git_config_ulong(var, value, ctx->kvi);
+		if (factor > UINT8_MAX)
+			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
+		opts->auto_compaction_factor =3D factor;
 	}
=20
 	return 0;
--=20
2.45.GIT


--Z4pP3gCVTXL9C3S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzOIACgkQVbJhu7ck
PpSvoA//Q3XsYO7wr7cu6aewPbgrbn9OvphJb2pFwVJZhtEoEIT01ih6Y8zJRJP8
BcW/T/xeC2mXsqrCDFfYN14Ax145ACQ03tVmYn6U14TTOk36y6eJvMyo6SYHLZyJ
Z6jCC7Ry2sRvEdchhxFmTYPDkuu7jhlnb3AogHoRYUhIWPtNC090XFLHKrjwxmfe
IxV7znSnEZBTx8/roQ6c8M/l3nqE+YFziBaG3cm0rgojj8TmF8gJxfhrsPU9OqH4
YAceoAlm+blRXT4dKur8Byl+3waNwgzhoWZCz/LiTeXWD8ShGY56TmepKvHV4pJi
4Rzu4FYhesvrMibHhJe7/4m+GOp36hhBMZQlqcVQ7S4/bJRjkhc3sFyODq/pWyWf
exG3Xsk+CFFie0vkNqZW4aHynM1GfF4TDkcobJ6K8Z5r/j64SN/KzzWdTlj4vF8j
22kROVcfkA9kfj0NoE1fJTMBY8kBB2YiVtFSaRcUQbZXFeJugwtmM0in3hdBQNiz
rjYSKKuviPXwLEShlTKJsQHNuYFzXsZ+rIGXiesvupeJ47RPVzJ/BZ4PMkST/qhm
nJWk+NW1yOp11tx92Q2s4TlnDFPvJVWIu4SmctZk9Ber0EXcQSmobBcn27+gGyIA
qz5iGWsKeJldWbAVbGx6F8cHL9NlN2bJEHc7X3lZq786uO5K9Zk=
=5zsd
-----END PGP SIGNATURE-----

--Z4pP3gCVTXL9C3S1--
