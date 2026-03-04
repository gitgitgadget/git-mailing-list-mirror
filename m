Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446F38756E
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612630; cv=none; b=haXhFqHdFmZjo5qCZc6wmu4V8RgMSo4lGoBSuw/v//SCDaoYtKzalOFuoEEUd0lwRgPQ+dFXX0rHnh2cgNMcRuUNjA9oW5NjxWWfi5wgEdAMOi2FEOcSuNE8etHCbdnxiOL3MrHlz3WCzxYbMvppIDGU1U7vQ35zzyv7qaU45k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612630; c=relaxed/simple;
	bh=LezNXxeLyhR2R/Pjm7qIZ0T8715ThbkiYVCb7GD83RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrkijeCOmeYkPFpJcmucmHeu/eYEfbjHbA8sTIIf3+YS7PKNi5IwvT/x8bC8XknZraNoIKvnF66Iq6ynzQVqSor1oTeJovjBu3w4NcHvorlU+TXT9xksfZd+p6woM7z2HcZtAqaUKtkk+TVq6QgrhzcpJ9FDWQ0FrPfU19X0RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kF/5N9/Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9bjGquQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kF/5N9/Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9bjGquQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D9BD1400229
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 03:23:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 03:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772612627;
	 x=1772699027; bh=lYYoVVja0+4vJbq10Cuyw4TfSeNqFk1XVM+6e9iky8M=; b=
	kF/5N9/Z+hX6EiberWu4VZ3RkS2RXAb3VevJB7L/Zq5vxIimA4LN9Ro7gZSY5E2V
	dQm5A5igxQHh3kDXJcdWSia5m/6zzi1PRAAwttxTEIwkeNuJv1tYilELEnWBLxkb
	gxQcmGyun+U1DEE8KH2J4OfbXaXiyhZlC/3rpfHd5DofL2x88ErJY618lcsPd6Zf
	TkbfI2CHbR5Efdjes4HfR/XdK0dO4OS9H2OV4y4k0LRUEYaMZgRkIiqf2uwLUmKI
	S5qnXKjhWA9uJvGuD27eAn+Pb3zoXC2k9WIHbDtCYbAmtXMA0x+oJuLbwkQPUzY6
	XZFXZnj6L3OKlrglxujQFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772612627; x=
	1772699027; bh=lYYoVVja0+4vJbq10Cuyw4TfSeNqFk1XVM+6e9iky8M=; b=s
	9bjGquQLU0gK2MoOFsMCgW9X/HWTv5TX6kdOg2n/MuKDy4XYfbNLYDScM0Dhxd75
	ix8Wwfxm2BW6P1XZ/JyA5KkZKvD+fwrJ/LoVmM9ekBdg0bF8O2SspKEDdTG/hrI2
	B0WL6rEy+/fdgk0qR2G7FyFpX2XQS/ENycZpuCXXUICtcvRGl9PDP0AA1RW6AHyk
	kjd1XFDsKfczcDM/VYquKorvceI3v0OsTMV5ylDpzhHuwWw+Hop9LQv10aezKt2c
	gtGQqIaiDOqicdPtPWgrM7AKqpekQU4MYZ4vJmcAiTDZAVYdux5vYAB8nbR5HzdY
	cay0r3GaNcJvm1brD8wdA==
X-ME-Sender: <xms:E-ynadqpIFWJX2Qjykt8uUP-E-aBj6hOt4LwPKSf7vgcf6uQf9_mNA>
    <xme:E-ynaWlCGt8Fv4kWADlicL7AuBIz_NR9n_j3_-iS52ZcS8N88Yv9uVcuXEgcUkr0M
    KtvXR6PCfYykNF7ZG65nnl9T5MKnFFZbvII8JYnZXrfrVDJJo2E7g>
X-ME-Received: <xmr:E-ynaf0Hx1jtX5Wh5Xd-UAZ9auU-gAR0jqS7nAGET28yuVJVhj77IVdrmI9kSiZw-z4Wlev-mTN7--db7wupjvCpsBIYZDt6SQng3N7oBUz1Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:E-ynaeA1ncmIEXtkyt68p8ohFBmUNNydSvicZrwBBytPmf9CiDpqtA>
    <xmx:E-ynacwl_KErPmLNaH9KuBtlFK3DPX1D0iwuzYSI0RGNsCM_dwWQxw>
    <xmx:E-ynaclMDATwCCyINrGa6OtSvic-NBODpH05PshvOJb5Pl7_MP6k0Q>
    <xmx:E-ynaRFRhOzuGkTh9EgKJHVHbr1RPa_a1BIMJbezTLjod22zZN9dcw>
    <xmx:E-ynaVK9yjYpSUGBJ2Kl1_8puYlBL29NbcwzHiBGwYAb0aTokN3iBkU1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Mar 2026 03:23:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54342030 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Mar 2026 08:23:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Mar 2026 09:23:00 +0100
Subject: [PATCH RFC 1/2] INSTALL: recommend Meson instead of autoconf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-pks-autoconf-deprecation-v1-1-f5b611b13138@pks.im>
References: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
In-Reply-To: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We're about to deprecate our autoconf build infrastructure, but we still
mention it as part of our "INSTALL" file. Switch over to recommend Meson
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 INSTALL | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/INSTALL b/INSTALL
index 54d7528f9e..a8b4c7f1b4 100644
--- a/INSTALL
+++ b/INSTALL
@@ -17,13 +17,12 @@ The beginning of the Makefile documents many variables that affect the way
 git is built.  You can override them either from the command line, or in a
 config.mak file.
 
-Alternatively you can use autoconf generated ./configure script to
-set up install paths (via config.mak.autogen), so you can write instead
+Alternatively you can use Meson to autoconfigure your system and set up install
+paths, so you can write instead
 
-	$ make configure ;# as yourself
-	$ ./configure --prefix=/usr ;# as yourself
-	$ make all doc ;# as yourself
-	# make install install-doc install-html;# as root
+	$ meson setup build -Dprefix=/usr ;# as yourself
+	$ meson compile -C build ;# as yourself
+	# meson install -C build ;# as root
 
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with

-- 
2.53.0.697.g625c4fb2da.dirty

