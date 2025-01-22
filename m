Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D65212F98
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547561; cv=none; b=pkzEq13utPUA3vYGZs8OsSuPalEX3pD33MyY/JUn+Wz9u1dpQnRuMJ/fKZhGtTht8+BFxum7+gUv6G2+6IvR6ioVUPljUyV8iHHDXiLpy1DXmOZOvHukAVCt9dod3oWYl1nTm2KYO49oWm1c8gE5zAw232+24AkxDNzD1DvtdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547561; c=relaxed/simple;
	bh=tyFF+1nKiTv5kl4t+C710iKJn5V23uSpfqznsa5NUB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxlQ+H/96tV08hPYup0ZeRKG386NOwPcHuu3pwg9qsTlU5ndpC0oKznB09+v0rnLV6d24ZLvoLLuvn2MVNrQR7G3ZmrnzCuNy3mswICDxd1JtLkQzEm3gqjfVwt4fx4mFITPmNkxOwpHxISuFNwlUV9eUjJ+UU2TRZSZCmix6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TqxPJU7z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVCUXiAF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TqxPJU7z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVCUXiAF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 539ED1380832;
	Wed, 22 Jan 2025 07:05:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jan 2025 07:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547559;
	 x=1737633959; bh=vjkplmel2ZgGrKirTPzkfZFEFUIRmhwELw4zrep17Vs=; b=
	TqxPJU7zrbsQ8g+WwUfoaVv8bf2ATkQYiz+PLDVulppHCYVSu2tir1hWrpPy3yNe
	v8IZLZqGcVQNk5GrB11eeOnuCvfr+kwie8mfgb41eH3UaJd20sA5/Wm8d3CUJOfG
	w4nzR2Lr8lG6eP6MELz4UrvU6I+nSTJIwUWWF1UxKCWfzDC8WQdz/1ADdktgu2yh
	TozcOACL0l7ICHKnaumy/FD535oNwKjD9AGScHLN7OlVEK7MB1ZcMneSBWkcE0Vq
	JuUKDCaVYlvtPD2fmo7COvmQ91rDb4dcueY4HiZt11fxU4cnMJswOnWDhVPepLlr
	kXC310SMZChRTLe40P7tDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547559; x=
	1737633959; bh=vjkplmel2ZgGrKirTPzkfZFEFUIRmhwELw4zrep17Vs=; b=L
	VCUXiAFz2bC7WUHaxhFUnKR1UgDNrLptp170nXP4HqgBj/mNSXcZ9d9n4SmfkUU6
	ktCs/uiJTyjpXPshPoZfSi8sU3hTHHSx4HI0BxOgU+voIGMQGwOxtrXsGKScYLgq
	lZRW3K60g8TTbxhgKurMCMgogFKJQVgjfbT8ifVL3tAUt7eAO8EYqlv6Ngf0/x/N
	lbWoXuF/kCIZf17wyEDoM8rHg0Xap4gAFLpNmXWNzQInJMHcFFknomogfQ5dt2n+
	cMyOFVkL5xS6Q91l+jUN+CSdY1otn8Gl0ysqfxgIoPDW0TTSAh6n8V1VNDnKssqU
	pD1MQXD6TQWzXDaUlbfUg==
X-ME-Sender: <xms:J9-QZ5CzAHUUqePbr3T7vZKFkoLcr3SscRexE7c2PKwkRPEDWUFiIw>
    <xme:J9-QZ3jwVSNUkPep2QIGQCNV33kck5c9aEh3x8GMuIoe5I45TJdBStZV-OiBuTbmf
    uVnIAe6jHTP2uFWQw>
X-ME-Received: <xmr:J9-QZ0mLo_cv0PYNklAeVmv51DwASFjn_2JaYlhFnGZAfcPCauGKl5dDjTe4x8kRfoDZABMMJXHnZBY-bTr7Kh7cA14Yru0ePi8x5AzTSpARt0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthho
    ohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhgpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:J9-QZzxQ9VnxUkbAEJ-1rF1FnqR-h1_n8gNcHfzW2Iu8EVli675twA>
    <xmx:J9-QZ-TVHO9Ym1ijsfhJ5JI1-qDu6utRa0ShF2HyVXxVQgT8QnONDQ>
    <xmx:J9-QZ2aGiB79Q9yX7umP835I5PnrpnmQlUOp8G2dvS5cEYyis1_eiA>
    <xmx:J9-QZ_RuhnXIW9M0d44NW7kKu4EiOq_naYuX8wOskmalWLCWko7-6A>
    <xmx:J9-QZ9EcQr9paIGj7KXJmBvCJh_SWpo5ww_nRtt_he9GVdBk63aFzROg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4159e3d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:49 +0100
Subject: [PATCH v3 06/11] meson: wire up generation of distribution archive
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-6-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Meson knows to generate distribution archives via `meson dist`. In
addition to generating the archive itself, this target also knows to
compile and execute tests from that archive, which helps to ensure that
the result is an adequate drop-in replacement for the versioned project.

While this already works as-is, one omission is that we don't propagate
the commit that this is built from into the resulting archive. This can
be fixed though by adding a distribution script that propagates the
version into the "version" file, which GIT-VERSION-GEN knows to read if
present.

Use GIT-VERSION-GEN to populate that file. As the script is executed in
the build directory, not in the directory where we generate the archive,
we have to use a shell to resolve the "MESON_DIST_ROOT" environment
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/meson.build b/meson.build
index ab4f229436..a59072edf5 100644
--- a/meson.build
+++ b/meson.build
@@ -1947,6 +1947,19 @@ devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
 devenv.prepend('PATH', meson.current_build_dir() / 'bin-wrappers')
 meson.add_devenv(devenv)
 
+# Generate the 'version' file in the distribution tarball. This is used via
+# `meson dist -C <builddir>` to populate the source archive with the Git
+# version that the archive is being generated from.
+meson.add_dist_script(
+  shell,
+  '-c',
+  '"$1" "$2" "$3" --format="@GIT_VERSION@" "$MESON_DIST_ROOT/version"',
+  'GIT-VERSION-GEN',
+  shell,
+  meson.current_source_dir() / 'GIT-VERSION-GEN',
+  meson.current_source_dir(),
+)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),

-- 
2.48.1.321.gbf1f004a4a.dirty

