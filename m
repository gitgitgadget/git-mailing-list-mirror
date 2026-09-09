Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C9534476
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952383; cv=none; b=P+NyT0IRsp5v0Ufp56AV8HSrc/41RPtwaqjqp6DKM5y0/YIPA/uDbd3Jgca7AfvVG6jXFLdfnznWgpTU2W20xpgq5N0zfi3nyMC/Fg6NEQRc/WkfKbvCNZf20Tsy8fk7Nsed5+cs7CoQxYZ7dZIc8RmKBrBBNhx9OZiqir9tqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952383; c=relaxed/simple;
	bh=0zE68S91AxM22FaQEbG0fDkDaruqw5R4Xz/iF6cKZJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCjTubfEVTl2M0P3Z+TTp4lZZYdO3dC+T/4IWuQaSYrLPqPjy4DxzrKWZHVG/zu5tsjcgYkwKhlmDGQqlJzSfq7r0orVofaf7yOeNwb76+zBnTU6WBbWR+SnumRcweo7XnXLzDbMma7lF8uAsYPiPTw+eE4Ndkft1n9cgO8Lg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q5pmnUNa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yPuKSs9v; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q5pmnUNa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yPuKSs9v"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 176C1EC00A6;
	Wed,  9 Sep 2026 07:12:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 07:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952379;
	 x=1789038779; bh=43AoWLFXNEoPFHin7DLJgbiWwX+0aMHaI1EFXH+0ppU=; b=
	q5pmnUNaHZRWrn1v7lu7PmDRNb350AR/NtcMguVx8zCwGQVBz9aWTphBAgEnET6g
	zacLbfHmtoy/5TIujxGHrebFrht6MSyvq9L1fjuMWtFLyEVrKLgMe+xRyhQZVHiz
	V4XhoxfgW185zn9aO6EJ/yKIDMTC/JUH1F+JOTjvSlKadjV9vucjLoWLsveFaagW
	Zo8P7fzXaOZ33LJYCedctYgtdX4uaP43zOf5wY23xFD+hbVB6g2Oykh0tn9JrHS4
	plAboIleGzcr7VgnVVmncbM7ex+H6KjaYVrDovtFjpgPlgD+CXLYdiEA9DvUuPQE
	asqUWEnZLnEqs6BMJAnKSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952379; x=
	1789038779; bh=43AoWLFXNEoPFHin7DLJgbiWwX+0aMHaI1EFXH+0ppU=; b=y
	PuKSs9vSNEThqfj8KJT+ursAIALXYf1y/hK8BGeqQE2c+sCmuD/8ZqzFmZ/A9RZ6
	wFEoITLMYKwp8iNWNowXXkDETt+CPquwhW7LKjDoIIKAc6E7fh0LxmUNnUSFK6Uf
	lSZNj97rgEaOzsQ+aoJG5RLkse4QXMgfbpPQJ8tBabimVlOP6Z+p8IEdG9NIC3Ah
	pTQuw8xgBS5g43GeNwnt/SAbNFmy+depARDHLylwvpPbF2pk1wpZz4dyODYgCNKJ
	fBnJV5lpNz893/WMMhD3lOzsvKJnO3fyUeD4TW03yesKdcXG4zMsFcJXOKq+W5jl
	W2cw79OOx77A2Gh06MfVw==
X-ME-Sender: <xms:Oz-hatXgsw0j8TWI9K-shUeLVetpIVVffZJZhIVdr6VAQK-7riAmFA>
    <xme:Oz-haknZIM9IKB1q1I6mIF36Qf7Meg9nuYRWNzMSnaJZ8kO0PlqHjNyCz0qCMbxg_
    hqPZaBuKP6uM3bPYjGvNvuFWWNhB8eJDeSTJ9zsyo7uMcW_zFPwgA>
X-ME-Received: <xmr:Oz-hauYnar9YvrKnWmkd7A2FdHaC6bqyn5TNC-AZYOYNtLOT_ZIFqIqY62R0iYYeyccCWQ>
X-ME-Proxy-Cause: dmFkZTE3Kr1NBd8JgUfl84Cb5cL1nWUdKmaXEokJASImL17FtufGP+r88gnlXAgjOipOth
    P0q/MAO7driC9DWr9Pb2NSvnMboXAXQWKqp8q78rYacR0TIfgyDDisWpv4xgCjkfxpilFV
    de0BOcTzvSAwUjVggAVO3f0pp6fIXUozrRPx2JvGzCsepeV8jO3cLnixaA4fSCdk4cUvuV
    rWLiAxUXVbAEgGiBosN+gythNumpxzm2a6dIrhwBK6rKLm4zyqnAIVm4MkYADQfX4sBmuh
    t+6+cjeSCFtzPIC/cVXe+1M7eMImUQxfOX84m9qkFZENNlkxbbgX53FSMd/vtpKdV6ooWX
    QeWpsWZos3X8f/htPpa2YWujPNp+IGLFdEReBTiVmtTxM/oUl9xbItE1Xc88X6PNUbVpeK
    3xaQ3eCwjmqK73SyxUttYq/ZWRoEI7z2TfVTj31b60V6DuqSxZhXVFqCTjD1OcxdVDQeEa
    I0EViX7SleKjBbTgKw2MadEhIb435YfGCXszQyWSB/pdoa3gtjWb9i3ULnbBhh3MnUGo1t
    OVAuGp4kQrb3p1/WWWlG0JbTEzfDrVkRZIbeIJFvirLkZ7/aM+FUWc2WXDDX2G5Co2AaCv
    E/4SKsQo3Rb9QiG84vjnLvN6yI3wphz3RAd/ZNFQ7X5X452kjQRLg/MGK/0Q
X-ME-Proxy: <xmx:Oz-havOuM_XBYTGkz4xknDSX19BH8ls-elhv8ThatexdXLa9hLOPcA>
    <xmx:Oz-hajYFdYVa2yuId35lLq3yvcLYivJtoYCEsen0uddxU5fYEP2bZQ>
    <xmx:Oz-hat0J4OXjDVzlkCU0kTIooZBBCCF4Pc1ZX-yvfcth_bWQDFUz8A>
    <xmx:Oz-hapfU526JWPddIKJ3mYuPEHIJLxJbNEwnwS6a-DPiGWw_Y0qlXg>
    <xmx:Oz-hap7psZGiCPtgwamdTp4Ch81qeJWuOoRya9weKGdu1G6W0nMDCkh0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:12:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 443aea17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:12:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:47 +0200
Subject: [PATCH v3 01/13] parse-options: allow for hidden aliases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-1-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The `OPT_ALIAS()` option can be used to create an exact alias that maps
one option name to the same semantics as another option name. This
option type is especially useful when deprecating an old name in favor
of a new one. But curiously enough, we don't have the infrastructure in
place to properly support this use case because we don't expose the
ability to hide the alias via `PARSE_OPT_HIDDEN`.

Introduce a new `OPT_ALIAS_F()` function that allows the user to pass
flags and propagate these flags when rewriting aliases to match their
respective source options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c | 4 +++-
 parse-options.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..51a49792d1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -925,6 +925,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 		const char *long_name;
 		const char *source;
 		struct strbuf help = STRBUF_INIT;
+		enum parse_opt_option_flags flags;
 		int j;
 
 		if (newopt[i].type != OPTION_ALIAS)
@@ -933,6 +934,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 		short_name = newopt[i].short_name;
 		long_name = newopt[i].long_name;
 		source = newopt[i].value;
+		flags = newopt[i].flags;
 
 		if (!long_name)
 			BUG("An alias must have long option name");
@@ -951,7 +953,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 			newopt[i].short_name = short_name;
 			newopt[i].long_name = long_name;
 			newopt[i].help = strbuf_detach(&help, NULL);
-			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
+			newopt[i].flags |= flags | PARSE_OPT_FROM_ALIAS;
 			break;
 		}
 
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..a0b30f3c04 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -386,13 +386,16 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
 	.callback = parse_opt_noop_cb, \
 }
 
-#define OPT_ALIAS(s, l, source_long_name) { \
+#define OPT_ALIAS_F(s, l, source_long_name, f) { \
 	.type = OPTION_ALIAS, \
 	.short_name = (s), \
 	.long_name = (l), \
 	.value = (char *)(source_long_name), \
+	.flags = (f), \
 }
 
+#define OPT_ALIAS(s, l, source_long_name) OPT_ALIAS_F(s, l, source_long_name, 0)
+
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
 	.type = OPTION_SUBCOMMAND, \
 	.long_name = (l), \

-- 
2.55.0.1074.ge7621b4bad.dirty

