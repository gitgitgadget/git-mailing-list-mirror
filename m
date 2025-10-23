Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FA2C0F83
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203875; cv=none; b=rBV2Gv8UIqTRKtghiOzITcHFqKmE8qs4xDVArCpBexzRl/on5Zm49fZDZ4ApIrA6bNP9zLAvUrZvSzzshffFm1pP+Eog150ldDWyaOmV7EyK4IFwh7/BYbkACk7S6Sv6w3ugGaqMZH5z4/1vVY3z5sO3xXB9CdlGP7bHCTzA6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203875; c=relaxed/simple;
	bh=jGAqDjM3XB0bet+fTjyc91ZZ3AP/r+uOYh3PxqL5OyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtWXS4HpO8sN2ISo0kzugNxxZKWypCKcMPC7aqUDFLvLcOBu2imlB/M8FMGk5w420JuggvVcUo4Z3VtOTW+iczKTvzSGYLKANJjNgmiiOe67MAmIaszSN+CEhbrCWUwXcmrlSgMID0efYJBibneyVJyT8S964uesQQQHL8oGYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xdh9sS5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmCDY6DI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xdh9sS5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmCDY6DI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C42CBEC022C;
	Thu, 23 Oct 2025 03:17:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 23 Oct 2025 03:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203870;
	 x=1761290270; bh=llUcP9zK1LpFSUkiNfF9Az+1mXDkbFwD3/urqXIHEpo=; b=
	Xdh9sS5qSCCi1JLMRsG6rHNwF1LuIGEeYRfeEtNNaeV0MUj2hMepzhrInunpGJRv
	ZmNH7yPsK/wc4fObYBQSftRbCNZYbvtOzE5zoBhDna4F9v7YZu9YPhXHaGI7dCK9
	LiNS+2M8OeRW1ga7Uc8FZwrb5DMhwzXxWkw9Ti6729NutSSze2tozvzK494O5BI3
	klfci8SX9ih26CEv4LHrK8zLHWNBCqNPfG+pcXWxmVK2TYfw6HGpHfKoW+qVPAUE
	MRCiFyY2tgnRfFoq1eM6dc/JPB9cOGhysuU/NDWDfRTOGULd2ZKAQOEEYT+Sldxf
	jP3porDrFRkv85NxrTtKuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203870; x=
	1761290270; bh=llUcP9zK1LpFSUkiNfF9Az+1mXDkbFwD3/urqXIHEpo=; b=Y
	mCDY6DIHcAFiknaThw0HqdVco+LWwjE7gbMg0dPePCd21IiaCwK5nt4W0Oz4QFrZ
	XQFMiuZgGatj9mQLebcKnqMBrlIp5JMHNvalbjTm/nl1qYTxF+CLO71SdPr4OvRf
	9Sp3xF7PinCRHc1XiTGgmcg/CbdLtvNea++eI8aswzA1wOAAXmEiAzW5faqN5SDT
	jMjbLOdgZER4PCeWQ78DxHWweFhvNCLRoXMid3I/J/YdqxgXpa9jdeYKT2zRgeco
	T8zqXeVqBHjmLtdawUxKf8usYGQRV2Pp0PQrg46nLX0lL0uq5jQsSIllxCPZSF2M
	RlIuHROB0S3SBlEOxy98Q==
X-ME-Sender: <xms:ntb5aN8sF-hixiYtzglznQQcbLe7k9ow7tZ0tt4DvootZ4P2UYI0nw>
    <xme:ntb5aJJslBWsJgxS547_2QCR3EKtnV0oSMBhTgawQSVq4zjSqT0ehn3ibAtq6BC12
    MtxE2oPNpPkOY8BFyOyAhWEkcgxFruub1iQWwboG8QJ4f8ILy8jKGk>
X-ME-Received: <xmr:ntb5aIZu03BqOZPiyKEqjT6yzorBweHNXf72awwvf6der618R2Ck9K_Ojynk1nRg2FkD6uP4P_hRm4sNtcF4ynozwjmisIUniVwDCrK_EEk-WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ntb5aLL2pP-bPIH3iT3CU5Pr73USeLk9_F5LTjCCQYCz_sQClsV31A>
    <xmx:ntb5aGBxWkH1_vGzOAmmxVpIKJDlj8qdttIiWP--Xb2kzExmkmk-Dw>
    <xmx:ntb5aAoHcOTAx9dzS34I_g140LB-wGVWv1Qvl5rNOqW_4HqPjmxDBQ>
    <xmx:ntb5aBgFEYG2Da_Gohn65NES0dMyT8b8x9yF3NEVxHA10vDbM9ZuZg>
    <xmx:ntb5aGW5XlZCLujyCuRtSm6FuVtIwjOA-Ym13P2rimiU8w3Q13xe5uk3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:17:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ddec7db0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:17:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:17:39 +0200
Subject: [PATCH 2/3] meson: rename Rust library target
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-rust-cbindgen-v1-2-c19b61b03127@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>
X-Mailer: b4 0.14.3

Rename the Rust library target from `git_rs` to `rust`. The latter is
way easier to remember if one wants to compile only that target via
`meson compile rust`. Furthermore, this name matches the test target
that we have for Rust that can be invoked via `meson test rust`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 src/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/meson.build b/src/meson.build
index 25b9ad5a147..1c73549696c 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -17,7 +17,7 @@ if get_option('buildtype') == 'release'
   cargo_command += '--release'
 endif
 
-libgit_rs = custom_target('git_rs',
+libgit_rs = custom_target('rust',
   input: libgit_rs_sources + [
     meson.project_source_root() / 'Cargo.toml',
   ],

-- 
2.51.1.930.gacf6e81ea2.dirty

