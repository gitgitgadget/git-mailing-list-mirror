Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1C7F
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714352977; cv=none; b=khMBAZgp2p51kFdPkDfoGJEtHhQfpE9LHXg/8RGdBEJwznqk1zNgI3dn7T2Fs+HGntiRz0ul+VUed2ua9N3HApu8uzq2u5pN9kD70X12u+bqfSsFJ/QP9e7IE34YFeSjcYvxUeM5N3DeLGWWsN0uu6sv3kDhDd8IHq9xb4/Xa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714352977; c=relaxed/simple;
	bh=kQ6egc/re2UKSM7ZtDgbu7f5Z0areQgaZxIC7kx98Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rbzebvj3N/Ns8PDZb6RJl4NUUwxDAqY8KVDP4dIJlGMD+VOAqr3spKAA6PUcQ6qzolX45xcHKVA6X3g5vOVtM0eBjl1m1AQRBqPI0SOSD3ZNyth5gEZuB4/aaTbMNDYiib+APJb6jS80iEyt4fX1S5so9I4vuqdaBzTcyz3gS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=bkJahB5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/8YsYO8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="bkJahB5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/8YsYO8"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id CC5F1138024D;
	Sun, 28 Apr 2024 21:09:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 28 Apr 2024 21:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714352973; x=
	1714439373; bh=1kqwTcICpRDr0yYEBpjWVlsUbAVb4ddwLIBZ7o0GhXQ=; b=b
	kJahB5uw8FrYwoFCh7SEVN9szayVoU+S8VwblE9ApFYFusdzPWBhs+epeLhVMxT/
	KcQ20Wl/8GaXBDF7Kop95DwW0Zt2LzoCnMLLVi1qzwcCOMjyZTB7NQl4WmtgmcX+
	5z2idyxq1bU3W3Rt28y3Fszk4UR5qwAc3HURl3Esc5EE1ffSj+XTKop2kfZ+8KKt
	hBxTGE3uy6oxez4RXuZvqptL+BRxykx02Bmt++n/4Hgl+fEgqN0c4+W79vKkvFt2
	gOfxZs2f6X2UVJivMvvugnXupQDrPx2/b5emF4bXPrexdl1wIAKEhtlhfhSCaUf1
	9sDh/kz6ldIpFEVYVajzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714352973; x=
	1714439373; bh=1kqwTcICpRDr0yYEBpjWVlsUbAVb4ddwLIBZ7o0GhXQ=; b=M
	/8YsYO8xdO8R7/UEpENZwPqErQN3YMn9qMYLnU7mqfph8g7KfB1mVNbsqjv2Y6jG
	FWKz9dAg+veuP5ipkXa/7HgoyuIbKfyS1xoWvUrtHbjGixrdzs5f6to94bmnS5Q5
	SwXXDO+tmm9mm5+BXEy4Y/lerX+WrXdH7ONkRPgVFfbKwx1nWB3EFMJjCRMkhKSG
	CpqUisjwF0Z3fI+f0mH6R2VLGJDt/8R3Z55obZwNZMaIJ8xc/vLCMXVqM33M9iVK
	VON3wpsotXWT2igLaXqYytolfAlsF9t1m8HD6Y2yJgUhIdsoUz4SPyJqzmGgXpZ+
	gT6uhjYfn9tB3Y4apZOSg==
X-ME-Sender: <xms:TfMuZjWob_ZZDQv4ciZBF7d9Ujd1lDEUQlvdKyoJj8kD06FkMCIyxQ>
    <xme:TfMuZrlYfI27y9__o-LnyjVQVA022fOKD_BB2r73nXgH_7J3Y5f_El6fMrq6MSOUV
    4pGt4-uxkmVbqbGJQ>
X-ME-Received: <xmr:TfMuZvZUlCVlclZAzfwKMVOuRHcvETZqdlw8mKdcPUKS9RhHzxiiBjlXBTvrQlUx7yZzvkCTo28CS0oyXjvrE7Bsd7ICl4SVDXStNJ5yNepp3aPd2bfk9CHv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:TfMuZuWcKDCfuxpuiSGeQ4deNSBv4UJ2CJoR6VDF40qQFg12QqXFEw>
    <xmx:TfMuZtlPoHMqU0P_YXrr6752wj-a5AeVT4OXhJ3opAq6U5V2du4vVw>
    <xmx:TfMuZreR8Y0Xz9LGCL491qRPUQyTQ6gsTXshHmGLPg6FJKHVP5Tslw>
    <xmx:TfMuZnEGF_IVgp_xLGqBGjQ6lhvlMiZw6n8yfvL8F232qEhsFjMf2g>
    <xmx:TfMuZiwfaod08zxB6Au2pcnK4BtvEi2Qz03J_Riy9eYQod-msfWRnlrV>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 21:09:32 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v2 0/1] advice: add --no-advice global option
Date: Mon, 29 Apr 2024 11:09:24 +1000
Message-ID: <20240429010925.93205-1-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424035857.84583-1-james@jamesliu.io>
References: <20240424035857.84583-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of the patch series to provide a mechanism for silencing all
advice hints. Based on feedback, the change now adds a `--no-advice` CLI
option which works independently of the individual hint toggles.

James Liu (1):
  advice: add --no-advice global option

 Documentation/git.txt |  5 ++++-
 advice.c              |  8 +++++++-
 environment.h         |  1 +
 git.c                 |  6 +++++-
 t/t0018-advice.sh     | 20 ++++++++++++++++++++
 5 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.44.0

