Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF292010EF
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423320; cv=none; b=lqkQqTCCoCLlORVcMkMdKTL1kppmsbUglh7XL7X8yn/C12m0IhU3Kp9CuO2TwYcJisf2ahgn6q2V6WknGizZCnbMUyeIn+PZkEJ6bpES6bi1lJ/d7I9ZvYbUlII0q9V276skb/BTvOgzWERSCq1Rafu0bKxovds6y4N5C+oZo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423320; c=relaxed/simple;
	bh=A4MsP7CL5jGf/L/WhEhreLc9vhRjSRynVmusCH3brYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=uiWh3Q9Fm4le0tc/PYq57/glKkAUgerAJwxdkR+rwP+xwSJjNsm5+pzV8x7onE0YV52wmTCAmc3KHsFzqFkgG810XaM86uld8sLWvtv3IxvmBkQLpg30dIteg0NsGEY2oky6vrdD4uttAtSc2Tj+PHTSrs68maW18K75SHVMKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EYBGiWkK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTKmIj7d; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EYBGiWkK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTKmIj7d"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E92F32540181;
	Thu,  9 Jan 2025 06:48:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 09 Jan 2025 06:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736423317;
	 x=1736509717; bh=sXRikVOgQIavMXdyBxLCsDLHgcX2sfuDkN/Y+DL++4I=; b=
	EYBGiWkKo6TkE91lihfdtEgfFuFKCcnAb/BJBPaT4iRBf1Fqk2WVyszk7yW10bJK
	44todQBhYoZ9PfEhTrfA4K41QTW1nn/jZ6ysVubsN4esNH0z58t33MpMhhr9vVGt
	61G8Wd8qAvttMvi/fnBYja/v97Gj6lMQcTQ5jPUCSXM6Tw4dZKw3YenfU3TFYzao
	jK6WnTxYWqx3YUfAr1xInJb0CWKZKPQmtJqVuyur61vMUGyzpH5VRbs65yriq4NJ
	5foe3GkvaLdgqjI/BL8axisAQqcx3lGH9MNzWZ8ZZyqlx2ABkkrORxqkV/ny/7CM
	m7DhJYwKobSp8cA0j1D3NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736423317; x=
	1736509717; bh=sXRikVOgQIavMXdyBxLCsDLHgcX2sfuDkN/Y+DL++4I=; b=a
	TKmIj7dA/mlo4B/IyQAI7IF8YaG5R95bRyiYwOLN+osfKdImoZtZsSRW4KM3+eDU
	apbwbSVDCxdI+Oyvq92nKE8BhbXxj7HZJVznVXqETuq88gWF2xB54VbdEvh0qzAz
	4uLObTQe6E2dK8WsSSoLZ8fmDLBdgE/Y++iIO5ebGHZCWwNsGOgbbyXOM7PY9Txc
	p+wnm6oiaS2EWjVf5DjJrSxIMGye7J1WIVtMAbRCaDkcFkEQ/n2GreZhb4JEgXt+
	NikkSuyMJCJSwe6otxsmbwkGOozxXpl1BTw+oVhag5kZ+5C4Rz3Tp+cgbRrWolZ+
	6TokvuwZBUxixNEACPh1A==
X-ME-Sender: <xms:lbd_Z4Qb5OYosa_rOV9xzg-Ljk608He4Szqed3QuXhfM23E_MjpXQQ>
    <xme:lbd_Z1xrfl0r0RVcf3n4WIk13qcJq2q51sjPzFcOvLBKySwIMw6ouDe0Z_5P_zbwp
    ErQygZR87cBNmRPlw>
X-ME-Received: <xmr:lbd_Z122eBvXhgvFL-UmGUDYnB5G435CSRKQ9tJATwaPHmGZZcUT8zKYHzlSTQYRkXHrSepfM0T6c-vmrgICH6z5Tb2sL6VjMKk7FSVyj07yqY4_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeiuddvvdefgeduhfetgeeuffejlefhkeehfeekteeu
    teelhedutdeifeektedtieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:lbd_Z8Cf3C6ib_uDZbVkhNAxZj9ZcGof2VHRXhrQfnzw-A6-Yet1tg>
    <xmx:lbd_ZxhJuiyBTx8VddvRK5Mc6s66SYlU18b17dhq_9xB3iTtKn3ayw>
    <xmx:lbd_Z4pLAxzLAEpwzCZDXf0gD9dkJn3lV5b-LlsNdr7ouf8v5pmg1A>
    <xmx:lbd_Z0i3GqVRsr65kWrya4Ak0H1g81YEl3EvLJW5iRSxy6fUDV6FQg>
    <xmx:lbd_Z2vY8S5hkJpCRW6AtUKf1AxsuCJAMqbmqo0dXmmbVHRT--o_U-Y6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 06:48:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cfb901cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 11:48:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jan 2025 12:48:22 +0100
Subject: [PATCH v2] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
X-B4-Tracking: v=1; b=H4sIAIW3f2cC/5WNTQ6CMBBGr0Jm7ZiW8GNdeQ/Doi0jnQiFtJVoC
 He3cgOX70u+9zaIFJgiXIsNAq0cefYZylMB1mk/EHKfGUpR1kIKhabC5RnRjHoiTOHlrU6ETke
 HI/khObSXtrbaNk3fSsieJdCD30fj3mV2HNMcPkdylb/1H/sqUaLSfWWMUCRqdcuHM0/Q7fv+B
 Sz62WjPAAAA
X-Change-ID: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71
In-Reply-To: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
This fixes the issue reported in [1]. Thanks!

Changes in v2:

  - Take into account that we may strip ^, * and ? indicators by moving
    around the check.
  - Fix the testcase so that it actually fails without the fix.
  - Link to v1: https://lore.kernel.org/r/20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im

Patrick

[1]: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
---
 builtin/blame.c  | 5 ++++-
 t/t8002-blame.sh | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 867032e4c16878ffd56df8a73162b89ca4bd2694..f92e487bed22eec576a4716f2e654cb61efb9903 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -505,7 +505,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			length--;
 			putchar('?');
 		}
-		fwrite(hex, 1, length, stdout);
+
+		if (length > GIT_MAX_HEXSZ)
+			length = GIT_MAX_HEXSZ;
+		printf("%.*s", (int)length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..7cf6e0253a5bbd4d6e438e627dc18b47eac4df66 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
 	check_abbrev $hexsz --no-abbrev
 '
 
+test_expect_success 'blame --abbrev gets truncated' '
+	check_abbrev $hexsz --abbrev=9000 HEAD
+'
+
 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '

---
base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
change-id: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71

