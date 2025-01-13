Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B5232363
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757245; cv=none; b=NXqbCoDzZRnEoHftZDubKBCLMtybLrHHn8MZ8KVulNZvczPEfScDU0sv40mzVufHFtnDZAuxP/uXH9o3fp1ZX1K/oi0ShVsPUCBdG2lCtKz1Ar9kbn8VlEvZN2z9y3MMNT4hjq5shke0Slv6QIYBEflHeDTScG8Nr+W9x4vi25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757245; c=relaxed/simple;
	bh=/lFcYwQwwr/JWz6QndIhMdmKvTZ1FxpKRHcpvIjNeAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEfM6f6UoKKwxsBixmPvLIzefZEKc/vBLIqyZhumPL7xnASz5h1FtgUmVBI1fxJVpnTucSx8QX0GSDd5E3DHekTl2MQ3GA7peSyy5MWr6Ys7v121eeSFwIJT/FHAF4vWefeeVVviJ109RKyRywgIgc6w4opePYu0x8oaQMtGFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ktHKT9Lg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/WGzYaZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ktHKT9Lg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/WGzYaZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 840C21140137;
	Mon, 13 Jan 2025 03:34:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 03:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757242;
	 x=1736843642; bh=XFWOj80HCvIhoQUsy7UtRYe4iObon1cXrYB9d6YpteA=; b=
	ktHKT9Lg/bBb8vBGYBXoHyp/gMIQeg7b2nC3KsJSWpX7aXwTySnl4OxhazU/Z/ae
	Aqdn36EX+ByTiNyEjGRgUiWGxAOHX2f8YKPRqzoTGVv9SZ6rAorHMB/iZgYovtyO
	xZN4OJk8ANl2maH8ZZac23ri0vqeUxvQWOQWFtVonlsqhEBY6M0KgqPOpf356dq0
	DBk1VAh9aGgSnMudca9iPAZYFmJ7RsTbEckcFOvrg1zBc9lzRiMdJgPFtjMeOtDL
	6kIIa6RnaPBS6uDazflHy+u0Q9+uJmZzvphq1sbLAfuaGHFf5CQ14Z2EIsHUaJBX
	8gTsI+SAtF9ThtaVSkD3yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757242; x=
	1736843642; bh=XFWOj80HCvIhoQUsy7UtRYe4iObon1cXrYB9d6YpteA=; b=A
	/WGzYaZhR3qzMoWyiI8HAbv21Y/XxhqUQx4uVJyO2OQawmoPTfoTD2KHOaxgJvn+
	4WagsAoAU+kFEdm4WFFoAC39ZlRSs8a8cyx8SW7Rg41seepaZUcbLu5w6X0XZFrK
	Meui520eL57586xev3Wuz9jQUAyBhRJVE9aHLsT7J0NM0MDxhvZDZi4DjhzP9XYs
	i/OJ5QCbDfWPc4rQO4Vjjka0jpatsYxleJzTWilLXxxEEBEnk+wE4Rmky8uaUvQE
	Qhz2BgdHFCuIoQ+rLbBi8TCsJk9e3ANLcjTWBjTQEyI3Qjl6Uu4Nm+ijzt7Urr+l
	76/ZjmG5EzAr0zvQmcdWw==
X-ME-Sender: <xms:-s-EZ9G11FJktfC70rC_Mfoa8MfY837ArmASDRHOCc3TRdsp1_dRpA>
    <xme:-s-EZyVMjYIxMKCMmKrnPyMNCKd4HUcl2ficKTA0qP0_Z2CLiK3WgwlajPz8JtY4Y
    itelY2LS7UHEfGILg>
X-ME-Received: <xmr:-s-EZ_IBD8hjFO5nXoXDfmADipozJ66n_avHLQvYjR07g_3nAHPa8KeeElXlJw9vQ96rZP58DStcoT6RSJke-ut3sJdtqt0_Mt63AXs0lb32iq3C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:-s-EZzGsHpaJRuzWHufc3FWqFyR-V89Gg24JgefTZ4ZTfEFofA5DPQ>
    <xmx:-s-EZzUbM_F4XKHo6Auc9BUrE0B1DBhsusyVjCaXj9aH_OPqT6azyA>
    <xmx:-s-EZ-PP9iixynVvIW8JNAMOhct5IU5rtTFR_MIY0YBrAaUSyjKINg>
    <xmx:-s-EZy0HviEc7Aj_yYaf7mFKCESDtDmo53yd64ZTTtrLCuXUzW8QCg>
    <xmx:-s-EZ-QuZoEfXJU5aQzmSoOH7GXF7UcNsI4dsbGMt0W_aXymJigdxsbG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf57043b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:33:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:36 +0100
Subject: [PATCH 3/9] meson: fix dependencies for generated headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-3-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

We generate a couple of headers from our documentation. These headers
are added to the libgit sources, but two of them aren't used by the
library, but instead by our builtins. This can cause parallel builds to
fail because the builtin object may be compiled before the header was
generated.

Fix the issue by adding both "config-list.h" and "hook-list.h" to the
list of builtin sources. While "command-list.h" is generated similarly,
it is used by "help.c" and thus part of the libgit sources indeed.

Reported-by: Evan Martin <evan.martin@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 87755537d2aff84a9d8e86f0f5b025ef8dd23292..e278ff207a7714fbb6b6cf8e1ec1fcca37360bd0 100644
--- a/meson.build
+++ b/meson.build
@@ -480,6 +480,13 @@ libgit_sources = [
   'xdiff/xutils.c',
 ]
 
+libgit_sources += custom_target(
+  input: 'command-list.txt',
+  output: 'command-list.h',
+  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
+  env: script_environment,
+)
+
 builtin_sources = [
   'builtin/add.c',
   'builtin/am.c',
@@ -607,14 +614,7 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
-libgit_sources += custom_target(
-  input: 'command-list.txt',
-  output: 'command-list.h',
-  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
-  env: script_environment,
-)
-
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   output: 'config-list.h',
   command: [
     shell,
@@ -625,7 +625,7 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   input: 'Documentation/githooks.txt',
   output: 'hook-list.h',
   command: [

-- 
2.48.0.257.gd3603152ad.dirty

