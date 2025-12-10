Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DF318139
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380781; cv=none; b=RdisDhE1o7VA4Xko4/Zhua0lgnOdeMEkTTkvc0crxa4rSGiD6szA5eUzIP6dPnZWGpq4k2/O8rau0e8MW0dUysuCtzzRTe9fzlTQJZaIQ8PZ6TIIf4WRcXa40w8toJipHMPhNCYfqWJVoedXZ37yZrzskqwG1KiqXf7UiusFSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380781; c=relaxed/simple;
	bh=Dbqw9p5TAQCa91Ix7ilh6nq4lKVQJ91YsKi7pb12fUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9pX0mCy18yt9P6ckeHm3Blz7clHllX8Kybax4WMX34qa7bjtcIHNCVrtqYLZnly+HPi1oPKQDZBmLYsAV1oBgcMzEkzDiR1UxNKBM/MhL7TzJ4OnOp5nlMXkzJUKR5Aif5v9BXkphihdAgJAItxzIAHMCAkG+7ifFmI7Lco96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UoZptED8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbCWNzQZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UoZptED8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbCWNzQZ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 62978EC0683;
	Wed, 10 Dec 2025 10:32:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 10 Dec 2025 10:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380778;
	 x=1765467178; bh=JYJg6ZG3s7rF6KFfh7bGtd9CzwcIxUTwJYA7SSy8qWI=; b=
	UoZptED8UzfgDG7DWWSEtnk1L4ZQyNKmJaUZD9d5i7Le4FFq8R03JOi0GzlhdUrH
	R2oIeM0EZXYONFC2AJSFWFzQ38/UJJS9Lg46gsKKQigrq2xHtq2w/sWm/JuPX24y
	d4wx5HxynyqM1h22ll6QCNPR9/oJZ5FkmZRZS7foeBLh09VLQfmtber9hXxsf5LH
	cDx22q2JRf62GREwTN2wGnQJ/LJbhnuyk6w0vxBK/KiDMASysrlRGUgoYE0jvBg7
	WyqE7gsI1eyFA4ysyYcpShCKnlz3Flxo27apmQHC7+g5nCkyG5S8pEfCQpg/qIkG
	LxStveFhzzc8SVlozxrVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380778; x=
	1765467178; bh=JYJg6ZG3s7rF6KFfh7bGtd9CzwcIxUTwJYA7SSy8qWI=; b=l
	bCWNzQZlPMFtdZVhLMn21G5V1H5Aes4KEFovIEF5GLnP6pxyUcu/TiEHpYiGBxHB
	HEqKbVLl4+G3bG78pR0EFbbCUhAFarhrKFZH9H6syjWaoRmxuhUyHM3hfgwXQPoh
	LSMw+8G4XoGcL1+Tdg9epy6bclHSz+RfTfeX84pHfkk8Hqq3NX0K0a62GgMM0w9Q
	V5tj6ZoO9J65egYyg1KLH/D1XGxwF86o17rH4/B04xRoTCZb+wQWsWmKUMUXZLSW
	N3bkk6LjfuNxUJxYEAu397Gbucv5qsZoMOl8g0mjJ4HHMcbXWim2cTZVTkrDTCk/
	pNaUL+1BkGfUBVUir9UhQ==
X-ME-Sender: <xms:qpI5aRjDaG0J1SlU7D4oNzAl3FpHQjPKFOyVPyhc4V6TXFCG251n-Q>
    <xme:qpI5acBAljeBhcMkOLt-hf0_Q4MUz7K7sEmd_eX1BQYt_wUR90dcO8BVJJ4JP067w
    VwTNewe31dgWbGY8GXh0kLPhRro9GhW6c5viRYYgDUG2bGr3Yqh>
X-ME-Received: <xmr:qpI5aesHbw4dTWdbIkNC_Ip6U2Z3IkF56QPC_ogvuaEbx7KGpJv3K-eDvkeKf-NGPlMWpudBlvrsfwzzAFKu7aVZwxPGBk4JZ2bObury0hAX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qpI5aRbK4SQ-6QjUtBSbqZTRo4qyRtiJSdwGcb_8XCLa5aiE5m5FyA>
    <xmx:qpI5aRVNwdmCnlKa7R6slCCxJV_d4-bQLQkkB4u5ii9UF8p5C9hENg>
    <xmx:qpI5aV6bgkWHo4TZRsodM6JD8dW1ujj0kRm4Z0f4v9aA_ol2cYR55Q>
    <xmx:qpI5achNb4oZAtQ-E-535Xh9mrgRyCgb0Ij0Jbb2JIqsX7CikTE99w>
    <xmx:qpI5aZQv3Pa2ApwAQyV7O4h9d7XmjDrixVVRFVxPjZL4vRExr_d66a-i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4afdbafb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:40 +0100
Subject: [PATCH v2 7/8] odb: read alternates via sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-7-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Adapt how we read alternates so that the interface is structured around
the object database source we're reading from. This will eventually
allow us to abstract away this behaviour with pluggable object databases
so that every format can have its own mechanism for listing alternates.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index dcf4a62cd2..c5ba26b85f 100644
--- a/odb.c
+++ b/odb.c
@@ -199,19 +199,19 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static void read_info_alternates(const char *relative_base,
-				 struct strvec *out)
+static void odb_source_read_alternates(struct odb_source *source,
+				       struct strvec *out)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *path;
 
-	path = xstrfmt("%s/info/alternates", relative_base);
+	path = xstrfmt("%s/info/alternates", source->path);
 	if (strbuf_read_file(&buf, path, 1024) < 0) {
 		warn_on_fopen_errors(path);
 		free(path);
 		return;
 	}
-	parse_alternates(buf.buf, '\n', relative_base, out);
+	parse_alternates(buf.buf, '\n', source->path, out);
 
 	strbuf_release(&buf);
 	free(path);
@@ -257,7 +257,7 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(alternate->path, &sources);
+	odb_source_read_alternates(alternate, &sources);
 	if (sources.nr && depth + 1 > 5) {
 		error(_("%s: ignoring alternate object stores, nesting too deep"),
 		      source);
@@ -599,7 +599,7 @@ void odb_prepare_alternates(struct object_database *odb)
 		return;
 
 	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
-	read_info_alternates(odb->sources->path, &sources);
+	odb_source_read_alternates(odb->sources, &sources);
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 

-- 
2.52.0.270.g3f4935d65f.dirty

