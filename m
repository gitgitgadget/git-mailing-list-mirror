Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FE34F48F
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612632; cv=none; b=rVbATRw5ij4BEPown/MRepqPJpnXIbo6DHMV8NWiyjZsIkKA+HD8HQ/TSvVjho1EmUzttDumCDF/6Fqqt7cCfFBwe8eyS8NY9oA2aGuUhuV+Xssb+oIxpfzg/FsutXSueF2nGoYjmSSnAZH/nijJT8HG2u0fTUeh6Xw7zEFeWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612632; c=relaxed/simple;
	bh=N2LV1RfG03f+2FqKLDLQn2mvgOuWkTUixzZpwqDwD8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCkuDr/GKfEomhlO6XrxAmpPqC9xi/Po5FW6fTQqt6SSadDe4QF+vsWmqNQZ75z8A4roZdOXU8ODVo1CfwLx+46QwA6fFntEWP9xzeaDKFWP/YUJCI6JkzP0KBAmLI5e6juhU7v3CT9ZqqJhp1lj8zCrj/udUJofJayt+jn/jTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iv00LciO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rGPLFlCc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iv00LciO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rGPLFlCc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 414201400224
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 03:23:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 03:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772612630;
	 x=1772699030; bh=KBnvxM6I1VkxnmELLChCEzJ5CVXIs2rf5D7tZS+1noA=; b=
	iv00LciOuk4sph65pHRISb3kO+f15GmGuCc3RC781ZuUhkbbbsOqvJ13PTMkEqjH
	DxosGozVd7qKU8kF6b7D7nOozy7kfhQxgTWlan/rnE89elfwQOSMz+B/tz/WSJV5
	vQTpodJTdY8HBM2bUgqJMUCJy54hzeeAxsaUu2Ds5bi6TiVs78sCStPVqirjjIki
	uxy9p/B2D3GDLLvPXje4TsY/DM6hQQ0G4geZDnTEzSzLSbHt28skn9SsFL8vuzmA
	M4KOUEOW1wJ/l9Pps0z+ZjTmEkelhXLlsNe9chICdjqqHX4TbGkvtfWQV5BEkXLp
	7pg35Qd24WtNi3oKioU/yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772612630; x=
	1772699030; bh=KBnvxM6I1VkxnmELLChCEzJ5CVXIs2rf5D7tZS+1noA=; b=r
	GPLFlCca1OmqetYri2G/Lh2RV3adcVF8MNJbUCxOp7tAB5JFfnMZCZDQCFn8Uq5Z
	L/UK0ZsNglq8Ow7kHuRVosmpkCOURTxk9zFCtxssMgDRVCho+ahQpjflbnlBMndU
	ElY1YAFE0pr89Xu8ElExgOUqle409yocHdgUxr0fV3eHgRNc8izA8UYrZgfVWwU1
	Mx66YuNl9O9Was+Jim7ngHYn1DM7R3rdEMX0bjTixsLbw56jDkDoaw5nxftfhmUW
	RMMjkv1qFBPFtce+9170LnXWA/NzhwSQMzGXYY+4HDQDgmKniPJCQvXMfG/cLue8
	N44yWIpXBd+CYTezwoSNQ==
X-ME-Sender: <xms:FuynaZJ4fAGgqjgtcaptd8tHanpYQxE5kT4jg7v2t7KoIY-jHwKsZA>
    <xme:FuynaXLtDLXzxnCpTGTSg6Yts62qVQRVdIb86OiIHTKmb9P5dMAly4Wm8MKPY0atC
    S5WvUeTedbVg_W3m9d2AIS1szECKsp65wZvGP4iq8DWovdz6Q>
X-ME-Received: <xmr:FuynabEGY91V_3CulJ0LJELFgA-p0VYry4GO-RAD8A9ZagDj23x3rfRTrLl-yMR1y-PKryVqhq3bqKpkyAXpbcYk_10xEK0FjID24WwgRN1Nqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpefgleejleekveetgffhudejhfetgfdtfefhiedvgeehfefhteetgeeitedv
    hfegveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmrghkrdhinhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FuynacnUfYV1Kb2bd1uE2Sf3t_KkzWde4wxzJ_gw1hoiXdSNjRrduQ>
    <xmx:FuynaYIctxygd_bEQOzUMAsviGLSkecz67ss5wv6ghGyvHY-ARSJBA>
    <xmx:Fuynadb4atA_n-RRHeZgLJ-vnNzqaH0TEWNAHTsSLGmvPCoZa4DpZg>
    <xmx:FuynaabW96o5PDtONfEYdr14AZWaYwEM2fTbk78lFIrgpG7prbHvyA>
    <xmx:Fuynafi9231lxs-hw1GsHhyDVnKhsQa1LCXaEcUUmzlofWOnPvh2x7Sy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Mar 2026 03:23:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5b33c23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Mar 2026 08:23:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Mar 2026 09:23:01 +0100
Subject: [PATCH RFC 2/2] Makefile: deprecate autoconf build infrastructure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-pks-autoconf-deprecation-v1-2-f5b611b13138@pks.im>
References: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
In-Reply-To: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Git currently ships with three-and-a-half build systems:

  - Our plain Makefile.

  - Meson, which has been introduced rather recently.

  - CMake, which is part of "contrib/" and used for Git for Windows
    development.

  - autoconf, which only counts as half a build system as it is
    integrated with our Makefile.

Out of these, the autoconf infrastructure is probably by far the most
unloved one. Its syntax is arcane, it has bugs, and it is generally not
recommended to use it. This has led to a rather long discussion [1],
where the project had general consensus that this infrastructure is not
exactly loved and that it'd rather want to get rid of it in the long
term.

This discussion eventually led to the addition of Meson as a modern
replacement that can cover the autoconfiguration part of our autoconf
infrastructure. Meson has by now been around for a bit and has generally
stabilized over the last couple releases. With the recent addition of
support for gitk and git-gui it should now support all features that are
required by distributions to use it. In fact, some distributions like
Gentoo use Meson already, and GitLab uses Meson for its production
builds of Git. So it should overall be ready for distributions to use.

Deprecate the autoconf infrastructure so that we error out by default
with a hint what packagers are expected to use instead. This behaviour
can be overridden by passing "--disable-autoconf-deprecation", so that
distros have time to adapt to the change. Furthermore, packagers are
told to send us an email in case they cannot use neither the Makefile,
nor the Meson build system, with a hint why that is.

Note that the date for removal is set to Git 2.55 for now. As the change
is generally not user-facing but rather packager-facing it is not
considered to be a breaking change. That being said, depending on the
feedback we get from packagers we may adjust the timeline to match their
reality.

[1]: https://lore.kernel.org/git/GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 configure.ac | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/configure.ac b/configure.ac
index cfb50112bf..d7e221f62d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,6 +148,38 @@ AC_CONFIG_SRCDIR([git.c])
 
 config_file=config.mak.autogen
 config_in=config.mak.in
+#
+# Deprecation warning for the autoconf build system
+AC_ARG_ENABLE([autoconf-deprecation],
+  AS_HELP_STRING([--disable-autoconf-deprecation],
+                 [allow use of the deprecated autoconf build system (use Make or Meson instead)]),
+  [autoconf_deprecation=$enableval],
+  [autoconf_deprecation=yes])
+
+AS_IF([test "x$autoconf_deprecation" = "xyes"],
+  [AC_MSG_ERROR([The autoconf build system is deprecated and will be removed in
+Git 2.55. The autoconf infrastructure had been generally neglected for a long
+time: it is missing features exposed by our Makefile and has bugs that went
+unfixed, and its use has generally been discouraged.
+
+Alternatively, you can either use the Makefile directly, or use Meson in case
+you depend on autoconfiguration for your system:
+
+  meson setup build
+  meson compile -C build
+  meson install -C build
+
+To override this error and proceed anyway, re-run with:
+
+  ./configure --disable-autoconf-deprecation
+
+Please note that the autoconf infrastructure will be removed soon, and at this
+point the workaround will stop working. If you have strong reasons why you can
+use neither the Makefile nor Meson, then please send us an email to tell us
+about your specific use case.
+])])
+
+AC_MSG_WARN([The autoconf build system is deprecated. Continuing anyway at your own risk.])
 
 GIT_CONF_SUBST([AUTOCONFIGURED], [YesPlease])
 

-- 
2.53.0.697.g625c4fb2da.dirty

