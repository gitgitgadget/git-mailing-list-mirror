Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B726CE04
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042243; cv=none; b=IPnfteVFZnQatvwhBmjwHXdWuRRuMWMywOo8x/WriDSKvNFRa2/jwNZzq6Q9eWYWVndX6PGBBaonF3rz8O1scKrrtiznef8QEblUxXP7gN1UAQQoNYFdPj70F239faXODUTbyAfsc/k+ul+WhY/JUSZ2jdj2ILB2mZ9wKfp893g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042243; c=relaxed/simple;
	bh=aJZQHBm3tamA7NHG3lFFO8nZtJ7S6c6OCyH+zrpdE58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCEqjIjitk0lVTOUv+8GpU+RPZ8P0QPnWpZNB0BYONrh1D+hwcvvjmBZ9tPjqIwglRxaY3CJeddnttl3XvlzsPuBHybL902vG1hGXZ0uH325/rteVWpoR5lKdxQk2fPHDCk5R+zBs5r3LtvpuN4Zpj0yETCaCYv95CUmdhKQu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SYuWtcFd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XRMPePVc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SYuWtcFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRMPePVc"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 27B31EC0435;
	Wed,  9 Jul 2025 02:24:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 02:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042241;
	 x=1752128641; bh=DixXYwiISJf0nxZqT4l0DuR5GGnlHd7bpzySPnwMdsA=; b=
	SYuWtcFdLiU9P7MHHQtZMHmF+GsyZSkpvZEBEJMNj9046Lqsn4/OCaaaAnQ/PzGi
	QlFhZmf1qWCR8mUVJWURyGXHmleh9ZB4YOpqzkh5VJ9WC+oOtjtX4ybqffo1zNK7
	gxZx7ahZDcTecveN2EGhA5oSlmglTOZVvuTmZJBoS6mGX+mM64dVkLimkQwGCfFE
	PFYs+a51IkPAKvMff4jEtNTW1gnG1VzjeICAa/wUEfUhyEGU+ZCMRJEXIpJLS0nh
	TPWDu2ugvZaYaNwXeGh4vR7aIz09qmMbXS8xdhawNRFRwSpajMuPasQuVFHq5RbZ
	804tKNxkjkn53JoE+9IN7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042241; x=
	1752128641; bh=DixXYwiISJf0nxZqT4l0DuR5GGnlHd7bpzySPnwMdsA=; b=X
	RMPePVceyezjC1F3kifO8k3hPI5seE8xkhK/cZT0nohorSe+ivP4Sf9L9kzcc6Oo
	f/j7apTjXC2ooUtRIlk7XfWX7ZoSbJy23tNAImrfb1g3Yutp4I2R824hwUpL62gp
	Cb0fBhTpriM8bfKc/fsjL9K0s01d02UoKTtYfH0DdgHB/yuo/pzg2d7OpMx8BwlZ
	zj5DrgFLtyNmFI/+Kw1SDXYiEG6vL0vyErkgbZ66WaKTsd2ktDPfoQTJpCs0IRGo
	6PbgpRKXUppR1wIXodB30NgpcxFvg+RzzzhpNUVfSxOT3Njuj+rV0ZokhcARQDw3
	VTV6ar623cCumlGr/Pr9A==
X-ME-Sender: <xms:AQtuaH9tkBl5btu2tnd6wrqYUf_YqDyu84dXlDGfRLRodXZQj-lOEQ>
    <xme:AQtuaHiNp_-VsdmBZ0RsVp3OOp3mU9JqJzgXU-gSdnAgdXUuK1FKl0C4O4xNZ2VVU
    ggnqjsJy1BB64bdBw>
X-ME-Received: <xmr:AQtuaOFrXjCvdGNNdeSlDKuFmtjFcaKue0BWXGY6_qwI8QHDeZ3lHR99HK0QUMGL4WkbRIHmWRykwrQv0DAiBq6_59p6mp3h--juMDk5cWJNYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhrvggttggrrdhkuhhnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AQtuaG9wZnIUNWPfnxPopKzQe7H4YTopcfkcyHg1_Zgp5a1Ayxnmvw>
    <xmx:AQtuaFyUXjWpclzkZHJMl-ZoV2wikKAYWhasye7zBNnd-QgmsRmcLg>
    <xmx:AQtuaCOR7NKpd7tWpvH-EGuPBugQBZTJ0viiojXSfhL-_UGrvMFKgw>
    <xmx:AQtuaK9bTPTXBXoi48sY8_SUyj9tFyfWoC10h1i2RO6vY4pV-vXxyQ>
    <xmx:AQtuaGXI2qvCblb4ZdcO_4Q5JTfQHiGPK-ib9dCZFpX7uvBxWZ2_ctCn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31334789 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:40 +0200
Subject: [PATCH v3 6/8] meson: fix GIT_EXEC_PATH with overridden
 -Dlibexecdir=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-6-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

In 837f637cf51 (meson.build: correct setting of GIT_EXEC_PATH,
2025-05-19) we have fixed how we configure GIT_EXEC_PATH in some cases.
It was reported [1] though that this causes a new issue when overriding
libexecdir with `-Dlibexecdir=`:

    $ meson setup -Dprefix=/tmp/git -Dlibexecdir=libexec-different
    $ meson install
    $ /tmp/git/bin/git --exec-path
    /tmp/git/libexec-different
    $ /tmp/git/bin/git daemon
    git: 'daemon' is not a git command. See 'git --help'.

While we correctly propagate the libexecdir to Git's GIT_EXEC_PATH, we
forgot to append 'git-core'. Consequently, it cannot find its binaries
anymore.

Fix this issue by appending 'git-core' to libexecdir. With this, things
work as expected:

    $ meson install
    $ /tmp/git/bin/git --exec-path
    /tmp/git/libexec-different/git-core
    $ /tmp/git/bin/git daemon -h
    ...

[1]: <66fd343a-1351-4350-83eb-c797e47b7693@gmail.com>

Reported-by: irecca.kun@gmail.com
Based-on-patch-by: irecca.kun@gmail.com
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 02d73188537..ffb1bb61d4a 100644
--- a/meson.build
+++ b/meson.build
@@ -1599,7 +1599,7 @@ endif
 git_exec_path = 'libexec/git-core'
 libexec = get_option('libexecdir')
 if libexec != 'libexec' and libexec != '.'
-  git_exec_path = libexec
+  git_exec_path = libexec / 'git-core'
 endif
 
 if get_option('runtime_prefix')

-- 
2.50.1.327.g047016eb4a.dirty

