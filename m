Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DA19E833
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134736; cv=none; b=DQKdHGaItgXyObbGv33QwtumG+AYN7Ilo6XkzgPMpTe+I9iNlj7OZrz4tIuNV/STsZbolqsnWIOUwrSaQ8T+fG4ELqVYkzh9ElG7Cz+YnKyUNv13S83QqyTaNM2mRhC74QRKbRAfiKq/abVf2c9ALnW6IkCV2N3itTNhjUxc2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134736; c=relaxed/simple;
	bh=y9hZgunIB+W5uIC9oHHaYZl328iJrudqRulOgDBmCb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcTKWY6LzLd0wvEkoUVyyZtDO7Sf3wUznxOzlAcrlitt/BY8Yicf6gWMgtD1M6A3ojay7vGqJ8x9XkltaJRJhG5XO4hY1EL0LBcdEcMkYMbFY9YMc6BJ9+7LVotL6t5F0rbBBEG3rMDX599n+UxNALGKCx+b61y2h46EPGopBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fo6ukGFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sEzNkmib; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fo6ukGFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sEzNkmib"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 63BA01380B1F
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 29 Jan 2025 02:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134734;
	 x=1738221134; bh=f/WmCyRIG3SQSPojxYFuhN9uE4+MjCrkHskdniOJr+U=; b=
	Fo6ukGFxyX6Eqh89qH1T2Dn2GxUD/BsaxEXWyCnBkSC+7gI8EQF6ecdMPZDE2RsI
	XRlwKG8ydqkQOOTY1cj5SVutvIch/T+NX0/TBXdoCC9qntctSE+YjWVCAQ3/9yH3
	qXScABzUJqEscWjjTIoxi7bN4y1ya0nuwl5mC/fy6lbOusek+KHpnH+7i3d8vxYz
	RRf5XTnV50g0DGvKa1XUDHClXJBaEHStVdm2Vl1uCjL1NJvJG8/tbt68T9kdGHic
	r0wL8QQp6g0LmQsPUaav84n3pTp7LD86lPRoyOymnD/XH3DYx1k43vwyRdS3lhk/
	Tsh3IH0oyePOF3GmfoArGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134734; x=
	1738221134; bh=f/WmCyRIG3SQSPojxYFuhN9uE4+MjCrkHskdniOJr+U=; b=s
	EzNkmibm66bbA1ZVHRtNVn1P64D7U6Rs01/V4NA4zBnxetDQ5lWGw+q+gvSY3GDf
	Cc+4ct0tYMY1EOx1SPG6kDh4k+XfEnoT7x19vl5w3Ca4kA9TPmGZMpcdEASy2D23
	e0PZFSbmJ/WiZKI0qAEg5AN5UDWlEmjJrsldEvPJUV1MNspQ/muNuL9UBy9YCFsf
	vRifjnnSKGEC1eoaVZXAvrpbVjlbSgGEJUKNQduV/zX0tbI+mKHYped2DHonf/6D
	7B8gf92sPk5cTf63PFLsxZuEnZKQQ8oJTKZZc7sJl0/rqDBuLoo7BRa1rtL4aj9y
	2ocWvbaOKQrmRgmDGuesw==
X-ME-Sender: <xms:ztSZZ9fn7ztM9e2eOToxwQtSD5YcehimoQsTJ9DYtQZEo5ilwosKfg>
    <xme:ztSZZ7P8moOAvIVV4ZDXYzlQQAJSDoY07S2OHWqme1bU4k2ctHkaamMIqDoJ1O3SO
    GoljDbxdqAgEfdUBw>
X-ME-Received: <xmr:ztSZZ2jCam74ZgN5LsCtixct8rN4R1cdHHNgHR8R-MWYYAWKdcy5U2al_RiQ2_eaR0f6SzJG7JvinbEhHKS5bdjmqMJbNnJ8wqJx9cCFS_7qUT1kIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ztSZZ2-i4ZqLZQYAjIdQRujcwnXbeIhI4g2Vjnc4ENx9nePGmS2vAw>
    <xmx:ztSZZ5unmeZLM6rAP269nxN0qV_aXtHCNrrA2sdu2HrQ6jsIROPK5A>
    <xmx:ztSZZ1E7zKlTBV87yhXo9KqAub2OqzI7mpA7CXFzsm7YegVg1KWNUg>
    <xmx:ztSZZwOZiSiG5A0X8ZdbJ0g6NDM2gkTGN67s4uz-ejGOkbaDlDSgDw>
    <xmx:ztSZZ6XsWqGIwaH8umZCUrvh7XO-qfcmUGrS7ipQJxnb_LlxuDiwyGJc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f5a055f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:12:03 +0100
Subject: [PATCH 10/11] meson: fix overwritten `git` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-10-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 2a26fa8a5f..6438fa6792 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -283,7 +283,6 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-git = find_program('git', required: false)
 xmlto = find_program('xmlto')
 
 cmd_lists = [
diff --git a/meson.build b/meson.build
index e3829f2365..828fbae8b0 100644
--- a/meson.build
+++ b/meson.build
@@ -1567,13 +1567,13 @@ libgit_commonmain = declare_dependency(
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
@@ -1664,7 +1664,7 @@ test_dependencies += executable('git-imap-send',
 
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   bin_wrappers += executable(alias,
-    objects: git.extract_all_objects(recursive: false),
+    objects: git_builtin.extract_all_objects(recursive: false),
     dependencies: [libgit],
   )
 

-- 
2.48.1.362.g079036d154.dirty

