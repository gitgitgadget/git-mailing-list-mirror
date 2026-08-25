Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7542481257
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667162; cv=none; b=mnq3S76aV/rdk/tdECw8gSdCQBuFan07wa4RZ3SOGADoS+z/zajmHwf+s7Vjk5H0wkuwPsIhMYA1gzjzUwNiObW6bvz+RGaRZKE5WkVa+ILsUmd58EihBQcqpMQvU+TAiMY3iklJChh0Zr3K1jHjE164N3IsL2oHK3JK9oJu/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667162; c=relaxed/simple;
	bh=Y2QhzptP8e5U+S9WJebYHsCJTiFaOhgxGelNR92j+DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRkS0qm+JJxJ/OylWk+AC1qU4zanoQN3fAAYJqUmIZXmzXFZn/xSugwM8crIsRcbuuQEB188v2CzJeSIHC/tyt0ABJTJ9fIhnGjVYi5kZiY+AbL/nm4sEap5ByFAXuwLWah8kXp3P90NJaJh5He6tHZFSiEOaILxbkRRHNnODLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MjshmK42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N15/GmK8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MjshmK42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N15/GmK8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E4A47A00E7
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 25 Aug 2026 10:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667159;
	 x=1787753559; bh=n8JnNpwp/QmvMXXjro6akUwONobBuYSj7Bnbu5to9o8=; b=
	MjshmK42XLx9NPCwLA30eW/vflKffJWbf2hDGtIf1BIh9ErC2FiH2J0PtFEdwdDb
	6f3FfNn1817vBTFRF9x31kg4SgTAuY6zPAENNOtJgK0gqmmtgM07F//6vjk8tMAx
	26QdD0r3CznyLwga98dE8G0653U7OXcXK0hOfkM2e7LynBcCbn3jpX0VClk11nwG
	X10jB1WbiIiu9femrBePju6uGbJ4vJzwbe8z080LPOZJGm49ZNJ+4NyWxnDwyiOm
	AH09ZqU9D6ONiadsk4cv/k/Xb1j6ZYEr4CxYqSR8m5G5/SYdc5DAjnb6T3rv/Q56
	rDWlCRE0qj0txZ5jcnk6XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667159; x=
	1787753559; bh=n8JnNpwp/QmvMXXjro6akUwONobBuYSj7Bnbu5to9o8=; b=N
	15/GmK8ng7yHi5IyytXettagtzmCef2AvxZH5CogW9rVDZbUSlkY7MSVSRVsuIv6
	A63IyY155lJQ8wcEOCorc0etSYOH2A5UUb4xaRuGdpymN1F4zBYF09XP5j1V0xFZ
	hndb2vPmnydjxzke5YF1ipOBM0/ZwhpKcA4EwTq3fIySVCqoBsCk2ldJhwreFg1y
	3Mg5i/KJT6j31HZAlrzgerJ6V7HBNy/OHEc741kfGuRr9N+PIMHKNQvJ33bsfdkX
	wbBCOPI/xugmW0KOvgom5YruL9dgAR8/3Mib/OGXSk7ckSxyP6D3P7757YCMCX/T
	tqUjfpubt9uUt6j0xpicw==
X-ME-Sender: <xms:16KNaiEZy9TyoIEoApn4rRMy4Y4INa--f8RmDJBEMu9uZ6II_fEGUA>
    <xme:16KNaqRtGYKf8r89j0YusaMlHFN27vmYjMe7Gb5HlCeH0dOw9HgAcJ0nv2oWU21Ql
    DQjJ_N0aaA-4ePjrK_de6zTR0tRajWg2DMt2uiTpwgGk3XZHGEnGQw>
X-ME-Received: <xmr:16KNahxypwQyUnxIxxZEo-qHfIoui5yrzd1obPMCzJ1QKacw5xCLJ8_nsJFkQIOwq5zckUeP1YzeqS_nNEPQ0QJWLEcuuRJdL-0J1vMRMw>
X-ME-Proxy-Cause: dmFkZTE3jfoGHhusg9MTdgZjjPeXzunuY8+VTV9+ccqpDyM3jHYuDTgaXhieu+hGrwVK6t
    LYjEAhBAqq+7bXnTA0XgdcWZUKZhde0atPjeiQPpaWlFHkA9r38J2jU1gZpIpXnz+H/rop
    zTqPBgefCiexiXzdoXyFwC604wbImO4Jif2zfPosGifPTvusCEPKy+N4dzxJ+TL1MNIUnc
    /cP7WHPMVQlW92N2wdww5yTruPEPqRedKOAg3za/t0KSGG8PmOeot3XPVYoqCw60VQUaN+
    1SHeJclv84gmHXMMggnBfUtBJVFgWmgDAcCBvqsDsOImiWwbZHF68zoi2wewJr84jC2Fnr
    EzznI/O63wyKCRmxJr4ws1j1YrPpl9dlZQp8gcY6j3XQoD+TzwSV/MHZUx3fNC0GJJ/2qb
    VlEdfSFw0yI/7f5lQc6rd53Imsqlq7UE28JGqedG1Ks0MXrD16UURPuVlCl7T4uopxuUzq
    bFIGKOIy1UGh3ODjYWy6MJ3a76AS/m8KCYzC9W2f2bzmx+S1Na8FEFi0ODQhzgs0ripeR/
    gheiBhTBzAIWXAv1kkysyLaB+V1ti4ndq1c4mIeBLNQ0fv69CGGvouRpP3kdmsABwpWwiO
    t1p3OUKgUHMWd6kk56AcKkMdxYwLL8N1N6kiJJFR5bE0ytxoAX74cD5wK2Eg
X-ME-Proxy: <xmx:16KNahM_Fk52f0H7PBXxoiNsmu30nGfnqQWoZHTF11-m1s0GlZR1BA>
    <xmx:16KNaoPizHy6mDvFqaZGzH-8UkZz44l-kAOnQP-CyTsiLbiLc57mxA>
    <xmx:16KNarQQLWN1aoVh9bIVotJDn1I6YbTT97esSyu8w5L0n1I0ZHtmQA>
    <xmx:16KNaiDeIESasV6Q6CRG1_9vW2b6EopZ0yQE1D9YP8qKRdFq8XV01w>
    <xmx:16KNakV5tBZJZRtYlpINtznjasHZAxGFJQnPER7xlwvWvP5TiuxB9CoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a32ca36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:51 +0200
Subject: [PATCH 2/8] builtin/clone: move around `setup_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-2-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In a subsequent commit, `setup_reference()` will start to call
`copy_alternates()`. Prepare for this by moving the function further
down so that we can avoid adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0a67492ebd..8c990ce0cc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -179,16 +179,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void setup_reference(void)
-{
-	int required = 1;
-	for_each_string_list(&option_required_reference,
-			     add_one_reference, &required);
-	required = 0;
-	for_each_string_list(&option_optional_reference,
-			     add_one_reference, &required);
-}
-
 static void copy_alternates(struct strbuf *src, const char *src_repo)
 {
 	/*
@@ -228,6 +218,16 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void setup_reference(void)
+{
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
+}
+
 static void mkdir_if_missing(const char *pathname, mode_t mode)
 {
 	struct stat st;

-- 
2.55.0.822.g20453c30eb.dirty

