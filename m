Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA86FC3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312186; cv=none; b=YTQUfaBVjsHbZ0kWa2zTnfsz7rta3DGcXy0pGpHVnmGJ/Zd803xvNggZrDw83yw2bzhvajGQQpHZE/J7nRY1rqypR+T3RBgO3zReaWcQ/xloetlzSp7zEDid70751E2Lj9Gt/xsYAZBKF1MmqViMJ7QBlutfsD/lerRLF49Oo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312186; c=relaxed/simple;
	bh=313XSdoETwMJzxe6bb11uCkgEh4q9LEGQOsZd64pYQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fl97Ky94/5xNKKi8DyC9Hh+XPTXYV4wfivUoguMobS0ifVZhsnnWrZnW37+7SsxFO+BL6xFMYqUCILvcu2J4ISlPVMz/JZ8nVNDIm4tQDlerIGAyxXe7dW5RRhGMCgfvGPDDDvS663OMnHUvp/1+3tFXoqJAnBcgeoGyR+fYDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NLDlJIix; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NLDlJIix"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8C3755D4EC;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=313XSdoETwMJzxe6bb11uCkgEh4q9LEGQOsZd64pYQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=NLDlJIixDyr+HdGV+9fIjbC50NIlxO/+8PZRU5mKJ2Dago1L5tsWsTMX9n7o0FrM+
	 57jDLqsgWHGjDRCrl+wgx7VXI5YFIGdQ1HYNp5Jzh/YkW8D3WqQwGBrKeagoWx4BAQ
	 aHmrkXweTmhtZi74nydfmiI10PyNUU00GHbu9r26Dz+IlrJmEU9n59JMjC1iZMFfeK
	 g21btcOop7hFs8UdyaIr557QKeF3pbCf6YMnIGCApJD8bg1X9fSFPxdHwEPK9foJHr
	 O5eYYqMSMeqn/Kc+Tl0iQevlclIimkBkHX8ylV61z1voZgc2O8lDzb2AmslDg9rHvE
	 Q6BT9K72FTmcAbiox1ZXvV55r4zzHPlEFHorP4dIhccRZ/YKR+ydsVK0XskT6MBPIz
	 RHm5pAtFalFIuwNxpR2PdhxES07HFRBV5HPXse2LTMg1MaAFZb/2B1n22X16Ppri3s
	 mwCxUJhJdXLvsHZxBRTFi968EYVd5aXTPXnS6Ga9+chc2tvrWK+
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 11/16] docs: set a limit on credential line length
Date: Wed, 17 Apr 2024 00:02:35 +0000
Message-ID: <20240417000240.3611948-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240417000240.3611948-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently introduced a way for credential helpers to add arbitrary
state as part of the protocol.  Set some limits on line length to avoid
helpers passing extremely large amounts of data.  While Git doesn't have
a fixed parsing length, there are other tools which support this
protocol and it's kind to allow them to use a reasonable fixed-size
buffer for parsing.  In addition, we would like to be moderate in our
memory usage and imposing reasonable limits is helpful for that purpose.

In the event a credential helper is incapable of storing its serialized
state in 64 KiB, it can feel free to serialize it on disk and store a
reference instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f63a8e0458..4bbf2db9ca 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -111,7 +111,9 @@ attribute per line. Each attribute is specified by a key-value pair,
 separated by an `=` (equals) sign, followed by a newline.
 
 The key may contain any bytes except `=`, newline, or NUL. The value may
-contain any bytes except newline or NUL.
+contain any bytes except newline or NUL.  A line, including the trailing
+newline, may not exceed 65535 bytes in order to allow implementations to
+parse efficiently.
 
 Attributes with keys that end with C-style array brackets `[]` can have
 multiple values. Each instance of a multi-valued attribute forms an
