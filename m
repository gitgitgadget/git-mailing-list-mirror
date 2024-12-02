Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292471FCCF4
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141103; cv=none; b=hfJaZrmS2oDAXQYgZ6Stq+0hta0f6n9m+nx/8uSA4SQqLWo56ncmZ9eXmk41eWvGoKbmxsn8Qv1fIIMLlP5XFJBQk5ejd3xA1gxfODcc0Hg37wf4R0Kjze1jO8FXIqXFjYU8nOiIBXG8Y5dVaw++IyNEXKvV6wDBs1/xyHxO4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141103; c=relaxed/simple;
	bh=+GAZHQwsNXOz5X6RBqCMGSS0jJ6zg/37nifc597U8/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLZEBghuPS3gbecMHqpn9UshHVhHfSgNGpWurTO/w2aO0WP5+GRl2BlE8iYYum1+7OOs9gNyxCmpuCfqrx5/nmqRLcWeAMVaHTkb7K+vShKMhE7o6IpoJWiM/mFiQVmdXnO1h9o0pHecxu5u6OXoXUD1BVU5QZoxz3kD6Fv9XeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ak/34nfA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MB43cNoX; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ak/34nfA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MB43cNoX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 0BA6D1D404D7;
	Mon,  2 Dec 2024 07:05:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 02 Dec 2024 07:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141099;
	 x=1733148299; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=
	Ak/34nfAwHv3oHvHiA6OJz4X1eGYx4rTBFBU/FWt5LLk4Ta3jzyaQVXOmPGMSu1/
	uK4tQSJ1jVluLtUM38jGFJAqsyyFq0EGFn6DzlZUbc56FMqOSN8cjW+Ge7RS8lmd
	mPujLHy4CQQ85Ne0MGMP8L5VG+w8xaoVxHN4/o3oyimJYdczHk+DkJyT1AW1SIuA
	mXgME/f0aeDgxb6MwtxGIgvYdxRTmgPNdNiCSVFOHUcaeW68Zn4oMwHR/bh39/fn
	7+VdaiHRQBQI8b3stI95QaJTzkYi7xuS/wO/5mvQCCneiuP6wwj6H3KBlJxap0Y3
	kb2dltWGRkXdOwxmYs/x3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141099; x=
	1733148299; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=M
	B43cNoX5VSbfvT7kRe6dgQN9B8QFXmDlVfQXCrzzGsWoiXRuvCrNZkVzXbqBQuem
	5+nsGjUMyMPHWV39MSLbYDZIEjgDqPL2y4xamu/9oLesnTRhjbf9hNRsEn+T9qCA
	cdtzpqxUARNiy1XZRpIJLtQaAPpdQfkeK2hIsXgWYXy/a/wB351gJE/lpfuH/3ZT
	IELEPTRrF5HYRkgM2ZhVnTW9EQyO8aWa9seJlw4sTUhrN+2gicRlnR9nl9jFQeAp
	0NIe3WFtdw/iPVLAOmxMHjME8elkqTKIbrrRZSBXml20oYsgCfb16UuMzwJEft3c
	Oh2YSld33SDT/ULFQplpg==
X-ME-Sender: <xms:a6JNZ2_xM_C5jhwIoHUxp2niRw2A4Mk2vUres-hHwMb-bTjYFsRVxw>
    <xme:a6JNZ2uiUQ0-558_e0QtuY4WDt4v0bhmZWUioRKEQkUL5Wu_kSsJJFtf9ZA5s61LH
    V3YHw16aIeyqaZXng>
X-ME-Received: <xmr:a6JNZ8Chsn987G-Su_uoLN3-JiqiF5Kp1VUgoorH9vNxctwr8It3ssbDtevGX0OcD8I7hu2961rTsliJstL32rHTb6UnxPl-U8kLZGA-EwuHOUk8eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuphgrmhgfrhhlucdlfe
    dttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetjeehudetjeehhefhheej
    teeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucfuphgrmhgfrhhlpehhthhtph
    emsddsfiiffidrghhnuhdrohhrghdslhhitggvnhhsvghsnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:a6JNZ-fKRL5k6WE6TlpSGBrNdAzU_pX8_Xgv7tEUiO7ZGOHPMVjspA>
    <xmx:a6JNZ7OyzWxrc_udHV_YIn3UI5u5Gq9hb1pKjHwSQbALhmjuPtFwEw>
    <xmx:a6JNZ4mEDJr0tbhLAIFHj3CHcHIiAC0x-bObupYnuseUImwpzu3IVA>
    <xmx:a6JNZ9sVUUUV_itFUwGtXxzanQqKPA7ih1OSY4JjOg_8wjfeOscb_g>
    <xmx:a6JNZ9U2ijHBznrkaGHhVwFTnWpNj2042m250RvQjukTBYaOr9LxUdp3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:04:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 290fb5d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:34 +0100
Subject: [PATCH v2 02/14] compat/regex: explicitly ignore "-Wsign-compare"
 warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-2-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Explicitly ignore "-Wsign-compare" warnings in our bundled copy of the
regcomp implementation. We don't use the macro introduced in the
preceding commit because this code does not include "git-compat-util.h"
in the first place.

Note that we already directly use "#pragma GCC diagnostic ignored" in
"regcomp.c", so it shouldn't be an issue to use it directly in the new
spot, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/regex/regex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index e6f4a5d177bb7d44345fcc25fabca1e62b0eebc4..4b09cc4e1457dc362b2c974e82a6f9739b499a83 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -17,6 +17,8 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#pragma GCC diagnostic ignored "-Wsign-compare"
+
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif

-- 
2.47.0.366.g5daf58cba8.dirty

