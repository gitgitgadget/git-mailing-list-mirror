Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F96260A50
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473766; cv=none; b=suolbE2CfK2XLS6U6GCYjoO7glsNGRir+ixWx7LYBIu0pZzK9EaGZsNWxkRSOy6Urn7xb5oQn70YvuBK0vyPbd5HD5AjFh+fx5MZYe0xqFAK6iY1u+iszc59Y1BaF4F3/O6m2sVlh6XwvnIQTP6SGly5kT6Tog0fACf43y5c3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473766; c=relaxed/simple;
	bh=U7E+tBbZQh8kk/TZf2fGr35FzJT7uatAztjgYj6qhfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSUtUzqV010jb3akFgMod+XNXM1YmT6EdT2MlBqMvLQ/qIn+r2Ak7Yu9zBnW8Pinhyb1CM04PI2ybzja0ROlCqhUfTagBXN05DEYVz2OuKwb5OLs+u7s/2A2by9BwAtB7c321g4yptLz7wL1s1YaScOTm09gyzNCz4Ck3i+txFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m/KGCA7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0CjlRMgH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m/KGCA7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0CjlRMgH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 913902540182;
	Tue, 25 Feb 2025 03:56:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 03:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473761;
	 x=1740560161; bh=B+idYlwcjtlS+U8zuBikIt4+jFeMPBD1DEGU+eSDb3w=; b=
	m/KGCA7S126Crtx69S1SnP+skwkiZ76FXh0N4d0OpZ3a1Pr5QxyR0Nrzin/eqidc
	A7+prFtjPVGBvHhitCxxyFb7MkHCPhpDp73mx14BUqgyo/wmaphpExRKYxOUlKoX
	FZZuJPyU2Ex8rDFMuFLgLF9IebAhdEDhiI8J+Dd39LKuy1h6JnFf7USrjjJSSFm5
	HwGMa2Sh9kHp0p5MyQDoLaFuaKVP4c8DTJtpwR21HB8htYuiUnCxJZcvJQjPylXj
	gs5rVJ52l/waY1mqDZtp+kwyCizEjr5qTt3PnRCNRMTRHlrVJ/roArdvD+Be0QY2
	3lHH1sU4wLkA0F8++TBmtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473761; x=
	1740560161; bh=B+idYlwcjtlS+U8zuBikIt4+jFeMPBD1DEGU+eSDb3w=; b=0
	CjlRMgH/RqNtx4yIQvV14Mo2txz+VCxf21+N2zRtG9h1IOgMaIZRJrW2aEIcGW1q
	6mUTHoDED3rM2UbywQM3jFBTC8KNHRJLZVptSC96LCWkBNY4UJKQoCNI9k6OlBq+
	PVznpZp5SEtXmAvSU07FLk/lyPFnsutZBUERp+8nyuVqqKiCzoKt80YzcsjYluXM
	sziar1rq0HQfF/BMcqnYfX2U/80unrLCi+jE3orvhProjtd44NRXUVBKeO+I96FW
	VMrLTKLIXjvg49ElnuZTZ2YZj4VmuBuOOczlptcg6KuEkbF/GO7N7fvqyzuE/cbv
	DibXOIQKIgJyixgO7LDxw==
X-ME-Sender: <xms:oIW9Zza8wifn1WNkvIx2iEsMwR2Jmev2gBoKCfzynAvmpb08Zt4XOg>
    <xme:oIW9ZybDwIBeLzGwUpTjYw1eRbvY_-zEDMtB4b04lQokxwdBO8cwJbuqDwY2j7nSh
    Nm3qzHwqUkkQldoEA>
X-ME-Received: <xmr:oIW9Z1-Tz9N_j2pocPO5oXxHs-BBqvXujE6q1TDm3jFOgiq2o2BnaYC6cFy701XgnJOF4ep8G8nd9Lk-prcgWEKewju_KHHw1cOx5Z5eabkdEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:oIW9Z5qFQDBb5K7XvwIVaq-2b2CKbybinS7A_kT--HHRCJ9VobGosA>
    <xmx:oIW9Z-oCvXVVuhhA39UED7XF6cEShnqSuInISamJMQyl_fYFDLELqQ>
    <xmx:oIW9Z_QVtw4czHGaUBcjPolTXSFQ4zoNWVCrgOflV9x9ujM0WZNkRA>
    <xmx:oIW9Z2oiOwncdtDe_ukRdGnhEZau3x92edyyw_x1mdy6eXQxX7MLoA>
    <xmx:oYW9Z-JiGdKhQWPgJEOshhzxH3EpWRs31gdNPec2beSPrTh5gnhIrvJH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:55:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ac6fd3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:55:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:47 +0100
Subject: [PATCH v3 01/16] object-name: introduce
 `repo_get_oid_with_flags()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-1-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Introduce a new function `repo_get_oid_with_flags()`. This function
behaves the same as `repo_get_oid()`, except that it takes an extra
`flags` parameter that it ends up passing to `get_oid_with_context()`.

This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 14 ++++++++------
 object-name.h |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 945d5bdef25..233f3f861e3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1794,18 +1794,20 @@ void object_context_release(struct object_context *ctx)
 	strbuf_release(&ctx->symlink_path);
 }
 
-/*
- * This is like "get_oid_basic()", except it allows "object ID expressions",
- * notably "xyz^" for "parent of xyz"
- */
-int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+int repo_get_oid_with_flags(struct repository *r, const char *name,
+			    struct object_id *oid, unsigned flags)
 {
 	struct object_context unused;
-	int ret = get_oid_with_context(r, name, 0, oid, &unused);
+	int ret = get_oid_with_context(r, name, flags, oid, &unused);
 	object_context_release(&unused);
 	return ret;
 }
 
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+{
+	return repo_get_oid_with_flags(r, name, oid, 0);
+}
+
 /*
  * This returns a non-zero value if the string (built using printf
  * format and the given arguments) is not a valid object.
diff --git a/object-name.h b/object-name.h
index 8dba4a47a47..cda4934cd5f 100644
--- a/object-name.h
+++ b/object-name.h
@@ -51,6 +51,12 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
+/*
+ * This is like "get_oid_basic()", except it allows "object ID expressions",
+ * notably "xyz^" for "parent of xyz". Accepts GET_OID_* flags.
+ */
+int repo_get_oid_with_flags(struct repository *r, const char *str,
+			    struct object_id *oid, unsigned flags);
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);

-- 
2.48.1.683.gf705b3209c.dirty

