Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48A20ADCE
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508389; cv=none; b=nVSGcStwgESSPi3lGWfqLWvmFCS9LFHyUt2xcn3C0rvSqPvaaMB2bgLuOytzbmqg38D0+nAU3343VYv/w8Sne6k0zxmXMD3uOv+on2GSnD09yenEuKpC2yJz52ULdx+E5yNpIJSMTGguyNQh/GoVhivX8OXvq0G/WWizVusBGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508389; c=relaxed/simple;
	bh=BMgf+5ZpgptyK37bZux6Jc+dyJdjFExsg5MbjQQ2FjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRzWHTL4MSz6yE71FVkW7/OLtlSA9/OMkHcvQlYNfBHiqKuGIIyhm1JK4B4aVPGdoSlWLWXoR7ESWDo0Iq/ae63dOrWLpvVLLX7POMQ698O7x/8ejnxWI4UqA1PWwOtkB84e7jLNQKS4rdYDwlK3rgLK7BSmzJrFxObuvCPlyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GAI3g2Yh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p2Lshk+4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GAI3g2Yh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p2Lshk+4"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 78C9A1380141;
	Fri, 10 Jan 2025 06:26:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 06:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508385;
	 x=1736594785; bh=J3/ayXcJqhIGu0HY/H3gcA9MWZmQXgTOZXMyCbB8udo=; b=
	GAI3g2YhfPTP+zDifrSRRs9zG7A5TeTH8P/hR5dI81izst6WwxHE3kLUaEMqnKQY
	UJPG0wGov1E1Wse4e9Por0dVbuzKEaM9TFo6Q7nwT2ADWGWFBVDrURgCvaobyoZT
	W4XbkhW6RZBTP7kDxMkwAIPz8+si9Qo01ony7Cvt6AjIt22l0OHkdTlqXzcd+e4c
	xpzebQaf6IzsW/JpQg6JfUVfMpDsL5BeRe50NeuaDglLRQr6VjaezC/uhZwD3MVS
	/7tDysYtmsMnk2f6TdsCURKg5ukhhrBjp2Eh3FNZelaa1ZswAyG2+C/3ng50CXXQ
	NEGhqLNGW4c/FIjpTtmL0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508385; x=
	1736594785; bh=J3/ayXcJqhIGu0HY/H3gcA9MWZmQXgTOZXMyCbB8udo=; b=p
	2Lshk+4Nz6k3FnzL39tRwOGlWiege+hMLa8q74trsoziuwSxBRef16FAZTWzSYlk
	/iYufF0OmBDkZQ5e6OxtpGWotzLPeliAhVctGIuHTONeeQGprj1k89hH7/ywAARI
	S8MbDYuRwDURF/eXCCifdmKUZOvDHoHhRoBEWKxkCQc0w35maUWSqjrSD2zAS+hL
	MLk4Sj5RvCz5MB70qU22wRWQmDZMYTw6AU+SPM4KJ9Du0ZYlvBBgOVqZUvHZnPBK
	vEzIfS54gS2CxCCbrSmaBme4he0YL8sCavLbX080D71hfUWvULafz+5Q0lVAzHAl
	Xwjev4DtcRo88HbGabC6w==
X-ME-Sender: <xms:4QOBZzcZHDQkCJn_KbZoA1Zs69y1NUJcFxNEiD9lcF_X1Ln1yINqYQ>
    <xme:4QOBZ5NCSKdNY0Iwh5VglcWfw_schRtGKPNuWat9xlap-udqg-3nmPTt0BR8Vf7DN
    8mAt8JXF7yuEETLUw>
X-ME-Received: <xmr:4QOBZ8jCePapuNNh_pSZOrUKx33RUapByIj3uPeuO9ZL4jwpif_yjV9X263i07IGC_M9KfkMzlXYW2qfnaeBpxW0oQ1oPjY8D8sHjkLVmKXwFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4QOBZ08LrrXJe8VtjkyKrAirM361owoVY8f9RGTEfP5xv4JnF9zGtA>
    <xmx:4QOBZ_uOW-RjWEe0FDWgFnaCXgkuk2NtF3dr945_hGvTDlcoQfHMpw>
    <xmx:4QOBZzH_u3eC4GWhK9xQQ0nlQHwR8WgsEvoyCIXjOgfHhnARiSw4-g>
    <xmx:4QOBZ2M_GxQ-3x_hKsBiXiVaLaP71E3XOFQOUWi3r683d_8CsU61bg>
    <xmx:4QOBZ5I3In9-cF7Lw59f_-dorxHUlVyfuJXS98SGQlVJvy0CDs91bCs9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:26:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 096e68a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:26:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:26:17 +0100
Subject: [PATCH v3 1/2] builtin/blame: fix out-of-bounds read with
 excessive `--abbrev`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-blame-truncate-hash-length-v3-1-e61f25b68f30@pks.im>
References: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>
In-Reply-To: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 6411a0a896 (builtin/blame: fix type of `length` variable when
emitting object ID, 2024-12-06) we have fixed the type of the `length`
variable. In order to avoid a cast from `size_t` to `int` in the call to
printf(3p) with the "%.*s" formatter we have converted the code to
instead use fwrite(3p), which accepts the length as a `size_t`.

It was reported though that this makes us read over the end of the OID
array when the provided `--abbrev=` length exceeds the length of the
object ID. This is because fwrite(3p) of course doesn't stop when it
sees a NUL byte, whereas printf(3p) does.

Fix the bug by reverting back to printf(3p) and culling the provided
length to `GIT_MAX_HEXSZ` to keep it from overflowing when cast to an
`int`.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c  | 3 ++-
 t/t8002-blame.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 867032e4c16878ffd56df8a73162b89ca4bd2694..d7630ac89cb7bd6e9ce5d72c6a98aa433b3b12da 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -505,7 +505,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			length--;
 			putchar('?');
 		}
-		fwrite(hex, 1, length, stdout);
+
+		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..b3f8b63d2e6744dd434f38fd9f10b56cd432141b 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -126,6 +126,14 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
 	check_abbrev $hexsz --no-abbrev
 '
 
+test_expect_success 'blame --abbrev gets truncated' '
+	check_abbrev $hexsz --abbrev=9000 HEAD
+'
+
+test_expect_success 'blame --abbrev gets truncated with boundary commit' '
+	check_abbrev $hexsz --abbrev=9000 ^HEAD
+'
+
 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '

-- 
2.48.0.rc2.279.g1de40edade.dirty

