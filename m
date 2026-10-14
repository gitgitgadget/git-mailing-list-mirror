Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7824CC632
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968049; cv=none; b=hCySvZ7OSh5AtEPB8dPpyfOXP38X20MZMcY5Qlki/U6aQDVUYSEZ1njX73PhFANTs+0aIZIQvSyW0yn2lOI0XM2iA5LbTYLRk1FxqnVgFOeRRividk0spxl+IJadHfVdLcLbehzQNN40Y1ndCMAOozO7Za3Fh8ZJZFFrXHQOlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968049; c=relaxed/simple;
	bh=cpLqzlKZ7aif3q411cPhk82D0UQPQwvrdUtlR2n39uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LF3RaQwbML1I0uPDuX6EmWlPDpF8wKN4ncYOvNHFlaJRnA4fPK/PuW0de80FWh9TRVrnUBwgec0UrzeGnllKFNyWHY+olHIn1pK/E5ysjrq4HaGskY2vGbeveMCCw68VBjtZgfabYvd7YgIlrvDLCSpx/27qbx4iyOBC+b3Claw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gq8M9D6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1x+HpIM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gq8M9D6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1x+HpIM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BF7014000F1
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:54:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 04:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968047;
	 x=1792054447; bh=omOqjPjs2XiAsDziuBoSoU1YMoxMXomynGcRT/u46/0=; b=
	Gq8M9D6SjiI1YmRI1yFYvdcsMZgNXEse0r77gkMPc0javorgmJSQtWfoRCpxVdH1
	DZYnpMNtcs3ePwzlFGDrddKOIilKHvCv6oOO63fLfITG0LxtRGha/twCiHuNnVNl
	aBOkstw8TnNHglJ0PBXpO+QTVImVmhmTfD9bXoL6QNh8QR4pbsglqDywsZsbPaWR
	YWm9Tm+wiH8PjYNsOvEqcuplJsroPfYeoufxNvxwj7hn1bxfweoZ85JK+19Q9XBW
	8zemeQkiOk9MZdXS0LWNr9y5MzJzFVWZsQ2obphPdR4L7O//knfc9p4er28o5hac
	vEyYiKLidhzYFuPsxnKpog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968047; x=
	1792054447; bh=omOqjPjs2XiAsDziuBoSoU1YMoxMXomynGcRT/u46/0=; b=R
	1x+HpIM6q8pChAH97rN3NOptzbrnF6Rk5Gy8YccB0TjgMxL0gWTWlvh1G01rmD+t
	dPmE3IpqvMLZpX9BkGUKlxrInLdBVY6Q1ZhODqxkS3WB/JNfykE/wBTQzmjXzEx2
	3VQS1dhe2TOJOymmuveR5z1fMUjnNPVsN7hzGHcmt9xOk0TcdfwBWsVUiaEh9PZi
	fqB+sLlLtHOELkqXGgh7MQ1nkddHMm6wEpR2U5BrIy0Mhc5UETTKfU9Q4IrzXNnU
	kIi9Y6nV4t5/h5EwwG1Z14ypc0uZ6OtCdkDz7rzHOJTZsNQg7c8Q9t0ixKLOCsmH
	2Anuz5eH7SGTzsmppiyxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968047; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vebSgwlh13jxOxFSDru1hINbax96d4DDtohggEZRbq1wFUW
	VpqZaPU652I3x5/rhMBOgGNan0PEq1MVHVNOCNkohcHvfMTRzEUCGTadoVbo8QrF
	woSwcHzoHQlaxW39KO3aXbvA+CQ0wRSrQ8yA5c8VWs+pkaBklLprQu8eF5lgLvPi
	J6dnOb5rsnBbPY9V9lQbWPi9aFj+YP5M+ai/2OLq54mxpoO66x3XXCNpm7ksdrT6
	g4WzErlM2dfBpgX+JGbw968lb/sUghEC/J03jCSwtHizWbgnby+tBMi0XgyblP4P
	tkLguThlXXevobMzTbROjlKYbt2RfY8+gMTqc/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iBHfodR5lg/dfaRXT5zXD8zWTaTp48dhq5ZMmQCOOm0=:cpLqzlKZ7aif3q411cPhk82D0UQPQwvrdUtlR2n39uk=;
X-ME-Sender: <xms:L0PPaig4vyLj3isyqVIK-205p_FErU2qpS44FsvdcO5nuyy_lp6fjQ>
    <xme:L0PPaqCZ7W_jf9xdtBGhFwpQg9agYm74iWh_pc1LJCqJmGi5TX8EDLXcfmnO0gfZO
    QffXbzmO7YdiZgEFzdIxtfh2dxx9_wv1GlYBKhVOFy-CgOD7xoHRg>
X-ME-Received: <xmr:L0PPavE2mu3waAJol564vvp1yZKuRU_fkSgQtYjIx718xVDUAmTqqQ>
X-ME-Proxy-Cause: dmFkZTEIGbfxSI3LK1PjypvgEMHVXUW0L5HWcG0BIsOmbk6itNM66/4zvoSPIX2WOSwp1X
    61Ife/ZBu0XlHdtlQJBOGqy3Y4djmbT/ZTaw+DFeOy2p/xriFVqMihR2QN5pzzYBDKw2VT
    qv4rA+uKFyqpW0LG1fskR+o/dZ8j5BYdcM2t2y/v84NZWoeKtSFHlzlC59O3EAJaZsgJi5
    ab0DSmncPPyrquYVpCiXeeXgmWhnsNx1yTH2IoJtv9NiunhMjc0uAh6jITC5QQ7XMnL0lB
    u1haWUg9JeY4GmBu5H9VkPO9DUniWQ3hzuMSYDU6A/ES/I+5NjGtpi65Yl6lLdAwHGTwoh
    uNfzxVQnKqFzl3AL7A9RVcm0T1IiA8ugBS79c8d87Vlt7UvDk1nyBGTOn5ulRItU99O0C6
    rDQNkSVwn2epxx8pTNKeNtG01hpW2Wu6biwE/GlUYkouu0JIM4I/elD9ZxHt9m4BFpooix
    mv6ARkhMMi4i6TD0oOZ6f3WET1CHKsDWX92TNOC2J2p5aCRBlc56Yyzbc4801BgRXLrnHA
    rAlt3GqvwhjqJdE0kqcSyoPF+T1QHhZXNJ7JVzKQL52krvD1urDVPKFXcg6b8k4bR1dCif
    nb5Of67dnL5v9AuHfCk3X2QtsBgFzmZ4qxDfVo/HCy7r2iZYHYb3Gcq3p3bQ
X-ME-Proxy: <xmx:L0PPaqL4UTXn5VboeyVIUgcU6wk0TfOMA2FMhzd3YzMHwyDcjUbjSQ>
    <xmx:L0PParme4be8qR7S3EcpQbScGmRJTUFd8WHE9dIpE4TOEjJYjOCQDw>
    <xmx:L0PPaqQYzQ4bEkcjUUT_bPKxvNEcBhGNt_SjlVkmOVvYkhJ2k435eg>
    <xmx:L0PPalLpkQgVJz3z7O2IrVfKN4_dZjg3AHlnSs-Y_il4_K2Qnqzn8w>
    <xmx:L0PPak_Y5rDL0UV7AgzVkQFMutAmBsWvVmEegzZoRb9upLG0BQY9j2_j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:54:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53c22126 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:54:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:53:48 +0200
Subject: [PATCH v2 4/6] odb: remove read loop for found objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-4-fed9b2caa3be@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Before moving alternates into the "files" backend we had to handle
alternates in `do_oid_object_info_extended()`. This made the retry logic
somewhat complex, as we had to juggle reloading of the sources, the
second read and fetching missing objects. And to handle the potential
retries we loop around that logic multiple times.

Nowadays though, the reload and retry logic are located in the "files"
backend itself. Consequently, using a loop is a bit on the heavy side
and makes the code harder to reason about.

Simplify the logic by removing the loop. Instead, we explicitly re-read
exactly once after having fetched objects from a promisor remote.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index 69a4c203bc..095183aec0 100644
--- a/odb.c
+++ b/odb.c
@@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
 	enum odb_read_status ret;
-	int already_retried = 0;
 	bool corrupt = false;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
@@ -277,38 +276,39 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
 		return 0;
 
-	while (1) {
+	ret = odb_source_read_object_info(odb->source, real, oi, flags,
+					  &corrupt_err);
+	if (!ret)
+		goto out;
+	if (ret != ODB_READ_NOT_FOUND)
+		corrupt = true;
+
+	/* Try to fetch the missing object from a promisor remote. */
+	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
+	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		promisor_remote_get_direct(odb->repo, real, 1);
+
 		ret = odb_source_read_object_info(odb->source, real, oi, flags,
 						  corrupt_err.len ? NULL : &corrupt_err);
 		if (!ret)
 			goto out;
 		if (ret != ODB_READ_NOT_FOUND)
 			corrupt = true;
+	}
 
-		/* Check if it is a missing object */
-		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
-		    !already_retried &&
-		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			promisor_remote_get_direct(odb->repo, real, 1);
-			already_retried = 1;
-			continue;
-		}
-
-		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
-			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
-				die(_("replacement %s not found for %s"),
-				    oid_to_hex(real), oid_to_hex(oid));
-			if (corrupt) {
-				if (corrupt_err.len)
-					die("%s", corrupt_err.buf);
-				die(_("object %s is corrupt"), oid_to_hex(real));
-			}
+	if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+		if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
+			die(_("replacement %s not found for %s"),
+			    oid_to_hex(real), oid_to_hex(oid));
+		if (corrupt) {
+			if (corrupt_err.len)
+				die("%s", corrupt_err.buf);
+			die(_("object %s is corrupt"), oid_to_hex(real));
 		}
-
-		ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
-		goto out;
 	}
 
+	ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
+
 out:
 	strbuf_release(&corrupt_err);
 	return ret;

-- 
2.56.0.212.g129ede20d9.dirty

