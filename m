Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A771E1DE4
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558156; cv=none; b=IVt2JTY2DVCn3Ge4gI4ogjMgvs+jmW0er/Fjb8ZlhcByjy5gBBMu5t9e0Md+9NNKeGF3VaXsqNQiIwu6OLT/As7lKnxotUInQpw0K5Appr8ptPPZKm/Z7+8chp3h8y859tiZAzgHgKkkDZIrBZy0M249HXOz+F0YaZrgyfmjlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558156; c=relaxed/simple;
	bh=MJQLhUSeF2i+8Vum3qreFYWAvSEOoRKi5SxCMayUlmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eo1ZYIb27pKoxxgbWY9xOAEPdv3QCqRMGxWqDTIeuWiNAgcNkRFFkDedqJUSoPUE0qN2R5KOP3Tq5HUMvgQl6HEPyoL3Umlbk8GiAMtjDAI9LHWAhewp+IX8yy7p1pm0k44Iehk+KFvTK5ESpypXeDrtSdHu7u6P0zUxdMz5Xqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XzmS9XCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBx4OrHy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XzmS9XCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBx4OrHy"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C41B6114017C;
	Wed, 26 Feb 2025 03:22:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 03:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558151;
	 x=1740644551; bh=JQq0daYORmQAkuzYSPgAFzgo3PoNmiTkYIaUzIDbPJU=; b=
	XzmS9XCwr0l4oQm9+Bert5PWcQmAuI8yux+3n2lO5852yjoHqORkDoDTeIwk54Jl
	gnr6AJwxkDDwuwbTnoOnewRm/AycyRdtxpJSVpiZgD9avxSkbJ3wFbs4ETnceyYg
	hHN0IEL07e76Ovvjo+JMoSJlE3ufqgoVk26Em7j7F+fGj0AL/OBNvlkq2HhJC3SE
	H8bTv+PyjK/XV+3aNe56G0HAb0o9L/mFl27k01cIjSQQcxRllmEkt600TTmNorsb
	2wBCsRSKWkcUmV2IELs1fkXynSvzx+23xCvJ2OVaXHQG+GN+aWi7l2fOhPufoEFn
	Ut64v5NxwPZbt/w1BALaOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558151; x=
	1740644551; bh=JQq0daYORmQAkuzYSPgAFzgo3PoNmiTkYIaUzIDbPJU=; b=l
	Bx4OrHy0UrQDpHiYI0VRzU65Ujv6hPfd5l3eD8vFkA8ShsY6Sb5p03/nh2uAj/aP
	hSdsURMRGnpSCUdBSErfEhCEWBZLmHClDe7TucQaqHvofwUv02OiO+ZnJrwyENuH
	0ciuMuvj/zJjEJA3MyaY2EAosWkjf1diEQK2QQREF5U67OMexL84nh5KKnUc6JHf
	S9GD2Vpl6UXYpvgf5cmsNNlp52VogO5dfGzDU/D+aYGRjmJHqiiSRyrAmgjJx2nw
	ZJs5zupgQDApZWcR+hVnRbm/iq56tDMrULC8pKeXLko4tW7ulzi9BYfyc0r0R5M+
	UV2b49H7bN1ECJCKKyg9A==
X-ME-Sender: <xms:R8--Z8kvaHZNLOp0kjbnaic-6QrsKMDpIjpIv7RO86iKcVZOt4GcHg>
    <xme:R8--Z70KjajJTNsqhQHMF2PQzJ1b-LY_NVZa_GIPtqG5yWmTUpyq_kxc32YBJVHXm
    vgM0glA-auJFhQ6tA>
X-ME-Received: <xmr:R8--Z6q4Tz8DrndNnQQJvUx-9a3z-dY3qRaHPk20DRlcAaAOhsihpltFNqD57jaZHZawuxd30Cl4Say2WIfQ4MKHp0SH2h5xeg9mA9H_KGi5XYBN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhm
X-ME-Proxy: <xmx:R8--Z4nIdYLLHZdA4uUKnF3EfORv64LvNY3b9oy-HLtjKZXf8i-mdw>
    <xmx:R8--Z6084UYLRfVx39xnT7gdcCcU0TQtCFIk6mmKdqWJIHa1If3vtw>
    <xmx:R8--Z_vfzACs0pco6gLEtRfkDDaR_ELZlz4yicLPQm8EI_qGOt6dLg>
    <xmx:R8--Z2VxeAD4awV66VzJ2y48RA_lVYsCeM14lgFggUrDiJzfoiRDFQ>
    <xmx:R8--Z9TnflHlX0nAQ_3pnUE38Jb686NaKEhmWO1jpCRYJjfipsHKp0xd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec018cb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:21 +0100
Subject: [PATCH v3 11/13] meson: fix overwritten `git` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-11-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We're assigning the `git` variable in three places:

  - In "meson.build" to store the external Git executable.

  - In "meson.build" to store the compiled Git executable.

  - In "Documentation/meson.build" to store the external Git executable,
    a second time.

The last case is only needed because we overwrite the original variable
with the built version. Rename the variable used for the built Git
executable so that we don't have to resolve the external Git executable
multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 1 -
 meson.build               | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2a26fa8a5fe..6438fa67920 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -283,7 +283,6 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-git = find_program('git', required: false)
 xmlto = find_program('xmlto')
 
 cmd_lists = [
diff --git a/meson.build b/meson.build
index 5bf6a914ead..930b85a6dfe 100644
--- a/meson.build
+++ b/meson.build
@@ -1608,13 +1608,13 @@ libgit_commonmain = declare_dependency(
 bin_wrappers = [ ]
 test_dependencies = [ ]
 
-git = executable('git',
+git_builtin = executable('git',
   sources: builtin_sources + 'git.c',
   dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
-bin_wrappers += git
+bin_wrappers += git_builtin
 
 test_dependencies += executable('git-daemon',
   sources: 'daemon.c',
@@ -1705,7 +1705,7 @@ test_dependencies += executable('git-imap-send',
 
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   bin_wrappers += executable(alias,
-    objects: git.extract_all_objects(recursive: false),
+    objects: git_builtin.extract_all_objects(recursive: false),
     dependencies: [libgit_commonmain],
   )
 

-- 
2.48.1.741.g8a9f3a5cdc.dirty

