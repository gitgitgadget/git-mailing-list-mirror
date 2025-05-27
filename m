Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6A274FEE
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354583; cv=none; b=RxpcTqzwMafXa9YA6lW3Mgms5tBYED/rXZzOCkBQRg9ce97hrlrbg9HwxWJE1QSZ0fZBxpbRUr1Wn6BRx64PdizAgzfw7T/ipkygXxeMpp2yfqaMsZTILURR2eM60rS8EMDtxDFJi7bE39oEXE35Fw2gtdPZIW21er2DZZxSrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354583; c=relaxed/simple;
	bh=vIQbgZqKcp84SOF9kyEDMDRFPHYB0UGjB0/Z0b2/DBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tu49Bhop/zZbnceyyYIDVZN8NPmw3ScCbcp6B5yCtcXYn2U6AIB2/kZ6ctOroXHemjBdZntFcvX+2B9MIW5DBoyuA8pb3u5hlhhrdAYO15KTeYd3t+HgS2GPi7SO14wnhX2qEChgHsSwJyerfpXXwFKtj54Hp0f0jA49GkfJAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B8M4qR/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mG5SqanA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B8M4qR/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mG5SqanA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C73C61140163;
	Tue, 27 May 2025 10:03:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354580;
	 x=1748440980; bh=4Yoc2sQKSLsdRRmDFD73oPinIW08eHOrZFsKjakliGk=; b=
	B8M4qR/Rc+oiZNuKlYc3F4i8WdOQcIoPidC012pZcU3c135ZqQ6C+nF0JISFoK6U
	SvqH/uYiIhn1kvkKzF+aooORKwYywqOmHQdZ0hwHW94bj03RXzQ0eaVgSI3dVc1o
	geU0NEwTsXnEpM9L0xfWTND/GIJVJWmX/vMsCzAyEyncT5ItXWmUjbgjmR80+UOM
	fpKcxoWzj5l47hYqTn9EjFE4l9nAmQpyN0HxGACJmM59IpqRo0TI+h+YxQqle2+w
	S5VTA0vJ2+AFxVTNylpTfnR0ehJd3qM4GhKXzoQrr0QKgNvbCcspST3MqgOudnBs
	LlW/E3RlPNTyHhNRnsx1vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354580; x=
	1748440980; bh=4Yoc2sQKSLsdRRmDFD73oPinIW08eHOrZFsKjakliGk=; b=m
	G5SqanAf28gOZs2BL4ekMF1wZ6bygTMp1yyPyZCRDO8SYPCVLNQDTZ59ehCltbhK
	lag80jQD8yJ5BVQm+r8T+28JHbosOcIe86AXLp6pWj5f3oonJ+vkeDC8QgeT+gu+
	7q8Ac/RbGDD7jSaCz7NzmKQx2tY4R3Yj/VTPB3KoBhTGNLmk/+5wHKFK9i+N6Ev7
	ppIE3nVWoxzFrBp6p4bijv5VZe587LkTUbMU9FO0+5VypMQFz/Z73hvQMIM+vx+m
	jaGwBBg7giUYjAJKGHvMvfUhEPgXP/uy0WSviNZxMsgD+MsruKoC7N7dt+9PpZlI
	Il5VgUfPxiC2avsYU3SLg==
X-ME-Sender: <xms:FMY1aFUJEge_OHJ6iF9YKBradd9SdZNw8IjZno6NpEKY_ta0ZXaduw>
    <xme:FMY1aFlzYs90gmQ6lEyaTlDcPB6xSPxb8HIqMUblF2NlQwHru_lVcNojgwqA41Ms-
    Ba7qCNY_lG-3Z0Mxg>
X-ME-Received: <xmr:FMY1aBZr-TsPsMNdQ4hNEJP8U6I8zjIcsa54yk3yjougonvUVtlyHkjkXvczrum3wDPxzhJJ2oLojtZ0FMfA6fIZa5ImlDWd_q699fTg_YouuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgv
    shdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhord
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmii
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FMY1aIXIk7CU9ICZ-1kdO1Qp1rNPwkbLPuPpaS1wCWzl09US9gXlFQ>
    <xmx:FMY1aPmi82FGTkcyYK7705WxsyafEZmP8IS3OBiKDbUfdcyMZEo2Dg>
    <xmx:FMY1aFe2mkVemB-X9dxUMwnYFzCGPWsksu2IQSxce6knj-6LLBE1fw>
    <xmx:FMY1aJFeg59u8LoNVKaUXWsc4LvZS8OTpy-nv1b17RXd8LEE9XKyfw>
    <xmx:FMY1aL4ypbn2Psjg37indQJQCpIcNOYNoby9tJiI8qFP7Y5kkFs6rVma>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:02:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d1ca640 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:02:51 +0200
Subject: [PATCH v2 3/6] t/test-lib: fix TAP format for BASH_XTRACEFD
 warning
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pks-meson-tap-v2-3-ae360f77786e@pks.im>
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
In-Reply-To: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

When the Bash version is too old to support BASH_XTRACEFD we print a
warning to stderr. This warning breaks the TAP format because it is not
prefixed with a "#". Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6ce8570226c..8c0d76ea5f0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -470,7 +470,7 @@ then
 	then
 		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
 	else
-		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
+		echo >&2 "# warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
 		trace=
 	fi
 fi

-- 
2.49.0.1266.g31b7d2e469.dirty

