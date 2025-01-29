Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F11990CE
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134731; cv=none; b=PleNMGUpZZFNYZlYHz8p+TPM+ItHkK0BQfn5UYYIt/ebEBjlIlTKVUco0e1jWX15mpwxGMU3syINSDewDP5iUG0mdCRiX1RHIHBMM+CNk34aw/9GaTJsfQCxh2r0Y/+nKFNhypm36uPxirjgYuInWnXrEOuiinB3a4bWnAado4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134731; c=relaxed/simple;
	bh=5OwcILQajgaOpwzb6toT/ceCdY4OJ6NvVg9WQ6D/JWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WC2ZWykLStmSWhMIiOsOdJn9gA8HXTYkGHaPxPqmQMcv3O8ZtnGFkR2DL4rOaoNECv+vthfxh58UQ8IXpHJLQFybWp2THT3g8K3elhJ1E9aFDZgs6hiCkQ+VhDf7yhRPdFnr1hwW6xjF2BGpzdk7XWdlk1Xwal1mOClRP6ElCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pNvgU/Ve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWXL23iZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pNvgU/Ve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWXL23iZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AEA7C1380B1F
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 02:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134727;
	 x=1738221127; bh=/5vfSTw8LlkNdI8geFCEu1qgMkMQoK+df0lm+MsYvUA=; b=
	pNvgU/Ve2/v1noW2Ok/ueufXNcYrynobP4RCBQkMktZ6fHZhpO5008PPzW9u0mQt
	7k/ePJCfqJkth6WgSrtJApIMNkgKa3rjPMcSH1urz8pUT7wPHN+VwSLP8qacbbup
	h8lb2Fxg0ZpPBaOQVa4HUz0HKaCL99A+67HxUZuLkVXUY4Esyrh/f/gPQW1++hTp
	4f5+vR2GipIb6NUqcjS/wDXrD5qWZnXRK4R/Fq7vbXaZiGGcy3L4DU33jDx6DezF
	crwmUuPCAnUi1l4xjFVo/DPHhO2zNKccLPqrmsFJ4T173lo3X/3nvCUIsU4FNywV
	IxgneMhkuuCtByqPtC12Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134727; x=
	1738221127; bh=/5vfSTw8LlkNdI8geFCEu1qgMkMQoK+df0lm+MsYvUA=; b=T
	WXL23iZUvKY4/KStgplRlEXlHmkqlHUXe80FbqpKmeFdcRrQmj8Y6477rJ/cPrj7
	6BtjFobJ9gqXHVDbz/2mPL5KCSmJ71a4mZ7fVcFsXMEPURdSy08dcbHuxp+UNX0M
	h9z+rKyYwkS00g8ujVXvAiz7McI0WpPtFAgYvMPipHfQwW30ZtXg0HHuEzdDRiqF
	92iIqSU/ZSOJbDsKmvLvz3uiRvzxZRaV2/IZbVczcpnqpOgRZf5oYjWsuxKFP2ON
	xeI5eYXUE4ZedhdRgzCON8GEDrLyP+Wy7PkyUzg/uLqK7Xk0wey24hMco1oFutoH
	pUYvPp/LQxmN1YyW8hgOg==
X-ME-Sender: <xms:x9SZZ9Gq9sspkT-GD5aJL-0OO7w9MTk2moLuMjehW6J6TKpD_Mrtag>
    <xme:x9SZZyWdIHS7GYaGbx-tbyDNdqAJ4w97FkWBS7_8MRJDgl6lGDVb6x1tHFRMPekza
    PW7T1p8pjnFAn8Opg>
X-ME-Received: <xmr:x9SZZ_J-jqp5GJU8AkZ64Ug4vo49BQ0Xr2XNLxOq8ewYi7l5ZK_bsZ9ZPf7JiD7mZcTJm-9LGc2fza7eksRntsj-sfO-YbBVRw3B3NYGhFwMvZBXvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x9SZZzHltMweOCLHQuWxK53FX9kU1AfjB6IIb6DyGu1O_DvQ2CHiEA>
    <xmx:x9SZZzVgX7IevypT7x-MCN2xBytjGz8vx1cpcKkPwD-V-l4cxTZ9Hw>
    <xmx:x9SZZ-MwzsrvU8aMpccbLttMkVY22dGVZuGYPNvWsvp_7Xx-8eT8PA>
    <xmx:x9SZZy1UmPdNH8CPst-j5XdKRiOLbEvwoYWkJjL-2DeZ1WsNi6FeqQ>
    <xmx:x9SZZ6cFF2ju3MDTYvf-Phj8fymipFyJDLoVcg6zQmL-Y5vbWr_Bg9HX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf26bc33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:11:54 +0100
Subject: [PATCH 01/11] meson: fix exec path with enabled runtime prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-1-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When the runtime prefix option is enabled, Git is built such that it
knows to locate its binaries relative to the directory a binary is being
executed from. This requires us to figure out relative paths, which is
handled in `system_prefix()` by trying to strip a couple of well-known
paths.

One of these paths, GIT_EXEC_PATH, is expected to be absolute when
runtime prefixes are enabled, but relative otherwise. And while our
Makefile gets this correcty, in Meson we always wire up the absolute
path, which may result in us not being able to find binaries.

Fix this by conditionally injecting the paths depending on whether or
not the `runtime_prefix` option is enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c54ccd2162..fd83df8c42 100644
--- a/meson.build
+++ b/meson.build
@@ -675,7 +675,6 @@ libgit_c_args = [
   '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
   '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
-  '-DGIT_EXEC_PATH="' + get_option('prefix') / get_option('libexecdir') / 'git-core"',
   '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
   '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
   '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
@@ -1437,6 +1436,7 @@ endif
 if get_option('runtime_prefix')
   libgit_c_args += '-DRUNTIME_PREFIX'
   build_options_config.set('RUNTIME_PREFIX', 'true')
+  git_exec_path = get_option('libexecdir') / 'git-core'
 
   if compiler.has_header('mach-o/dyld.h')
     libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
@@ -1473,7 +1473,9 @@ if get_option('runtime_prefix')
   endif
 else
   build_options_config.set('RUNTIME_PREFIX', 'false')
+  git_exec_path = get_option('prefix') / get_option('libexecdir') / 'git-core'
 endif
+libgit_c_args += '-DGIT_EXEC_PATH="' + git_exec_path + '"'
 
 git_version_file = custom_target(
   command: [

-- 
2.48.1.362.g079036d154.dirty

