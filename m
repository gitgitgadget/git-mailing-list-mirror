Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C231EBA09
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248260; cv=none; b=hA44HQPaHwX4Tr7PIVFrJzFSXzC6u0IVTVr4RDz5ij76kj2WWxkkKw7swbFQacX+4ldeuVOKosGZLZXSqUuwI0/Zo/F5z7IzPohjoij2EPfZSQN8y8v4A7y2kpp9ZZdGAp0xApsyIc7DR77uwUL3rqoojoVp+qKXo4Lgg6Ne6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248260; c=relaxed/simple;
	bh=a4LeNaicKa1WGktolbmwcIGTJRy1pViWOJqui3j9Y28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnw2l/Q86sNorcWdqORG8VL7zvMkskabeqTR+uNWC0peJTB6OqtwFCugPCZy6dRi4w1wzj9k/Pin4ovNIht6qTJs2XyluluFkfxY4jIU6mM/IN/YBjJKcJxAiZVDsJ8PP84GqU3+lOE1WTSIwqDMX1EpTO+U4OxY93u2aBtlfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aUOxUH5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNHr7fFG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aUOxUH5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNHr7fFG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 05671138019B;
	Thu, 30 Jan 2025 09:44:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 09:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248258;
	 x=1738334658; bh=L9edcznVl7/Du0ajIi2RI0tbZWrKIvNG1lZMoaV+91Y=; b=
	aUOxUH5SdfCdMpJOluLAx6lSquguSl5cEnN7t6OfXTSvlsMT7O7wYazPNq36Evuc
	7WUN0J1wp1WUKz2RuWuEKT6G+3EJYo5W9yWAvmR4RrL8S2mPiDqZnHRr16UVU57e
	aiCdl54BkAIcb6c67rDJ+DJFKZbYpC6Cc+zz6216i6Dx5rUZW5wNJb378bzzw/XM
	1vUcvqJgJ8TCzI/a8qU6AkgGZRpLllxxZtCfJnt8nytdJqbN7cehrzVuiuJkD94c
	HHqGJXrgI+5MqwhSVIQ0pbvx5vMulKBECmwgOAhHJd/ZI5b5lQIUgh5+NIxuC5IY
	mRUO2SH/3G98ArUWjID6TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248258; x=
	1738334658; bh=L9edcznVl7/Du0ajIi2RI0tbZWrKIvNG1lZMoaV+91Y=; b=g
	NHr7fFGyw+LRZCR+QKH8DuJSrUKHqubkggdvlMPfPDO8yc5milD1jQ4FAN98I0+s
	jm927wotHuGGgpFofV8Q6vgtI2chTE+rKLQ+cXUMqX2jgO2LBr/Jzy42PgbCZVVz
	sKGt0c6sp9gJYkgNHIOCk8rcSR6X7lKKWL0xDpQU97l48e4BFhtpFw/3ET3V0IOi
	udGc+OJvIIfS4D+1OgvdZiJi+wb0GznmxXCbRf1jGU14mcOtgyBCH24NBYAX4dti
	jrQouziyxxrl2h0vjlGFFmMM0AvdUQhF4cDJvkyH5WV9+GzlDKFRcfm0RAOHzXLL
	h7+j9WsLh5MyDPt7eebMA==
X-ME-Sender: <xms:QZCbZ-HVZeLsxoGI4A3kGb82lSGY_J-xC4U1AbWUWFolEMQ9QZXU5A>
    <xme:QZCbZ_VS5nRtTwPIhup8yhcC8cNEzDtM8SYPIWXFg-RxmeMQS30Kj1e1lZHbaIAhU
    7cmNgO53_yQy8SNQw>
X-ME-Received: <xmr:QZCbZ4LI1Zt8eHwjgXC_GKyVD3fPPJjpGAviW9NqKE-4_EEiIHo08Sk9zwAP-qjXwc2hyvySTI36Ipp9yUocX7yaPFE7xnEZd49VHuyjPxRH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QZCbZ4GX5kRxRY38J23biYKjm45dC6LqeosF3TBBOpMKCvKbtZQYFA>
    <xmx:QZCbZ0UsfEfcfiDgct4IGdV3jP4Z1wSH0oLSzna39Iu0J2_vnd7e_w>
    <xmx:QZCbZ7NzJybWVIRj0raqXAEnNr2unaBY7uWUzJaVrT5bkX3Vaq8-FA>
    <xmx:QZCbZ72mYAYG97hFAAS_Idd8azxQqyGWETkcqE2tXBUHpRIPLc1_EQ>
    <xmx:QZCbZxidRFSfa_kejKNrRkji5LlOrAhja9Ej_kdccTg97dOPIB5DZt2Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8dbdc795 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:44:01 +0100
Subject: [PATCH v2 09/13] meson: improve handling of `sane_tool_path`
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-9-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The `sane_tool_path` option can be used to override the PATH variable
from which the build process, tests and ultimately Git will end up
picking programs from. It is currently lacking though because we only
use it to populate the PATH environment variable for executed scripts
and for the `BROKEN_PATH_FIX` mechanism, but we don't use it to find
programs used in the build process itself.

Fix this issue by treating it similar to the Windows-specific paths,
which will make us use it both to find programs and to populate the PATH
environment variable.

To help with this fix, change the type of the option to be an array of
paths, which makes the handling a bit easier for us. It's also the
correct thing to do as the input indeed is a list of paths.

Furthermore, the option now overrides the default behaviour on Windows,
which si to pick up tools from Git for Windows. This is done so that it
becomes easier to override that default behaviour in case it's not
desired.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 17 ++++++++---------
 meson_options.txt |  4 ++--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index bc42cd994c..7180fd58fd 100644
--- a/meson.build
+++ b/meson.build
@@ -191,9 +191,11 @@ project('git', 'c',
 fs = import('fs')
 
 program_path = []
-# Git for Windows provides all the tools we need to build Git.
-if host_machine.system() == 'windows'
-  program_path += [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
+if get_option('sane_tool_path').length() != 0
+  program_path = get_option('sane_tool_path')
+elif host_machine.system() == 'windows'
+  # Git for Windows provides all the tools we need to build Git.
+  program_path = [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
 endif
 
 cygpath = find_program('cygpath', dirs: program_path, required: false)
@@ -212,10 +214,6 @@ foreach path : program_path
   script_environment.prepend('PATH', path)
 endforeach
 
-if get_option('sane_tool_path') != ''
-  script_environment.prepend('PATH', get_option('sane_tool_path'))
-endif
-
 # The environment used by GIT-VERSION-GEN. Note that we explicitly override
 # environment variables that might be set by the user. This is by design so
 # that we always use whatever Meson has configured instead of what is present
@@ -671,8 +669,9 @@ build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
 build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
 build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
-if get_option('sane_tool_path') != ''
-  build_options_config.set_quoted('BROKEN_PATH_FIX', 's|^\# @BROKEN_PATH_FIX@$|git_broken_path_fix "' + get_option('sane_tool_path') + '"|')
+if get_option('sane_tool_path').length() != 0
+  sane_tool_path = (host_machine.system() == 'windows' ? ';' : ':').join(get_option('sane_tool_path'))
+  build_options_config.set_quoted('BROKEN_PATH_FIX', 's|^\# @BROKEN_PATH_FIX@$|git_broken_path_fix "' + sane_tool_path + '"|')
 else
   build_options_config.set_quoted('BROKEN_PATH_FIX', '/^\# @BROKEN_PATH_FIX@$/d')
 endif
diff --git a/meson_options.txt b/meson_options.txt
index c102185ed5..e0e8089891 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -13,8 +13,8 @@ option('perl_cpan_fallback', type: 'boolean', value: true,
   description: 'Install bundled copies of CPAN modules that serve as a fallback in case the modules are not available on the system.')
 option('runtime_prefix', type: 'boolean', value: false,
   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
-option('sane_tool_path', type: 'string', value: '',
-  description: 'A colon-separated list of paths to prepend to PATH if your tools in /usr/bin are broken.')
+option('sane_tool_path', type: 'array', value: [],
+  description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
 
 # Build information compiled into Git and other parts like documentation.
 option('build_date', type: 'string', value: '',

-- 
2.48.1.468.gbf5f394be8.dirty

