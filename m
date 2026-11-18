Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036146;
	b=ourfHaxyPFCmPXU8ObK2sn8sk0Lu5K2nPtcdRKfX1q3Drg9pjZ0wDsWJlcHRMbSttYIk
	 lUxUNXJKfYfsvHFJhqn3L3tASG/yu0XHdFseZdRTDCQhxES4bZ4zezRPS3/cSRyoVQtIz
	 z8vidCgpWa+VEBpASrXYFeZ6E6NAymFfbUj8ucxjKwf+2Xkj0odKe97eu9L2jmYp1h/v5
	 BmdyJXYrh0Knethx2A+wzUcyBFUx+7+lpmUCwSiTY46DtynjvSegBe1/BjLTAxp/7UVj2
	 f38BVPQGSQTSy8sqV7DYoyijlyXnWZ6R8gJ5RfsAPGhKe5yd8idaeDXwSvQZ3Pq3/uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036146;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NtaHWMC+Xe77DOkXt8faalZonPt4QL67SIfAk8bT8FI=;
	b=LZQRE379kJa43lTYBxj7YjiCwT6CeEkv8YRCCzZ5Ke0AdFwYPYJZ05FmtnyAXb51Knrd
	 CKJEeZUDECWd3r33jKOxbNc9o+ad3fc6c/eK8/lkJ1YG51GI09dCW8SiuvAddq08NyPBB
	 sAkV+v+5JJusZDW249q3MjeAqGi45f7R2AjAr6GNC+19XpbR9rEf042o5nCvVIK1LgTCN
	 dQAJp3cm90bfgaWXUbUxMpIXFz7WyWdWZw5sDgYlI9Bt75SHY5eSPDCU9MYZll2S+2ts4
	 RZGmIM4HRdgN32zVtjkjKjC/WHCxh/yVakVGerYOMOcRSM54QI//JccNgfBOtWmYWRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=fyAh+LeD;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC3606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04DC3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=fyAh+LeD
Received: from lena.gouders.net (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIL8tdQ1931210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 22:09:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795036144; bh=NtaHWMC+Xe77DOkXt8faalZonPt4QL67SIfAk8bT8FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fyAh+LeDSnCyEE9S47AKo1IZR2Nvg46Z7baI6ciRR0OCZRbvZNVFC2f22WHuIROaC
	 lCK6MKWl8Kx8dpSC+jURbfshqzc+F3MS2vkxBFzWP3L6MP11qU5/tJQPr7GIQFeftc
	 m3dct3hpPTrcDBDSfzhLLuvz/AxDf/LNBSBcHYYE=
From: Dirk Gouders <dirk@gouders.net>
Date: Wed, 18 Nov 2026 22:08:53 +0100
Subject: [PATCH v2 4/4] utf8: respect boundaries in utf8_strnwidth()
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-master-v2-4-3f2aaec15d31@gouders.net>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
In-Reply-To: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=dirk@gouders.net;
 h=from:subject:message-id; bh=876pncpND2ODn387dP9SMQw003r5r+EUn6n8YPd0C0s=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLL+Cb+dvcR/xUOL3vjvjy41X17HVCF079um2z+M196P/
 LW1zOrZik7GCSwMjFwMVWKKLEsnFdmlqax4UfZNNRNmECsTyBRpkQYGIGBh4MtNzCs10jHSM9U2
 1DMEMnSMHCBy/Awa6QXpDun5pSmpRcV6eakljqaWRuZGxq5mZkYmjhauFuZmbmZGpmaWjiam5q6
 OLmbG5samJo6WzgxcnAIw6+Y9Yv9n4lu1+F2eaPH6y1a5rBNXvtvwchOXVfnl9jlnQ/7asp58vZ
 +1zHx/86a9Xokcbdov+k7EvpYtjDH7fsOom1/U21B0n8RNNd3TkyWf3ZdZ9eLDUvbwQzsjZxR8W
 mOw6echi9z1ZqVHD4qknlhxb8NyI4dJhy5P/eU3t9TqkEpOyZzD+Xq8084+rTZtuThVsnvRt4Dt
 nOxmDFWPUsy0qrbNn+EuturtFWGJGxd1thau15Nmj5beqOe+tq+FyyTplonHerVMpf/6wdUCjzc
 X5U3k7eMpZ1ANYrayXiIvIPao2fyFilzFrmkdPHl3LCZkf3p+THgyi8ZixmRT/hM7jvg8NTrgf/
 TJ7eM3RIt08pcBAA==
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

utf8_strnwidth() can be called with boundaries that effectively cause
incomplete multibyte sequences and we should return "len" in such
cases.

But, utf8_width is used without its optional boundary argument and
will thus work beyond the given boundary.

Fix this by using the boundary argument for utf8_width.
Add some tests that cover such situations.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 t/unit-tests/u-utf8-width.c | 9 +++++++++
 utf8.c                      | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 5e2b636db9..c4df4dd6a6 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -2,6 +2,15 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+/*
+ * Test utf8_strnwidth for cjk characters invalidated by len argument.
+ */
+void test_utf8_width__strnwidth_cjk_chopped(void)
+{
+	cl_assert_equal_i(1, utf8_strnwidth("三bytes long, 二columns wide", 1, 1));
+	cl_assert_equal_i(2, utf8_strnwidth("三bytes long, 二columns wide", 3, 1));
+}
+
 /*
  * Test utf8_strnwidth for strings with SGR sequences and corner case length
  * arguments.
diff --git a/utf8.c b/utf8.c
index 1b88324ea3..8d4b159e1d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -229,6 +229,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 	while (string && string < orig + len) {
 		int glyph_width;
 		size_t skip;
+		size_t remainder;
 
 		if (skip_ansi ) {
 			while ((skip = display_mode_esc_sequence_len_counted(string,
@@ -239,7 +240,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 				break;
 		}
 
-		glyph_width = utf8_width(&string, NULL);
+		remainder = orig + len - string;
+
+		glyph_width = utf8_width(&string, &remainder);
 		if (glyph_width > 0)
 			width += glyph_width;
 	}

-- 
2.55.0

