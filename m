Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118E535C6
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334597; cv=none; b=Cj7ktraj10Wua2cFgYJY2AtTeu9nWrR3niyOg0KUKZahu2CsBtIK5XmB7N9zc268AClEVjDPTehzxFhlmsBQiqA2LZ5i8ldZA0yrtkrkPJMOKTFWY3uUsZmvebB6ayZLzCfKgNtDw5nL9pi8KK8aHpBxH9l++sbVh+kiJy7ATXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334597; c=relaxed/simple;
	bh=JA3yilpB6Vqo3L9RIrIqDKolfLudq0Gb4D06SGlziVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP5DIkfcb+RieKQULjx3wkbNICY30PWtgUPz7mDM9G5BdXDCosD1zwzrvhh224A9wlLy0Zij1/rPFJAMZTVSwSmyv3zF7NGQc8ByQuNFvIOOInv/PMukE8hOu0PohI8slpyJlzUSDEQbA1OdZBRY5mLJDDMEi3hX8hNRnF6cCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OE5JhUIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVHTuNkM; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OE5JhUIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVHTuNkM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id A77D9180014F;
	Wed, 17 Apr 2024 02:16:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 17 Apr 2024 02:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713334594; x=1713420994; bh=B/cmZpMbaJ
	fzY1o564OH1C2KfsBe74tRhbGMU+S3ba8=; b=OE5JhUInlZgyUVA4k4Gl0J8xgc
	MCqZJ9dCQsiIcRKzdq6eSvEe9nZO76JnWbCogmxAh20aIAyuRkOAVBDj5y4oEYPK
	YmZY3cSshjBjT9TrSuJFvyfSqb8FwC5V3VrIRy05JFJcwJj4fORRolbq2EEaUHXO
	PymHErOjnuem1l3yVeFwzTngHX5hlL/m0YGQqSJ12sEWAQIvI2b/trL32cn2Odpc
	Rb5ZnIu05evzVnX3kK6ndYPHBBV/auz3QCcRRLlkesV8Ev7xQIQF0j3ChwHYWAEe
	1X2vEk3eSNxBHaBuMiKe3ZYoo9j6CS4P162kmURASIy3/wTtvOE+C8hcj4Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713334594; x=1713420994; bh=B/cmZpMbaJfzY1o564OH1C2KfsBe
	74tRhbGMU+S3ba8=; b=HVHTuNkMD+dI+Ew1H+Fub7TtQkvFxxpc+1Pt9b23uy5j
	mwdzTe2KufkZZmHBM+7G0beIZhPoaw29NUpBNP62U1E3wOxh28URbm9Rfr9NaGh3
	TGUMyj/dLTJt8mLgOkkOVLFlgyyrcdi5YCPYDqpnyrA5J/bPpmfaj6nCdVDckMdB
	YVCNsSgq7L0cao15N4C0b8N1rgnHtTwaRJRXRjv/qcmULIUAJ/EB44p+yemo9U2p
	BwM3WLbyytoT/2236o11YHDuxdOOGpHxSno7awsRsONaZjRV03yMnFIcAdp+K3Eq
	D+iBi2ZHPNHvEh4tRuBw2BDq1GrzEb717HKtzRFRkg==
X-ME-Sender: <xms:QWkfZl6X_UP43OX6ex9mCJDmOarwGR3ogxYv2yRSTsxbKuL96Rev-w>
    <xme:QWkfZi4Dlh_4FBnZd7x5UTQMvxw_pby53XM8DeU5eWQlrl21DkbY3KZnZHejFrRa1
    KwwY7V6Nz372ChV8w>
X-ME-Received: <xmr:QWkfZscGgwPu07IzZWNGocWWfCXvaLyQrw_MQRZ3MhkIPBKfXeI8DszWOcgD_yNMhnD-4zV9FkXD0IobOlFKYO_c5QHyA-WXAcg33DXBTahpcD29kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QWkfZuIYOE3FbEqIiz5PF4U1uu6mLO-0IGOyD3QLG-daY0c8rEv1Zg>
    <xmx:QWkfZpJo2W8I2TArBZUGVCpOcpge0vrKP0CM98-orj3ZdrdCFbEN1A>
    <xmx:QWkfZnxOA3djSQ9m9CrawaG0WIokHYsXJtb0aumnNgzeG73Vh_kWpQ>
    <xmx:QWkfZlJk2fma2h0ird5SEC9REI5_B-PapgD809At_SufZ2BJvEhpRw>
    <xmx:QmkfZp2HwKZ3Z9xt7wIZUs6v14tFhtEXEQgPY1UH0Wer9jJ1FjM-oXHo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 02:16:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6f49815b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 06:16:09 +0000 (UTC)
Date: Wed, 17 Apr 2024 08:16:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] run-command: introduce function to prepare
 auto-maintenance process
Message-ID: <929b6bfa08132523ee97f5adc376c3600f779a99.1713334241.git.ps@pks.im>
References: <cover.1713334241.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evNYWMJzL59uqaWK"
Content-Disposition: inline
In-Reply-To: <cover.1713334241.git.ps@pks.im>


--evNYWMJzL59uqaWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `run_auto_maintenance()` function is responsible for spawning a new
`git maintenance run --auto` process. To do so, it sets up the `sturct
child_process` and then runs it by executing `run_command()` directly.
This is rather inflexible in case callers want to modify the child
process somewhat, e.g. to redirect stderr or stdout.

Introduce a new `prepare_auto_maintenance()` function to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 run-command.c | 19 +++++++++++++------
 run-command.h |  7 +++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 0e7435718a..1b821042b4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1793,20 +1793,27 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
=20
-int run_auto_maintenance(int quiet)
+int prepare_auto_maintenance(int quiet, struct child_process *maint)
 {
 	int enabled;
-	struct child_process maint =3D CHILD_PROCESS_INIT;
=20
 	if (!git_config_get_bool("maintenance.auto", &enabled) &&
 	    !enabled)
 		return 0;
=20
-	maint.git_cmd =3D 1;
-	maint.close_object_store =3D 1;
-	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
-	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
+	maint->git_cmd =3D 1;
+	maint->close_object_store =3D 1;
+	strvec_pushl(&maint->args, "maintenance", "run", "--auto", NULL);
+	strvec_push(&maint->args, quiet ? "--quiet" : "--no-quiet");
+
+	return 1;
+}
=20
+int run_auto_maintenance(int quiet)
+{
+	struct child_process maint =3D CHILD_PROCESS_INIT;
+	if (!prepare_auto_maintenance(quiet, &maint))
+		return 0;
 	return run_command(&maint);
 }
=20
diff --git a/run-command.h b/run-command.h
index 1f22cc3827..55f6631a2a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -217,6 +217,13 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
=20
+/*
+ * Prepare a `struct child_process` to run auto-maintenance. Returns 1 if =
the
+ * process has been prepared and is ready to run, or 0 in case auto-mainte=
nance
+ * should be skipped.
+ */
+int prepare_auto_maintenance(int quiet, struct child_process *maint);
+
 /*
  * Trigger an auto-gc
  */
--=20
2.44.GIT


--evNYWMJzL59uqaWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYfaT4ACgkQVbJhu7ck
PpQNUg/+Loh5oTXnkyfOk+ZLJcYTogyDUghY9ZOqC2nHmfln7vj5hgoElHrgO0gv
unVI0kjOgcUYq1qZlJm/5wB1OSwnDzm71eIZ4CA4deiefTJQLCWw+29EdFrwO4Zq
QWwp/otndM8Z7e66zss0lolAthF26ydD7YhJ7hWbYlRzoFQV5jN09QnuCg1RCy9b
VgdckBac6iBAdawNLOcVILIGkk5obkhI+Sb5QtXgxAh+GJ8fWT/rGuADnzy9occr
gOUN4X+rG11tCSKr9Z7ngl8J3+QiUNwDh9unar8vusEl2ZBcbBezknjk7QFLVHhf
FoxXMxpDchhAb/dEBUbVYwqvOCOlQWdHRyTuwk1SNifs6NwgYEVu2sRdugJCPSCE
E053FuO5AG/2JnGKdR8ddxMBPpZxfzJYE92Ol0hZ0R6vkXFCVQgs33XqPUljp/la
AxwlzpAQvbGES5SWo+CKYxIywJfsWhNmrGGLgyymJxAuw/BHRmqvsJdpCwHaqk+n
uFUf0warPxAUhbM5O2dOGDO6aXpqTrBQCF4CtqJV+ZtaF12ZosPQUKq87Okxmv+R
dlt/uVZN8FhdMqYun9vkPY66+meSoFyVVfsU5ccKqQ/KCb5IQt+uxoeeC+UMI4dk
qQdBk1tTt4NaJZj9Tg0zVigNrmQtTgFq7Gxp9jI/hER6+12fAmg=
=AjK+
-----END PGP SIGNATURE-----

--evNYWMJzL59uqaWK--
