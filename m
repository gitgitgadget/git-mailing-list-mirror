Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBD226CEE
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558155; cv=none; b=ukWV9OEDXZfT/Muy0oAdl3vBzPhdqcRWQ8rzVzxKhtFdS+64JuQHSiJP/h2tMtYRKGKGljoZGnOSYIoHC8DMfq9+qfEeBIELfSZbFlkklDKBRV+rMWNd8is8GtLQxtV46e1JBbFUKuDi24t+5WbpYQH0l+STDrbe65mQ616sk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558155; c=relaxed/simple;
	bh=W397jRG81+5Hnu4MsgfKPDZyF2XWTbUbHKL/zvoQOlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1CCkRZ332lU5HKb9ojzwDW27gm0ATKhz4y0G31HNWOzDWAruRdBZddp9FqTGufUAg6VqNAT25Rp5De6v+G+rF28ruJOJBIIkCbv3uGcyeyyPKF6KLmNTni15VoPTxzWjw3yrbi4VUbRusCLJDO7JVr+zPgZfXix3fo8lPlHnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fB89lQdC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNEAiE+q; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fB89lQdC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNEAiE+q"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 175881380EC0;
	Wed, 26 Feb 2025 03:22:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 03:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558153;
	 x=1740644553; bh=rEjsEJEJO582CILXeGbnqXapzG82agrBmm+d00gvtvI=; b=
	fB89lQdChpJT4AoFxZSYP4JPMYeFyYDptoC7iBoHFXBPUocj3O1QZTkoCG+10/DW
	oF2cpf23ctLd1z2KQso388phrl9LzfWKwwgf0D6929SRU9RPZbLIsV1jhUENvW5T
	i2fIxzrJZsuTa1SOdys7srATD2THxwqIDsbKLSrPTztswVRUXrVNYUYnuT9f4fUz
	tUr87k/o07kAwanG8mpf7TctUovWFTeyE4IdrcH5l5zIQnD1iWfBwq8o+3TZd4E8
	M05qhNoO8+xwsSp4ODFM+rbHCCviFmC3bNHZL4KeazPPCobsUCUi19MekxDQnaQa
	gCxYnZyZ82kmyurF6VwIZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558153; x=
	1740644553; bh=rEjsEJEJO582CILXeGbnqXapzG82agrBmm+d00gvtvI=; b=P
	NEAiE+qqXqN1jVsCDaQzOI5JD67lYU9ze1DLwbAyMcju2UABUoaO2xfvaUhLE2Ut
	rHLvkTQkFMi6//+mcdcXTVabcRFyqqZdcn6cV9hvO7gM8KLEO7bkqYh6NejcpI3A
	Jt4dNKp+SYKByT/MXdeIaMVex0MeoHCFMXKUF06Sow3VB49MEj0F1WB8OAJTd4N5
	DnSBfwS3GieCQtc26lLGyXYMJGhDQ+wSjrZ+W0dHXCKnlUpoL9ZzrYch5n1Ijen9
	XY/sTtdRcJOcxDaXH3FHbD/zx/6y1PLf/QOY2fycdZWum89pYCd3ShB/nSvfUheM
	LCWYvomUb/pWAY289Nr4A==
X-ME-Sender: <xms:SM--Zzn8NMyGGmuMEkrkzH3Ts0cMcH1z_cU0eopK7nq9huFEHx3mgg>
    <xme:SM--Z222rMfsE1MR_XEKBjZMZyPE5dQkNx-9kn1IiJuqwa1r0oOOdl9dUMXU9DNG-
    U-ETySTnDPq6D_maQ>
X-ME-Received: <xmr:SM--Z5ryS9p2Ryg1MBaWVSBBTPflM8jbrYSEkuBj1EI4qVofuPa-hiamx1nHXOBQKeHegTGIH7pWvB3U9F1RhOyNb_gMKRgk88o08Kr89c5VmjKp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:SM--Z7kTKKUfwyxTZvXNml0mrjsgcOG4-Vw2-XHB8kBJTEv5M2H0Mw>
    <xmx:SM--Zx1gmCx6dtmKJhl5CVxbDUQySv74b8WfRIntXpQwjdaIbb4DgA>
    <xmx:SM--Z6uW3SS6L_nw-Owv5Ysfir-MebRbrWMLcs4eCt3qY3UaPZoEAA>
    <xmx:SM--Z1Va-Glm6bP4K3E34II8kEbZ_NbdfugkCtr1aYKujh9p4X1kLQ>
    <xmx:Sc--Z8T-WBdLj2AY7VzfUbYb7uDPACEJtKqAtmZwOvApq6VCckjUYgtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a19cb57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:22 +0100
Subject: [PATCH v3 12/13] meson: consistently use custom program paths to
 resolve programs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-12-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The calls to `find_program()` in our documentation don't use our custom
program path. This variable gets populated on Windows with the location
of Git for Windows so that we can use it to provide our build tools.
Consequently, we may not be able to find all necessary binaries on
Windows.

Adapt the calls to use the program path to fix this. While at it, drop
`required: true` arguments, which are the default anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 6438fa67920..c6117366ff9 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -206,9 +206,9 @@ manpages = {
 
 docs_backend = get_option('docs_backend')
 if docs_backend == 'auto'
-  if find_program('asciidoc', required: false).found()
+  if find_program('asciidoc', dirs: program_path, required: false).found()
     docs_backend = 'asciidoc'
-  elif find_program('asciidoctor', required: false).found()
+  elif find_program('asciidoctor', dirs: program_path, required: false).found()
     docs_backend = 'asciidoctor'
   else
     error('Neither asciidoc nor asciidoctor were found.')
@@ -216,7 +216,7 @@ if docs_backend == 'auto'
 endif
 
 if docs_backend == 'asciidoc'
-  asciidoc = find_program('asciidoc', required: true)
+  asciidoc = find_program('asciidoc', dirs: program_path)
   asciidoc_html = 'xhtml11'
   asciidoc_docbook = 'docbook'
   xmlto_extra = [ ]
@@ -245,7 +245,7 @@ if docs_backend == 'asciidoc'
     asciidoc_conf,
   ]
 elif docs_backend == 'asciidoctor'
-  asciidoctor = find_program('asciidoctor', required: true)
+  asciidoctor = find_program('asciidoctor', dirs: program_path)
   asciidoc_html = 'xhtml5'
   asciidoc_docbook = 'docbook5'
   xmlto_extra = [
@@ -283,7 +283,7 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-xmlto = find_program('xmlto')
+xmlto = find_program('xmlto', dirs: program_path)
 
 cmd_lists = [
   'cmds-ancillaryinterrogators.txt',
@@ -404,7 +404,7 @@ if get_option('docs').contains('html')
     pointing_to: 'git.html',
   )
 
-  xsltproc = find_program('xsltproc')
+  xsltproc = find_program('xsltproc', dirs: program_path)
 
   user_manual_xml = custom_target(
     command: asciidoc_common_options + [

-- 
2.48.1.741.g8a9f3a5cdc.dirty

