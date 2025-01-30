Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46C1EB9E7
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248260; cv=none; b=U7u9ZSbPEeKhmQwLiUvXDa+uMwYWoXAFfDRGyJHknsiw7thkuamSpJzt8DzXSSJH8yx5CIsKfLX5jj+CSscUAPq/4UUzprhnF8UYAl6geKXXvp81vXyvzLTuuslC9cFCpaKok4gxIyMyb+m4O3UfJ+/g1ZTCYuDLzmqMG3gUpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248260; c=relaxed/simple;
	bh=P90jykugAJdvLzP5l05fFumleRRvOLiJdv/9/2bZ47g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6Zy1UnNgGUTA5tQdGbDc9hHHTvssy38ui2nsrWtlwJO5Aro7rx2mg+KsCjWffZrxxhHz/a2HE3sgFys3+Svs7998CPX18CTh/Qcb4z4HqMqlzmxhMGq/fMW7XgowfWnlQ6NqSy5iCwacOcyJMHWIPbnX5YrQir8KivS05tiwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X5kPUsMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCWIikSt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X5kPUsMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCWIikSt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 066A31140106;
	Thu, 30 Jan 2025 09:44:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 09:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248257;
	 x=1738334657; bh=lhIBs9CBf0wSgg1NK9ymsYmRz7nRYL2wZ3FAGeb73Q4=; b=
	X5kPUsMu+ELoZbM/Dfvejxf9rYELzTTFig9B3aEu5FSYXDaSMUZiIlLxpvKPC29U
	BywJEGANgbFfDBb1EI9TJVTsTOK60eTeQzBTcBwBHGOd7XJbKc1ykzPymP8UMXjE
	/Eqp+A6neaq/SeW4AbpEQfSuNzDLxzWDYpagY6kNWaawsM+/z5/INXoPX3qdJrSR
	wt2Pv84b6Bc7y57iiXWpYo+jWhLg76CcO3HKTVSjOPjEMIMBgzL0r3fmYEHgJ8Vh
	wzuX/gLKup7D0nSenb/0gNRVqZaukEb+L1N18gdQuS6k3a1Fty6kPBFNTPeJXAVQ
	1NAjrXuPKEd0aUfuMcxEqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248257; x=
	1738334657; bh=lhIBs9CBf0wSgg1NK9ymsYmRz7nRYL2wZ3FAGeb73Q4=; b=m
	CWIikStyvO6fXLdqbMAUdfgdDgf4RHV3EzeJpnTYjgZE+tbAJHkoZV75kkJN25Tm
	BNNs+RjY74N+vbH0A5RDPbIJ3XyeQNkkGdloiYGCHGPt6zrsYe9ew5HIOuRxLHMz
	NcbSt91Gjx47DS3nFOMnlQIDklot9izDsBFo8A8aCFzvU5SV8mf7tpsd3+eFsYyT
	uP1TPlROfLZui3oAYCNITspl3Uo4BxvbRLPPtmLE1pzrhOQmkaAkWuVnytgo/Z4T
	yVaRrZm6A/V6x3uCznamuZFsRmt+gRUxaum97mJDVZITf6XD3DV20X0mdIa95bw/
	MLEJSUSFbAAQd7XeLBaXg==
X-ME-Sender: <xms:QJCbZ4u6_nO8JvI7lm5J7bSFTLiDJzBBBbMpKcy2V9wuPHYCA3UoBw>
    <xme:QJCbZ1drKAmNmEh47mYvHEDHrkLpDQm9VlkpivEZ3wgbfpE1SXXonkUmph5H0xbQa
    wRA1o6EshmXZj5q8Q>
X-ME-Received: <xmr:QJCbZzw2OpTmO7SqNRtayHyjd1_dS8RkGqMHghdz20hmEBldJPxCgNIKy5L6ZyrnxkJlZIN7KYo03ytThzz22yyxPi-UGdIztfInTpVuu9m_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QJCbZ7NrtrVwDwfw9cLU1UJxJjL9r0JvFC8pOiXeoZ6hRMgJvffcww>
    <xmx:QJCbZ49xtgI95OSjf69d6iRL0XXzDFXSf9eFB4uD65WuPhM_UeSfuQ>
    <xmx:QJCbZzVwb0RfLmIwJ32GeR5AffF7FnfrNyUJriJnZZo5YrRf967ogA>
    <xmx:QJCbZxf2uxsZvwcGgmByC87qbqKpN5fOfgGk1MzayGQoo_3MBIvsZQ>
    <xmx:QJCbZ6KBgqHXwiBnGwMpBbu8ynAKVaAr5J0_TuaJE3dn7-VwZdik5D9z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 14361f12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:44:00 +0100
Subject: [PATCH v2 08/13] meson: improve PATH handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-8-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

When locating programs required for the build we give some special
treatment to Windows systems so that we know to also look up tools
provided by a Git for Windows installation. This ensures that the build
doesn't have any prerequisites other than Microsoft Visual Studio, Meson
and Git for Windows.

Consequently, some of the programs returned by `find_program()` may not
be found via PATH, but via these extra directories. But while Meson can
use these tools directly without any special treatment, any scripts that
we execute may not be able to find those programs. To help them we thus
prepend the directories of a subset of the found programs to PATH.

This doesn't make much sense though: we don't need to prepend PATH for
any program that was found via PATH, but we really only need to do so
for programs located via the extraneous Windows-specific paths. So
instead of prepending all programs paths, we really only need to prepend
the Windows-specific paths.

Adapt the code accordingly by only prepeding Windows-specific paths to
PATH, which both simplifies the code and clarifies intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index e9af093024..bc42cd994c 100644
--- a/meson.build
+++ b/meson.build
@@ -198,19 +198,19 @@ endif
 
 cygpath = find_program('cygpath', dirs: program_path, required: false)
 diff = find_program('diff', dirs: program_path)
+git = find_program('git', dirs: program_path, required: false)
 shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
 
-script_environment = environment()
+# Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
-  program = find_program(tool, dirs: program_path)
-  script_environment.prepend('PATH', fs.parent(program.full_path()))
+  find_program(tool, dirs: program_path)
 endforeach
 
-git = find_program('git', dirs: program_path, required: false)
-if git.found()
-  script_environment.prepend('PATH', fs.parent(git.full_path()))
-endif
+script_environment = environment()
+foreach path : program_path
+  script_environment.prepend('PATH', path)
+endforeach
 
 if get_option('sane_tool_path') != ''
   script_environment.prepend('PATH', get_option('sane_tool_path'))

-- 
2.48.1.468.gbf5f394be8.dirty

