Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0E358399
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526058; cv=none; b=j7qk96bSDPEcr9L37UW8+R1DW2Ig+ykhlAIxmaWPlsSUcj3htIlF7cphdNCed0GFdcW5p9XliXRTOazJhpA1mzw+MAUmlC6J1V8zAryd9AD7CK74Q3hQoowEFaV1rBmeotIQy/oLu6vTS3muUPAdy2vdowYbdpryxf0phCMtGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526058; c=relaxed/simple;
	bh=CtxgEUJfzytz3d/oayPEqOpqOucT5oS/oE359CwqA+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIuGXmYEM2nSg7ICOVDnOylIwYiIJjzUVY8TMM6VzMFj/Zb+GWgwK3hOUNv8ZIjGtkCLOeCoiqkOf64mQGy3gHkhs1gHvqbPvteKmzU95F5zTXkJFzISHR6iG0C0rmQua+crkF8qtLkTaMmOUtzWi0dcg7N6w6CJWnvl3lTsNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0H7aSMc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCRc3cr0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0H7aSMc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCRc3cr0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4466BEC0079;
	Wed, 12 Aug 2026 05:14:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 05:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786526056;
	 x=1786612456; bh=JeL/8uoy/DEIzIUDzFycr2SDbkXumgRvbI8JHkaDa5I=; b=
	W0H7aSMc0Mq5o7KyAAWkOPm0Pd768FMAJ4zcVlIB69rbHMOcfMSsokvqBdmuZ/AQ
	D4vXBjk9uoPpGKIxNS8fDgsqupya5RO34vsQW5OcnSm2OpGHixyh+Y6LuRPF7zGb
	M302UykJ7uScaSftH35PptljN+wZwFQ/RVY4UOl7OdsyA7r/H7AcRuZh5q0APui3
	r/SHn6AzfASrC3CU3TmV9z/A+TIiF2Q8AtxOqyO35tUUXIsDgG9CliYikoKlB4kk
	0S8yQAsqqDp51oczUDPBrN/D6AeLy2oga7NGQgW/bF46vC3Q7IO2j9R2t6TYo2lr
	RC95J8hCIExoU2L0eMZmMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786526056; x=
	1786612456; bh=JeL/8uoy/DEIzIUDzFycr2SDbkXumgRvbI8JHkaDa5I=; b=H
	CRc3cr0VzjzQCgiftvceEuAdr0QU+ZmKKtE6luJywRSiYaZXhp4HOJzy+VeC3UZA
	JbIozztQnceNCryPNMSAUNn7c6TBpX6GShvsvjC8HptWTjJwR1FYNNJqNgTZLEdS
	f2Oax7ANDg7N+5cRc1lkTVcl1tuIUaOVTB0BAXBb1b7d25Kv7lGK72HWmsUxD2iH
	6hdWhleh2zGdJJ6pMZzu8WZ/DnKzPLVVXSur0obXlEJCv5fw7FRK/gxrM5MdYA47
	QzRQ6un+udcTg819sW/4fxPZ+CqKL22yTQSnOJDlCh6fRPihebCm+A6pqJSvEvKC
	STXGk0XXpgMDjT81rzyXw==
X-ME-Sender: <xms:aDl8amRmaR5kx57iTEAZEN2f_aGMwF_EpjAHwoiq8abTpt33z9FNog>
    <xme:aDl8ahwQopkEVjEs4qt9A85gUo1-g-GmOHWbMDQn0lenUmtBS0YZhsadfD6sJQAub
    ZSqBC4lYtI3YCLIpd3vx-zsAQZnUgNnd-Qst0Hwfes1Q4XZkpwnxA>
X-ME-Received: <xmr:aDl8ahf6klpv4ovKhs4qDzmqXlKFFsi142LeCVJ8fR6_c7AKX9IrR7YE3fbFxjQ0Afj5ydn0wmfWOVT5QzPlCGe7IVxW8PYUCbTdNqCkxA>
X-ME-Proxy-Cause: dmFkZTFJ3Ey96XTDwvDtEyNw9f2ykmsSDq1CAJV5NAn9ZaEtMw0kitb05nucIFAovqbjvN
    BirrtIf6Ao9KDPqzc7qme/SYQznBQxIQGJ6KGDSObs8Khw1jY3tM8xRwKKmAk7mZ/kv3sa
    QCAfWZQI8/b6wWHKOtX33Hx89h91R+6loFoZ+OD+9vHil1xqHnD37tcY/FKHz8kV2XtfaW
    5CvXM4IgGe/9HNE6nd9aqC3nP5o/tMoDoMJZbHhNEFCHTTHaslx7Em86EDcOvhT8/jsN1B
    vAOsHdHRhi8GqMHEEa3iJ+bXtsC7MsF9G9VvTXpZRuZxxN+lGo7lDkJasQcEiXS4R26YUv
    uBRwW6pFj6n5DjbH9+XCbNq55k2NUtA0/t9ZPgux7oKwUXmtDjK/fNl/NdpiGOPLStlE40
    q92pQygUkwHLPcMXFKW0GimR8SAT2DqlHabpvSpiX3mis9xtxEoadbFcaa8t29Z4ZflRzb
    yKE5aEaV2O3NgTgVDe9jXIB0XlJE8uQqBWnZ/1Gjg8ykCv3ak5US4grTaWBIzhNZShhcGW
    y+dHyW7kDGCQkZcHJZwUvuZ8T1v6OJ0BUsGO5TcY+h/pLZkC6OPHSkxmLvlk5/8ajfXVdD
    F5T/hEz0ekdIvQO2Cm4puj7KVhvZ8MtGJ7bKY86w4jngAqcRCcZ9mIvdSDLQ
X-ME-Proxy: <xmx:aDl8atJuU0R7ITTZc574JEeXmcj4eOKi6yTeY9dAdDkK7lOj7ExH3Q>
    <xmx:aDl8aiFZdTytj8xibZg8xary4dSMgcX9G5jGWWdwWMZnaNE5yX21dQ>
    <xmx:aDl8anqEDpKrby8iiBlUWK9ojuUleROkZKMUfEp5mP0HtssTI_u4fQ>
    <xmx:aDl8arS2QANtW56KUPUNeMhjGlFBfvGCAZUru3xdBnpPjTscRIjL9w>
    <xmx:aDl8aqAnabDjpYLiEO6n0q11X3EJf0UMpVI8Oaf38lgLsDMWsdNaRspc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:14:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a008ad70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 09:14:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Aug 2026 11:13:59 +0200
Subject: [PATCH v2 3/4] odb: drop `loaded_alternates` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pks-odb-eagerly-prepare-alternates-v2-3-522b9a5bc1ea@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The `struct object_database::loaded_alternates` field tells us whether
or not alternates have been loaded already. This field was useful before
the preceding commit as we were indeed lazy-loading alternates. But now
that we started to eagerly load them we can assume them to be loaded
after `odb_new()`, and hence the field does not serve any purpose
anymore.

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 9 +--------
 odb.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/odb.c b/odb.c
index 2ae8228dd2..2eb37a2f44 100644
--- a/odb.c
+++ b/odb.c
@@ -230,8 +230,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	int ret = odb_source_write_alternate(odb->sources, dir);
 	if (ret < 0)
 		die(NULL);
-	if (odb->loaded_alternates)
-		odb_add_alternate_recursively(odb, dir, 0);
+	odb_add_alternate_recursively(odb, dir, 0);
 }
 
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
@@ -495,16 +494,11 @@ static void odb_prepare_alternates(struct object_database *odb)
 {
 	struct strvec sources = STRVEC_INIT;
 
-	if (odb->loaded_alternates)
-		return;
-
 	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
 	odb_source_read_alternates(odb->sources, &sources);
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
-	odb->loaded_alternates = 1;
-
 	strvec_clear(&sources);
 }
 
@@ -1132,7 +1126,6 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 * the lifetime of the process.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		o->loaded_alternates = 0;
 		odb_prepare_alternates(o);
 		o->object_count_valid = 0;
 	}
diff --git a/odb.h b/odb.h
index fbafee174b..aefb34213f 100644
--- a/odb.h
+++ b/odb.h
@@ -69,8 +69,6 @@ struct object_database {
 	 */
 	int source_paths_icase;
 
-	int loaded_alternates;
-
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will

-- 
2.55.0.679.g6767b8d81c.dirty

