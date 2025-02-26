Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945F20E018
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558151; cv=none; b=tW9OUw0VlgElCTr1YOFhKvaWGLS6Bygacha6Tcz5pgyOAR9xYojalGQHReKtZ5vNotV/1oxi0pM7ynFNKLsWdKaq/kjKYBzIEXNsEYYloYXImsQM4Y4ZWZM1112GjNG8haGFyEJptxcqh4wvGttFvt+C18+sW1/dfizHEBhkRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558151; c=relaxed/simple;
	bh=Z0bjl1PS90wyXyglAwvnekAEeY2gG9i9EwrGHn8xbe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glAPeuQVdAUSlEklvHFdOZdveU2e/7P1uZC4DcDW073W6/03cmH3hg44cwT2YjdpPvy1/kIns6L+xN0PhFXc39OUgn+26a445tQq9j2jajIf6iBJDZzhBZNRwmUKs9pox5PoaStkI32UFl/2vJmcpD9Gv9+x/FgN7WUJRoabc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m8Yaj3M7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sLW3aLgf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m8Yaj3M7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sLW3aLgf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E4BE1380EC2;
	Wed, 26 Feb 2025 03:22:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 26 Feb 2025 03:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558149;
	 x=1740644549; bh=0LUELWD1/WiuXWiZCidqwzufpDVLvFHd/UkEG5oca0w=; b=
	m8Yaj3M7/lw6/qdqX6jvYqU+YYeUDsYJcp4lEUt6Gx1VipF6T1TcCifJJHxXaBkZ
	L0Wd+vOUDqJZ7l7N517g5QzU76QWGRWm5eXSZDHpJ6g+26qfsEo6boQ/d30gkc/F
	D+9K2QGu4xsZw7R2et3t1QLHJkBL10RpBxaQ3+EbLqJj69ZEWVAs7aTQlAnzYPtL
	1PlM51WVrnvrsAIIFylUuvuVqlEl1UilIsxe5RXGQd9gPCMo2ML2SfPR4fi/r2X1
	dezmsYg1iQ1ESsIXziUh6ruyTIqQGNWB59OtIxvpjz6oielP2z/YN6uy4YacB2aZ
	RVu3UZvboL48ira4rcPZ5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558149; x=
	1740644549; bh=0LUELWD1/WiuXWiZCidqwzufpDVLvFHd/UkEG5oca0w=; b=s
	LW3aLgfZWIhw2Ai7+fihuqA3yTy1ChSDsctu74qgl6p1bN7RaCNJ4jtQMOzel0Ie
	p1Lsbmxqw90jSxvxPZ03D5eia5w1BRhYwxktaN4pZOD/z4tSlhmxJjQvRWAq0c9z
	2Ea/BmOFMDbpWuRIv7jbXjZijjBZyYAQmoR2G38EvbANdPEibURq4QXXV/2opPyK
	favo0DXA1FKFRRUzGCwpBHG0e6nlZ5YPztsxxje6uqzi4OMeU3n1otOitav0Zqgt
	Aooj68ASJ+WzhLNWsX/IiyImp9fUDo11QVlQVC/ZPGj0OVvBOqWREvMk1cHpQA4m
	tVbBfBM2bksN9bUL5ZRkg==
X-ME-Sender: <xms:RM--Z65BgTC3qNwWgc-WYKkknntkB1SQcrW7qPfLjIyezqRNriZXTA>
    <xme:RM--Zz5naYBgxJAASCAHjHypwJ3O6jdvQGfJ0ZhX6sGYFs3GtlCZNTTOMEKLqye9T
    A2aNQnqDvEXQsDwqw>
X-ME-Received: <xmr:RM--Z5cBK0g-cY5XtEjYm54XKtvJawqmGwn5xGq5I-smjDDiIqM89XSId1gPNveQUEu20fSN-Xm-bggIdQ47nkUFrqnDA85ww8CpR7LVj_TWgx3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Rc--Z3LD1Au1l5YYWiaD0jshiLVsSPuIOnjkW2j9pkM7kyTyQtWlgA>
    <xmx:Rc--Z-Jni3YQULi0mKZDi15UX-ULDHwVuDtG9MMxcYHAA2YvTQ74PA>
    <xmx:Rc--Z4zj7vlnr_BIH6E3jxdb_g0CAFvRVjGwRXokKspuTMSEEqGSng>
    <xmx:Rc--ZyI81Kqi6B_X4qHZbImCLNT5APl_SKFI-qeOAIv2_EPCsxoTvQ>
    <xmx:Rc--ZzFtkPqwMNRgkJCha8ZIKRJDmX0USW1_2sKLDW3Y80-S6A6p6Q5v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1135524 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:19 +0100
Subject: [PATCH v3 09/13] meson: improve handling of `sane_tool_path`
 option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-9-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
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
index acd6074b32d..ed857aaa4ab 100644
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
index c102185ed5e..e0e8089891b 100644
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
2.48.1.741.g8a9f3a5cdc.dirty

