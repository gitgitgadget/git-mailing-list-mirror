Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633649F10F
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356134; cv=none; b=YWWHmibHAOp4dKnxUWo8vwauq2+wKymGQDUXXZ9AO3x72N5ygaHGxk4Cwymf0S0aiFdq7fAMX+i8CGkh8s+8kVH1FwIfCxTrDAGAxa8lR97htFQNmowU0sfFAhr9qMkNWmJEhMOLl7YG0hELgdSlMlnOWMcPkAtXlzVp0iVO9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356134; c=relaxed/simple;
	bh=t3SZebhGthAGCpNqV4n9HiJOC5F47PiapXAEWfN/xyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Will2a7Y/IY1ryM+nmhARl4A2hPVQkcCon2y6gAI9IIffP69FvVJqSDYReyvRU6zuqlilivkr/26/qu55/J1y7H9Hc2a28+0zlZTdDHbEmrpU01KH3afVGHx+Csfsurk4GsVUsoR/mHEBYVRC/wkEZ3ETJEMt17nIBa9YBKnx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bUCLzN3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVUISMkf; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bUCLzN3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVUISMkf"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A5157A0126;
	Wed,  2 Sep 2026 09:35:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Sep 2026 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356132;
	 x=1788442532; bh=/xYB3y8sXLcL/rk4yRDdsPvnyvsBIx5Z8NF1QXD+MKs=; b=
	bUCLzN3xmWa4s3RKLd5zXGmzqzH/wJytK2mWuDnabpXqpmdGKkrwVA0Mofew8Cot
	4hvyCccvsbOrM46cvjwszsEaarvHGgyAbNJL0XFEk3Xk5o+0nKw3pquWLn+1zhVg
	5kfeWQu83B+Ik5ZW2qAZ84K2tWbvvX5tvjbQY99LyXySKbO2EDUAgDt99pgcFInx
	KYIo73yDuoscLMz/VRAwiU43n53pt/jOy9MpiqGBIPE8BVEgy25M/oyzElA9rnfW
	0RVViVCkVJ1lJTfKY9pgb3GMSRsxtr/KFb6QWWSTREH20twuBSgVWvxve/M/56w6
	c4XRfM5yVTJcmOUKqtrM0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356132; x=
	1788442532; bh=/xYB3y8sXLcL/rk4yRDdsPvnyvsBIx5Z8NF1QXD+MKs=; b=E
	VUISMkf5+98FAvGJXHVSmxnsaHfc3QUHiV1jnt2WbtQNrKTK6nXmHK1UTY8JFJKK
	0BQxucdqYHEh0X9xxBe2Qae1m+MauMcxc4LZbSXNA/rr4EzpVmYDf1VeCRc5hveH
	QKchjjQV8OOdC8vgrfcc4iwERUw6GGxNZFfW9cP3QO4t6PBTKEZB0b9d5l8vhPx2
	+aaEFng/2TArR123ymj8B27JezAFTVKaaGQLwXoodrGxB8I3nvHiTxIQNICVgMp5
	GO+RtOstuzJWPdC8/aFIDXsb9sOrEvxCyFu03mFRLw7P5U8BcOBZMcp9bo68v7Nt
	2SlzvP47RYNT3teWoMPgA==
X-ME-Sender: <xms:IyaYaunPVbq-Ub2LF5b2a61ZZnJJU2L5vcuyYHhYI4gN5cCSCX8a0g>
    <xme:IyaYar17tABa59kaq9MYUseCvUvvq_4QoKbhJTIHlMlBhVQJWEW0V93KWOaAU1CM1
    totXM402_GdGr5zi5ENLAN0IqJtYjbOBskaZlA8Kx6r3cLGMwKHLO4>
X-ME-Received: <xmr:IyaYaqRziaDeQ-LJUVpicMBcFXEDMjucJq_zYcMEmtclW4jU5bJ94seH6ogV02tuaLrAoTo>
X-ME-Proxy-Cause: dmFkZTG4ZQ307c0r+GT+cG0MbckYhWlAFFJxCbC0xT9lvs2dpNbfp5F9i62CHGxLqxgQEe
    1KClkHVJPGKYIUdzMTZI3Wayv9loYYluTZTMLtBxFxFx6yRoVtEs/1+0189PyMCQH1L56C
    4/84m+fxkLWTwq7X++7tLMV+dCd46hrgvE/2HnstGCs2lxTTPV1QPl1CAIe+19hO2dqMGo
    z/R/W1DbWne0aicrH1l+gKAEg55+PhiT1pD2GHQUC6IMshvIH8K5QQPcdDBjCz5r1rQWpU
    tSVYKTo0wvI7lPxKf7umF/8t+XwgUF1IQNPP+0YcwY/RmETnSnMzYq3vMEuyh6kueB4rdq
    fwjPsOtRPTn0W3NVEnkTkBN0iuSA8Z/R2X5BWP+VgpGolTP+uTKLOaB8WM+/T8Yf3VVRmo
    BMtqaUwj6gIce74WXAtaWcgpdan9U6xEHygM20iviR7nn4PDQrcvAF4ZbuijM/eac7tOmz
    1Dw7es1AUQpmdWSkyFDgnipW+bDMz8mDWNRIXgJQlW6fIi0l5qNyhxSc+xJbZcZ9e+91PH
    +M5JUNmDAJQcDk3xDvW+YfQzryKAbbSbTElsorX5KMBXcydXLs5sx3GPgto2wRaG1KYlFE
    DfdvTyCiINmhIFg4todGm7G1kPsGOd/OLScdOm15WHFrphdX5xkHxvclU28Q
X-ME-Proxy: <xmx:IyaYatvdddMFf-4tkQvQZ5EayIjkzUQYT7WlhC_16cFsR7y7EUMdhg>
    <xmx:JCaYava1LEiCgCJo1tlssHjrIs1QD1UuIXn4qBu61qjdWgOXb_qMFA>
    <xmx:JCaYaitp5JatZfetChPPAa8VX1mRW6MJQuFPR669cXmddZSNGtWVLg>
    <xmx:JCaYahEc9o7NyIXXquCPePCe3dnGyI7xhT3AGM146ynu0plXN2my4w>
    <xmx:JCaYap8GhpSzCaEwKGNW9EN6FlKHeSDJxB-Iy5GGilYIbKqGzK4WGaUr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dbca90ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:35:01 +0200
Subject: [PATCH v2 13/13] odb: remove the ability to link sources ad-hoc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-13-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

