Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C391DDC3F
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380768; cv=none; b=HkSAHGedOlO/bhKUuGCdazeftzVpotkEz8YfspD6rxQ+zi+XPlO4cln2eDQ76QAhu9QKOo32ucy8I5eiLt/bfyoJR/vGXeKXiPMD9jcKjNBucKh2y8N4VHZPgBP0Zw4hFwq4ZBHghALLhwPKCo+MliLR3XH9Q0stTqXtiUqF65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380768; c=relaxed/simple;
	bh=EfbRzitdVCXzF7Mn0bevioO9l85lD899b6LU2fe6Vl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3SBUDcvVad65fEiwyrndlC8jur48iZEMl67DSQSO+Pkx5QI1/5oM5qVoRccu0RCITR99NO3SFPnd3vbC+Ruua7VUwf+wSc1uaQYSMonD4Cw8rVPvvUhl+9HVQA/TuVYzGXPPqZDXuLKvjfffFymL3wDvym6rdhWSZlq/wsSbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NnLdUrg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMmofljL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NnLdUrg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMmofljL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4380AEC0568;
	Wed, 10 Dec 2025 10:32:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Dec 2025 10:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380765;
	 x=1765467165; bh=EPsGiMyBCFwCDjV/qYNboAwWEAE19gKS9TI0nsL7IDA=; b=
	NnLdUrg1QICwq1HCnI3jhSZ9pgnLrmNRnTiXJHnDMHw/UV1/u2QXUbIMhiVeHC4Y
	S0XrqTLkP4xoXDg8elL28FgUhgRsJGcRknaWZutacI0HqjbEwT14BqMnqDqnb50i
	AUtu4IfIqLvRK1nikVSWAP9uIQ+CCI35RJQdjS4/b2W75qRD2tPtmgL8EIH3PFHx
	c9r4pLGQsbVuizCmGoEX+4ITZRopLOX/T3iF3nZs6UKsB6gZQvdIzusrbJdlwhEs
	6tlISijoUQ048eRcju2+ltwHjjPSmuw2RYfIB11MMpAzYjdNo5SIUDCCyWFySEEN
	FUKpRUEXekfhN0aXXgmAng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380765; x=
	1765467165; bh=EPsGiMyBCFwCDjV/qYNboAwWEAE19gKS9TI0nsL7IDA=; b=I
	MmofljL/MEDbSlbzYsX4BFKX2LeIvOy9/88B1IvcxElHo8gkWnVZO8Ljp/fHJjLW
	921qyQBSqCANSJP5W+izcARXs1sKk+BEWppQMh+W00/4qn1jOEwm00LgT4GbZNm8
	vI/rR0FN8y7h+5M2LyW+RCr0DQC3huKnkG2JI1BiVSvJXQ4IvMM0GhGZrFxhtq0K
	fjwhFrbYqp27elHw7xN93qW1qW9Fo6lbjBLHrbqj/Jm57nps/Lti50Zeq4B+MbSZ
	7EJrurUUot/Za5hICs8GMOwqaHgeTfU7NUe5JbDF632yHRjWdrcOTriCTTsQ254+
	ltPrZ94x2ow7KNMA991IQ==
X-ME-Sender: <xms:nZI5aZEGNt_cYrIuM-AgCSLjeCEE-Q3jVFoVA5IKBiXSG9D8Pj3Dhw>
    <xme:nZI5aUWxJjh58lXqlhQgr29Ddlg4re10a6fbZuey8CZOyfSMGQEMorZtz2LktQh_H
    2ZPbktBf8zuAYlOXgwqjM1BIEgT9K83sWgopgT3DWM0A_XWcwbsEGw>
X-ME-Received: <xmr:nZI5aYxuoiGh32LqAAZrqfirpNTsfWI4nzLHcPx71yMrDHG5abNyYWgSmOiV1bz5oSv9gOq6RAXCf4gp-gGilipEwpmr3HQZUrDpYNOTHPpQ>
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
X-ME-Proxy: <xmx:nZI5aaMiZbpU1ZPbcL7r0gzCCrrkV8h2vBF8LijNuDf-due3peeVKg>
    <xmx:nZI5aR6vOGztLm6Kqa7S50OCMPmQgM39-zyM7TBxNXAmgnS03T8KZA>
    <xmx:nZI5aTNvtxKpbRO84fIHxParKnnvsa-_PApTo-7jUKWwTvws14ZyQQ>
    <xmx:nZI5aXndml4nb-LQ_iOy8e2uUA0ol5NC-BOnKBMDMZnhOKC21x6fxA>
    <xmx:nZI5aZ1C96z2C2r3FQTapOyhoLvbQJ4Nhjkn59gXKF-eBoAUx8ahwx2M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id deb96ca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:35 +0100
Subject: [PATCH v2 2/8] odb: resolve relative alternative paths when
 parsing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-2-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Parsing alternates and resolving potential relative paths is currently
handled in two separate steps. This has the effect that the logic to
retrieve alternates is not entirely self-contained. We want it to be
just that though so that we can eventually move the logic to list
alternates into the `struct odb_source`.

Move the logic to resolve relative alternative paths into
`parse_alternates()`. Besides bringing us a step closer towards the
above goal, it also neatly separates concerns of generating the list of
alternatives and linking them into the object database.

Note that we ignore any errors when the relative path cannot be
resolved. This isn't really a change in behaviour though: if the path
cannot be resolved to a directory then `alt_odb_usable()` still knows to
bail out.

While at it, rename the function to `odb_add_alternate_recursively()` to
more clearly indicate what its intent is and to align it with modern
terminology.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/odb.c b/odb.c
index 9785f62cb6..699bdbffd1 100644
--- a/odb.c
+++ b/odb.c
@@ -159,44 +159,21 @@ static struct odb_source *odb_source_new(struct object_database *odb,
 	return source;
 }
 
-static struct odb_source *link_alt_odb_entry(struct object_database *odb,
-					     const char *dir,
-					     const char *relative_base,
-					     int depth)
+static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
+							const char *source,
+							int depth)
 {
 	struct odb_source *alternate = NULL;
-	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 	int ret;
 
-	if (!is_absolute_path(dir) && relative_base) {
-		strbuf_realpath(&pathbuf, relative_base, 1);
-		strbuf_addch(&pathbuf, '/');
-	}
-	strbuf_addstr(&pathbuf, dir);
-
-	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
-		error(_("unable to normalize alternate object path: %s"),
-		      pathbuf.buf);
-		goto error;
-	}
-	strbuf_swap(&pathbuf, &tmp);
-
-	/*
-	 * The trailing slash after the directory name is given by
-	 * this function at the end. Remove duplicates.
-	 */
-	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
-		strbuf_setlen(&pathbuf, pathbuf.len - 1);
-
-	strbuf_reset(&tmp);
 	strbuf_realpath(&tmp, odb->sources->path, 1);
 
-	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
+	if (!alt_odb_usable(odb, source, tmp.buf))
 		goto error;
 
-	alternate = odb_source_new(odb, pathbuf.buf, false);
+	alternate = odb_source_new(odb, source, false);
 
 	/* add the alternate entry */
 	*odb->sources_tail = alternate;
@@ -212,20 +189,22 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 
  error:
 	strbuf_release(&tmp);
-	strbuf_release(&pathbuf);
 	return alternate;
 }
 
 static void parse_alternates(const char *string,
 			     int sep,
+			     const char *relative_base,
 			     struct strvec *out)
 {
+	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 
 	while (*string) {
 		const char *end;
 
 		strbuf_reset(&buf);
+		strbuf_reset(&pathbuf);
 
 		if (*string == '#') {
 			/* comment; consume up to next separator */
@@ -250,9 +229,30 @@ static void parse_alternates(const char *string,
 		if (!buf.len)
 			continue;
 
+		if (!is_absolute_path(buf.buf) && relative_base) {
+			strbuf_realpath(&pathbuf, relative_base, 1);
+			strbuf_addch(&pathbuf, '/');
+		}
+		strbuf_addbuf(&pathbuf, &buf);
+
+		strbuf_reset(&buf);
+		if (!strbuf_realpath(&buf, pathbuf.buf, 0)) {
+			error(_("unable to normalize alternate object path: %s"),
+			      pathbuf.buf);
+			continue;
+		}
+
+		/*
+		 * The trailing slash after the directory name is given by
+		 * this function at the end. Remove duplicates.
+		 */
+		while (buf.len && buf.buf[buf.len - 1] == '/')
+			strbuf_setlen(&buf, buf.len - 1);
+
 		strvec_push(out, buf.buf);
 	}
 
+	strbuf_release(&pathbuf);
 	strbuf_release(&buf);
 }
 
@@ -270,10 +270,10 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 		return;
 	}
 
-	parse_alternates(alt, sep, &alternates);
+	parse_alternates(alt, sep, relative_base, &alternates);
 
 	for (size_t i = 0; i < alternates.nr; i++)
-		link_alt_odb_entry(odb, alternates.v[i], relative_base, depth);
+		odb_add_alternate_recursively(odb, alternates.v[i], depth);
 
 	strvec_clear(&alternates);
 }
@@ -348,7 +348,7 @@ struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 	 * overwritten when they are.
 	 */
 	odb_prepare_alternates(odb);
-	return link_alt_odb_entry(odb, dir, NULL, 0);
+	return odb_add_alternate_recursively(odb, dir, 0);
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,

-- 
2.52.0.270.g3f4935d65f.dirty

