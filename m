Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C151AB6D8
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079750; cv=none; b=q6k2Z4+biN5P3RLaO6oZyPo/uo15yhEWEKMyMpNgw0IVnSGC68A5EwusUu5RCnHpYOQ8sTine/NzEwyP1yRmgZn5LhmluegOqHvUeFGdIidCbQFBpPlS14VIR9yNIznpBZvg74EwTen49T4ArtPzj2/BoL0qhy5Te8JNNuWLQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079750; c=relaxed/simple;
	bh=3NGtl8R6O6gFPXNZtJqlF6s7FBZos9neAs66x4AX4QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0xhfu0fo9CczLC/SGCXNpKU0TXDlIlLco2quP6crhQznHgu5oXsV9DFY07S6fv/CDFOfzWQUONT6swmOV8uLXMMMor6Ti2pB4Lrb1+wJ/Q+aSzhbLQVQKQfAwFoBV8rmdi8PF3OG7LACufu3eWdFj4xRVKV6hdJF7QRN8tt0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S6saTI2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rI3V1u7J; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S6saTI2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rI3V1u7J"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCA6A25401ED
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 03:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079747;
	 x=1734166147; bh=VHcX43gy6B/92m960XFhf/XTULYWldE1tKBsqsTux6k=; b=
	S6saTI2GG9iRBJiUcT/Vq363r74nMqgsje8+MU9zStPwq3eQPy2ONfL+tJ9t7ZOn
	GawoyiXBIyj0cbQDlOV50kEhSzztsbcB2+l482ZLOptLKalqqMfsvvym5knrCB5o
	P5VQaZ34/g8H3S/E3p5KlUZSCBxMcAYb3F2op8Uy3YReT7rJGssxE6rdkR9purAx
	MM4Wu7AA4HhJBL8tv3VLyz9TQB8HKy7yBMC//SHm4YFOB0vRJ52m9k9qicOAS22I
	1/FXd4JiFAfDXyDGdbvr3Xqxh3JneMMQjMNekH4ja57ENyO9eoGu3/otDpR/TLKN
	aYB+KYcLHynmiEL8aFpBGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079747; x=
	1734166147; bh=VHcX43gy6B/92m960XFhf/XTULYWldE1tKBsqsTux6k=; b=r
	I3V1u7J8yh3V5rnpHu44nUIcVQw7AsiUVUdA3oTfkLZVkefodJSB3PrBe8/EvdGh
	3DVJWuYxxmvFJOxqiUIo5mXjP/GreRSjcWhkOxyhYgtKkWpRV3o1X6FPZHChfnnY
	XxY6uMluJpLFTrBsXHArz0ZP5MVaCplfmK8aN0giQMw8cpl9ZXPgEDqfnPyfJzyN
	2imIJDd8Jq9ydnJbRafeudK5Zya3VPVdVh4o3fQ1i3ZExKFDBv1EbwHhGomgGs61
	ITd9MlLB1aIB97t2TRvuFobJZsp2T28N3ak4M6UxTZLp4ATBsjHyun/genHmVCGS
	f/uISzJgNJu4iUgwpim5w==
X-ME-Sender: <xms:A_VbZwtzlwoM1YryTMofCVeJmlJ1vTyIM82votXpXFRCZIyXOlnxHQ>
    <xme:A_VbZ9f58XPopYlqPgIouLnBn3B1L8XLBi19vEoSx-4O_v5LW_VuWSNEjx6S6wAFl
    nQe99pJRcpIsCleMg>
X-ME-Received: <xmr:A_VbZ7ziEoDMDoAhi1B6S_4fTxmEp3pQQALhq4b_iEbvebX5oN4Ax6zTcpsVnLSWocvJfRjFOjG-7Gnlv85b3VLGDQkGqJtOooHIIe4ZmRulyNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A_VbZzPe8tE6JHpoOjrCGhsCJ18fOUUF94-RSNYEgFp2whO62TcH5A>
    <xmx:A_VbZw8yUuUzM9JTghOcz7HaQ7YJOwR2ZGeBD5yQRnXYVODzWnh3Qg>
    <xmx:A_VbZ7VmsyV1qdIYVBH68rPhB6oqOsPVA5Lw0gt4tnxjZS9Z-Guebw>
    <xmx:A_VbZ5fqIlOK6je0R7udi7gEhlwcP-nK4mRUm9e9vSEXgaTai2yp-Q>
    <xmx:A_VbZ-lcBs4a98iso5d3sjgYJX_JriXv2bTjPfLsMFuzJ30A6htiZ-o3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc8d1fe8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:35 +0100
Subject: [PATCH 06/10] meson: generate user manual
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-6-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Our documentation contains a user manual that gives people a short
introduction to Git. Our Makefile knows to generate the manual into
three different formats: an HTML page, a PDF and an info page. The Meson
build instructions don't yet generate any of these.

While wiring up all these formats I hit a couple of road blocks with how
we generate our info pages. Even though I eventually resolved these, it
made me question whether anybody actually uses info pages in the first
place. Checking through a couple of downstream consumers I couldn't find
a single user of either the info pages nor of our PDF manual in Arch
Linux, Debian, Fedora, Ubuntu, FreeBSD or OpenBSDFedora. So it's rather
safe to assume that there aren't really any users out there, and thus
the added complexity does not seem worth it.

Wire up support for building the user manual in HTML format and
conciously skip over the other two formats. This is basically a form of
silent deprecation: if people out there use the other two formats they
will eventually complain about them missing in Meson, which means we can
wire them up at a later point. If they don't we can phase out these
formats eventually.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index d36b2b0d8e7795d0520976c1e54a2f90b332cacb..1fdc6a61eb04707d7c4b7aabb412b32ddc517dc7 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -380,3 +380,35 @@ foreach manpage, category : manpages
     )
   endif
 endforeach
+
+if get_option('docs').contains('html')
+  xsltproc = find_program('xsltproc')
+
+  user_manual_xml = custom_target(
+    command: asciidoc_common_options + [
+      '--backend=' + asciidoc_docbook,
+      '--doctype=book',
+      '--out-file=@OUTPUT@',
+      '@INPUT@',
+    ],
+    input: 'user-manual.txt',
+    output: 'user-manual.xml',
+    depends: documentation_deps,
+  )
+
+  custom_target(
+    command: [
+      xsltproc,
+      '--xinclude',
+      '--stringparam', 'html.stylesheet', 'docbook-xsl.css',
+      '--param', 'generate.consistent.ids', '1',
+      '--output', '@OUTPUT@',
+      '@INPUT@',
+      user_manual_xml,
+    ],
+    input: 'docbook.xsl',
+    output: 'user-manual.html',
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+endif

-- 
2.47.1.668.gf74b3f243a.dirty

