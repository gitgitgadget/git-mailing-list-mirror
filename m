Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B631F4E4A
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308014; cv=none; b=uE/TnzmU6TILpSzpaYQ3ZtoqDrJZIswchIMmKUyqbVqanuJIBNfhHuQHo7IzVGuuZXv/ffTYYUtNzB7eo/P7wAtwJwnWLHAAbSjYH3J3srXd1nRpQjhJF3zvKjDWuLCa/2ohd4lITvNlmGNjMDeHvizs+Ed700xd9k0BrPsdLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308014; c=relaxed/simple;
	bh=ohiBOzeXKpW+cfOTzdqlsXyEnGk3FvsY6EwWX25Jd8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASdQ3tRun/52vctOmnHXO0qb6HXorszqg8SlvsfwfwwlzDAjpcq6TnoWI4QWHWIrT+egtVplwR91KDoSfiXDy048yJzNFwyJr7jvh6uNl+uxPMATR9X/xIn2csDoSbh49/pSbB/mW95oij4YzrBLW9xPjjflixU7omGk8tvL3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NkwPlCWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYfs7wWX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NkwPlCWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYfs7wWX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D8F71140120;
	Fri, 27 Dec 2024 09:00:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 09:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308012;
	 x=1735394412; bh=nVZKHcl3vOOo8D+Pm//ROfAqnUHV8+oRlkQiH+yUnFE=; b=
	NkwPlCWw/qhaE2etki4zGGiG/+ZuA3XUv2zKE1lQsNmFJ8zUsHhlO84i38aDRbJ6
	w6eWDifr8jlty9KIl8mifvW84Fj9vy+LkVBfY2mpB5G68truqzBnrLQFBv5ced9B
	oAjy33mP5AKAaj2BabbVN4NuUnf8RPSG3gLffgev1Q1/IUc9r1QZbLs55Z5jxhp4
	mBBN7ISUtgS/EkAuKjbPBDBgWAs+k/kuXC1bbLAc77OyRI9yHhkl+DkIYo7VdgtW
	rDtpOuIW7IJsdJ/D3yc3Ka2hXHhXexB4MuBVPOyNcfyw9tFS1O3eW+Phl1+u638Y
	39W/P3eiREpsjD/wgg+gvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308012; x=
	1735394412; bh=nVZKHcl3vOOo8D+Pm//ROfAqnUHV8+oRlkQiH+yUnFE=; b=X
	Yfs7wWXN2xPbkXrakVPP/l4zAtOZma66tI0bIvVdylMfzkDJfa0zgh8KiGINIzIc
	bq1sffZjKQEvFRw4cthjyiQ5iwA+Kx1KkQaXY2+rciO5n1AnghR5Q+C6WWwDJdLM
	wxYuFCP5VZQ1J5koc3UngUuIU0FMXAgbBM4kR0Cyg1Wq56LP3bCXxCFynrkTWo49
	by7gc7YYlJG0Zqm8K/Y+J9d1xGLQu2CPPzrStiyHeB4eh/SlRe7ViaEL78CSl2+g
	UkKcNHcv22AeRKOuzRR1oRQ4s1C6WI0aOv/et++sBzqdtGvbf8YMHDknqeTU0p5i
	lWSSrF7yJRSnhb6Bc5SMw==
X-ME-Sender: <xms:67JuZ1UcqSy-vafXX7lwcFUuHaXOZAz2yDBLjwF3AWgvpecjv2-2Jw>
    <xme:67JuZ1mKxw9dqT5NpchCC_6dRA7_IJKcRX7i3d_fN4EN9UFw0YFuRcapJc9eA6CeR
    VRqk6MRJaXXUqGMTw>
X-ME-Received: <xmr:67JuZxY2rq2r9E1bF7gcBOjQTKqmHV45PY6gEtd_CWaTZYSHktZAp4pvemHbJCiz_ypvTLeJRyO3860VgoaY8TCwj11AmJJk4JxkEiATxx_6LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:67JuZ4U38Ky4wSru-4QUjbONDRhtSUJNOnTnY0QbZ4sOsqeQU0TZTw>
    <xmx:7LJuZ_nlCDUc5D80VGUHX40Gy3bCDNGL0q9sP2lG-20b3Ub6y1PfPg>
    <xmx:7LJuZ1c92gP3gLUBW-aPykArhK1HM4bAe4N00cYel5ud7JSaCCceUw>
    <xmx:7LJuZ5HZ2SfrKkB9YtfeDkSgxRoR7png5ozXr96J4NeoFKLTvgDZAA>
    <xmx:7LJuZ0xZw_0z_Tm-0WoFLQl9C5zSnacRleB1_K3MsFM36IhLbuhf5djm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 55269fdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:58:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:38 +0100
Subject: [PATCH v2 10/12] meson: install static files for HTML
 documentation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-10-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Now that we generate man pages, articles and user manual with Meson the
only thing that is still missing in an installation of HTML documents is
a couple of static files. Wire these up to finalize Meson's support for
generating HTML documentation.

Diffing an installation that uses our Makefile with an installation that
uses Meson only surfaces a couple of discepancies now:

  - Meson doesn't install "everyday.html" and "git-remote-helpers.html".
    These files are marked as obsolete and don't contain any useful
    information anymore: they simply point to their modern equivalents.

  - Meson doesn't install "*.txt" files when asking for HTML docs. I'm
    not sure why our Makefiles do this in the first place, and it does
    seem like the resulting installation is fully functional even
    without those files.

Other than that, both layout and file contents are the exact same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 8c6ff0bce1206d988cc0d3b7997fa0f338d01194..4d9511156502653292144fe6962bd3411558d96a 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -384,6 +384,27 @@ foreach manpage, category : manpages
 endforeach
 
 if get_option('docs').contains('html')
+  configure_file(
+    input: 'docinfo-html.in',
+    output: 'docinfo.html',
+    copy: true,
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+
+  configure_file(
+    input: 'docbook-xsl.css',
+    output: 'docbook-xsl.css',
+    copy: true,
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+
+  install_symlink('index.html',
+    install_dir: get_option('datadir') / 'doc/git-doc',
+    pointing_to: 'git.html',
+  )
+
   xsltproc = find_program('xsltproc')
 
   user_manual_xml = custom_target(

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

