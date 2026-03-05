Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B14383C85
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709631; cv=none; b=aPCEJ9sUtDyTapBehLgwBJofpmss/w5tnGsUppry6xJ2iIpOEckwNan9B3kY6XbB68UI9Syx93ALL0Xq1fXLo3Fe4N+eXSzOA51RR2vcCyamcY4bxRNAk1eCRlQMc+iw97wlDHcLW8d3GwjWDyvESQrfQgB+Rh7I6v27cGnQn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709631; c=relaxed/simple;
	bh=CiZFmdZa4W3YJlXQxpjMu8zYQxJHysRwN95eO7F2aI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcLZrYL8ToOHW8ejLcz+YGiHfYxdBU9NWcPu9XKR0y6yXn2dinVaErc4LP+YMxMTjGtJTmknNHqyoZTI/UoLb2nj40TDICVIA/0EeRV4DJTuL/ryXvXgtuxMMDUKENCVrIcsYsLI4LaMGYYguwB4tvohq2CMsj/syqPu30GpxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hx6fwwJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPUOnLET; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hx6fwwJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPUOnLET"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AAF47A02F5
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:20:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 06:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772709629;
	 x=1772796029; bh=UPGnyZWszEg6aG0HmonSURRo2yZ8ar2siVoMT0KxNWY=; b=
	Hx6fwwJxK1y3Y6i8fGv43UFL0qfDaQ7iAc2eb4YZjTHoQ1KWywBWiGm5MkyrC6+I
	YThgC07a/aEVGIWsrfzUXK+e3QvDdJhFeVI+mW+uMMgaGWFv7Ws997Mfjkd0mWP4
	K6N/D16xKiYjcrkN9QCeiOIR5u8hWi68HXBus7c0+uxfM5M35k+tDNNr7EvjXecD
	8ZJSjggKl09di6/xTI+6u9mfgLbbEX8iHeEAVHzDIw86An6XxGF5mFM+FH+Ndzdt
	LCNRB6i8/14ZbXxMWoX7Ag5A7FyqAGLCmFILaKFXJXuDaIwO3ymAgl8Mksc31anl
	Braks0qDVO8k0LvJ7tVY5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772709629; x=
	1772796029; bh=UPGnyZWszEg6aG0HmonSURRo2yZ8ar2siVoMT0KxNWY=; b=d
	PUOnLETFEn/1N+dFpOCkv45SfhmGPHOwW9ZzLLOi1mPtt91FUxhXv02ZEK5TqaYc
	//FNK1yhgIZdllDl4gHMnjL/Qjr4CUHTxXxCItd3rgJphtMNIPFUU8EiI1uxrhHE
	88aws1VT9hoVUVa42DEBQQ5BB0QF72vYLmKekv5k7oLDHBdYm5UnAtnkCUvtCxQw
	vrXAD8LZPT2vu1ve9Tmp8qIZHMJS5OlvLLMhkRWQsFQ000LU3YJ+7PS7SlAgCpwq
	aXOXRdQNxr1LMfkvfFJGne9g0HOyIp9Rx3ANtSyVurVjWqybEoFvGJUsUAeNVFWg
	7mdBHfROcxJL+M/punzDQ==
X-ME-Sender: <xms:_GapabbuTU88EwWJCbpRyJujCccF_MO2UM7xrqqPffGIaIJV_l8lGQ>
    <xme:_GapaRU8DlMK-Htprzv4vEoqJgnHyuWwEyAQctX3f5SlhoaBwBmiCLKcASivcG6TG
    39iGs3lEHPlSUdPNIuUHmo95_0bkKTxbiq7lz5bFHtibd0HEtfllA>
X-ME-Received: <xmr:_GapaTneiDyDTJ_X-XaLW3v6fongwUsANZ4IMX7_C4OVtdC1ybnBEWtwDS5n0pbPkADDKX5xHyPnzY646bl9OozlRyZwbUWzxkMdU8fpaAL7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_GapaWxV73CrSCSzaT840uGmnRdpY_rG30UkmH7aUlJDkEE5wjhBVA>
    <xmx:_GapaWhcWyUbG_zd8VBXl42NjqmEtwjVNNiOpITymK4IPJ4axUGNEw>
    <xmx:_GapaTW1dh6tSThtAJipl7s2IM0jWprc3UkVvu0W18gxxt1c2eXcAA>
    <xmx:_GapaQ3PM7HIzLIKjeR0YlT6bfz3Kt9T2xWLR4pIqygOYek-TrZB2A>
    <xmx:_Wapad7XUyI6SeArCR5a9FVgX3fgWsVTaxArt80k95ODdQAuygaao2_P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Mar 2026 06:20:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17e62bcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Mar 2026 11:20:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 12:20:21 +0100
Subject: [PATCH 1/3] meson: simplify iconv-emits-BOM check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-pks-gitlab-ci-macos-16-v1-1-ce8da0ff29c2@pks.im>
References: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
In-Reply-To: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Simplify the iconv-emits-BOM check that we have in Meson a bit by:

  - Dropping useless variables.

  - Casting the `inpos` pointer to `void *` instead of using a typedef
    that depends on whether or not we use an old iconv library.

This overall condenses the code signficantly and makes it easier to
follow.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 56 ++++++++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/meson.build b/meson.build
index 4b536e0124..ee3d9ced92 100644
--- a/meson.build
+++ b/meson.build
@@ -1040,42 +1040,26 @@ if iconv.found()
     have_old_iconv = true
   endif
 
-  iconv_omits_bom_source = '''#
-    #include <iconv.h>
-
-    int main(int argc, const char **argv)
-    {
-  '''
-  if have_old_iconv
-    iconv_omits_bom_source += '''
-      typedef const char *iconv_ibp;
-    '''
-  else
-    iconv_omits_bom_source += '''
-      typedef char *iconv_ibp;
-    '''
-  endif
-  iconv_omits_bom_source += '''
-      int v;
-      iconv_t conv;
-      char in[] = "a"; iconv_ibp pin = in;
-      char out[20] = ""; char *pout = out;
-      size_t isz = sizeof in;
-      size_t osz = sizeof out;
-
-      conv = iconv_open("UTF-16", "UTF-8");
-      iconv(conv, &pin, &isz, &pout, &osz);
-      iconv_close(conv);
-      v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
-      return v != 0xfe + 0xff;
-    }
-  '''
-
-  if meson.can_run_host_binaries() and compiler.run(iconv_omits_bom_source,
-    dependencies: iconv,
-    name: 'iconv omits BOM',
-  ).returncode() != 0
-    libgit_c_args += '-DICONV_OMITS_BOM'
+  if meson.can_run_host_binaries()
+    if compiler.run('''
+      #include <iconv.h>
+
+      int main(int argc, const char **argv)
+      {
+        char in[] = "a", *inpos = in;
+        char out[20] = "", *outpos = out;
+        size_t insz = sizeof(in), outsz = sizeof(out);
+        iconv_t conv = iconv_open("UTF-16", "UTF-8");
+        iconv(conv, (void *) &inpos, &insz, &outpos, &outsz);
+        iconv_close(conv);
+        return (unsigned char)(out[0]) + (unsigned char)(out[1]) != 0xfe + 0xff;
+      }
+    ''',
+      dependencies: iconv,
+      name: 'iconv omits BOM',
+    ).returncode() != 0
+      libgit_c_args += '-DICONV_OMITS_BOM'
+    endif
   endif
 else
   libgit_c_args += '-DNO_ICONV'

-- 
2.53.0.797.g7842e34a66.dirty

