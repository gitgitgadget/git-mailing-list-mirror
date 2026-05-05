Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E94266B46
	for <git@vger.kernel.org>; Tue,  5 May 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983988; cv=none; b=qGO7WGDhV5nqpaGc2Y2cC/vlL/D7GSXpE/4nYY2H7LoDr8lnSJ5d5HnP8Mx6IMhSBphnPqyrjbV38ORki7KO9jUMU3oMyxVF3zLGyabFbITXRN4JWSqnsPLu0PtjbA1AApID+ak1JOHC//q9zkZNHygB1pmgvzB1cFR+mzeYJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983988; c=relaxed/simple;
	bh=Tn/J0jrPepnbof+AODj1++Vb7p7+DJHO4t+lHpU0ku4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pJ29xyL/wv3jgO5hF0lZXM9rqVO2XW4qAeYcGxNbVaLIVti1UD5vIaPLO/eG6wRG+U4u0tKvgyWnIVG1BqLn1Ul3pRoGwTog0BYs+MHUb+aPrqZC/2gewIm7coqgh7AfnFMpoQpocT+EAxrKZl3efhBHsNKZ1wsbApyUxJQfqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lb3tQ6a6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2FjeoTz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lb3tQ6a6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2FjeoTz"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1575F7A0132
	for <git@vger.kernel.org>; Tue,  5 May 2026 08:26:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 May 2026 08:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1777983984; x=1778070384; bh=p+KLGuhJPE
	b1BpdukhGGCpehI2DgKTTdDrYCfeib2Us=; b=lb3tQ6a6O+v7ZjVOmALADRWGoi
	SkE5jgzLjNZCzU0/sXNN1HYbe/ObqsPDtW2Nz43ohR35MekHHkPVJY3HcaO3Btst
	YB9mtLFmPS4EUpQaWvSJCS5qrn8B+4LWn4519sxR10cDdY427B2nTQmAIGZYvjwk
	O1u+DMO7jVOSrt5e47LzS9fZSymqEjcolC8ycnbrtXDFWoXywjHPKzWyhrOzkKsk
	cRpkYlUL6xfbLpxWJ6V+VOoJBuetAsS4+eWy4PW/FBsCSiN8kqhipoDi5rmfo/Tb
	piB4Z3+4wz/fAR+2dw91u1Qg4sC/26BeIMjbyaUDFg3sa2gBo1WMRyl/Xosw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1777983984; x=1778070384; bh=p+KLGuhJPEb1BpdukhGGCpehI2Dg
	KTTdDrYCfeib2Us=; b=O2FjeoTzquUnpz9rWPKMKcvKjZw2SDtPPcNTGca88Agv
	I8Y+ii64OUDfREfbnaM+oItKdwYhni8dOBpE+byHJglJ1zW4SiahhPXO49fyAphJ
	uhujFEn5OW0zrdqMcdSsB710mRiXdRinXTu7R4rJI1bYITfxm0rjcP8+6b4+xnW2
	rCAjWZvnUntSFInEQIhpzIGfcXsuqP8HAI5CmeLh1bok6HFEctKyDzt00RC9ZJ7q
	fCkkTcOsDlrITCrAoJtoeU3AnTAYuLWQ4hSHOsqqtam9Y5G8sQKR9bUfO0SPgA4n
	Ws5RsV5iVC/Sm17YDZEchHzBoeJ2mi5yTSuwdk3aDA==
X-ME-Sender: <xms:8OH5ab1Qaf73RVKT19v3-eMEl1J5V2j-nOz8_iM6MjiB3Eb1Fs9yRg>
    <xme:8OH5aRBDPezKlBcpVLwH24_fTDJqJbZfg_DRBIyI5yRcHj-S0zBJ6dfj3xv8_LW9H
    sGJcLX3hLxUsvlLwr6FXZXIgihBRzB-xG7diIksieL_J2v_76oBYg>
X-ME-Received: <xmr:8OH5aRhZOM8xMLaz-zX30TeT_3dWRgHjU_6d7z46FT0i7EzN16BxGQu1XDIsBHEcsX9Nz7NE8doGsvMRp_LvfpWsziv-Ai8LnRKoVaxdgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevjeelieegleevleegtdehkeejuddvuddugfethefhteekledujeeiueeltedv
    udenucffohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:8OH5aV8AnzVwOgIpVY-gI4ic2BV7ZEptzzGZ2hAck4zJeDnYOeHKAQ>
    <xmx:8OH5ad93wQnWoS3xp2h5-1NqktMDJE9tbkxmqXWiPHPIAav9OGjOSg>
    <xmx:8OH5aeBQUZ4O0-z6YGGF9C3N04uPNqvBSu_PayrYHMmh0b6_ysRQUQ>
    <xmx:8OH5ady4x1Tq2x_QQwDfQ9gN35IpdinFlCK9Vl-0Ulf2ZDwANWkp3w>
    <xmx:8OH5aY5SRsBHMNVXPVGgmAxY7uWSBGgk8MTqC-ryOlRz2od-F2PzpAzk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 May 2026 08:26:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74e49945 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 May 2026 12:26:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 May 2026 14:26:03 +0200
Subject: [PATCH] build: tolerate use of _Generic from glibc 2.43 with Clang
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im>
X-B4-Tracking: v=1; b=H4sIANrh+WkC/yXNTQ6CMBBA4auQWTtJQevfVYiLdpzWUVJIpxATw
 t2tunyb762gnIUVrs0KmRdRGVONdtcAPVyKjHKvDZ3pjsYai/6A00uRBMs4cHaFMQ7iCSOnShG
 ac2tdCPtLCCeozJQ5yPu36G//1tk/mcrXhW37AOSkU/GEAAAA
X-Change-ID: 20260505-b4-pks-ci-tolerate-glibc-generic-0815aff39ff7
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When building with `make DEVELOPER=1` we explicitly pass "-std=gnu99" to
the compiler so that we don't start leaning on features exposed by more
recent versions of the C standard. Unfortunately though, glibc 2.43
started to use type-generic expressions. This works alright with GCC,
but when compiling with Clang this leads to errors:

  $ make DEVELOPER=1 CC=clang
  CC daemon.o
  In file included from daemon.c:3:
  ./git-compat-util.h:344:11: error: '_Generic' is a C11 extension [-Werror,-Wc11-extensions]
    344 |         return !!strchr(path, '/');
        |                  ^
  /usr/include/string.h:265:3: note: expanded from macro 'strchr'
    265 |   __glibc_const_generic (S, const char *, strchr (S, C))
        |   ^
  /usr/include/x86_64-linux-gnu/sys/cdefs.h:838:3: note: expanded from macro '__glibc_const_generic'
    838 |   _Generic (0 ? (PTR) : (void *) 1,                     \
        |   ^

In theory, the `__glibc_const_generic` macro does have feature gating:

  #if !defined __cplusplus \
      && (__GNUC_PREREQ (4, 9) \
          || __glibc_has_extension (c_generic_selections) \
          || (!defined __GNUC__ && defined __STDC_VERSION__ \
              && __STDC_VERSION__ >= 201112L))
  # define __HAVE_GENERIC_SELECTION 1
  #else
  # define __HAVE_GENERIC_SELECTION 0
  #endif

But this feature gating isn't effective because `_has_extension()` will
always evaluate to true as C generics _are_ available as a language
extension to GNU C99 when using Clang. This would have been different if
`_has_feature()` was used instead, in which case it would have properly
evaluated to `false`.

Unfortunately, there is no easy way for us to work around the warning.
We cannot define `__HAVE_GENERIC_SELECTION` ourselves as that would lead
to a redefinition, and given that the conditions are or'd together we
cannot disable any of those, either.

Instead, work around the issue by not using -std=gnu99 with Clang when
using the Makefile and by disabling warnings about C11 extensions when
using Meson. This isn't ideal, but we at least retain the ability to
detect the (mis-)use of features from newer standards with GCC.

An alternative to this might be to simply bump the required C standard
to C11, which is 15 years old by now and should have support on most
platforms out there. But some more esoteric platforms may not have it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch fixes CI failures that have started to occur due to the
upgrade to Ubuntu 26.04. Thanks!

Patrick
---
 config.mak.dev | 5 ++++-
 meson.build    | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index c8dcf78779..8830b78c1b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -21,12 +21,15 @@ endif
 endif
 
 ifneq ($(uname_S),FreeBSD)
-ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPILER_FEATURES))),)
+ifneq ($(filter gcc6,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -std=gnu99
 endif
 else
 # FreeBSD cannot limit to C99 because its system headers unconditionally
 # rely on C11 features.
+#
+# Clang cannot limit to C99 when using glibc 2.43 because its system headers
+# depend on the _Generic C11 feature. This works with GCC though.
 endif
 
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
diff --git a/meson.build b/meson.build
index 11488623bf..2997d4f90f 100644
--- a/meson.build
+++ b/meson.build
@@ -866,6 +866,12 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
       libgit_c_args += cflag
     endif
   endforeach
+
+  # Clang generates warnings when compiling glibc 2.43 because of the use of
+  # _Generic.
+  if compiler.get_id() == 'clang'
+    libgit_c_args += '-Wno-c11-extensions'
+  endif
 endif
 
 if get_option('breaking_changes')

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260505-b4-pks-ci-tolerate-glibc-generic-0815aff39ff7

