Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF862D9EF1
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535033; cv=none; b=TbGtinjBHlN4rok69Dy5VkOOjEkjac+r7lJqtzrR4S8EyEalfMdi6iUkLxQYglcJIC81vuZgyRxnmZnByst5zBEAtQEWSakteUhpEEAZHi2fSdaxrnZQGBaWdB2O7Mv2LiCR8sTI1JadXFHTri788dNLsKJMYBobMGr5K3HoadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535033; c=relaxed/simple;
	bh=P0JTjd2RPLT0j/TkBAPo98N778vFQh6OhRsPZc+Q20w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/zt7lvewJsq0IVWf6Xon4lmZNAiux1H+SCrSgwy7cvDsKzNOs43t5g8HaRCjzpXTa3P3q4mZBgDk3u+N0xQctVBbKBYdviNILy9c/yyccHvgfF0iRzvidRUHAbX3qECYZ2jmkQL1JTjNAJFmwSTp7+EaFyDa8hona6+kF+/5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RMziJEe+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSmOO8Ng; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RMziJEe+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSmOO8Ng"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 78C8A1D00298;
	Thu,  3 Jul 2025 05:30:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Jul 2025 05:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535031;
	 x=1751621431; bh=EH46pZ09Tg1RnoZ1ARn/5nnxg8onKDznyyMv3YvVzcs=; b=
	RMziJEe+wPcQ+LK2K97t6BIDrG5W8mYUxJI+GKhwRAZCDs5iXJ6/vWfAtW+vQXYH
	VE4hlBb3cuu5ivH0kZr6HLAz7sFXDGe4/94E67WUVuASK5hpGamA9Z8rThynpLWd
	im3hvSAt7H9mDyb2n0wlU+BUGXArqML/OvK7AmDv/ouZHPhenC7orQruIX7gbZJA
	rvSJhcBPu6Eor35ayyu6ebNG2njWrS0//aoAhbb3LKxPp/77ArXzeS01n/Zy9exl
	FlOifY1RdKotM7NYGfUxNBneNXdumsyzAK213KvzH+AdWJ2zTVYPZZLK6Y39k+NS
	eRwuFukzqf4wpB0S5ihCEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535031; x=
	1751621431; bh=EH46pZ09Tg1RnoZ1ARn/5nnxg8onKDznyyMv3YvVzcs=; b=f
	SmOO8Ngt+qpKs3Zr5lecXwgOzIC7vnRu8VX1yEYJ5rFavssecjx7xuypfM431jAl
	JmUn/WeejArff4/rY1+5ylAtRw+W0Odg73EBMZ+M8wG2cNR8wxL0QLd7cu5fM70/
	+SveoQ93RvEFdVjH6jsi6pv0047YLyXAfvA5W4uEwyEGffjd2khTHVQWYDZABf/F
	7hf6P3ePVbHmG11vj1z06XGCMQ8S3nyW1e/pqQ8ltMQ/OmXe2SsazcWVEBpOsjnt
	10W072Ye4VMpTMhWjOAghVk+JKiy7hZgMecQ8w83mABvrYAmFdyS/Vao50tEwrD9
	h9jOvo9rlTKo8nJ54QFdQ==
X-ME-Sender: <xms:t01maMBi-dfqZzQBIEd8bnaR0Jn6TsFOlAfIKjEy4pBfA2v4Lh2Brg>
    <xme:t01maOin3dQKrUtGHaW8oPSMgty5I4wv661jPqm1WhslJNFGSzRmCej1lQDvDOoZ4
    X9ML_fiZzaYjLGXXw>
X-ME-Received: <xmr:t01maPlFe7jOWq21N3p6vuFep-triUxqttqEsoYEjpFioRpgOe3kKHH26tvq1qzmeSgmBkvATjx0sFdypxjKnxa91xgXdlgizBU2RA5kwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgih
    jhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhg
X-ME-Proxy: <xmx:t01maCztyQGClg0-YpZemzyxes5lb1ZAdK3C4wSB9X0u68qB046JYg>
    <xmx:t01maBRI4zYgQjFZ_oy9i2jeAIrRAOcOElJKzqaALXfIQ8dlpjWYtw>
    <xmx:t01maNZE3txE7OxIGzVgWEFbVYqTC8kAJsFwxUTdi495BlZLFjW_FQ>
    <xmx:t01maKQkYTg4dJC1vTg_LbP2ykESEOhNpx6DBKsCcyvabVJmr28Lrg>
    <xmx:t01maNdT2ZnXdfJcwd6lsOKdRt5fY3_eElCmsiPLNNl1-GZT0cULslqq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ce6ab68 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:48 +0200
Subject: [PATCH 6/8] meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-6-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
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
index bef80b118a8..0da14255820 100644
--- a/meson.build
+++ b/meson.build
@@ -1596,7 +1596,7 @@ endif
 git_exec_path = 'libexec/git-core'
 libexec = get_option('libexecdir')
 if libexec != 'libexec' and libexec != '.'
-  git_exec_path = libexec
+  git_exec_path = libexec / 'git-core'
 endif
 
 if get_option('runtime_prefix')

-- 
2.50.0.195.g74e6fc65d0.dirty

