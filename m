Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9A1993A3
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134733; cv=none; b=BJ0x2+OmC7txOUA46tvSae43+Wk+QBdQzA/oQbewnxIWPsNCrnsWizFBgKkiGiyrJBpz35boT+BhmLIbIcnPoHoby1nNGj3F1oDkqPpJci+KO365KePxeO0DFlxNRAmy+OvdczVzemEYGCTGgOR7h6+Z2KqJDbrHcvNVw/cO0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134733; c=relaxed/simple;
	bh=AKhrsEoXkM+8pjy4phMO+Sz5CxJoNRSoEmurjh68VZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fej+YeNTVw+mDtHI+zocUoHoy9HAMZmKvlU46s0PFTq1ZdlKoCww7amd+Cp9N6tOiPodyr67+vcc+ppDRjFPmIDIIuT3t4iQefU8Zp7Zjo4lYuhITZC4lp5s3pXsimFtiXbEVWnrq4Ngmt1BlQKoLtTSuWqZbUEzamJLqMONGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jgTBmyOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1L6zA3I; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jgTBmyOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1L6zA3I"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DED4A1380B1E
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jan 2025 02:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134730;
	 x=1738221130; bh=GWhllDdaSxZQ4eSnlcpAazRNbvCvw/UI/ZNnmAGYts4=; b=
	jgTBmyOcsKgpqqTQaWYteZ3/lsmxnX4v/vfKZXcpqn3/af4hI7Wt3HSdw6t6YqpC
	7auvt8TXFVz3IrdSeJYxZImJ68nKtBmUMosRDMjvDW8KMs4yDsltntEdQS3Duhxu
	H2IeygB9ReoPVjtTKFtk37B0doxgNFW0IIyosbcWWfGkFKpjMv+i+4/SgQBru35F
	40DwkJGEqB1no52uANGpKn4BeHGNKAVFDbc7KPZ0rMArUdmTT1gUmk68KNSLoxbV
	WmbVaKv7th4NGpXklUxpPf0Ay1HUyzHQGW5dFMIinLHbAwToMb1ZuFIPGWOmctqs
	McEprmcYXfx67LOkdOtyIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134730; x=
	1738221130; bh=GWhllDdaSxZQ4eSnlcpAazRNbvCvw/UI/ZNnmAGYts4=; b=N
	1L6zA3IC8bXeavAWWeczMrdVEtpcT4Hk6z5RLnFfC8PuqGHpcvz7mCyrfMCWdT4z
	vlasA5F01MY0wpJd8loCHBvpqC1JYfjqmiQ54arvJZg2X4N4BPN6YfZ12naKa8j0
	0RxOdGCTvw5i7L6+J5mC6EWD+Kw4u6fJt8YM+WMDqGqFX7h7WzMLPMycvTovO0vh
	bmuWzAwsGOCYqIVTUW6GOQAF9rVpyx/pG1U/YKckSNpq1a8MLokL9zymoo/TXiz9
	YoVwTWHf6h8WV7b1EOa4Hnp/kv2xV3NMNT8N7riYkpS1NwNIWj3FNwTvFRApimRr
	v4Ho3bVivKGu1GdnUOeTg==
X-ME-Sender: <xms:ytSZZ8TyMf7bbqmnx1fFIU56PXOG-MNug-A2351E_b9v9GOB9CrnYw>
    <xme:ytSZZ5yRBiiKcosMqH6GcT8c5vS8qymf-wmiCXSAT-Qp5_pFH3KWsSs5fbYfNJ8Vy
    gXbaoxNxqo8NvW-Iw>
X-ME-Received: <xmr:ytSZZ51_zmz2C70vR7FVft8OxtPKcLu-xKwDSGocmV3MComEy4twijl_BAr9z1Pyu-VWiITMXAD1J7q9aWbpiAvPzOwm41THQmmQhQgJVqIdqoq1wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ytSZZwDQMuq4FpMnxaGLTXRCqG-RSG1tsnr3WxGF_T96ll_3KDhtUw>
    <xmx:ytSZZ1hUxlqPza1DE8mhjmz_bfB93IiMDwcFnnyzd2QxUOPzwQ6JTA>
    <xmx:ytSZZ8qVP2jFrPFmJnVD52wPFJY-qSFm1Zkq_qsRCIBskGSFlcsAuA>
    <xmx:ytSZZ4jUezjQCCyB2W5l438WeNRQ5rPOwBvaJYovkryDG2YxOBhpyg>
    <xmx:ytSZZ1bbE-sRdTFS9-yjpEMANvIi7J5W9oEN8KLSvwxSJ1_fkTqGP7if>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 521ed288 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:12:00 +0100
Subject: [PATCH 07/11] meson: deduplicate the list of required programs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-7-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When setting up Meson we detect a couple of executables that we rely on
in order to build Git and prepend their respective directories to PATH.
This is done so that Windows can locate these tools at build time in
case they aren't included in the default PATH, as we know to pick up
those required build tools from the Git for Windows path explicitly.

The list of executables we check against is somewhat excessive though,
as many of the tools are all part of coreutils. Let's deduplicate them
so that we only check for one binary that is part of it, namely cat(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1e1e478d17..48eb068fd8 100644
--- a/meson.build
+++ b/meson.build
@@ -187,7 +187,7 @@ shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
 
 script_environment = environment()
-foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
+foreach tool : ['cat', 'grep', 'sed']
   program = find_program(tool, dirs: program_path)
   script_environment.prepend('PATH', fs.parent(program.full_path()))
 endforeach

-- 
2.48.1.362.g079036d154.dirty

