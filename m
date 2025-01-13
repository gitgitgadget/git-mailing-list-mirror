Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5B23497C
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757249; cv=none; b=uGWqkCRx0P5wx34uRW6bev+eu/V0yGZyjKhgdQIEkf4f6C3WVNgq1X0yXXcIe8NUv2FiESKO/oNrghL+tpfKoMAttXGgcwXSqBfjeYcN8pOToCahsaKN7xY4e4I2NWhfQQX4uBC+nWB3qpIUgnE73bxiQKjOt2ols2PDKSa2og4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757249; c=relaxed/simple;
	bh=FpA5vIeMOCqneOSeKl7Sw3yx7qPfUvN7JosfY4NzR0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNZY+7qY3/4QRncXH/1d2oV5ZDSDO7iezLQ2Q3caWRcxfeKnldYyp2i8Q9kLaX9tRYTH468kPcI4P2wLDp67KTDP0jITTu6srQFeRl6vK4IHOmGR5SJYdZdDNbHX7fIAbP8NIaWcDq0+EzYqHgwX+PismeK3JD+pNJxu0uNgL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y9rPeBLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=no6Dyxkv; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y9rPeBLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="no6Dyxkv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC9AC2540184;
	Mon, 13 Jan 2025 03:34:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 13 Jan 2025 03:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757246;
	 x=1736843646; bh=IBtC9pDEGZxGQWr7Kx9n6MowFYngOWCAcp5GLHX+acY=; b=
	Y9rPeBLC0un7XtPms5CEJTINmbbt5tzOHtPvxTP8mm2xQ4r1ylfmA7nTI65NdnzR
	LmmDTemX1Mzyn61lwKtycc96LJxGANgL/pQWT4SdZ6sZAM4T/uP5f5lhUyrjuqhZ
	euk3uZsZVGed6jMufFN+G/Cc3vMo1Xshr/Uj7V+lcTdmZ4UhqOEP8nD7qIrwnDoD
	5IS849bxY0fsE+0y+kClhKpP+Qggjiv1EK92wXR+dfWnDvjN1EBBqPNX1yVFI/dJ
	GG7ms72swXNNwNM6FGGjZldxY5sGtsqjYVDPGWy4DoA/OFNkDatcPBeBN2NnNhII
	dza3D9BVps0pxIftuxOmHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757246; x=
	1736843646; bh=IBtC9pDEGZxGQWr7Kx9n6MowFYngOWCAcp5GLHX+acY=; b=n
	o6DyxkvXXAgh6O+wF4mXxvbH9md5xOUMht/sNzZABL9KTLwlAGX3I6VcDMQPEHtm
	oCr7mazrK9v/zMd+9eUVVXo0SeBvttUbgcWndsZknGjDE3bEJr9q6FC2l66lJ1df
	EqUnVXv0iH3D0CxK0qvoqBQo+acnIHqA/H8MCVVLICO9c/qXSa61hvMFJ1JxsFYv
	ouRQxDyjD4jEvrwyjzUSrEm4m2CjiPaC4VEe3aY7qpi9K0I5HSP+XG823cIYYK3I
	zkBHh/oiixO34fsjYSikS6UPD7128lF9VtaU7tIRHJUOwMqgUEX0Qs0q+Xf5uaB1
	/hgDOySAPVuDQG8V1eBEQ==
X-ME-Sender: <xms:_s-EZ-Bw665D2x9e6Vi5oq47Q_Z6FiVvLt1JAqUXHuOTuJ0NwG1POQ>
    <xme:_s-EZ4hrHpjUnbIJybAM0lMVETA5WQAk975fPKHjd0YTa1rEs2AFt4XmYwVf9zOqh
    ODpFQZQexmdCUkYmw>
X-ME-Received: <xmr:_s-EZxlRUCK-Rz-96kWn6FYmI3DCGpcMyJOjrrRpBWbLbMnYYcFKUy4eqxMzXhykZDMT8USBjMdlHU90kaOmxn9yEp9ssiiwq8qN4TUQkXudxLNe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:_s-EZ8xp_npfIMEVOwvsgaM6c9UcLXkmC5aG0ScD5pY5ZRl6wuh--Q>
    <xmx:_s-EZzQYtJ0cvPm6RapXSr-zjJQfdA_O9syhyQoDoHjOvH0RTUr07A>
    <xmx:_s-EZ3aiQ9xjHojFYqrKLESgZSLUxemW04igL6UdO8H49ES9G5jXjg>
    <xmx:_s-EZ8TBJxhle1HNwl2XJ5Ag3tonm3BhQV-BUO46t4njL-jSMzuaHw>
    <xmx:_s-EZ9egVRFtyoLvCke9tHc65YlRSfuv92lRuKpScF_ka_07FAhzlBFW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00970054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:34:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:41 +0100
Subject: [PATCH 8/9] meson: fix compilation with Visual Studio
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-8-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The Visual Studio compiler defaults to C89 unless explicitly asked to
use a different version of the C standard. We don't specify any C
standard at all though in our Meson build, and consequently compiling
Git fails:

    ...\git\git-compat-util.h(14): fatal error C1189: #error:  "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."

Fix the issue by specifying the project's C standard. Funny enough,
specifying C99 does not work because apparently, `__STDC_VERSION__` is
not getting defined in that version at all. Instead, we have to specify
C11 as the project's C standard, which is also done in our CMake build
instructions.

We don't want to generally enforce C11 though, as our requiremets only
state that a C99 compiler is required. In fact, we don't even require
plain C99, but rather the GNU variant thereof.

Meson allows us to handle this case rather easily by specifying
"gnu99,c11", which will cause it to fall back to C11 in case GNU C99 is
unsupported. This feature has only been introduced with Meson 1.3.0
though, and we support 0.61.0 and newer. In case we use such an oldish
version though we fall back to requiring GNU99 unconditionally. This
means that Windows essentially requires Meson 1.3.0 and newer when using
Visual Studio, but I doubt that this is ever going to be a real problem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index cb352ce6fd50616e3281a776104692c5b2bfa5b2..831da1d43cafe85a8c9ac872e141476adbc08188 100644
--- a/meson.build
+++ b/meson.build
@@ -171,6 +171,14 @@
 project('git', 'c',
   meson_version: '>=0.61.0',
   version: files('GIT-VERSION'),
+  default_options: [
+    # Git requires C99 with GNU extensions, which of course isn't supported by
+    # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
+    # learned to define __STDC_VERSION__ with C11 and later. We thus require
+    # GNU C99 and fall back to C11. Meson only learned to handle the fallback
+    # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
+    'c_std=' + (meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99'),
+  ]
 )
 
 fs = import('fs')

-- 
2.48.0.257.gd3603152ad.dirty

