Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDB2F619A
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380779; cv=none; b=t/msjviBsBiB98KGj8e/S/rND0thkSKJVBbiURNfpUmzBmfAdN0RJdZiuVQttVVgJ8crWW4Trq1DiAdNQgD+iKZqZNkhZhJxBuDnbA1HLHypWNbUa/50qDe5og+/1pqi45ypbQnj/RsM+JcTJK+IF7y1u2vMKHujkAL0/1tku2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380779; c=relaxed/simple;
	bh=HEQG4/L8qeqf4+GGj6oP/KJInc0Hx0tQTT7cXjjqVuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FazEiI026hQhJyPmuz1odik0OJjJfrZsoNcWmli92AOKdGISz+0OhfWmeY2aV6pQFK9UvJSS5gDAQAqPHqiDX3Bjum1p38pz98pMUzuRB8YLcAV2Z+T8a7GYDkt4HHFHQK/x57DZ02oCcHyZrxVwq4rChBNZ2fQygX+5p5mkvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mv4p0kQd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpfPMpaD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mv4p0kQd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpfPMpaD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 89671EC0568;
	Wed, 10 Dec 2025 10:32:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 10:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380776;
	 x=1765467176; bh=jWzVFElU8oTtkz7D0sr5mQjugoTZTu+R4fOxcZkHCwg=; b=
	Mv4p0kQdJJcEpE5Na2UjMDaT9QKLv/01rtNqU/Wimacmk2O1IOiAIA9VmKY9Euhe
	RxEAJVFMIVXn0XZ2W9OIOWMfS0ishuMofcYOUpps4556f5Qq/LVoGyqcOtizdm2l
	apj4G/ZSvfph6dKAM5cUOvkpqqe0tQde4IngZQf2/oan3RA+FhlFUQXRZ5iTnhTi
	zyBuW2OH7upXYTO3CGuLX/xzzFEPtW0fFMdykDrHkptITWYu/rthHm77PKxJ21A1
	/6/WINFQ7i5OAvXlZon4cI8tjNAxi1oi+v8+UD+y6k2e6I/T2618fzxUhV6HArQq
	khHzgwa8vjnvmjFHMN4fmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380776; x=
	1765467176; bh=jWzVFElU8oTtkz7D0sr5mQjugoTZTu+R4fOxcZkHCwg=; b=R
	pfPMpaDVK9QKuboY5/PPgcICLHgmTfqdKhrmI8N//nY7JRLlTp8PMsk/NWjTQ4yW
	a2F2u3JbWcCdxHswUWJwRt3fjWiYoSbRKpNpsx2PW1aQkHqz9iaKGkLM3cMrKiDH
	o6QbSDOaOZF7jkc2XnuFzqHRs02ZX2bRUhMc3sUCw0NKJbVSvttW0JrTsHiYhwTT
	k0Se678UvG61kda/r5B51YzrlUHFTekhlcivo5RmUM4vyP5lbtkgynjj1XGcJZ3A
	xov9A7vwoWAFh/GMhry4jVrH0ilvfytQ49E036IGXrMXVfPvDWoJoF6zXyRvGkyw
	twdC4m84CXxQhuNSYXhjg==
X-ME-Sender: <xms:qJI5acU19A9BvKTHzVJ3qbCjnbTUbD45PRTlFD9ksQKtcX1K00X_qA>
    <xme:qJI5aWmCeXMbnWQLEe6S3ISa7qESbW6uQGPHkENkQiGCJ3GEI0CvRjU6tWEV0aOXm
    0jeMfRQrv-JtPqsx1hEDzxt2r8BvoDJogIxRoHSNcZe3S0Po7IdVg>
X-ME-Received: <xmr:qJI5aeDS-9BSpa3uN4yW-nYbS4LVZ2ubtAITroYfKXv2LNWT12Isbcijrc5lQFdKtYCbqtgAwDx7_tvTRv2SJenk2vKDpLj0XjDzC4FkCXXS>
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
X-ME-Proxy: <xmx:qJI5aWdSCAnn0tBchWGj8EHZIIT-zDNz-iMB5MSxF-3XJnzqci2-YA>
    <xmx:qJI5aZIdToW3lB5dc9Kln5EDFZ8CtbT5j0dEowHUpSZu400peUsDeg>
    <xmx:qJI5aZeuA21NhZf1eORyTN8EMpS4cayQ7Zoo9iVPXIhCOPD3hNN3Mg>
    <xmx:qJI5aQ2zNXo7TAs57k2T9s8qNmdnXFtzh4u5zPCb0gJ5wUHZLIRyeg>
    <xmx:qJI5aRFFcl0_rl11mei3uKHwxcyOD8XFcLJtYeeFaiIGuGpokixjpfGF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7ff5411 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:39 +0100
Subject: [PATCH v2 6/8] odb: drop forward declaration of
 `read_info_alternates()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-6-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Now that we have removed the mutual recursion in the preceding commit
it is not necessary anymore to have a forward declaration of the
`read_info_alternates()` function. Move the function and its
dependencies further up so that we can remove it.

Note that this commit also removes the function documentation of
`read_info_alternates()`. It's unclear what it's documenting, but it for
sure isn't documenting the modern behaviour of the function anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 125 +++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/odb.c b/odb.c
index 59944d4649..dcf4a62cd2 100644
--- a/odb.c
+++ b/odb.c
@@ -132,77 +132,6 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
 	return usable;
 }
 
-/*
- * Prepare alternate object database registry.
- *
- * The variable alt_odb_list points at the list of struct
- * odb_source.  The elements on this list come from
- * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
- * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
- * whose contents is similar to that environment variable but can be
- * LF separated.  Its base points at a statically allocated buffer that
- * contains "/the/directory/corresponding/to/.git/objects/...", while
- * its name points just after the slash at the end of ".git/objects/"
- * in the example above, and has enough space to hold all hex characters
- * of the object ID, an extra slash for the first level indirection, and
- * the terminating NUL.
- */
-static void read_info_alternates(const char *relative_base,
-				 struct strvec *out);
-
-static struct odb_source *odb_source_new(struct object_database *odb,
-					 const char *path,
-					 bool local)
-{
-	struct odb_source *source;
-
-	CALLOC_ARRAY(source, 1);
-	source->odb = odb;
-	source->local = local;
-	source->path = xstrdup(path);
-	source->loose = odb_source_loose_new(source);
-
-	return source;
-}
-
-static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
-							const char *source,
-							int depth)
-{
-	struct odb_source *alternate = NULL;
-	struct strvec sources = STRVEC_INIT;
-	khiter_t pos;
-	int ret;
-
-	if (!odb_is_source_usable(odb, source))
-		goto error;
-
-	alternate = odb_source_new(odb, source, false);
-
-	/* add the alternate entry */
-	*odb->sources_tail = alternate;
-	odb->sources_tail = &(alternate->next);
-
-	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
-	if (!ret)
-		BUG("source must not yet exist");
-	kh_value(odb->source_by_path, pos) = alternate;
-
-	/* recursively add alternates */
-	read_info_alternates(alternate->path, &sources);
-	if (sources.nr && depth + 1 > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-		      source);
-	} else {
-		for (size_t i = 0; i < sources.nr; i++)
-			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
-	}
-
- error:
-	strvec_clear(&sources);
-	return alternate;
-}
-
 static void parse_alternates(const char *string,
 			     int sep,
 			     const char *relative_base,
@@ -288,6 +217,60 @@ static void read_info_alternates(const char *relative_base,
 	free(path);
 }
 
+
+static struct odb_source *odb_source_new(struct object_database *odb,
+					 const char *path,
+					 bool local)
+{
+	struct odb_source *source;
+
+	CALLOC_ARRAY(source, 1);
+	source->odb = odb;
+	source->local = local;
+	source->path = xstrdup(path);
+	source->loose = odb_source_loose_new(source);
+
+	return source;
+}
+
+static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
+							const char *source,
+							int depth)
+{
+	struct odb_source *alternate = NULL;
+	struct strvec sources = STRVEC_INIT;
+	khiter_t pos;
+	int ret;
+
+	if (!odb_is_source_usable(odb, source))
+		goto error;
+
+	alternate = odb_source_new(odb, source, false);
+
+	/* add the alternate entry */
+	*odb->sources_tail = alternate;
+	odb->sources_tail = &(alternate->next);
+
+	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
+	if (!ret)
+		BUG("source must not yet exist");
+	kh_value(odb->source_by_path, pos) = alternate;
+
+	/* recursively add alternates */
+	read_info_alternates(alternate->path, &sources);
+	if (sources.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      source);
+	} else {
+		for (size_t i = 0; i < sources.nr; i++)
+			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
+	}
+
+ error:
+	strvec_clear(&sources);
+	return alternate;
+}
+
 void odb_add_to_alternates_file(struct object_database *odb,
 				const char *dir)
 {

-- 
2.52.0.270.g3f4935d65f.dirty

