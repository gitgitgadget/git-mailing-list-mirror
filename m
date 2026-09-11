Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6A3E51F8
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105933; cv=none; b=Sla6z8lLX9nkl7rrwTuh8QqWuPe1ztu6yvJccUH/E2ym2Bprzypj/gY8WvNj2DvhWMDikWwGaciGb6L6JdKnKrVK9q7IqbpV0UZ9YKKAgUou1HySuuT16rFp9Ni+MTVIN/egXb7Whj0M0HKxFgvzqj6Xy8yxPg/VyncEdsTocHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105933; c=relaxed/simple;
	bh=g62KGQM/7EtzjPvFJ+vHLmmABJoG4Lk6XjTi6xqA84c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3EGtjm7DUDICezABIm6wT7PYblSRRGLKbCDzp4+KJklqDlDQ32fEVUsVwTG8TUmupJJmRHlvBqACr8lhi8O2gf7KlV0AtMq6U/oTcM+lXYc220dKEs2z4aX+5zpktNAyFagDKUQVN4eCXYkV3Qh7+e2aV37g1FNh+WkRLx+uxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LgxZIpSc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gd6pwuBx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LgxZIpSc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gd6pwuBx"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F6A4EC06F3;
	Fri, 11 Sep 2026 01:52:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 11 Sep 2026 01:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105930;
	 x=1789192330; bh=kCEy15Md7iM/m6x1jqfwB4g0khXyg8cuWKsW8EiRuOY=; b=
	LgxZIpSc4WSLE9Uj0ofw3Q2ClZ36nx7S0MTyWphZb/s+xSWKHdxSalSB3DYavn38
	w7ezC0aM5vGAmka2ygvKUmOyRCtxWqBotYHg1mfAi5n8pvmErbUXtg2Ls1RGCGFO
	TpyEywoqBD6pkWqHIhyOpJ7PkX2ki7L0cy3GO963fEUEMiSYyljz2GdgY9D4sg6K
	QpCYVoPgqRsCIuK6Ey4Kxb7/JArBp/jxVRbBa7ZEb55I/ysDXzobfycA81FrEMO6
	9NweneKbn5cSXzOfavIYwzkiMA9AzC1NkO3A1CQ6VB0J/8hcmS3Pd35mRlAOhNgw
	0n54evUmh+vgYzth/AdHVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105930; x=
	1789192330; bh=kCEy15Md7iM/m6x1jqfwB4g0khXyg8cuWKsW8EiRuOY=; b=g
	d6pwuBxyM+LsD4ZgG42n42xBFdWGn9tGXdDkPABA6gJnGFKLnsKAjPsSo4G4uBc0
	CxO9gk2JaBBqs8F8DNIBdtUxLanhDqCsYrJdMJYJXUlrFxO8s8Aa5DyR3Q1IfxOI
	ElWR2nqWml80jVKOMYb05LfTZaFHlys6875YG9JGxS6qzH+EdJl0Yi9sgJDfNFSJ
	EAdiwwqS6CTpMzewrIgxdTayF82xdZFgvssRxygpWaOqk9ZnUOS1sW7Z9eX33+vM
	4DN7Rz6LJW0SMu9JI2UHQisgIsFv5+wpJjOSOyhfHJgeAcZd1qdw6deg1OkX90XJ
	5Yb4yYFZyo4k1Jdur5arA==
X-ME-Sender: <xms:CpejahYiChdx041spHzMnGjYw0usBe-5T5vKc4f-bT8cfOvZxwywwA>
    <xme:CpejarpPtp5Sz6OJ5VEuy03p7_XloKgWnDIB0mzzl51OcKJZcfkWslEWhrUJDR8gT
    b4NRpvmZ9rfFUjpmaK14h3NlQbaOBzhJFNzJMlywuqeOkwFV0tiDh8>
X-ME-Received: <xmr:CpejataRgxO8u1uJmsPuwVWMI8f0LU3N14YmiMgYtw5_htGndeZNoTspbSJhocpZpqt_TQ>
X-ME-Proxy-Cause: dmFkZTGbR+PpiMq/fYfcuarwQV619CtY/MIm8GXs7zsD2KuWA4drZUKw2GRt7Zp2Cy/Liq
    c5iYI85CYguPgbniJsqKgoamONuuzuQR7prkUQk0vuMFV3jCpFs/aGLCVSaoY0btBxL5Wh
    SwcyTSk8tz3IRcGYsoFeunEvJWfWh03ARictEtKUvntt91alGWX/E9rvWaeneBCcmEQe1V
    evMAVbUeFKJG1HnDZeJ+md2JETzWXS2/Xno+f6T1i0PYk7SHmwaHOjoSdLbXITljySQNyr
    9BV2JnubFRVMA2jKadAOPtRfLbGlVVfih1dCfcOs7+VCAxXW8e7jj62ep8WEieEfgbOaXX
    nIXSynx/eSy9SzbVXNVGjPplhESBu+pnu7RT3cDuES9h2ZNUl1vMUr5e7vNrIF3BBRP9x6
    jKw9uyT+XYpN+uJVHADeY5u45Zbbn8CPBCweboMxefjD1yy6dOSQLD+aMT0saZ3ldMPFaZ
    Go8kI/ftnOph7O4AsmthjJWqLMpynzw3KpCOKGdpyWFdAa74efznZLBzTju0HcTRp7uvJc
    A4fBLqPCx0i9/9xzbWnXnRtBibXmH9O/AMXe9IVor4tlfQXG7dXMO4j8Tuv3Y8Rr6BZ6uc
    L0P1xUuVAQyR5lhjCETDNzJMo5FjDoi43t/bbDnG5Zb4AMLXKtzQPCuNA5Ow
X-ME-Proxy: <xmx:CpejarTXtPPWv-i9qM3UXh_Trp9B4psfeeIF7DibsgZGYaC0TNf4EQ>
    <xmx:Cpejas4QTTqirjvMDKusvUsBRtvMVQkgVtLjMQkSXddtfRH8KgsFGw>
    <xmx:CpejaoxFpJ96qPG5lbSPSX2TFNYgFupEhhEL6uCJiM5T7w-SBNa9iw>
    <xmx:CpejajQlrHeV6fGSQmZAhjdf9AFfwNoefTV3xlQ81xikJN8vU3NGgA>
    <xmx:CpejasTwi3yAL2WI2_e82IlsarfksanmhKEX_4JslqtF9F-8kRNQeMbI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24e799ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:51 +0200
Subject: [PATCH v3 08/13] tmp-objdir: drop unused function to register
 alternate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-8-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The last caller of `tmp_objdir_add_as_alternate()` went away in
bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10) and is unused now. Remove the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tmp-objdir.c | 5 -----
 tmp-objdir.h | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 0eaa79ffd7..deaaf6ba2e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -321,11 +321,6 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 	return t->env.v;
 }
 
-void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
-{
-	odb_add_to_alternates_memory(t->repo->objects, t->path.buf);
-}
-
 struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
 						  int will_destroy)
 {
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 81eb927413..05f0d08d10 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -55,12 +55,6 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_discard_objects(struct tmp_objdir *);
 
-/*
- * Add the temporary object directory as an alternate object store in the
- * current process.
- */
-void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
-
 /*
  * Replaces the writable object store in the current process with the temporary
  * object directory and makes the former main object store an alternate.

-- 
2.55.0.1074.ge7621b4bad.dirty

