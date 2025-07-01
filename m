Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4722302CB2
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404968; cv=none; b=dBfaWKfNZYv0FfLtlbTb4cGEVdsDirIRbCrPqvmYr+mx5wGfEvKjxXmFD0AbaXbcEc7V2zvZbuLNa57T4mkHSQhuhxV49exSXPV7JCpSMgtZVCSYhBC6FXiL2KyuiyewFYPah5R7F8lJBfHCChOtklXlpoJ4XDSBcGSwfOno24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404968; c=relaxed/simple;
	bh=XgB1fJ+2aQmVn4S8LPW+XdlMnQsWqkxQpUnnhJkzJgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plY6kxaC64pj2vcsBzCbIp6JCxNG4xHlvTk4iRVg7+vpVWjfGQKcNvteJZAHd+jCRTGHHTq/J2ZklKSKy17Y76S4nHxzF/xkaw91am+bthBhWWMj3F1eZVSFoAQ4eR9IH3czhWKnTtW0PnMcE4zgpSsKdtPcnBL7r2Kg5zyQp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LBp0Odh/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LBp0Odh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=XgB1fJ+2aQmVn4S8LPW+XdlMnQsWqkxQpUnnhJkzJgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=LBp0Odh/1XTQ1XkY47xp3gqQEDdw/x96UiKXnyMXPRM+MJ6L4eqLSPUDsL0Qj/6EH
	 Er9jZGOdt22A0RHHenyP4tKya7oXCS/NEpzG7y+hZbl9+soJYpcwMgUqzfecNScxa7
	 TsAN+n3DilGIqJGYvfmaM17VkG7WeEf5nSXxA39n1On+RoshgnzuYv9leZuVnQDWR1
	 sb46RfgXiwZ9WMge7oeQDlUnV3/zIRykqWAV0GT+6GEp9Dyly/+Eu/W5zVQzRxseZ+
	 f9f0bmYvKPFOBcz2QYh72IhP3MDsgQPA070T6baVZ3PYks7XF6uVWTaW+Hon/kT37Y
	 pmQgfUSOfxnrnMq//xtzhQeVVT7GQZq/UdCaK/HQyYcvER4qyse8OGaNY2sP00mXDR
	 TfqRtJV/aL9oBFWz/fO+CwCw1wjw3CZLNuElLfcJam7bz9XN84W5haTVXHLMDAH+wz
	 imahSVzL0CNfh+vXejJcyulW9MalJjCg2Ong/KT4nsc8n01lYFu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7C8B42019E;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 10/11] help: add a build option for default hash
Date: Tue,  1 Jul 2025 21:22:36 +0000
Message-ID: <20250701212237.766774-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'd like users to be able to determine the hash algorithm that is the
builtin default in their version of Git.  This is useful for
troubleshooting, especially when we decide to change the default.  Add
an entry for the default hash in the output of git version
--build-options so that users can easily access that information and
include it in bug reports.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/help.c b/help.c
index 21b778707a..bd0be2ee57 100644
--- a/help.c
+++ b/help.c
@@ -810,6 +810,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			    SHA1_UNSAFE_BACKEND);
 #endif
 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
+		strbuf_addf(buf, "default-hash: %s\n", hash_algos[GIT_HASH_DEFAULT].name);
 	}
 }
 
