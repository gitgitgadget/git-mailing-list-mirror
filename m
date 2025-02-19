Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B91DED6C
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970848; cv=none; b=ts65YzCJuj6Be7U4MoCQnf6Gp7mpoqwnyPqjPwXD1GwX+q+TEEwiU3KCSGWVN4blupcQWxvUFAahBWtMHaoT5KbKZOfrpzyZ3GnD7qV3R1/nQXt66X3OxGlyLdszgW0uNRCUvGvYbgEEZ2dL/qO0wVZqKCOnEPpwL9QOLRYMdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970848; c=relaxed/simple;
	bh=ev25QBCFxCsMROqadZNqNUC0fFcjryvDj+jK0eMMpkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEY/pVq2s7wBhGakpb76J11kgSnqFoo5pLeghdQncNXhhZG66Q0kdlyqCeiQ0APcEaW2mt9s3ybV8TXbcwPL+FnzewXMW6DsdPW5apf6rvMQ2a+lqcPDAkdEzFjM+zAFCefgkAg9no78pJq0eqiBNiT/VVSy32Cu4cMVSYHTxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=briaG+Uj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocpCAKDp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="briaG+Uj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocpCAKDp"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 613742540113;
	Wed, 19 Feb 2025 08:14:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 08:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970844;
	 x=1740057244; bh=6YteMnT3qiXJXMXtro8FgypLgbVaKSqZCam4z/x8vTM=; b=
	briaG+UjzZ3SKtd+QjCTJto5d4dqoW9vbHdzYcVgkJlaIdMpNKc4kmtHxQEYXIJN
	AS7P+DHDgqNDoVGBHTjlzRRLeNRmI25ziTyAFAcCrDaCjDJh5g/26peB12yMQ3MA
	8FnwUPSGeMwxmjIkw8eHyFCO3fzTqfDPUUtkj0tv+jbqmo88x5ZaN0hbm60WvYbi
	K5Dmp9BLs8wc9cjWUcYY84vsudZDdt9g3DPpEfgWm+LEZylVqDOkM/ZcNR0bCPIg
	sFlsuTXhL8y1C87fJycoX5q8Xw1SRyJFbddx6r+Ke/+PGN5RCjWwd08aCAoOb92C
	DqQmfO9u4A+AsXij/iJzAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970844; x=
	1740057244; bh=6YteMnT3qiXJXMXtro8FgypLgbVaKSqZCam4z/x8vTM=; b=o
	cpCAKDp+WCq+WlVQlh1Mdpr5jKeJxUCQDxMi7THtv7asxGAs1jGpE6wCyNfzwkK0
	jaio+bIxHTc2QNSpKLZ8YdA1rk0HITso7q7kMV5LVThBZHcixjFVflqiUjtpLb3P
	Jr1x1qhYL1vCcgzkhOfgoSmyt/8n9O6V0UCO6HpqoYpuemIasGuVOdGvQdO54G51
	ISL6dWdJGi6ZSiV0swZzEIGLx/+8f5Un09/scx7DqeLhxKYyrMYhUkLGOKo6gT5P
	idFHQj0A0NBXe9BoEw0rF88bu/lH+UClXpNlWuMMv7i908NQSmKlr69+tc4TqPC2
	R6mz0Ic19ihPvyGU72BxQ==
X-ME-Sender: <xms:HNm1ZwbpH96JBFemkZcaKrBVboWtYmg52qsP6JxuUKD3E4nBplqwug>
    <xme:HNm1Z7a3b4zGYbXkahfTulZ0UZsWaxpMl9jpDjWhAPVhcrIxjK5bL8r6T9cdbQa9v
    txv1NTXlxR5qUy-Aw>
X-ME-Received: <xmr:HNm1Z68Ux1GmAE1zmWUeHj0XaF6_4PYttqTaRRdmUgKnrpQeEq-J4vQYe4Lk_62ROe3MEkMlD_TClZQV-_IoNyYVRliymnA1fdg4v5ZcG3BaWMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeffefffefhtdevudehtdfgfeefhedvleefveeh
    veehveeiteduteejgfffueeinecuffhomhgrihhnpehprghsshifohhrugdrnhgrmhgvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HNm1Z6p0kMatB4mngUN0xfz6Y0s9vclxkyAZf9d2e2nTNBy8R1sO1w>
    <xmx:HNm1Z7osTokJM0MrNHRTMWgUugeiuEbQufslmK-tJvckgx_ffvP3-A>
    <xmx:HNm1Z4TD1rpxvjk0Rv54rWeISEFJCb4xoH0NgmYqlWRepTJvMnx_TA>
    <xmx:HNm1Z7poZ6l0VN3F1ahkTCy3wozD4Vd2JxF732NoRLgJWhkfeC_I4Q>
    <xmx:HNm1Z8mUMw5nfn0s4kuWMv2u0P87MWfHHXB8t0uLDUN9ibY1NOLgSbnF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec538918 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:44 +0100
Subject: [PATCH v2 04/10] contrib/credential: fix compiling "libsecret"
 helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-4-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
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

