Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BA3A5E73
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007303; cv=none; b=ihy71QeQ6QCmM44zbgCeYtYtIqUkmQT8lFrNKMFPfs+htJ4UwB/ijh6MZDLvNFX8RbwDPE3QKQ4A94v+k/PuA78S1Pr1/41R3VwzoW9SjY8fmKpgoQSeZ0Jdp7th295b0jEk4qzGyCWYrkpSBoA+LAmoTzs3zkebibEDOb6eTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007303; c=relaxed/simple;
	bh=WGxsF5dA/jQv9HUDxF7Q30ydUrtlRvjiWc6io57VNzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FE0+FhW1P4JV39BOT5ettIh0jIxHccdNmPhGg3vGPtpZ0HGq0fi+vR+a/NB8v1rkhPuZISRRn3qWU0jgR3enWsUu/mSznwFj7yN4UsmEH0VrIrl3ur7tyz53VSxsnp9FpoVRZO6O5kxX+YqMbtvErh29T7PVKQTpXzLZCd2iArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XIWPrDH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZTKvrRV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XIWPrDH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZTKvrRV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94B2B1400176
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 07:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007300;
	 x=1774093700; bh=d2wCXm5AfstkkgTgbziy+Ew6r6IEeCgKTWbwUNXIK3U=; b=
	XIWPrDH+5rN2YF7ZcQCO6B5V4GAn4XyUSz7kjYUyWUzmt75FDktAYeuoeTqzpt1F
	843fPP5WZkCRE7M+J8vF/WQHvshDhNdSLRybZq0rTw2SmtcEXC65rxI6GieOm8KK
	mHHUdCJe6fttru6PvSg0oyy4eWjgEAI6rMW2Y7oSfNo+aUfCn9osf6/BcGOp+UPU
	9bvMD3xiypVId2ZxZ94KcrSI79MTF9kVorjZRGoZ+a1TZqKxUTfsIQOa7Gz0tsEW
	STSTMT/OdXfX7G5CNnLZwV6uhEckEqCPvNMY4f+fZhNm/9LKCYt+WlrGRnGofAHy
	3V8fGcqRugUyTlSLSAqTaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007300; x=
	1774093700; bh=d2wCXm5AfstkkgTgbziy+Ew6r6IEeCgKTWbwUNXIK3U=; b=J
	ZTKvrRVvhUwRAC7IpTQC9gKneFGdMII6GNBhQQzgzbJkJk5INYgchsmgz0TOxzDk
	P0O9DjPauma7Lnt+RlyRXKkkQ5n8dIblMB7I42SoMjo7op6lS0JnrIh7vt7jrzgo
	8BKvWFRWD7gOcKlb+zXgpzLY4qzaR1JxYiO/CwvPks0MnoHDze8niRj5ZZM1k91V
	E8l3tGvJdQKoaXvPSH475bx4gXAwFi1cqk3Nfd0uypTW5TJSNjhRC2W8l/qCi7rU
	O8qhraRpyG8Yhglg8AJZMJ/AkPzidRmR1CtS565CRU3N/Co20piOXd5CFLWshjBX
	jwVdTVEjpZy76Z4fYIJIQ==
X-ME-Sender: <xms:BDS9aV4JAjssrTfwD4K8ktSymj6bGMQwdM-kcyE63KSmNziBJwb4DQ>
    <xme:BDS9aZ2FkMHVbnjEiZdpO-DZLHl558uXShMQHnPSvZZTGDaLgu9i3O1Nu1VfHi8Gt
    nIO1EIB4YBmRzggkELdrvcjDuH3VJ0CkBgD-NsAI-ClHgu4Y_MdsA>
X-ME-Received: <xmr:BDS9aSFdchHFcSVoFQiUplPoFrdjbr1hl_OsKhnAn9l20gb45e11sAlXZf1QEalle-nIqAhGx_uFw82X4yQ0VfoUb0W4liKms-l76mnLLRzS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:BDS9aTTOPg4Ug8Gc1qRr_myYYZORq3SrUnQIVwLyajg9axo3vwzoJA>
    <xmx:BDS9aZB5FU_nG_yWgGLB6bzv06FFWyKSC9iow5s-cOci_5ahFOWVaw>
    <xmx:BDS9aT0Px6kNnfP09bRhFn5mIieJUqy0P0XRkttBj3rJKJgvVpWE4A>
    <xmx:BDS9aXVUrSLnQ6GAimK0xPMM-3v-40DP5CgntRCwTAjnYLFzNS7Qew>
    <xmx:BDS9aaYSE22659UvjEjpCRJ053A7qkjdX-BOqygszBBnSlFikKl1xm3W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 400abc47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:18 +0100
Subject: [PATCH 13/14] fsck: provide repository in `struct
 fsck_report_object`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-13-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The `report()` function invokes a callback function with a `struct
fsck_report_object` for every object that failed at least one of our
checks. This report doesn't give the caller enough context though, and
thus they have to rely on global state for `the_repository`.

Refactor the code and inject the repository into the report.

As this requires us to touch up all callsites, rename the `report()`
function to `fsck_report_object()` to align it with `fsck_report_ref()`.
We have already discussed this rename in the past, but we decided to not
do it because it required us to adapt too many callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fsck.c | 365 ++++++++++++++++++++++++++++++++++++++---------------------------
 fsck.h |   1 +
 2 files changed, 214 insertions(+), 152 deletions(-)

diff --git a/fsck.c b/fsck.c
index edf7a0618f..59b9163598 100644
--- a/fsck.c
+++ b/fsck.c
@@ -258,13 +258,15 @@ static int fsck_vreport(struct fsck_options *options,
 	return result;
 }
 
-__attribute__((format (printf, 5, 6)))
-static int report(struct fsck_options *options,
-		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id msg_id, const char *fmt, ...)
+__attribute__((format (printf, 6, 7)))
+static int fsck_report_object(struct repository *repo,
+			      struct fsck_options *options,
+			      const struct object_id *oid, enum object_type object_type,
+			      enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
 	struct fsck_object_report report = {
+		.repo = repo,
 		.oid = oid,
 		.object_type = object_type
 	};
@@ -626,7 +628,8 @@ static int verify_ordered(unsigned mode1, const char *name1,
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
 
-static int fsck_tree(const struct object_id *tree_oid,
+static int fsck_tree(struct repository *repo,
+		     const struct object_id *tree_oid,
 		     const char *buffer, unsigned long size,
 		     struct fsck_options *options)
 {
@@ -649,9 +652,9 @@ static int fsck_tree(const struct object_id *tree_oid,
 
 	if (init_tree_desc_gently(&desc, tree_oid, buffer, size,
 				  TREE_DESC_RAW_MODES)) {
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_BAD_TREE,
-				 "cannot be parsed as a tree");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_BAD_TREE,
+					     "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -679,10 +682,10 @@ static int fsck_tree(const struct object_id *tree_oid,
 				oidset_insert(&options->gitmodules_found,
 					      entry_oid);
 			else
-				retval += report(options,
-						 tree_oid, OBJ_TREE,
-						 FSCK_MSG_GITMODULES_SYMLINK,
-						 ".gitmodules is a symbolic link");
+				retval += fsck_report_object(repo, options,
+							     tree_oid, OBJ_TREE,
+							     FSCK_MSG_GITMODULES_SYMLINK,
+							     ".gitmodules is a symbolic link");
 		}
 
 		if (is_hfs_dotgitattributes(name) || is_ntfs_dotgitattributes(name)) {
@@ -690,22 +693,22 @@ static int fsck_tree(const struct object_id *tree_oid,
 				oidset_insert(&options->gitattributes_found,
 					      entry_oid);
 			else
-				retval += report(options, tree_oid, OBJ_TREE,
-						 FSCK_MSG_GITATTRIBUTES_SYMLINK,
-						 ".gitattributes is a symlink");
+				retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+							     FSCK_MSG_GITATTRIBUTES_SYMLINK,
+							     ".gitattributes is a symlink");
 		}
 
 		if (S_ISLNK(mode)) {
 			if (is_hfs_dotgitignore(name) ||
 			    is_ntfs_dotgitignore(name))
-				retval += report(options, tree_oid, OBJ_TREE,
-						 FSCK_MSG_GITIGNORE_SYMLINK,
-						 ".gitignore is a symlink");
+				retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+							     FSCK_MSG_GITIGNORE_SYMLINK,
+							     ".gitignore is a symlink");
 			if (is_hfs_dotmailmap(name) ||
 			    is_ntfs_dotmailmap(name))
-				retval += report(options, tree_oid, OBJ_TREE,
-						 FSCK_MSG_MAILMAP_SYMLINK,
-						 ".mailmap is a symlink");
+				retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+							     FSCK_MSG_MAILMAP_SYMLINK,
+							     ".mailmap is a symlink");
 		}
 
 		if ((backslash = strchr(name, '\\'))) {
@@ -717,18 +720,18 @@ static int fsck_tree(const struct object_id *tree_oid,
 						oidset_insert(&options->gitmodules_found,
 							      entry_oid);
 					else
-						retval += report(options, tree_oid, OBJ_TREE,
-								 FSCK_MSG_GITMODULES_SYMLINK,
-								 ".gitmodules is a symbolic link");
+						retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+									     FSCK_MSG_GITMODULES_SYMLINK,
+									     ".gitmodules is a symbolic link");
 				}
 				backslash = strchr(backslash, '\\');
 			}
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, tree_oid, OBJ_TREE,
-					 FSCK_MSG_BAD_TREE,
-					 "cannot be parsed as a tree");
+			retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+						     FSCK_MSG_BAD_TREE,
+						     "cannot be parsed as a tree");
 			break;
 		}
 
@@ -776,49 +779,49 @@ static int fsck_tree(const struct object_id *tree_oid,
 	name_stack_clear(&df_dup_candidates);
 
 	if (has_null_sha1)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_NULL_SHA1,
-				 "contains entries pointing to null sha1");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_NULL_SHA1,
+					     "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_FULL_PATHNAME,
-				 "contains full pathnames");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_FULL_PATHNAME,
+					     "contains full pathnames");
 	if (has_empty_name)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_EMPTY_NAME,
-				 "contains empty pathname");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_EMPTY_NAME,
+					     "contains empty pathname");
 	if (has_dot)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_HAS_DOT,
-				 "contains '.'");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_HAS_DOT,
+					     "contains '.'");
 	if (has_dotdot)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_HAS_DOTDOT,
-				 "contains '..'");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_HAS_DOTDOT,
+					     "contains '..'");
 	if (has_dotgit)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_HAS_DOTGIT,
-				 "contains '.git'");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_HAS_DOTGIT,
+					     "contains '.git'");
 	if (has_zero_pad)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_ZERO_PADDED_FILEMODE,
-				 "contains zero-padded file modes");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_ZERO_PADDED_FILEMODE,
+					     "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_BAD_FILEMODE,
-				 "contains bad file modes");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_BAD_FILEMODE,
+					     "contains bad file modes");
 	if (has_dup_entries)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_DUPLICATE_ENTRIES,
-				 "contains duplicate file entries");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_DUPLICATE_ENTRIES,
+					     "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_TREE_NOT_SORTED,
-				 "not properly sorted");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_TREE_NOT_SORTED,
+					     "not properly sorted");
 	if (has_large_name)
-		retval += report(options, tree_oid, OBJ_TREE,
-				 FSCK_MSG_LARGE_PATHNAME,
-				 "contains excessively large pathname");
+		retval += fsck_report_object(repo, options, tree_oid, OBJ_TREE,
+					     FSCK_MSG_LARGE_PATHNAME,
+					     "contains excessively large pathname");
 	return retval;
 }
 
@@ -839,7 +842,8 @@ static int fsck_tree(const struct object_id *tree_oid,
  *     case hit the newline we found here as the end-of-header. This makes it
  *     OK for them to use helpers like parse_oid_hex(), or even skip_prefix().
  */
-static int verify_headers(const void *data, unsigned long size,
+static int verify_headers(struct repository *repo,
+			  const void *data, unsigned long size,
 			  const struct object_id *oid, enum object_type type,
 			  struct fsck_options *options)
 {
@@ -849,9 +853,9 @@ static int verify_headers(const void *data, unsigned long size,
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
-			return report(options, oid, type,
-				FSCK_MSG_NUL_IN_HEADER,
-				"unterminated header: NUL at offset %ld", i);
+			return fsck_report_object(repo, options, oid, type,
+						  FSCK_MSG_NUL_IN_HEADER,
+						  "unterminated header: NUL at offset %ld", i);
 		case '\n':
 			if (i + 1 < size && buffer[i + 1] == '\n')
 				return 0;
@@ -867,8 +871,9 @@ static int verify_headers(const void *data, unsigned long size,
 	if (size && buffer[size - 1] == '\n')
 		return 0;
 
-	return report(options, oid, type,
-		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
+	return fsck_report_object(repo, options, oid, type,
+				  FSCK_MSG_UNTERMINATED_HEADER,
+				  "unterminated header");
 }
 
 static timestamp_t parse_timestamp_from_buf(const char **start, const char *end)
@@ -887,7 +892,8 @@ static timestamp_t parse_timestamp_from_buf(const char **start, const char *end)
 	return parse_timestamp(buf, NULL, 10);
 }
 
-static int fsck_ident(const char **ident, const char *ident_end,
+static int fsck_ident(struct repository *repo,
+		      const char **ident, const char *ident_end,
 		      const struct object_id *oid, enum object_type type,
 		      struct fsck_options *options)
 {
@@ -900,12 +906,18 @@ static int fsck_ident(const char **ident, const char *ident_end,
 	*ident = nl + 1;
 
 	if (*p == '<')
-		return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_MISSING_NAME_BEFORE_EMAIL,
+					  "invalid author/committer line - missing space before email");
 	for (;;) {
 		if (p >= ident_end || *p == '\n')
-			return report(options, oid, type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
+			return fsck_report_object(repo, options, oid, type,
+						  FSCK_MSG_MISSING_EMAIL,
+						  "invalid author/committer line - missing email");
 		if (*p == '>')
-			return report(options, oid, type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
+			return fsck_report_object(repo, options, oid, type,
+						  FSCK_MSG_BAD_NAME,
+						  "invalid author/committer line - bad name");
 		if (*p == '<')
 			break; /* end of name, beginning of email */
 
@@ -913,11 +925,15 @@ static int fsck_ident(const char **ident, const char *ident_end,
 		p++;
 	}
 	if (p[-1] != ' ')
-		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL,
+					  "invalid author/committer line - missing space before email");
 	p++; /* skip past '<' we found */
 	for (;;) {
 		if (p >= ident_end || *p == '<' || *p == '\n')
-			return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
+			return fsck_report_object(repo, options, oid, type,
+						  FSCK_MSG_BAD_EMAIL,
+						  "invalid author/committer line - bad email");
 		if (*p == '>')
 			break; /* end of email */
 
@@ -926,7 +942,9 @@ static int fsck_ident(const char **ident, const char *ident_end,
 	}
 	p++; /* skip past '>' we found */
 	if (*p != ' ')
-		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_MISSING_SPACE_BEFORE_DATE,
+					  "invalid author/committer line - missing space before date");
 	p++;
 	/*
 	 * Our timestamp parser is based on the C strto*() functions, which
@@ -940,14 +958,21 @@ static int fsck_ident(const char **ident, const char *ident_end,
 	while (*p == ' ' || *p == '\t')
 		p++;
 	if (!isdigit(*p))
-		return report(options, oid, type, FSCK_MSG_BAD_DATE,
-			      "invalid author/committer line - bad date");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_BAD_DATE,
+					  "invalid author/committer line - bad date");
 	if (*p == '0' && p[1] != ' ')
-		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_ZERO_PADDED_DATE,
+					  "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp_from_buf(&p, ident_end)))
-		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_BAD_DATE_OVERFLOW,
+					  "invalid author/committer line - date causes integer overflow");
 	if (*p != ' ')
-		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_BAD_DATE,
+					  "invalid author/committer line - bad date");
 	p++;
 	if ((*p != '+' && *p != '-') ||
 	    !isdigit(p[1]) ||
@@ -955,7 +980,9 @@ static int fsck_ident(const char **ident, const char *ident_end,
 	    !isdigit(p[3]) ||
 	    !isdigit(p[4]) ||
 	    (p[5] != '\n'))
-		return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
+		return fsck_report_object(repo, options, oid, type,
+					  FSCK_MSG_BAD_TIMEZONE,
+					  "invalid author/committer line - bad time zone");
 	p += 6;
 	return 0;
 }
@@ -977,20 +1004,26 @@ static int fsck_commit(struct repository *repo,
 	 * memory safety of the rest of the function depends on it. See the
 	 * comment above the definition of verify_headers() for more details.
 	 */
-	if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
+	if (verify_headers(repo, buffer, size, oid, OBJ_COMMIT, options))
 		return -1;
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tree ", &buffer))
-		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
+		return fsck_report_object(repo, options, oid, OBJ_COMMIT,
+					  FSCK_MSG_MISSING_TREE,
+					  "invalid format - expected 'tree' line");
 	if (parse_oid_hex_algop(buffer, &tree_oid, &p, repo->hash_algo) || *p != '\n') {
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+		err = fsck_report_object(repo, options, oid, OBJ_COMMIT,
+					 FSCK_MSG_BAD_TREE_SHA1,
+					 "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex_algop(buffer, &parent_oid, &p, repo->hash_algo) || *p != '\n') {
-			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+			err = fsck_report_object(repo, options, oid, OBJ_COMMIT,
+						 FSCK_MSG_BAD_PARENT_SHA1,
+						 "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
 		}
@@ -999,24 +1032,31 @@ static int fsck_commit(struct repository *repo,
 	author_count = 0;
 	while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
-		err = fsck_ident(&buffer, buffer_end, oid, OBJ_COMMIT, options);
+		err = fsck_ident(repo, &buffer, buffer_end, oid, OBJ_COMMIT, options);
 		if (err)
 			return err;
 	}
 	if (author_count < 1)
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+		err = fsck_report_object(repo, options, oid, OBJ_COMMIT,
+					 FSCK_MSG_MISSING_AUTHOR,
+					 "invalid format - expected 'author' line");
 	else if (author_count > 1)
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		err = fsck_report_object(repo, options, oid, OBJ_COMMIT,
+					 FSCK_MSG_MULTIPLE_AUTHORS,
+					 "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
 	if (buffer >= buffer_end || !skip_prefix(buffer, "committer ", &buffer))
-		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, buffer_end, oid, OBJ_COMMIT, options);
+		return fsck_report_object(repo, options, oid, OBJ_COMMIT,
+					  FSCK_MSG_MISSING_COMMITTER,
+					  "invalid format - expected 'committer' line");
+	err = fsck_ident(repo, &buffer, buffer_end, oid, OBJ_COMMIT, options);
 	if (err)
 		return err;
 	if (memchr(buffer_begin, '\0', size)) {
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
-			     "NUL byte in the commit object body");
+		err = fsck_report_object(repo, options, oid, OBJ_COMMIT,
+					 FSCK_MSG_NUL_IN_COMMIT,
+					 "NUL byte in the commit object body");
 		if (err)
 			return err;
 	}
@@ -1050,52 +1090,66 @@ int fsck_tag_standalone(struct repository *repo,
 	 * memory safety of the rest of the function depends on it. See the
 	 * comment above the definition of verify_headers() for more details.
 	 */
-	ret = verify_headers(buffer, size, oid, OBJ_TAG, options);
+	ret = verify_headers(repo, buffer, size, oid, OBJ_TAG, options);
 	if (ret)
 		goto done;
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "object ", &buffer)) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_MISSING_OBJECT,
+					 "invalid format - expected 'object' line");
 		goto done;
 	}
 	if (parse_oid_hex_algop(buffer, tagged_oid, &p, repo->hash_algo) || *p != '\n') {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_BAD_OBJECT_SHA1,
+					 "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
 	}
 	buffer = p + 1;
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "type ", &buffer)) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_MISSING_TYPE_ENTRY,
+					 "invalid format - expected 'type' line");
 		goto done;
 	}
 	eol = memchr(buffer, '\n', buffer_end - buffer);
 	if (!eol) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_MISSING_TYPE,
+					 "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
 	if (*tagged_type < 0)
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_BAD_TYPE,
+					 "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tag ", &buffer)) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_MISSING_TAG_ENTRY,
+					 "invalid format - expected 'tag' line");
 		goto done;
 	}
 	eol = memchr(buffer, '\n', buffer_end - buffer);
 	if (!eol) {
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_MISSING_TAG,
+					 "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0)) {
-		ret = report(options, oid, OBJ_TAG,
-			     FSCK_MSG_BAD_TAG_NAME,
-			     "invalid 'tag' name: %.*s",
-			     (int)(eol - buffer), buffer);
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_BAD_TAG_NAME,
+					 "invalid 'tag' name: %.*s",
+					 (int)(eol - buffer), buffer);
 		if (ret)
 			goto done;
 	}
@@ -1103,17 +1157,21 @@ int fsck_tag_standalone(struct repository *repo,
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tagger ", &buffer)) {
 		/* early tags do not contain 'tagger' lines; warn only */
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_MISSING_TAGGER_ENTRY,
+					 "invalid format - expected 'tagger' line");
 		if (ret)
 			goto done;
 	}
 	else
-		ret = fsck_ident(&buffer, buffer_end, oid, OBJ_TAG, options);
+		ret = fsck_ident(repo, &buffer, buffer_end, oid, OBJ_TAG, options);
 
 	if (buffer < buffer_end && (skip_prefix(buffer, "gpgsig ", &buffer) || skip_prefix(buffer, "gpgsig-sha256 ", &buffer))) {
 		eol = memchr(buffer, '\n', buffer_end - buffer);
 		if (!eol) {
-			ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_GPGSIG, "invalid format - unexpected end after 'gpgsig' or 'gpgsig-sha256' line");
+			ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+						 FSCK_MSG_BAD_GPGSIG,
+						 "invalid format - unexpected end after 'gpgsig' or 'gpgsig-sha256' line");
 			goto done;
 		}
 		buffer = eol + 1;
@@ -1121,7 +1179,9 @@ int fsck_tag_standalone(struct repository *repo,
 		while (buffer < buffer_end && starts_with(buffer, " ")) {
 			eol = memchr(buffer, '\n', buffer_end - buffer);
 			if (!eol) {
-				ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_HEADER_CONTINUATION, "invalid format - unexpected end in 'gpgsig' or 'gpgsig-sha256' continuation line");
+				ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+							 FSCK_MSG_BAD_HEADER_CONTINUATION,
+							 "invalid format - unexpected end in 'gpgsig' or 'gpgsig-sha256' continuation line");
 				goto done;
 			}
 			buffer = eol + 1;
@@ -1136,7 +1196,9 @@ int fsck_tag_standalone(struct repository *repo,
 		 * garbage" could be a custom header. E.g. "mktag"
 		 * doesn't want any unknown headers.
 		 */
-		ret = report(options, oid, OBJ_TAG, FSCK_MSG_EXTRA_HEADER_ENTRY, "invalid format - extra header(s) after 'tagger'");
+		ret = fsck_report_object(repo, options, oid, OBJ_TAG,
+					 FSCK_MSG_EXTRA_HEADER_ENTRY,
+					 "invalid format - extra header(s) after 'tagger'");
 		if (ret)
 			goto done;
 	}
@@ -1147,6 +1209,7 @@ int fsck_tag_standalone(struct repository *repo,
 }
 
 struct fsck_gitmodules_data {
+	struct repository *repo;
 	const struct object_id *oid;
 	struct fsck_options *options;
 	int ret;
@@ -1157,6 +1220,7 @@ static int fsck_gitmodules_fn(const char *var, const char *value,
 			      void *vdata)
 {
 	struct fsck_gitmodules_data *data = vdata;
+	struct repository *repo = data->repo;
 	const char *subsection, *key;
 	size_t subsection_len;
 	char *name;
@@ -1167,37 +1231,31 @@ static int fsck_gitmodules_fn(const char *var, const char *value,
 
 	name = xmemdupz(subsection, subsection_len);
 	if (check_submodule_name(name) < 0)
-		data->ret |= report(data->options,
-				    data->oid, OBJ_BLOB,
-				    FSCK_MSG_GITMODULES_NAME,
-				    "disallowed submodule name: %s",
-				    name);
+		data->ret |= fsck_report_object(repo, data->options, data->oid, OBJ_BLOB,
+						FSCK_MSG_GITMODULES_NAME,
+						"disallowed submodule name: %s", name);
 	if (!strcmp(key, "url") && value &&
 	    check_submodule_url(value) < 0)
-		data->ret |= report(data->options,
-				    data->oid, OBJ_BLOB,
-				    FSCK_MSG_GITMODULES_URL,
-				    "disallowed submodule url: %s",
-				    value);
+		data->ret |= fsck_report_object(repo, data->options, data->oid, OBJ_BLOB,
+						FSCK_MSG_GITMODULES_URL,
+						"disallowed submodule url: %s", value);
 	if (!strcmp(key, "path") && value &&
 	    looks_like_command_line_option(value))
-		data->ret |= report(data->options,
-				    data->oid, OBJ_BLOB,
-				    FSCK_MSG_GITMODULES_PATH,
-				    "disallowed submodule path: %s",
-				    value);
+		data->ret |= fsck_report_object(repo, data->options, data->oid, OBJ_BLOB,
+						FSCK_MSG_GITMODULES_PATH,
+						"disallowed submodule path: %s", value);
 	if (!strcmp(key, "update") && value &&
 	    parse_submodule_update_type(value) == SM_UPDATE_COMMAND)
-		data->ret |= report(data->options, data->oid, OBJ_BLOB,
-				    FSCK_MSG_GITMODULES_UPDATE,
-				    "disallowed submodule update setting: %s",
-				    value);
+		data->ret |= fsck_report_object(repo, data->options, data->oid, OBJ_BLOB,
+						FSCK_MSG_GITMODULES_UPDATE,
+						"disallowed submodule update setting: %s", value);
 	free(name);
 
 	return 0;
 }
 
-static int fsck_blob(const struct object_id *oid, const char *buf,
+static int fsck_blob(struct repository *repo,
+		     const struct object_id *oid, const char *buf,
 		     unsigned long size, struct fsck_options *options)
 {
 	int ret = 0;
@@ -1217,11 +1275,12 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 			 * blob too gigantic to load into memory. Let's just consider
 			 * that an error.
 			 */
-			return report(options, oid, OBJ_BLOB,
-					FSCK_MSG_GITMODULES_LARGE,
-					".gitmodules too large to parse");
+			return fsck_report_object(repo, options, oid, OBJ_BLOB,
+						  FSCK_MSG_GITMODULES_LARGE,
+						  ".gitmodules too large to parse");
 		}
 
+		data.repo = repo;
 		data.oid = oid;
 		data.options = options;
 		data.ret = 0;
@@ -1229,9 +1288,9 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
 					".gitmodules", buf, size, &data,
 					CONFIG_SCOPE_UNKNOWN, &config_opts))
-			data.ret |= report(options, oid, OBJ_BLOB,
-					FSCK_MSG_GITMODULES_PARSE,
-					"could not parse gitmodules blob");
+			data.ret |= fsck_report_object(repo, options, oid, OBJ_BLOB,
+						       FSCK_MSG_GITMODULES_PARSE,
+						       "could not parse gitmodules blob");
 		ret |= data.ret;
 	}
 
@@ -1246,17 +1305,17 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 			 * blob too gigantic to load into memory. Let's just consider
 			 * that an error.
 			 */
-			return report(options, oid, OBJ_BLOB,
-					FSCK_MSG_GITATTRIBUTES_LARGE,
-					".gitattributes too large to parse");
+			return fsck_report_object(repo, options, oid, OBJ_BLOB,
+						  FSCK_MSG_GITATTRIBUTES_LARGE,
+						  ".gitattributes too large to parse");
 		}
 
 		for (ptr = buf; *ptr; ) {
 			const char *eol = strchrnul(ptr, '\n');
 			if (eol - ptr >= ATTR_MAX_LINE_LENGTH) {
-				ret |= report(options, oid, OBJ_BLOB,
-					      FSCK_MSG_GITATTRIBUTES_LINE_LENGTH,
-					      ".gitattributes has too long lines to parse");
+				ret |= fsck_report_object(repo, options, oid, OBJ_BLOB,
+							  FSCK_MSG_GITATTRIBUTES_LINE_LENGTH,
+							  ".gitattributes has too long lines to parse");
 				break;
 			}
 
@@ -1272,7 +1331,9 @@ int fsck_object(struct repository *repo,
 	struct fsck_options *options)
 {
 	if (!obj)
-		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
+		return fsck_report_object(repo, options, NULL, OBJ_NONE,
+					  FSCK_MSG_BAD_OBJECT_SHA1,
+					  "no valid object to fsck");
 
 	return fsck_buffer(repo, &obj->oid, obj->type, data, size, options);
 }
@@ -1283,18 +1344,18 @@ int fsck_buffer(struct repository *repo,
 		struct fsck_options *options)
 {
 	if (type == OBJ_BLOB)
-		return fsck_blob(oid, data, size, options);
+		return fsck_blob(repo, oid, data, size, options);
 	if (type == OBJ_TREE)
-		return fsck_tree(oid, data, size, options);
+		return fsck_tree(repo, oid, data, size, options);
 	if (type == OBJ_COMMIT)
 		return fsck_commit(repo, oid, data, size, options);
 	if (type == OBJ_TAG)
 		return fsck_tag(repo, oid, data, size, options);
 
-	return report(options, oid, type,
-		      FSCK_MSG_UNKNOWN_TYPE,
-		      "unknown type '%d' (internal fsck error)",
-		      type);
+	return fsck_report_object(repo, options, oid, type,
+				  FSCK_MSG_UNKNOWN_TYPE,
+				  "unknown type '%d' (internal fsck error)",
+				  type);
 }
 
 int fsck_objects_error_function(struct fsck_options *o,
@@ -1357,17 +1418,17 @@ static int fsck_blobs(struct repository *repo,
 		if (!buf) {
 			if (is_promisor_object(repo, oid))
 				continue;
-			ret |= report(options,
-				      oid, OBJ_BLOB, msg_missing,
-				      "unable to read %s blob", blob_type);
+			ret |= fsck_report_object(repo, options,
+						  oid, OBJ_BLOB, msg_missing,
+						  "unable to read %s blob", blob_type);
 			continue;
 		}
 
 		if (type == OBJ_BLOB)
-			ret |= fsck_blob(oid, buf, size, options);
+			ret |= fsck_blob(repo, oid, buf, size, options);
 		else
-			ret |= report(options, oid, type, msg_type,
-				      "non-blob found at %s", blob_type);
+			ret |= fsck_report_object(repo, options, oid, type, msg_type,
+						  "non-blob found at %s", blob_type);
 		free(buf);
 	}
 
diff --git a/fsck.h b/fsck.h
index 62b7c3c93a..5d05996dd0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -159,6 +159,7 @@ int fsck_refs_error_function(struct fsck_options *options,
 			     const char *message);
 
 struct fsck_object_report {
+	struct repository *repo;
 	const struct object_id *oid;
 	enum object_type object_type;
 };

-- 
2.53.0.1055.ga2ffed1127.dirty

