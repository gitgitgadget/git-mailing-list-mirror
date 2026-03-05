Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F5387341
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709634; cv=none; b=ppJq31lBol7qM3C/BzBW9gT1RsmWtLstJtWuYtva2uHGaLaOqiNHkqppyoDyPNTIkVLesKa3iBDxXKbZvFpuYFS7HVYvsMXybcQi6wFwZ/ngl99Md6dcyfvvs1SlSBrE2LbqxR7P/i2BZV9lrq8SKwG1fj0ttTRiq2/sQdwFA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709634; c=relaxed/simple;
	bh=/Yl4PcIUDujHdWBFgodIcJdiTEhZoqkjwZarAsrTbyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZCV/oVO4pYOif9bcE4d2AH5/E67uqrVw9bYhsGns1LJNMstcQ9TriWg1IYaGThfR6scvQORSUy9HeW7dPlBQlFJeU45jlTt5bDipX3dqhAnyyNOdl1128TaUkHIJNG/qjbM+M0vLSeyeC5vIgVgkuyftHMUuuxCtpVBdn8aOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UTt8CMNO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6IS4s/y; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UTt8CMNO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6IS4s/y"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C8FF1D0022F
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:20:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 06:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772709632;
	 x=1772796032; bh=H60Bjg+CbBGPfiNcJjvvEA/2Q42Z00JYlfXG0eghoXM=; b=
	UTt8CMNO1ciVi3MmC8E+ifLrMSyWRgkp+lo60JCWAjGv0Z+TRj/nk0GJu7VKeOFH
	fW8+l5livg0M9rZS636WeMgxJU7/z6Y9w1zUQpxC7ayQCkt54DMc4tUzD9ezzqSI
	7GjIuhBGl4UZGc2lvqaRx6jmoCQAbjcK4fA4o0IfLFEn9mBHdekKRoSWx3XJkbyI
	l0No8hX6zV/Rh7xC31zM57w7BUCOuR+VrK1wynymZstbMNrfDeaRCyGVQClbZ57S
	48vT7UqQrH5jFasa0vZCEL5kSUxhBphBjvoLzA5exaO0sUGMgQejBJI+u3nNF+Ts
	O5oXHcYw5c6PYwnpykoU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772709632; x=
	1772796032; bh=H60Bjg+CbBGPfiNcJjvvEA/2Q42Z00JYlfXG0eghoXM=; b=i
	6IS4s/yl0O7K5EoS9fS7u5cnXAdri9kZ9DukXYYahpu47JSpzz7c3tjkKqprPE2s
	OA3oOLpf/DKsMAgro3klsHMYGqMjJ2IFIiHoRqroBGctNNYP36mciKzFRtjZkQga
	hQ688MYWjHys5qY1MiojDG3Q04DJiGKD/2Y44+TdqBBerWSoePE2XF9vV1qj+nQ5
	do93z5xUU0hTVNa+0TRVqM+L3jJA1vOG0GsNhkqR+tWkHSFmNdVJCndR/WcOOn8I
	X0IMqTCOZJdk4jY0HIu+to7HdSH0fN8d5MDEkpDJ8NCc74xFjsD3w90xeuAkScTG
	8dc4Gwd9K+TDHNtCycOOA==
X-ME-Sender: <xms:AGepafXOu_X7Z4YTmfnU-Y4ZOC18hc59PMMFV5huKEZDdK5OjeIZjw>
    <xme:AGepaehQY0NONlS4UrA3YK7fwBHkX7mZx-RK2-RkA9VR-CCSVloVoa26EWby4xNYK
    8jQ2i696YtAQN2_76j1R7-FdWNrTjBa-YwVwnknDZAbzBIDCDFeGg>
X-ME-Received: <xmr:AGepaRBO_C0Sjz27urqovybsBdNwtppyPoBJvYwv_5f1hKnXboJUrBJZzv4_nXey3NCTtdnITnsfdt0Bb_lMFc_3jvgl95R3P5k4En2Tj3eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:AGepafcdxYEWjrZDnVhROCLR6Y8w_-mPesolRUtleiquCP_DdTp1YA>
    <xmx:AGepaZehssxk6UOUUJb3RThaX4tck85llIHChebojI2WnY800wEaEw>
    <xmx:AGepaThkG1DPPzSf-QxWqnqxEc4YSG1AUkyQwdNIwVPs7s5Xm1VVhw>
    <xmx:AGepaVQFU7oguKfAbUu50y1MojqiMjC1kCdw9WGboj7cy8ZjdKHRVg>
    <xmx:AGepaSnZKBNSic20W9r1QXWrRD1BkGk1tS57I-f2Wq2N0enzmlqzDJd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Mar 2026 06:20:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec630245 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Mar 2026 11:20:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 12:20:22 +0100
Subject: [PATCH 2/3] meson: detect broken iconv that requires
 ICONV_RESTART_RESET
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-pks-gitlab-ci-macos-16-v1-2-ce8da0ff29c2@pks.im>
References: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
In-Reply-To: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In d0cec08d70 (utf8.c: prepare workaround for iconv under macOS 14/15,
2026-01-12) we have introduced a new workaround for a broken version of
libiconv on macOS. This workaround has for now only been wired up for
our Makefile, so using Meson with such a broken version will fail.

We can rather easily detect the broken behaviour. Some encodings have
different modes that can be switched to via an escape sequence. In the
case of ISO-2022-JP this can be done via "<Esc>$B" and "<Esc>(J" to
switch between ASCII and JIS modes. The bug now triggers when one does
multiple calls to iconv(3p) to convert a string piece by piece, where
the first call enters JIS mode. The second call forgets about the fact
that it is still in JIS mode, and consequently it will incorrectly treat
the input as ASCII, and thus the produced output is of course garbage.

Wire up a test that exercises this in Meson and, if it fails, set the
`ICONV_RESTART_RESET` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/meson.build b/meson.build
index ee3d9ced92..1b9be3d36c 100644
--- a/meson.build
+++ b/meson.build
@@ -1060,6 +1060,32 @@ if iconv.found()
     ).returncode() != 0
       libgit_c_args += '-DICONV_OMITS_BOM'
     endif
+
+    if compiler.run('''
+      #include <iconv.h>
+      #include <string.h>
+
+      int main(int argc, const char *argv[])
+      {
+          char in[] = "\x1b\x24\x42\x24\x22\x24\x22\x1b\x28\x42", *inpos = in;
+          char out[7] = { 0 }, *outpos = out;
+          size_t insz = sizeof(in) - 1, outsz = 4;
+          iconv_t conv = iconv_open("UTF-8", "ISO-2022-JP");
+          if (!conv)
+              return 1;
+          if (iconv(conv, (void *) &inpos, &insz, &outpos, &outsz) != (size_t) -1)
+              return 2;
+          outsz = sizeof(out) - (outpos - out);
+          if (iconv(conv, (void *) &inpos, &insz, &outpos, &outsz) == (size_t) -1)
+              return 3;
+          return strcmp("\343\201\202\343\201\202", out) ? 4 : 0;
+      }
+    ''',
+      dependencies: iconv,
+      name: 'iconv handles restarts properly',
+    ).returncode() != 0
+      libgit_c_args += '-DICONV_RESTART_RESET'
+    endif
   endif
 else
   libgit_c_args += '-DNO_ICONV'

-- 
2.53.0.797.g7842e34a66.dirty

