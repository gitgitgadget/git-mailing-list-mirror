Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D601DDC15
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410005; cv=none; b=DtV3RPY9Bqn1tMgs7q92M/GhWYfEVz3nUuyH/7aupZH94OMMpGPEA3tQpgksM4XRLEGldgRVRie4AbKW/cp8vYy1yJ3SSpRjx60oRO2zNgwZ6AHq6HXZ5M12OyYREfRHcGeknCgJx7o2oxX9E+6QgyI6s29VzAIw4OKSyNI9plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410005; c=relaxed/simple;
	bh=BhNZMenuh3xEvzm0xpw7VqyKTS0kGxQK/qqjmOyswtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nC5Y03/RxoWEq2xZBSuJxrwgi/tLgfnEqvyyIBMi8F/9FHcuo4CijTPpF/JslvTW1pFPNLe4Zi3ciJve01wRtZHHyGRuCE3PDoAtbo5bThNsfPtduuVV6Me/IjDTnfp/IjjVtnfD1U5Wqv2XYvt4bTI6kRfCDe8UaQojqGw8R/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aSGqHBDU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYs1Tfvl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aSGqHBDU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYs1Tfvl"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AB57B138434A;
	Mon, 31 Mar 2025 04:33:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 31 Mar 2025 04:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410002;
	 x=1743496402; bh=PJiFlBzxLFGSQ1MlXrf2verHVIp3sNV7Uw3S6koMkLk=; b=
	aSGqHBDUO8U5IQx6A/m67pmjNj/WmGGr+JgOXvDCUI3HvqwijHM1iFPa3A6pauV5
	4NlnThPV1yW/SoxjIJbr9JclFOMuQZqHZRThqTypD/GM0SWExni37KZcPzZlRa8t
	vSERP8yyAPtsYY/Zv+8mu8P+/c3A6z9zEaY+cepWwHL+tol6nJL1oYa4gmLJdhn1
	ytgOZkqydPWp+hexcLYyHG4CLjQAJtk99QBuUzymFuJuqegWQ4nHZO/cCbKqgXFn
	zMWkxgUrDaSxxhd7TdNg5AeNTVAKZ9rXiaRKW2hVBGhyDhOcjFvkF+J5VsiQ6LLy
	dEKsc6ZUW11LPR+4/OQjGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410002; x=
	1743496402; bh=PJiFlBzxLFGSQ1MlXrf2verHVIp3sNV7Uw3S6koMkLk=; b=J
	Ys1TfvldP6je7cZFA3eDt7okI0UWGTU8NnbuIdaerbE2EDtVDrGmEkERqjIF9bmJ
	G2s1y/4Jes/C/usSCxw+gRtOmtUoaIbqX9xxl2achwUSdCBXy2XVxFrwmVvhiRqj
	R8/Oh1LSkrKmagH32ksSlZrYeBt5TvxhQESOzm4b+jFI/Je8oQT4gylgFdRIoKNo
	DDVSrmaNcFsvD3yY2rSgNcQ8wF6C5Ba5HzU+jGNAMFg5lMsloIJBna+btJUTKu+7
	d95gFgJbVvaHnvFwoglcWOOoctIRc0dw6VvvQ1h62pAT5ANaxtztIeGadjqcf58p
	jXwwamc6I6l6lLbvqXL1w==
X-ME-Sender: <xms:UlPqZ-x3A16W2ahjYZueYwE__zWBL0GLSTxe_aQWtUdN7GCl29d70A>
    <xme:UlPqZ6QzvqKNOaSy92Sn4el3b_VVvQYJYFGT466w8KCGs5qnbI9uwFM95niErgi3b
    BMDIJxPKsre-eLGpg>
X-ME-Received: <xmr:UlPqZwWt8feC6Nvcq90Db8y56S9BOxxs2rMr7maA3RqFdTWdbfiDgIjpVHioDgXLlL_nSjd846GcjfeqARVbiCVLdtjnTWlS0A-UBbeADPrPNl0P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    thhgseguvggsihgrnhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinh
    guvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhn
    vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:UlPqZ0iV2M4FBAUe1Q-q6DswvUlgaGFkZZboz42QKTXRvu7dJi7M-w>
    <xmx:UlPqZwAE-vIptzx8mTpVCzjKprmtx-2pKnMkm6mn5rPQdtYPLo-s5w>
    <xmx:UlPqZ1JQ8kRqXZ4PjTCH_wcBvQzFTFBedrMqLLJlIP02jUWdg1d23w>
    <xmx:UlPqZ3Bwi6k7MgORwfry38-jhaUyUUbX3wzQOONx63eCAcpxStCHmQ>
    <xmx:UlPqZ-Dua6fPXlEIYgKydiScKUIQk6DBFXaJVHkEu8Gy3oWoza1H3dSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:33:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd040e36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 08:33:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:33:09 +0200
Subject: [PATCH v2 3/5] meson: respect 'tests' build option in contrib
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-b4-pks-collect-build-fixes-v2-3-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Peter Seiderer <ps.report@gmx.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Both the "netrc" credential helper and git-subtree(1) from "contrib/"
carry a couple of tests with them. These tests get wired up in Meson
unconditionally even in the case where `-Dtests=false`. As those tests
depend on the `test_enviroment` variable, which only gets defined in
case `-Dtests=true`, the result is an error:

```
$ meson setup -Dtests=false -Dcontrib=subtree build
[...]

contrib/subtree/meson.build:15:27: ERROR: Unknown variable "test_environment".
```

Fix the issue by not defining these tests at all in case the "tests"
option is set to `false`.

Reported-by: Sam James <sam@gentoo.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/netrc/meson.build | 22 ++++++++++++----------
 contrib/subtree/meson.build          | 20 +++++++++++---------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index a990dbb86da..3d74547c8ae 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -7,14 +7,16 @@ credential_netrc = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-credential_netrc_testenv = test_environment
-credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
+if get_option('tests')
+  credential_netrc_testenv = test_environment
+  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
 
-test('t-git-credential-netrc',
-  shell,
-  args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
-  workdir: meson.current_source_dir(),
-  env: credential_netrc_testenv,
-  depends: test_dependencies + bin_wrappers + [credential_netrc],
-  timeout: 0,
-)
+  test('t-git-credential-netrc',
+    shell,
+    args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
+    workdir: meson.current_source_dir(),
+    env: credential_netrc_testenv,
+    depends: test_dependencies + bin_wrappers + [credential_netrc],
+    timeout: 0,
+  )
+endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 9c72b236259..63714166a61 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -12,16 +12,18 @@ git_subtree = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-subtree_test_environment = test_environment
-subtree_test_environment.prepend('PATH', meson.current_build_dir())
+if get_option('tests')
+  subtree_test_environment = test_environment
+  subtree_test_environment.prepend('PATH', meson.current_build_dir())
 
-test('t7900-subtree', shell,
-  args: [ 't7900-subtree.sh' ],
-  env: subtree_test_environment,
-  workdir: meson.current_source_dir() / 't',
-  depends: test_dependencies + bin_wrappers + [ git_subtree ],
-  timeout: 0,
-)
+  test('t7900-subtree', shell,
+    args: [ 't7900-subtree.sh' ],
+    env: subtree_test_environment,
+    workdir: meson.current_source_dir() / 't',
+    depends: test_dependencies + bin_wrappers + [ git_subtree ],
+    timeout: 0,
+  )
+endif
 
 if get_option('docs').contains('man')
   subtree_xml = custom_target(

-- 
2.49.0.604.gff1f9ca942.dirty

