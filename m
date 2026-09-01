Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B54734D0
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261006; cv=none; b=cmZEIyKsYiIl7P14I3+9lD+qr4MS6YCf03Ckp1CqjqO8nSWVs/AZ3taXtKG2TaRWKuH3vS0iBPVyjAPVLCgRtX2gS/ZWwMDmFV+6azukeO7M5ogM+UVlmiKdsDmRWq5RPBk+DFiYRt/8ez7xcg00foA2nrcS3qngjNwuqeGmvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261006; c=relaxed/simple;
	bh=t3SZebhGthAGCpNqV4n9HiJOC5F47PiapXAEWfN/xyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3TOAseNqNCDl0ugsXrROLIJXmt+tAow/77jJGNg4ASKr68xIwao6/HFR6lNsVed110m1/08byeuLFjiXar2Kj/7zy8ybV/s2PQuAaF8hxQ6x/rqLHePaI6NE5ZPNxLrtVachtqu4j5ugkpcMBzy/i61FZHjrgIa8kZiVijmNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HAOesP7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQN2VKYn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HAOesP7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQN2VKYn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26A85140004E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:10:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 07:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788261004;
	 x=1788347404; bh=/xYB3y8sXLcL/rk4yRDdsPvnyvsBIx5Z8NF1QXD+MKs=; b=
	HAOesP7CVi0ywl6ouGNLX4pO1qljwQNuGpzs3iBy5svD9i/tf10oFOqTuhT6FwFU
	VXRfHYEoBb6gfz9ZqD9+VWs9/TVHGs97OEmEQp9r7ZQ9/WvbGRKYt09ur4yzyS4B
	cqeDDXX2oJksGNgKfEzs6cozJRSpxLWFy3+YboLoBf7xeWkiDkdBGtRK+7ETbRGW
	+IZpoIBbrjM3Zihu4K/2V7Qsr2FvzM0pn3S6+01swyWkipJk87c5/pcmh+swlxwc
	wPwEjD5DZY+YAw/K3lJjqdX3/afQ+SugsalL4Xu/HhSLk8/nUVw+rcAvYFi8sV0T
	tdqRoALE2uc/NMRmjqgs+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788261004; x=
	1788347404; bh=/xYB3y8sXLcL/rk4yRDdsPvnyvsBIx5Z8NF1QXD+MKs=; b=e
	QN2VKYnIOUgYHdAVpnooZWz5HX9tmyTehC8nhq9wEZ5m6NrHuvDW4ftWu4aFXebX
	2OwiXDcWWbCA+hjPJn354y4rDOiV7oc3Cq/TDbD9Z6FcDSb/ebENRlIdoQytuwk7
	IG+nF5xgO829BIzCdWksy07enT231JHaIf6kqWReApfgUVo+hWJekSETQTFiO80b
	DItZ0YVuevN7CJHandTNlmOw9Fh2EgwYQB0J9TkJ0dZ2RSt/OqTQDsH/U5AnTyij
	Y135MPtPZeucHfO4+1VKQj18e4q5GSyom1Liukue37BGmCZwwWU4AlHg1AUNDs3P
	f7CMhe00rIimyKws9MGUg==
X-ME-Sender: <xms:jLKWamhoM-5zB7oapZP9UzEYrtqI1y4WyXK2PqD2BRbvygUROnQtSw>
    <xme:jLKWat_4MLIxPaX8pE8lSYQaHNwS4LHmfH_agOH8CIyNKqp5nr8MNHRahFlq01cfA
    5Dw9uAvQ1zPDVnyapZ0BA2nie2ScGn6a7G04z8h1bJIZ4rGHrWnng>
X-ME-Received: <xmr:jLKWaju8KCqCT0ibVRumHdX3p7HxQP3_g5dCHR_5SZNrGIppvzV_8w>
X-ME-Proxy-Cause: dmFkZTEeyvyE9BuZcM8JHEm4Moh2nPcUNK8pAx5r2Q02EYIrWKM+gDqVSbXLFQIpTobG57
    aGld18vdYhL1pDxV0Znl3BI2ve6CU01nilPMGA79S2Gt5EJxUEPlfueY1yjqSs4a0BNUC7
    J/cPOZEYgdXPIW0ZMmA/8hIxRcf6GoRJQ3EjyKE7zm+MFrMNO0tViwYkQ//4Wo9PdLNjoy
    PFHS5PumEN4EgWuEaZbANAAZIG+P3KoDL8pqiGuSNGPxkJS18GzciF7M16M1IxnBUkyTiI
    S5eHOOA0eRNDhev/L6nfd5l50JalkGLbrDq4jHPQqapu+ixRAn+4m+Sr3uEl4ZmoWOdOUN
    ta/gnI5iM7fqNQO7whGqpcmN29wMKQsBkr7HStosZfkeBYTD3N83ayC3kIQgpH9sKvR/EV
    YBZx7IZ//0bDzcARtI6mhNNIjr9v97utdIXv2majM8w259RZlwdC2K/Bz16kMf4PdfZPPv
    R04cpg93pwe79DRXnEzWVqAHUe6qYxwt9jiLNr0skjfLZaImFejvaZE9Dt0Dcs+k1xqG42
    AwmklQJ5HQ2THqu1NJmzsUTnYMv1tBo2iBR4a/pL2UwaZ9xI4tWKwpL5CHkfz9oZU2OEs4
    14PoU7wHzDReD4VceXEIx6qoix90tWlriqSX9HbGjJO41rbJidAFNH1STIYg
X-ME-Proxy: <xmx:jLKWakaoTqU3vBcLYnYdBzGxAlwnv01SoxPb-XxiDQ1GZIHu8v3lvg>
    <xmx:jLKWajp_WYNrcX8ekrjEELj33wrdhrQyUvAf6e-VI_IlksiTcBHC3Q>
    <xmx:jLKWap80jKwCKVPYUwe3QVGFsLUMg-JYvqnj_T7cIRv-qjKTeIBSdQ>
    <xmx:jLKWai9LjOKXEbxdYkLMMiAHjGuvrzociE4dabUnR-ioPTu9Sl0AnA>
    <xmx:jLKWajiV9XfkXVbYI9AJoNpIM6lX33E86WpRpqqL_eNfkE59ax8OhMJo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:10:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08f0e131 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:10:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:11 +0200
Subject: [PATCH 12/12] odb: remove the ability to link sources ad-hoc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-12-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Over the course of this patch series we have adapted all callers of
`odb_add_to_alternates_memory()` to not do so anymore. Remove the
function.

This series of refactorings doesn't only simplify our code base. More
importantly, with those changes in place we can now unconditionally
assume that the list of sources linked to the object database only
consists of the primary source and its alternates. This serves as the
foundation to eventually move handling of alternates into the "files"
backend itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 6 ------
 odb.h | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/odb.c b/odb.c
index 2f8a70a90c..5fe081496f 100644
--- a/odb.c
+++ b/odb.c
@@ -247,12 +247,6 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	odb_add_alternate_recursively(odb, dir, 0);
 }
 
-struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
-						const char *dir)
-{
-	return odb_add_alternate_recursively(odb, dir, 0);
-}
-
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 						    const char *dir, int will_destroy,
 						    struct odb_source **prev_source)
diff --git a/odb.h b/odb.h
index 54548efc55..9025239df5 100644
--- a/odb.h
+++ b/odb.h
@@ -258,14 +258,6 @@ int odb_has_alternates(struct object_database *odb);
 void odb_add_to_alternates_file(struct object_database *odb,
 				const char *dir);
 
-/*
- * Add the directory to the in-memory list of alternate sources (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
-						const char *dir);
-
 /*
  * Read an object from the database. Returns the object data and assigns object
  * type and size to the `type` and `size` pointers, if these pointers are

-- 
2.55.0.979.g7e5102b832.dirty

