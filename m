Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B319B59C
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134734; cv=none; b=ZZrJZLxuwi9U5y8JSwec6kNFZavBXju1AyzNnBfyDO3niKT88sJ6APIP4cO1MZvLeippu1uknK//SI2DpdHRFqhf0HkBnwJpZ0WdSd1+F0F/8Qq10jX61ljrx/j1faWOmcIPog1ZZjru80Aw+eo8ipv49nSedgAnFg4vPcPrzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134734; c=relaxed/simple;
	bh=WNGqsVraVGQBljaecVWRdKW84JrJUJWV+o+RA81S9nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxO4KikcHiSqQTNx++oFEzkMwfyJ1ADDlUDp7YL2ZH6qbehuAgc/rNwNXMjEco9e4+nWeGLG1dFFvppoOzizkYuYny1p3occPYnwyHaGD8rI7V1lYi8GUQzWciU9Pvs2I6IB8LJXK0//Sd3d6GRkkdBAQmD1unXqlMdPNGgd1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h6D8uy72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wWthNIEr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h6D8uy72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wWthNIEr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A0C51380B21
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 29 Jan 2025 02:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134732;
	 x=1738221132; bh=OKWNsZqLldMaTQL0csND+gjgN2yVylrZbyiyZsOe/pE=; b=
	h6D8uy724SkhKfFUpQ8Z7y9Biyh0gu/llCTHS/Hux0XUjtd4TdO5BUcb/qpjJGQl
	70kKI9UJmv+b5IIMLvNW6j2sSytuo0d4BdM0Mu4ETRuR1VUZqv/mNwPJbu3k5xOo
	A7GaQFM3RrXV5XozsJtvxExz8WhezwnCIcAQBnf+srxe5BpBsCfE0sr8O5ox4xL8
	rG4NN7IoH4QuiDVvPPr/eJHWA6QclgxChsqWO3tmwVQqxVwCh2HLfgBKspIGSNfY
	Z40760m/G1b3eD5UPnRYbywyU0Q2jQMXXvHRu8mifkLjfF2FWlgIMbuXJfz6DDSq
	Hw1kC0OGVLWGxhxViN8s4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134732; x=
	1738221132; bh=OKWNsZqLldMaTQL0csND+gjgN2yVylrZbyiyZsOe/pE=; b=w
	WthNIErQu6NpkiGOxRomd5FcPPAb9U2rLwlK6mefojiuDVaqlB1Y/QmPleYg1Fo1
	eAgxvh0Kexhv/LuWP2QYYgskbHBoio1It4dLhXxh/brPxiMsWT55Z+2R8tqrFLPz
	Rb9XcUd4r3IRfyymhqWexdvGZILLFuhDc0vuTnqQhWTWLA6tBG8WjyGUpwtRby3J
	/BOtDGNCye/InGauLC2pbIRrpqGyILrNU0jX5mQ7Up7c4qeBmJY2OtlRFtq+6CH7
	Ye852ToQ5+QVOgUrzRg+GTA0DfRydfgeDN2YmM68dkblPujTah4QsFaCDF+bk6jL
	FLWFCucaLQaA1Vgi95LrQ==
X-ME-Sender: <xms:zNSZZ_V0xfYlK982cnbX93JbCtlKwSuiky5HBWrgGoVTEBM1gtk_vA>
    <xme:zNSZZ3kG-QhbAXUYsgRIm4l2oFltO7V2tGV1ODOZ-OfoWV8MP5fx2RLnfmiwac0mc
    wQQD3KGIhJSIahlOg>
X-ME-Received: <xmr:zNSZZ7bPxGqcGx9Yk75zqWXOE9GKjEqyu7aF1zjWwObe9oZN_JYCS-L2Ig_OJBEAtB4LtpDWVUG65gnQNfP4mCDY-HSDcC-voyYJSLkw9WB2XpZr7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zNSZZ6VgFd1PCMo9b1ja1cSU3Ov2EHvdu9uQNo03d11ByFju5vRBdA>
    <xmx:zNSZZ5koTsGLaVkgS6ugyupduX7l_L8ycYO0hltYvrPTreFYfNWIrg>
    <xmx:zNSZZ3dbsyJke88ECZJJ2XHLs0p0HRHWf__DmFqSNnjBnEBhYu6yLA>
    <xmx:zNSZZzFt3ODcI-LwmYd09joulr_qQyIaNzymlxLHnOmRKz3TjE5tsQ>
    <xmx:zNSZZ5v791QubTUr0CArAXusMfNefMoz1-sIsgAs9mnRxgm4gNrIjvSE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7acc98d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:12:02 +0100
Subject: [PATCH 09/11] meson: prevent finding sed(1) in a loop
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-9-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We're searching for the sed(1) executable in a loop, which will make us
try to find it multiple times. Starting with the preceding commit we
already declare a variable for that program in the top-level build file.
Use it so that we only need to search for the program once.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index c023c10416..92a08b13ee 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -41,7 +41,7 @@ custom_target(
 foreach howto : howto_sources
   howto_stripped = custom_target(
     command: [
-      find_program('sed'),
+      sed,
       '-e',
       '1,/^$/d',
       '@INPUT@',

-- 
2.48.1.362.g079036d154.dirty

