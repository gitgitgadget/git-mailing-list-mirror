Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EE227EBF
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611917; cv=none; b=sJNwcyoivXGq0e8WLOk6VBtCoavC/PWtZh2CoyJ4sVNf6ykEl1pFpZJchkLr39zIsCrUGpUlGHKw8J7J6QYHA0yLPdJD/4s2dsyYKdXgINgJyxYHCEdmax46NxFNcUImeRdGjVTEIsGks80ox8VKTLOEqlrtzSxAarUPyTpxf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611917; c=relaxed/simple;
	bh=t9mtW59WMtxSuQYqTAvLp45Ew0+WY36ZelnpZhvMQfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkOr5xjtCrnijMpCGwwd2dUSlZuhg+KkiEt6s/NoGmO7+9SbkqSQijN6tOgnEMV6Y3v6R/+HvmPvDJRH6fVosyhCqrbXIQUUs4SnGiTjerY5p2iB12zXOvaHZqEP20imqSpdRm41+QYSyLWVHqD2sO01r6u1BxR68tASAowScmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KRf4xxKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQTwxHR/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KRf4xxKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQTwxHR/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 039E5114016A;
	Fri, 30 May 2025 09:31:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 30 May 2025 09:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611915;
	 x=1748698315; bh=83zVFOLCaD15Bl+SlcT3MsOU+y7B3nxF1wjIEoMBIZk=; b=
	KRf4xxKOi4y2Qk/HrDIPNMMTdr6+YcnAlkW7dS3un/QUJxzEV7Va/mLiVckHNUAA
	P6elz0sQI4TD3GSwMB1DLcdnJ0wS3HLiu6SZNgzqASrAr0374ybWPMP8ebuO2doT
	HgLeT+cjd3zwyQ/J8W4l2zHvQduZ9Rc91zendVlByI7ztzmamBdNe+s08z8fl5Lh
	Pjrw37SzEAi/vvdgsJIOXdJtyEonxFE3jcnI5fx0d7BPB2dz8YQkmTGHKXkr0OXI
	FCBSnFwNi172dJWJxEQIJtinpjjghHVvBBWmjrJ/8mLkfeqVZ2vG8HwCz68OZmTH
	GKuRuZDC0iCx5R35O6tgLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611915; x=
	1748698315; bh=83zVFOLCaD15Bl+SlcT3MsOU+y7B3nxF1wjIEoMBIZk=; b=U
	QTwxHR/k24SJtIdCfv3ptTGfEk/3c+RLTZr2KbZPiQWxIEH+8T15SQLVcI6JA1Cc
	NpGtrcwpj1YEDNtccsgh0vbfpfIFSBZGh2TN1xtdTswBAKdf9Oz9aSvBRDi/0T6J
	ZISHWwYwJ7r6qEOo35cB88t+eNZi34BbSNTxeC9UfR1NSInPpDLCyhYtL/xxzL+q
	CVkISV08JqNxUycxtRJ9NFoPGv9aVSwrfOtRnA2xleIoh5HqkqUvpGSy2zlrdRJt
	ZGf5GGh9pAsoEWhQozEncs8wZEk51QS3Kzsm+EoDTvP1WwmGc8PxIDwREpWCAdl3
	lI87zDBhfkfjhP6Uf21Dw==
X-ME-Sender: <xms:SrM5aFGAJMhgrDlVMB_qymN50IO6lbd8T60Sf-Zfphfh9hjevNDmMA>
    <xme:SrM5aKWEddPaR5x8v91hKgU4WVJSCvWZOwgx4tg6wIaaYcVoNhc3wqawPzYZFyjwK
    7YmvJ-wyxzo7fnTPg>
X-ME-Received: <xmr:SrM5aHIQsvP2bxbyQx9Lvsa5jhmWT1PvI5wSQotr6PnXXP_h5ZQHyl-LS3SERGDQpB6kl8lNR6eqAlDZqJzpRQb9NRvpV0mxvH6qdFyipw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonh
    gvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehp
    ohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomh
X-ME-Proxy: <xmx:SrM5aLHYkgfB3E0AeuEIcybf1tODZTc_8W2qqyM5IDu1c9fm2caG_Q>
    <xmx:SrM5aLUNpaXb_XVTvdyJzlTHx7CXSLgll8NRTUeHBODKeUOaANhrOw>
    <xmx:SrM5aGMQWuunk0zP70xghkruMJSFxoV_rZU9a-dDixoFy9N7h96Hvw>
    <xmx:SrM5aK1984eixqxX9cOxZH4xC_SvX83DQHI779hVq0ulbgAKAo5eXw>
    <xmx:SrM5aOpz91qOFzraSi_yI-gYq3GrMidkP3ORWT3wL0PAXWoNZyjsbFal>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40fd5016 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:44 +0200
Subject: [PATCH v3 06/10] t/test-lib: fix TAP format for BASH_XTRACEFD
 warning
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-6-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

