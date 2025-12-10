Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF9312835
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380776; cv=none; b=udmepFZotqxT6DLEd3Ux0jStNY7BZrjWiQ2H89rDumqhpnd91jcK6picA3LtJgWkW0ocaX0d3WTwK4+dNLf5wUBHg2o/6QWvc8urfvV+hj5FHH/T0cgFJifoH+BPmPQSHF+9aV6A5tJNTuRYqM0P5LLGmYJJNyT3RMWJVuLPtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380776; c=relaxed/simple;
	bh=mjMOFluTzgXtthEqZi/YtY/ICgROpynaM2MU/ZUMNig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZcRfhwDnOX1QwlzK8VlCff8Qvms/KXutoL3K4UjZOJF4/tIqq8o6uDOuwLhPqssapuKRlabURs3VGFoOVlo36FiONIYL5qiMSHpDYXEYUPto87fNIjCsSQK6bMqaWfoauQWLJLNgWDWNNpUuVG5KM5TrzcYesD2lq2vlJHdbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CfyZHqkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQH+NxN4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfyZHqkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQH+NxN4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB8B8140002F;
	Wed, 10 Dec 2025 10:32:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 10:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380773;
	 x=1765467173; bh=C8PtYB/3jJU+dLkUMu5VP242Sk8LuRY2BsjXurLcagU=; b=
	CfyZHqkRPqJFNqIoWfLyNntNzzuuAQBslodizZZDEAIE/0FCv3ysfYUr1gNy4MaU
	xdS1jvvukP7hABeIfDCoZAEuVvOKe07h10rcSEbx+xCZopFjSwcGHe3/DNXpndJs
	FMrIbohqY/Tu49stZzLVGnL7TOTweJuvyukbKBmb8JBn+mUuFcgsIBlyR+o1E6KK
	8yaf7LdfwV8pojjbCXuXmOv/OAr0Z3alwoxb2U0tk81dNaGwrY/wOVX/YIayepfY
	N4lquySbmkdB4makzpi0mXfOEk2OgEGfvA14ahKL8INBYhBPqxH4IawkWT3hcpFy
	uVvwiPd3mrPUGC3QKTspgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380773; x=
	1765467173; bh=C8PtYB/3jJU+dLkUMu5VP242Sk8LuRY2BsjXurLcagU=; b=U
	QH+NxN42HzXOlnu1VxJsQ/S/y5EwJyJVNmwdCmTmgtkVmtbHPgEl102oX7f4ekgi
	t7mY2aySXPquPe2dJxseq+5woSx3F5gMJ9O5K7lP1CAoWPTVk2GW6jlVs7G+2seG
	Dhx6MoHdD9A/y9fBSx7DonPTiEmubXVfFsZfy+G6pIzojDGWYamADyI1JdzR9aHe
	S38UGDivIFwSHKQtwj/c2NvvLAMNH3tcLE13bd89tYI4dTCHZovgqV02X+QntGd/
	7VrDSARUnKRbuFh+1d55mwNf2KImiJa7BwERJLG11N+gdLg0AuHSehJwe9pusKIa
	NNfqFRFXLT5kW2lBHdELg==
X-ME-Sender: <xms:pZI5af3X1z0MIUyJYrnke5y5qmSrKaXAINXx1XV8NPmlS-UXD98FBw>
    <xme:pZI5aUHkw5yxda6QVqq4NqLuXgX_8uTU0GDTj9lX2cd-pGV1eNFAzTHcdW2eTSmKi
    NIIg5HL-exzXMCCh6zcFBocUVHnZGtNP6ikBUgKZAt848QQ1ilk6bg>
X-ME-Received: <xmr:pZI5adiLr7zWGdUQYxkyDQBEbnYynnKG_giWzK-cci3nzd0LF8Tpo_GpPgkNlR5-VX-AEUzMXnhMxVNDgDTkIddFb_1ZiLxSm3Pts6fHDK_b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pZI5af_jXHGLmF14Ojo3AZo_da8Uk6wBk1_a8TIb3b5d9LU8uTtKzw>
    <xmx:pZI5aUqrPvRa6t_rM5Sm5SKgOsiMA__D6yHDgmJAA9XQnig8xRxo0g>
    <xmx:pZI5ae9VY_7-isuci_DIFbwwWNjqvjEzarta-psxXyCEzXeUIzjF8w>
    <xmx:pZI5aYUDaeX_9abGmiuolCssvjvxsYNTcye02mG7e2O0b5CS7aO3dA>
    <xmx:pZI5aclKE9coGPZL-DTWKUpfawPBLnmVVMqp8gF0rYME1h1vHf5KcauK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 684d2aa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:38 +0100
Subject: [PATCH v2 5/8] odb: remove mutual recursion when parsing
 alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-5-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When adding an alternative object database source we not only have to
consider the added source itself, but we also have to add _its_ sources
to our database. We implement this via mutual recursion:

  1. We first call `link_alt_odb_entries()`.

  2. `link_alt_odb_entries()` calls `parse_alternates()`.

  3. We then add each parsed alternate via `odb_add_source()`.

  4. `odb_add_source()` calls `link_alt_odb_entries()` again.

This flow is somewhat hard to follow, but more importantly it means that
parsing of alternates is somewhat tied to the recursive behaviour.

Refactor the function to remove the mutual recursion between adding
sources and parsing alternates. The parsing step thus becomes completely
oblivious to the fact that there is recursive behaviour going on at all.
The recursion is handled by `odb_add_alternate_recursively()` instead,
which now recurses with itself.

This refactoring allows us to move parsing of alternates into object
database sources in a subsequent step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 62 ++++++++++++++++++++++++++++----------------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/odb.c b/odb.c
index d97e50fb61..59944d4649 100644
--- a/odb.c
+++ b/odb.c
@@ -147,9 +147,8 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
  * of the object ID, an extra slash for the first level indirection, and
  * the terminating NUL.
  */
-static void read_info_alternates(struct object_database *odb,
-				 const char *relative_base,
-				 int depth);
+static void read_info_alternates(const char *relative_base,
+				 struct strvec *out);
 
 static struct odb_source *odb_source_new(struct object_database *odb,
 					 const char *path,
@@ -171,6 +170,7 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 							int depth)
 {
 	struct odb_source *alternate = NULL;
+	struct strvec sources = STRVEC_INIT;
 	khiter_t pos;
 	int ret;
 
@@ -189,9 +189,17 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(odb, alternate->path, depth + 1);
+	read_info_alternates(alternate->path, &sources);
+	if (sources.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      source);
+	} else {
+		for (size_t i = 0; i < sources.nr; i++)
+			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
+	}
 
  error:
+	strvec_clear(&sources);
 	return alternate;
 }
 
@@ -203,6 +211,9 @@ static void parse_alternates(const char *string,
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!string || !*string)
+		return;
+
 	while (*string) {
 		const char *end;
 
@@ -259,34 +270,11 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static void link_alt_odb_entries(struct object_database *odb, const char *alt,
-				 int sep, const char *relative_base, int depth)
+static void read_info_alternates(const char *relative_base,
+				 struct strvec *out)
 {
-	struct strvec alternates = STRVEC_INIT;
-
-	if (!alt || !*alt)
-		return;
-
-	if (depth > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-				relative_base);
-		return;
-	}
-
-	parse_alternates(alt, sep, relative_base, &alternates);
-
-	for (size_t i = 0; i < alternates.nr; i++)
-		odb_add_alternate_recursively(odb, alternates.v[i], depth);
-
-	strvec_clear(&alternates);
-}
-
-static void read_info_alternates(struct object_database *odb,
-				 const char *relative_base,
-				 int depth)
-{
-	char *path;
 	struct strbuf buf = STRBUF_INIT;
+	char *path;
 
 	path = xstrfmt("%s/info/alternates", relative_base);
 	if (strbuf_read_file(&buf, path, 1024) < 0) {
@@ -294,8 +282,8 @@ static void read_info_alternates(struct object_database *odb,
 		free(path);
 		return;
 	}
+	parse_alternates(buf.buf, '\n', relative_base, out);
 
-	link_alt_odb_entries(odb, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -338,7 +326,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
 		if (odb->loaded_alternates)
-			odb_add_source(odb, dir, 0);
+			odb_add_alternate_recursively(odb, dir, 0);
 	}
 	free(alts);
 }
@@ -622,13 +610,19 @@ int odb_for_each_alternate(struct object_database *odb,
 
 void odb_prepare_alternates(struct object_database *odb)
 {
+	struct strvec sources = STRVEC_INIT;
+
 	if (odb->loaded_alternates)
 		return;
 
-	link_alt_odb_entries(odb, odb->alternate_db, PATH_SEP, NULL, 0);
+	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
+	read_info_alternates(odb->sources->path, &sources);
+	for (size_t i = 0; i < sources.nr; i++)
+		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
-	read_info_alternates(odb, odb->sources->path, 0);
 	odb->loaded_alternates = 1;
+
+	strvec_clear(&sources);
 }
 
 int odb_has_alternates(struct object_database *odb)

-- 
2.52.0.270.g3f4935d65f.dirty

