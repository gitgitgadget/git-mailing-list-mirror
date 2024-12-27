Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBBE1F4E5A
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308008; cv=none; b=tahUGDV4j8OMcT9UPSmZ4pG/S6oruXa/FdN9cBQAROrhOe6mH72D6Aj5OpxjMTzZNFqyp9jln3g6r7v9G8TNIpMXZF2BmCzioufuOO6gkN9/XSbHTsL+72Grju+XOk80X1N4k4fK4CVjWm1sgLF3mk0/FPHDtOdFPgMxA6QlMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308008; c=relaxed/simple;
	bh=B6pbq+SdWGKEWs9j64b5Ix2OZMiU43oUY4O3sUEhJn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAMIBdye/ApEcMa91TT0FwWXoXMt8ebn29BhLqJRe0gjJzH8fshThMNL8wpxTJ8NMmkZJ+cjttwk+Ed+GrRj/VfuVcIP+yOgQtv+lV+wl78aRh1dwmJX1HY2dQ1BdeLjFQYfgUOlFMw8RhF14v8xYcAQIJe0A9c5R2gdD6afhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LO1Z/PYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgAqNSIz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LO1Z/PYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgAqNSIz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10F55254018B;
	Fri, 27 Dec 2024 09:00:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 09:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308005;
	 x=1735394405; bh=8nAzg8w6XZ7KmHa7Y60LEgqORzKvOh0P29yEvSX3ues=; b=
	LO1Z/PYHOmytSinyfg4AVAlFwuSS2kAn+BlilXyqVRdJJJM1r+hFNaS01PyM4Hki
	0vdxQZnborJXsWPOBPiP9EosBjR/UEV5QrW30Yf+XKxEG6ui2xaFxR396pisgqtZ
	WWHQBxq6OlT3EJmRGmZOcTUvVWi75NZZ37Z28kIBrURWRQnEJzKrL2W/A7FJI6sx
	J6zWY4S6q+IOUImSXQDvPsopVMjuYUVa/JJZJ+Vfiz9kFDC+iu+Re9IJ0YkjEeBM
	CndFhgfoBNlFIFunvwlhs8V6gHr3wdiIWSVO2evxVYFbCQn7/HwoZLOwlDGRYgnv
	w/dw10DgMbErTQWB4AXffQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308005; x=
	1735394405; bh=8nAzg8w6XZ7KmHa7Y60LEgqORzKvOh0P29yEvSX3ues=; b=X
	gAqNSIz8oTLn/BRdzFWRT7HIhkb8j+si51F7idT2ZQRcudgzUCq6u78H15dtROGF
	+ozfVuw2KUAIqrhxROgubsCMim83Ss1W3aT7QCInKtfgK+2VIw0gMSHNNtql3kKS
	fSZAcERC0vOYPRysywl793cKyQ5yGqaF5s5KXYyUJtGWTYUBYOmXYaTcGJnp/0dp
	0B8sJEy3U/FKkRM9xPTCvqwKsJdCE8bvg4pxH4QbHzHxEXgBTnCI9iw/tkfYgqTm
	CB2Ev+XaOXg66opB3cDvB5ppmx2rGdgpmLN2KH2RtaU0Xqb8pJYpDqG//YbYp50q
	ssb+a/A2ulFIx5I+1oRMg==
X-ME-Sender: <xms:5bJuZzqnn3jWmWs9oPYbFD_1bYVxHMl2_3_ZI36TExwFD5QjVBeslg>
    <xme:5bJuZ9prpok8iZDrIHUXXZaK5U78bNrAtGCPNNlLZjqGNWlNoHUkzwzub9xAvn57J
    -mlvJsBCNzj6a-aSw>
X-ME-Received: <xmr:5bJuZwMgGpEGS9wb4cJQx07fUJuWAJpxPdXIgbAZWN_aiEhdG_9js4CuWqGndPgtQSEwN3Yne1DXqldBp4mTObQN_S4sZ8gQGNphte8UvoB5ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:5bJuZ26_iaJD-8OOTvQEkIPp_LWyYfUbzX-3RrPb3XAQp6c8wCs4hQ>
    <xmx:5bJuZy4aTxA7qLeYkdkgCbpauwcmNSdD5hzntWhwLIcXegThsgG7Yw>
    <xmx:5bJuZ-gVgopXKN8LY6-x1DX8YJRekKjdsNtDUF3jmlGVp0Hs7uCRjA>
    <xmx:5bJuZ05Vj60M66WJ2GJE3NkXvDxiu78GYLBK3hQZcZKrR9gBPWHrfg>
    <xmx:5bJuZyH_5VLBNh9ggfaCRqSoCGXXKnRXKrugQEN_2l1MWTvSTPV0h2xF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99bd7bd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:32 +0100
Subject: [PATCH v2 04/12] meson: generate HTML pages for all man page
 categories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-4-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

When generating HTML pages for our man pages we only generate them for
category 1 in Meson, which are the pages corresponding to our built-in
commands. I cannot tell why I added this filter though: our Makefile
installs all man pages, so a Meson-based build misses out on many of
them.

Fix this by removing the filter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index c2512328ca9b76a5dd512453ddbb776faea7967f..48583e9a7f4b037de218358f16f59ce08141cbe8 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -366,7 +366,7 @@ foreach manpage, category : manpages
     )
   endif
 
-  if get_option('docs').contains('html') and category == 1
+  if get_option('docs').contains('html')
     custom_target(
       command: asciidoc_common_options + [
         '--backend=' + asciidoc_html,

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

