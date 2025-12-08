Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4E2253FC
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181076; cv=none; b=JhrBTn60EVPeVECKrBkxP85IepuiXAnZ9kqhscgFhcx0rcKAXcg6w3li9BwC+ehvypd6hOOtgILvcr2gMm8Hy/iddJJUFdGCiWmQFdqr4KQvp/TEjKtt4Y+z1NK07MMz+D5tpX9GQ9So6H5m9PE+G18m6Nonv4j57UPt6XtL5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181076; c=relaxed/simple;
	bh=Vb3C97cWFwpXgU/3997ak8GW4/eY+NLXaf5Q0kOkanU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPBhkpcVeLTYHRmyzjt1vGV7zBgcl/7bv4CT/ClvI/tOtR6tKD+HNgkfiyb/PBshT0y3AJW/V4j1c0Sif8J/EbwMAeCk1aJqAafq5TQHnNl/dHnqiKbYTCaIbdkTSoGB5Pq0OSGaYqlHAEInrFahFw55ms+L0bJbjWASUAAk3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bE9FhGHd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4QLH9We; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bE9FhGHd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4QLH9We"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 038A17A01E5
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 03:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181073;
	 x=1765267473; bh=S6EC/qhE3a0IqgPYfp3vRPHMAkAdYbtnP91rulNzagc=; b=
	bE9FhGHd9Y9jSJYY00/D47ELH0YRrEwITTXDt9ySCrh/Xlt5IN6+jey4uoSnqK1K
	tRA3eAIUd7kkdpHdCrTtvmlofhcXknmIrF2fKatuMm6ZJ65yIsaFBNx0Ay8CT888
	lK3sroSahJA6hmDm3wffPbwy2z1MQ4T9ttTrOvUYY6OSNa9o6WGHKWVnv77AOi3F
	PJ80e1587jZ5q6boIkBTaH2kcL1ZqgTNyox6aCv+PxQwQN10R0ZXQl1y1AdaR86T
	4vY2nyLI8t7v64xiJkr60sT49X2W87OTWH3OXdIMkk1Ks81H4lS+jiN1HyhLhs++
	zZp02GehqslvJjjawLhCEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181073; x=
	1765267473; bh=S6EC/qhE3a0IqgPYfp3vRPHMAkAdYbtnP91rulNzagc=; b=b
	4QLH9WeOSWXwRgUBNNhjFXD0sCibz8JHjCtjkt+EnTGmpHSj/ZCthgzE4v/UpeuA
	k3949G/RniB3JmV4VycNJlb0DDrZwnEno/83dQVWLIYTqMqBIJceUb1BlQEm5qnF
	h3huUyv+94NPbd0Z51Qhvc9Pcw0bm8wvebgY0u8YLDQURckwiuBbHoPPfLNK6BcR
	LQNdA5MKsugPjMo/UXPy0SCeHf5+pwcfZa2rcXMyIGXa1CfRY6S3uQMdDM3S/ALb
	3EyW9MX83Pxi4cSZya+8RHEeZotznn7ulSJiHwgyPAD191HxGfRPPWPuLvxSwJF6
	oTGKErynjo41BT08X5oPA==
X-ME-Sender: <xms:kYY2acAATg91n1sStJWftfWluod-jMEVmstL2sd1b_vnT7SHd4wdMA>
    <xme:kYY2aVfmgnADLU8FkGzgfUDKLCf0TTSs4NUKyEUW5n4KHiujbzVq1aoHMNetNgv5N
    0e3hzDJIghDypb3DtZMCztj5zGEGRcaQEn__OTTh8sgUD8xOF6Y>
X-ME-Received: <xmr:kYY2aVOoBMlvnf7w_BRXOueDa8vY9f8yPNyp_6IOyOBQ4q1CmELqCk59svmRhRHRMhjb6WVQao9EbVGmH1M7UQh7znRlFd0WsWopOF8Sw9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:kYY2aX6-L1UY2hw47K6RAgco7BgWNAbzrhyvCLIIwoFoesW7cT9wTA>
    <xmx:kYY2aRJFxqswlrsaBHoMUBQKwTedPmb36krshuZMTLIukTqiKf2sIw>
    <xmx:kYY2aZeBvE8hG1ajzbDRwPw0148Syx9el_plqI7a9CqYoJ7pXscQBA>
    <xmx:kYY2acfg48cJ1VumP63qpbKzCXY26KZCk2mFjfM9CFOgziJXDU1o6Q>
    <xmx:kYY2aXCpqPO9KPgRyWQY3Unvtz184La1m_rhkr8jN1446b-fzJyfrLLa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb41d78f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:18 +0100
Subject: [PATCH 1/8] odb: refactor parsing of alternates to be
 self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-1-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Parsing of the alternates file and environment variable is currently
split up across multiple different functions and is entangled with
`link_alt_odb_entries()`, which is responsible for linking the parsed
object database sources. This results in two downsides:

  - We have mutual recursion between parsing alternates and linking them
    into the object database. This is because we also parse alternates
    that the newly added sources may have.

  - We mix up the actual logic to parse the data and to link them into
    place.

Refactor the logic so that parsing of the alternates file is entirely
self-contained. Note that this doesn't yet fix the above two issues, but
it is a necessary step to get there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 70 ++++++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/odb.c b/odb.c
index dc8f292f3d..9785f62cb6 100644
--- a/odb.c
+++ b/odb.c
@@ -216,39 +216,50 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	return alternate;
 }
 
-static const char *parse_alt_odb_entry(const char *string,
-				       int sep,
-				       struct strbuf *out)
+static void parse_alternates(const char *string,
+			     int sep,
+			     struct strvec *out)
 {
-	const char *end;
+	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_reset(out);
+	while (*string) {
+		const char *end;
+
+		strbuf_reset(&buf);
+
+		if (*string == '#') {
+			/* comment; consume up to next separator */
+			end = strchrnul(string, sep);
+		} else if (*string == '"' && !unquote_c_style(&buf, string, &end)) {
+			/*
+			 * quoted path; unquote_c_style has copied the
+			 * data for us and set "end". Broken quoting (e.g.,
+			 * an entry that doesn't end with a quote) falls
+			 * back to the unquoted case below.
+			 */
+		} else {
+			/* normal, unquoted path */
+			end = strchrnul(string, sep);
+			strbuf_add(&buf, string, end - string);
+		}
 
-	if (*string == '#') {
-		/* comment; consume up to next separator */
-		end = strchrnul(string, sep);
-	} else if (*string == '"' && !unquote_c_style(out, string, &end)) {
-		/*
-		 * quoted path; unquote_c_style has copied the
-		 * data for us and set "end". Broken quoting (e.g.,
-		 * an entry that doesn't end with a quote) falls
-		 * back to the unquoted case below.
-		 */
-	} else {
-		/* normal, unquoted path */
-		end = strchrnul(string, sep);
-		strbuf_add(out, string, end - string);
+		if (*end)
+			end++;
+		string = end;
+
+		if (!buf.len)
+			continue;
+
+		strvec_push(out, buf.buf);
 	}
 
-	if (*end)
-		end++;
-	return end;
+	strbuf_release(&buf);
 }
 
 static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 				 int sep, const char *relative_base, int depth)
 {
-	struct strbuf dir = STRBUF_INIT;
+	struct strvec alternates = STRVEC_INIT;
 
 	if (!alt || !*alt)
 		return;
@@ -259,13 +270,12 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 		return;
 	}
 
-	while (*alt) {
-		alt = parse_alt_odb_entry(alt, sep, &dir);
-		if (!dir.len)
-			continue;
-		link_alt_odb_entry(odb, dir.buf, relative_base, depth);
-	}
-	strbuf_release(&dir);
+	parse_alternates(alt, sep, &alternates);
+
+	for (size_t i = 0; i < alternates.nr; i++)
+		link_alt_odb_entry(odb, alternates.v[i], relative_base, depth);
+
+	strvec_clear(&alternates);
 }
 
 static void read_info_alternates(struct object_database *odb,

-- 
2.52.0.270.g3f4935d65f.dirty

