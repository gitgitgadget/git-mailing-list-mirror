Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD232C3278
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445421; cv=none; b=KXmYoN4A7wto+TiYMRrdXVEipMdZwcHjjBIt5HfLzeiZ80RtPlVbbPfr6n4IKtzk5bwy3BcMp14KtVWd6g0LY1jZ3gkwGNb6D55+3Q8NTVYMy/NkQmLHaIN3k2e81uiPaHK2imGqG5XrvpBsZ5JwODxJJBdR4UjWuhtTRoBj2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445421; c=relaxed/simple;
	bh=Vb3C97cWFwpXgU/3997ak8GW4/eY+NLXaf5Q0kOkanU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUph2uDK3pvI/DK9UOHuyHFzruBuva5E8Ne5o6jZav04aIzPqystOWCoKpkvdFnZ2WRDpxx9nhXPf1RwfMwhN/pwfslhx3m1HLM5aF9xG2Nuwc64mB1Iy5nkzUI10JyK2kzep95ddC/SyFMzyyfREmyyw7fjAjOgXwniTfoUffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZJyMlSXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fjim18Lm; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJyMlSXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fjim18Lm"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EACB71D0019A;
	Thu, 11 Dec 2025 04:30:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Dec 2025 04:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445418;
	 x=1765531818; bh=S6EC/qhE3a0IqgPYfp3vRPHMAkAdYbtnP91rulNzagc=; b=
	ZJyMlSXT3RnxecQpDTQZrPz5RGb5Z0uzQqqOoUkzsESjJXNAIwO+gf1f7jkofZUl
	smYwIPF9iGWogj//Oe0bs+DkAb+GfYWA0rf9up/hb7Tc1hbYGBta7BQoAQdLm2su
	uUvdSVFjQz6d5QrbFZOgPlZOmqA+H3FO2ax4ogjE5Ro5mAUMPqyeVeO4OdmhoAXr
	x+lpq1/cvKtp1aPPkI790qvk8GGipCsryfNQQYk5Eu59DSDBacUpKLFtI4cy56+3
	2QWYBKIQbI7GGz1GT/GBLLgOeHn0tKho3TQZFVub7QLxqllKeUOVa/W/NM1rePov
	xmsV3zft584s8+7syyC2yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445418; x=
	1765531818; bh=S6EC/qhE3a0IqgPYfp3vRPHMAkAdYbtnP91rulNzagc=; b=F
	jim18LmC6obumzs+h+/Hljn4vjE/NuT8gBswuB03Ec3X/PUi3y8teiQfV/emqpjc
	elxwqXi6pMtI9m72sd5Yj1Se29X6xxU9o8q93C+sFQsOmm77D1hCp93Gemw6OMkc
	x3PNYxLWt6rSUnOyQRyWt3CCQvAzL3pzIPnLMvytYLaoWfxwLuWN9ecQSP8EgNV7
	br1Uz9gKw7+wy1iQM8DT+EiWo1O9ofnAkRFFniWemxyCOAS2jIIX8n5I4SxvzMsx
	LMqz/L3Vdd8A3dTuHUc6rBlabjXJGxQ3JA9/UNIKRfK6fj8yXVKCo7yoF1/IFOgs
	Obm8UcSaoRfnXi9UN4JWw==
X-ME-Sender: <xms:Ko86abHqRQAVMyjjPaD9revO2O2e_A9CfbNIYlWAXpbVGn4gY9qLCQ>
    <xme:Ko86afzqnXl8h7Cn0K2rIyUgDc97USckTr2XqvTfhnc0uTBxbDrgF3TT5bwjhD7xC
    xLUNYF6ySKAmhOVdPq8R-MXrfplrWUx67jUZL2rkDdr3nlyjwJRl5o>
X-ME-Received: <xmr:Ko86aah9KQZqZShGFx-W6CJuESO9GfrILMO1Xz0lpjlaAacQ9jPJVfUvtaLa09d7DBhCWgnZCE2O-nTTlzqRZUtafM5bCglATNSAE10-C1TB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:Ko86aSz0OVZHVThqsYpcW-M8g06LHcVxfB8iY0O_N1mLedX8b0ubQA>
    <xmx:Ko86aVL6_XJIgzUHaGTBZrMa2AfBEr1Xc5tbdgltfd5-vOCrqfEEjw>
    <xmx:Ko86aRTCMg9AJQo82xsHDm1AxiiYVSJFw8be7vND6I3m_Kc38iGNjA>
    <xmx:Ko86aVqkPcP5XlO7qfGCHi_S6SzLUG6wvw7YVarrcAcwIUnpvCLgug>
    <xmx:Ko86aQMTM5mYa1lrw8l_zFTyE-gWmspa17NIGx1Pnm6UDZUdeQgHVZeP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97b47003 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:10 +0100
Subject: [PATCH v3 1/8] odb: refactor parsing of alternates to be
 self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-1-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

