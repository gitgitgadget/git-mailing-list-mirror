Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD938B12E
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903202; cv=none; b=TeJxd4KG4vQ2kq7NNYrSugFDTDlrfj04JydOZWlad/NOM9VxE4T2nSbfYOyQ4jPYCsywr8usDsZvX8nWyVnu7UQIXelc10MrpdoU+8cGSp0KgOnO20Mq3hOn5MUYAN59ty03P+pOHiGegwfb015H2zWEKCDbIX24EWSmxBxkGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903202; c=relaxed/simple;
	bh=jafjtXhd7gSU0yyuC3VjeeDo0IQw8W+BmGsixxKoOGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOxhHiwp1jrcHm7+T8PkkuXk9Xq1tyhNN9TOrz90xIVvgejw6PiXU+0Ip2Afg3iaOJMgFg2OOSGHkvCFsyjaw3Zx6RkvJKhP7mUcWvw+i3KSuSJp/YYFhLLs1MBU+e4R5B8J0kJIZ0K5lnuag6Cb3ce3dk5yHd0BXXVp9xHM3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k6adrFqA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZDEHmY9y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k6adrFqA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDEHmY9y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A3D2EEC0222
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 02:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903200;
	 x=1773989600; bh=p7LxMjqp6x3nv+w1b7cEth5lrBewKM+CXjMJFKt+E7s=; b=
	k6adrFqAnVeLuVU+YwWoToBr+85DqNaLRUAU4WvaLVyj4R4csaWRHna3qtEj6Zvb
	bGtROA8f4SXtynbhLGn6OnN5NGUKxtFeYuV0qdeNkXipU9FWZJq5k9dzIcnVX+3s
	qA6Tn4Tx2pl5OfXRwbLAiOYoHnYV3hLJsKnscsfyPDm2j5R6A5oUo5f1gAcgz8mF
	XJqa0GtQmAGCsqbXCDJWcFZkr62CFyd/NCtyIUm5xHlcB4cEM3hyuTm1VjZtPGtg
	h5Ttaj0QPAlznYOD4vLmjWJh6QusvpkzEz7Xe2sxbbLze5uL4BJrT8Dl4OQtWKPN
	zpLjDkPRgfeQ9lTRLlppvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903200; x=
	1773989600; bh=p7LxMjqp6x3nv+w1b7cEth5lrBewKM+CXjMJFKt+E7s=; b=Z
	DEHmY9ys+c5cKkEquRalglwUmOtQdjAW1Nmba2bD5YfLA5NpeDd47mQK5uQ7XasR
	4eU3apRkp1ft2lqFGe4/czy3ur+USyRULiC5uYC602LbmFtoVdlhvmpVmJ8lS011
	cOCo5P15VxdjYo2BgZ+dLSByM69EUWEzOXevW7Z6zNKHKuGx5Pk0ZSldr1YGfru+
	l1jKlC3KcAoUHbKae/HtR4ZFRXHQMAfu2GzmzWZtAdG3xW32KZd5R3Ac3rrtI/xq
	KAmUOKdwy9cXEucqPvC4Odyq8lNLKjiWGrpiGqOoYL983BiDQFWM+bPGd7/Dfnno
	bacAzj4S+xo+/Lcfj9KFw==
X-ME-Sender: <xms:YJ27afcVjDjzKgyon4_LoQfK9MkQsYgG56KnHsv20ecqJPkOM6N9iA>
    <xme:YJ27acJYtQf2hPrWalVFUybmyqNbotx4pTp9CJrqWdD8pIBAuCiyqxR8mFNBpam3d
    wPC_v8xcC5c8vhKDpLZ4BQqlf8-djWYJFI4v0QGyjOHCdlKJxAcnQ>
X-ME-Received: <xmr:YJ27aeKB78DsKNJ-DApDGYug54gq0Xjs0ZQVDWOdjKyzQwy6m_NFfcmWFrNgpcCoRPSDtQ4TRoNp61yxjS2VFSJwaGkam0RmPQEUH61oOH_a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:YJ27aWHaeHWzM87puYWqQ8eEfXh5_M6AHCsULCuvhLkQ0I-nidxqIA>
    <xmx:YJ27abkWOanfntjinX1ipqL6pCKNbzQykPd73R-XJX0wRE7oQwhk3A>
    <xmx:YJ27abLP73kEQ8o2rAre0AzWn8v0UNYlPYaCVjauBqo_IbWOjB-Y4g>
    <xmx:YJ27aUZkzEIHm7b_-o22Z3iPTGMUhwmjEIBNg5W1QGajHNT_usoHlg>
    <xmx:YJ27aROETHvkJqcoAxW25d7rIssuD2B4nCLvpnIzkFy7h5D4DLJ1Z3a6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbe926fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:04 +0100
Subject: [PATCH 06/14] object-name: extract function to parse object ID
 prefixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-6-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Extract the logic that parses an object ID prefix into a new function.
This function will be used by a second callsite in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 60 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/object-name.c b/object-name.c
index ff0de06ff9..fd1b010ab3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -270,41 +270,57 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 	return error("unknown hint type for '%s': %s", var, value);
 }
 
+static int parse_oid_prefix(const char *name, int len,
+			    const struct git_hash_algo *algo,
+			    char *hex_out,
+			    struct object_id *oid_out)
+{
+	for (int i = 0; i < len; i++) {
+		unsigned char c = name[i];
+		unsigned char val;
+		if (c >= '0' && c <= '9') {
+			val = c - '0';
+		} else if (c >= 'a' && c <= 'f') {
+			val = c - 'a' + 10;
+		} else if (c >= 'A' && c <='F') {
+			val = c - 'A' + 10;
+			c -= 'A' - 'a';
+		} else {
+			return -1;
+		}
+
+		if (hex_out)
+			hex_out[i] = c;
+		if (oid_out) {
+			if (!(i & 1))
+				val <<= 4;
+			oid_out->hash[i >> 1] |= val;
+		}
+	}
+
+	if (hex_out)
+		hex_out[len] = '\0';
+	if (oid_out)
+		oid_out->algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
+
+	return 0;
+}
+
 static int init_object_disambiguation(struct repository *r,
 				      const char *name, int len,
 				      const struct git_hash_algo *algo,
 				      struct disambiguate_state *ds)
 {
-	int i;
-
 	if (len < MINIMUM_ABBREV || len > GIT_MAX_HEXSZ)
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
 
-	for (i = 0; i < len ;i++) {
-		unsigned char c = name[i];
-		unsigned char val;
-		if (c >= '0' && c <= '9')
-			val = c - '0';
-		else if (c >= 'a' && c <= 'f')
-			val = c - 'a' + 10;
-		else if (c >= 'A' && c <='F') {
-			val = c - 'A' + 10;
-			c -= 'A' - 'a';
-		}
-		else
-			return -1;
-		ds->hex_pfx[i] = c;
-		if (!(i & 1))
-			val <<= 4;
-		ds->bin_pfx.hash[i >> 1] |= val;
-	}
+	if (parse_oid_prefix(name, len, algo, ds->hex_pfx, &ds->bin_pfx) < 0)
+		return -1;
 
 	ds->len = len;
-	ds->hex_pfx[len] = '\0';
 	ds->repo = r;
-	ds->bin_pfx.algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
 	odb_prepare_alternates(r->objects);
 	return 0;
 }

-- 
2.53.0.1055.ga2ffed1127.dirty

