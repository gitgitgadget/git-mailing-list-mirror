Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B711DF268
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864772; cv=none; b=L9xdlWfZpLjuE2if2042RHCLFuat97bHjs8ubmkF/Lu1rH+CiWCr/8LPECrAC9uUdKumTuYhjuZ5FdnUWr5BeAu/qrno6HnRKEe/+fQujKQF6GDB1QDPvpmWxXtZ4aMTqVAaROiBK3DjuFKkWOJguYDP09PGUDuj50OW5vpw08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864772; c=relaxed/simple;
	bh=ev25QBCFxCsMROqadZNqNUC0fFcjryvDj+jK0eMMpkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grwZJKFQCQQKHvdNODyRWA+MMZ0CjibLuXoUODNBy3uKhFZ07z64d5lbxLuE6q736CrfXOAd/7vlfUxWsELysgUPVYurTPlDEyg39x3EExj4qcGArb1lF+wmnmGruRNz1NMXwoUM28Qax4U0sVNfdR2p0ol/fzaVSmkzos1BDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDw3Y5ia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IyqRTJ0R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDw3Y5ia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IyqRTJ0R"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4ED01140195;
	Tue, 18 Feb 2025 02:46:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 18 Feb 2025 02:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864769;
	 x=1739951169; bh=6YteMnT3qiXJXMXtro8FgypLgbVaKSqZCam4z/x8vTM=; b=
	NDw3Y5ia9s0+VLHu+GT9wPchUXJ3D7DXN+xEyEZd/zt45vSWH2VSM2bil+NTKv8p
	s/C4ldMWDvGaIt+EO6YABm9ET2W/Eceo0q9PpuOB2GPiV8tm+ukixWuSvc+osQ6P
	ftatZcm2rCIdFKBPz+DTqMSFu9UxJ1Q3R81EgXiwKlQhtkad18iZ4LWf1EMgxzA4
	kiNv6pJO8MGc+Xo5Ngs2Zidl4u6rh4OWlOlg89PufTYoqWzQVq/Wkut6vHL5IAc9
	NcJNHsJszO6KCtZrEyzokRZOAPS3wkTDWjd9VlTbE0XwVL2sUjwwLT1e2Q7uEtdc
	mYEl14tYW1Nkma8sUYXOPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864769; x=
	1739951169; bh=6YteMnT3qiXJXMXtro8FgypLgbVaKSqZCam4z/x8vTM=; b=I
	yqRTJ0R30dO+JtB9/dyHaPHVceQZie4684IXH/gwnUr7eqOGuD1MYRV79gMWjBjA
	Rwb9CxWr44Eb52G7TapOEw2OXIUClIjPfu7z+yuZDQLnnQIHPuGG5qINfIgK9f0b
	sX6s3gtf+2a9yamUAmgbKPurZoctAFZEYmenX7SCMGs4kpDSiW/6yq76U4aSP+Lr
	TFgQQDo/il2J2RwAVme+58J+PedlpZQqHwFjwg+gQOkTNOFmp2TwTXJgEsJGFXeF
	PR+qd2Vu9tYHFVKLX4/tiaPvnVmfULQ/TDydKWBRwsp1eOkR6YoAhKSbsVg5I3z3
	DP67sDpVCpSumynhQABrw==
X-ME-Sender: <xms:wTq0Z3AuhrqjA3rAvEWosKDvmFXd6RDVk976smdvlHRQ5YZ0VO7H5Q>
    <xme:wTq0Z9iBEDBbiRa-3WUlFHl9BdxqBff-cDmIl3CiVmB5JlVDGjCq4jGmkYQYH_tQr
    _k2BexSAVKzoQCiRQ>
X-ME-Received: <xmr:wTq0ZymxL0bg01xqvUKb2T5ZZ__4igQxsDG8G5q9F85fr93y0IO_T0_yoWP465TfB1O4wVZ9JGRQgdK-BysvOSSl0vfckYh90Aw3ahclTVNENP7h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeffefffefhtdevudehtdfgfeefhedvleefveeh
    veehveeiteduteejgfffueeinecuffhomhgrihhnpehprghsshifohhrugdrnhgrmhgvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrthhh
    rdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wTq0Z5ywKODhzsX1APft7dtCsX-i5OoJhUCmKs9sUYiK_89Yg4rD8A>
    <xmx:wTq0Z8QeE1SFUUoUmYN2GcoK9zAc9EQXV4je4J6G02-BGIQY6E2nrA>
    <xmx:wTq0Z8bNXs9Dn0uIw7Bod0OJhc-al7BPURQSimzr6M8pt-MtCVTJ-w>
    <xmx:wTq0Z9QSY1E0eJDHNmCLbdprcnC_D0iXE0YVbM1WUZkAW33w0mimlg>
    <xmx:wTq0Z3fAsaFGGs7_1B-misvv_12kS0PmplpYNBjzEx8qx9WbWOBEH6wW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24e32d2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:52 +0100
Subject: [PATCH 04/12] contrib/credential: fix compiling "libsecret" helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-4-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The "libsecret" credential helper does not compile when developer
warnings are enabled due to three warnings:

    - contrib/credential/libsecret/git-credential-libsecret.c:78:1:
      missing initializer for field ‘reserved’ of ‘SecretSchema’
      [-Werror=missing-field-initializers]. This issue is fixed by using
      designated initializers.

    - contrib/credential/libsecret/git-credential-libsecret.c:171:43:
      comparison of integer expressions of different signedness: ‘int’
      and ‘guint’ {aka ‘unsigned int’} [-Werror=sign-compare]. This
      issue is fixed by using an unsigned variable to iterate through
      the string vector.

    - contrib/credential/libsecret/git-credential-libsecret.c:420:14:
      unused parameter ‘argc’ [-Werror=unused-parameter]. This issue is
      fixed by checking the number of arguments, but in the least
      restrictive way possible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/libsecret/git-credential-libsecret.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 90034d0cf1e..941b2afd5ee 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -59,10 +59,10 @@ static void credential_clear(struct credential *c);
 /* ----------------- Secret Service functions ----------------- */
 
 static const SecretSchema schema = {
-	"org.git.Password",
+	.name = "org.git.Password",
 	/* Ignore schema name during search for backwards compatibility */
-	SECRET_SCHEMA_DONT_MATCH_NAME,
-	{
+	.flags = SECRET_SCHEMA_DONT_MATCH_NAME,
+	.attributes = {
 		/*
 		 * libsecret assumes attribute values are non-confidential and
 		 * unchanging, so we can't include oauth_refresh_token or
@@ -168,7 +168,7 @@ static int keyring_get(struct credential *c)
 				g_free(c->password);
 				c->password = g_strdup("");
 			}
-			for (int i = 1; i < g_strv_length(parts); i++) {
+			for (guint i = 1; i < g_strv_length(parts); i++) {
 				if (g_str_has_prefix(parts[i], "password_expiry_utc=")) {
 					g_free(c->password_expiry_utc);
 					c->password_expiry_utc = g_strdup(&parts[i][20]);
@@ -424,7 +424,7 @@ int main(int argc, char *argv[])
 	struct credential_operation const *try_op = credential_helper_ops;
 	struct credential cred = CREDENTIAL_INIT;
 
-	if (!argv[1]) {
+	if (argc < 2 || !*argv[1]) {
 		usage(argv[0]);
 		exit(EXIT_FAILURE);
 	}

-- 
2.48.1.666.gff9fcf71b7.dirty

