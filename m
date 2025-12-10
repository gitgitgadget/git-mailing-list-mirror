Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC21C69D
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380765; cv=none; b=lVSuiIGr2xMbPArmVBosbci7plo2aUi2R+yv9QkNI6AX5urDz0mLQGdxFTPLPelrKsH8NWCBwQL35ImKohjWnEO09YTgORyGVrUKG/k1sHkjZJOp96dCJklBPH+4B2oekn1RJhsVoRlgljfBsD0XAbTh48A3Kx9MLRCr9uWQbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380765; c=relaxed/simple;
	bh=Vb3C97cWFwpXgU/3997ak8GW4/eY+NLXaf5Q0kOkanU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDs1rwgQy1URxa0wx6dvnntDJqgQLPoTljg1bFbsnc+mpPduoKMsgEfv76MI9V6DotiCLtGbVEoFJ3riiFxBG6glF8RngWSfJua7a6h4Rg0xI0d+IscqH3giZvCZIboA9yyzvGqVhj6w3I3UTafJkWOHHYaqNaClc7HjPwBclKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vxvSPN3f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SaAwnEyR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vxvSPN3f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SaAwnEyR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A1ADEC0568;
	Wed, 10 Dec 2025 10:32:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Dec 2025 10:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380762;
	 x=1765467162; bh=S6EC/qhE3a0IqgPYfp3vRPHMAkAdYbtnP91rulNzagc=; b=
	vxvSPN3fPHSUwBms74Mn7c1n3hsSVUGLSYtr0ZjwNY55TuWvx1paFIo+gg3hmdvX
	rRG1BDduMpjPQYyE0dPRbqIILCaIf+Zqs/LQ5Rs51Kf3+W7aIYCE1ZCfB79L5wfL
	SBqK5jSPD8JIR1Sj7xe8TS0eXevx95kwCVXp+NDgbVF+el5iugbwVLZM5GDeZtxR
	YNrpBykR1DOVeufgV545ufI+p+pwmeTjIwlw3f6FIMBJ4XVJWwK2B/lQ/ETy0c9C
	YsGkVOaPRG2rlgdbN352NUyH8PQPGfS4uRpivx2x0k5G/4cSIyIZz2alT0nm3OQu
	D9sP76mRBmN/VEphlnjNWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380762; x=
	1765467162; bh=S6EC/qhE3a0IqgPYfp3vRPHMAkAdYbtnP91rulNzagc=; b=S
	aAwnEyRNRRZmK67oEGeId4PWhnj+sCWZZnxxlC2Aaeu5j0oULZ8sVXq6AEoFeRWn
	sns1INCT72k92OsS2V1+68e6sImZi2w4xbzbwPQKrT3G780vb1122UcRWPGaWB3T
	x/3HBCQF4YdR9+ULqmgRCE0Ai/dcPOmMsUbtn5bKpdYDei2gAaUWdu+5gJk0VwZQ
	e/ylWb1U72p/vnk4GcpjX8OYVZNmW69lCrmcH5f6lTgeO8SYEmrpNEPMAWvClLlj
	HdsDz/fL0u2JiVe59t9Cl1+ZcV1LiNXJAy/KWFJ5FJDBJLEzYxMfseqEQ+4L7kYN
	yWuu6azpFboaYANz4UQ+A==
X-ME-Sender: <xms:mpI5aU1UiTADyG1W4Ph9xp-U4C6kX_4TWoq2eQySp0d4JPt73IeOQQ>
    <xme:mpI5aVGyxWG19fC2y42pz4pgBcPQ-Ks2Gy8h9WDeKoVFmjDSzXpgl_rbMYzSCy5Bf
    Juc2M1nyO9W6MiM-Nnq5GgfSwczK6618kJqZXhjVtFotgNehqySgA>
X-ME-Received: <xmr:mpI5aaioVhRl8Lcu2WRA2y4ZLZ8unkV4IVRFnonedNLXus9bfmrDi49Z1wxgRAn9FgOnXKjvxv5TpY3511zq0MoGxg_KA6JbQjJ8jRQa8RhN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mpI5aY8IJ9d6RcI8o7wUOe02-rKgNI5FdkeoI5AeYSDd6sLP75bXfw>
    <xmx:mpI5aZqc6XwL_juhODaKWwBMsAcDcX4q-um_ZKg_TVSXCJtqRtpqOQ>
    <xmx:mpI5af_0uZmCGyA_B0avBwGIv8d1khzYE0uaayiE3GNfmEUTToRhig>
    <xmx:mpI5aVUd816NwIwTad-A6tXSDemerD9syoG66Jl-gnSFGPr2EStCow>
    <xmx:mpI5aRkMGAJRjPJ2E9ovXPT4OsiUAVNgq2S6ZqaJ1J1QI9QIdq7FJWaL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f71f90cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:34 +0100
Subject: [PATCH v2 1/8] odb: refactor parsing of alternates to be
 self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-1-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
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

