Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44D1953A9
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321541; cv=none; b=EYxuGN57+1+1Wblr73eHw0aEeyKuMGK4f+Ym4ATNUSDN/tB2RauYiP2C2Lgt/AzQuV4s/xjq6RPTE8K5oBRCSnj3g+FetzAXnsiJB/flNvjblKVRGzAS0yhN+1sVyUf90C/lGy0Xi3+k8EQunHo3utWxnfs23OXNSn9sAkPoQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321541; c=relaxed/simple;
	bh=0vE+5Hjk4VMl8Cj+au8Xskk9s+Orh5ppdeuFzdv/jis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Og8C9M4NSrqPGEDiUVTYrkOi5aasY1TLoxuYKIRjym4HM5nWrw6uS7GKAz/HmLw3n+SVachVTtHu6r7MljRwfgk2sVdSgWQSwN5HnKxBPHmVbqga3L53CEGS5854WpgE2gHmXquuPGoEPgvY+iAXAo2v41N4dyg+6h6T+U6vLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDaqy5Q4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YONISayD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDaqy5Q4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YONISayD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE0F0114015F;
	Mon, 11 Nov 2024 05:38:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 05:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321539;
	 x=1731407939; bh=Va50yG0d2x3d5zeob4vna9CM8w2Uy6vi83xNiJzS/nY=; b=
	NDaqy5Q44gMEeQE31WnumPknKK6VyuIch0e0oIl2+vPQoK7mu0SVezTKFTi4ozhL
	8A42tXnjv0iztk3ouMollyg58B3RXaR8Kv8SzflDBnJ6t20DApnyEBiQ8IeDCNNn
	FE8aVvL9MozgBuoi9Nx8FPg/TeDxC32erP7+EfRyi138cEF/P3IP8C2TJqA9hoLm
	eZVzUDygfyj/dJLvt9JgoMrMrB32by8EoHOQA5DyebznSvKv8aSdK5dIII/yU8PU
	cnaO695OMrq+D8vCiveda5/ZTU+0yoCoe7PulrBtGmGbfi1uSU09WWwTJtWDFpsW
	Xt3XX6OEqH9fAsVnbDwzgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321539; x=
	1731407939; bh=Va50yG0d2x3d5zeob4vna9CM8w2Uy6vi83xNiJzS/nY=; b=Y
	ONISayDZICdTbR1Ys3gWu7hcDb2a5FAUctHq+95s1OUrE8mrmr6BKqVrDEiK46u2
	wxwaE835EO4zFufh7c2uJ7ZBOkAge5Je2XQk9nro8LCNLOJ2kPKooXj0mqDAynEk
	QQml/3/ss5JlnGN7a5Ru+r9Ziilvi1h7iYZEdNgqOqa+l2ZkDVSHrmUw2NjPleJ9
	I5FbnpbxcPK4dQEMKepw/curuBejgo55P2jv2cuPslovr46XnVwc4LknbN4EQzt6
	9EJ8Js5TPHVSatUT0HJ+vdT11JLIsVkuHBQQKezARK46lfFwhkkb6LhUbfFbhc9e
	tlaYCwwQEdpeMQP7fAIPQ==
X-ME-Sender: <xms:w94xZ4rcU0_xFbiGjvKgf89RKOPIwiD6E0l0sa31SBfF0FGeOWzR3w>
    <xme:w94xZ-r-BmISFAihRMKOU4SyLlAHXi7OpXWpPk_fpR_wVr-3o_jByljDyBlMYMpFV
    st2496Xr52FOPlHnw>
X-ME-Received: <xmr:w94xZ9MdGemOcFcc6lTi2oIzEHcbtmH2Pw2bgf_syaq6nMZIZTU11Rc0YnVU4A9gEKkK6lU07CIl_GH19wxGodx5fzBKjQ25jMKjmubz6QIzfxja>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w94xZ_6w5I2uBeRX96P76odhGWIm-p5H7rExaQrtsv6m5U4lQ-fbwQ>
    <xmx:w94xZ35Uz4sjah8pUoOqT0eshKlo6Ns7eT4hQnWcOxoj2OKfTJrDWg>
    <xmx:w94xZ_jJPna9WGO5f9L3l0_uIqkoWiHSHHVwmi6aHO_86fmzn6NwLg>
    <xmx:w94xZx5gbnUx8PI0NjnGUL5iKXH7b0FTbE2eNdFt3FaU4p6L4Cy_WQ>
    <xmx:w94xZ3EzNQBe71VmquPGRCNhWzUlOYk0ALO_XdRMX2_NnFxDHNjB7iIM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5661ac61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:44 +0100
Subject: [PATCH v2 15/27] help: fix leaking `struct cmdnames`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-15-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

We're populating multiple `struct cmdnames`, but don't ever free them.
Plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/help.c b/help.c
index 8794f81db9bbf457b7cabca59222299922f3cc7f..8b56cd6e25ba5f2be2cbf2a7a9ed48136e12a0c7 100644
--- a/help.c
+++ b/help.c
@@ -723,6 +723,10 @@ const char *help_unknown_cmd(const char *cmd)
 				   (float)cfg.autocorrect/10.0, assumed);
 			sleep_millisec(cfg.autocorrect * 100);
 		}
+
+		cmdnames_release(&cfg.aliases);
+		cmdnames_release(&main_cmds);
+		cmdnames_release(&other_cmds);
 		return assumed;
 	}
 

-- 
2.47.0.229.g8f8d6eee53.dirty

