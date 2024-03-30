Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC444B5CD
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838793; cv=none; b=kQURp9dHvX+o9OBNh1/7MQNsezHCAyeBRoKFzN1EosPLuCtDCoIl6OVVRZr+o0MPfsF2pZDtzjLzMYbrBrFTHPQW4L8od/r2kwzeY2pCh5B2DiPuj6EFlI1oOrNaew2R2lEIYvNZmhnZrIS3n16XDyCBe6NL+BYNRofQO+wa8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838793; c=relaxed/simple;
	bh=SgRBdx85GJTZ8tVtuuv6d8V3jnqZDSTXU4n7fCBYEQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaI+CxAyetssdGz0I7Q9hWwxkkIRuFkXbkZ/MPl0OWqqxYaQLpPSt+s8QhKwZGYavHU8N3v9NrBdNKtR5EtV/zMGuZrFBhhPqJHGW4AFJV9XA9bptehYlLTKXQlDIZ+Us229AHGezjkQ8hD7WjfQ9VCzWundvk77A62LPD+paRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAm4iR5Z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAm4iR5Z"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e6777af4so4962629e87.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838790; x=1712443590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scGVmOOzRt0YOi1oGfhnGq8ys0G08AR56BHOt+nkQPU=;
        b=SAm4iR5ZiRlVxwpw1VMR5ndcqycO59RHZcKuJ8x7QK7wpWYpxRU90ke3wNipL8ZM3t
         FYWJufuVWWXtNmRJ6VUctgOrRYGBw8u6Ir0PramjPFCBLnrlUkmKmed6G9M7aTGdTDnl
         9nciwkqSWV8lmNEZt8qdwvK2i7NGD2ZvykP3Qa8c3KZ+H0X2cg4VXjY05WFpBOuMQQPz
         xK3iN6V+8/+6hZ00I8W83WKobROyBMnngUl4DdTWM4d9C7PGUEjdZqVGbMQmGioseWZF
         v3xF/7rBVtcB6cl8JohjyMYgD23yRXzadIYUA8obp4HjbWtqNxEBkDYKjYOqnBmXnP1N
         mukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838790; x=1712443590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scGVmOOzRt0YOi1oGfhnGq8ys0G08AR56BHOt+nkQPU=;
        b=ovjLT/kWIB7MvfQuGrIhMT/lYEX2WyCMsx63re6KqVwSB8dMCGW3BA0VFJAIglBphe
         12Ei9qZDtag18BBYfelzCfQ58HeihP9XWlcE9198eFn3pwxXKF0DfPO/MbgmsyqEmKSz
         8eU9OB3/A72QVIjcGZh4IErOcFIxZz0TvSuo7WrdGNxQej52/Sq99B6vnN/v00Vfb1Bh
         Ta/3UETYkAvTT6BjDlGg6wLr7H7T+o/c6AKMJBippJkEZvWNi8tG/aGYawgljlnZVRBb
         mFwKrwySd8+WPU20oFnPOZUtVkIvjq3/pEF2p+XgdPEFi4mPq8kijdZb7A3HlXQLb6d2
         hsyg==
X-Gm-Message-State: AOJu0YwzCRqYSGvI80zpIlhKjbXfNEvyiYJmXvz7PRixgK2FtCOgyq5C
	56eMO9Scfiv40YRXfwbgXCEEYADNDeD4A6tSZCS327jEsyDxyeem13V3FGLdkGA=
X-Google-Smtp-Source: AGHT+IEc+sAkFJfEhrtRL68TLxfpk6TprvykLzxREDG6zkHLAmaJSsaV2urLI+KxQklZvLZ9UsT/Zg==
X-Received: by 2002:a19:2d54:0:b0:515:bfaa:fa12 with SMTP id t20-20020a192d54000000b00515bfaafa12mr4780247lft.22.1711838789719;
        Sat, 30 Mar 2024 15:46:29 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/8] reftable-backend: move `write_symref_with_log` up
Date: Sat, 30 Mar 2024 23:46:18 +0100
Message-ID: <20240330224623.579457-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `write_symref_with_log` code will be consequently used to provide
symref creation functionality in transactions. To do this, we move the
declaration up so it can be used accordingly.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 116 ++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 282a08e3cb..9b53d42541 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -588,6 +588,64 @@ static const char *original_update_refname(struct ref_update *update)
 	return update->refname;
 }
 
+struct write_create_symref_arg {
+	struct reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_symref_with_log(struct reftable_writer *writer,
+				 struct write_create_symref_arg *arg,
+				 uint64_t update_index)
+{
+	struct reftable_ref_record ref = {
+		.refname = (char *)arg->refname,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *)arg->target,
+		.update_index = update_index,
+	};
+
+	struct reftable_log_record log = {0};
+	struct object_id new_oid;
+	struct object_id old_oid;
+	int ret;
+
+	ret = reftable_writer_add_ref(writer, &ref);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note that it is important to try and resolve the reference before we
+	 * write the log entry. This is because `should_write_log()` will munge
+	 * `core.logAllRefUpdates`, which is undesirable when we create a new
+	 * repository because it would be written into the config. As HEAD will
+	 * not resolve for new repositories this ordering will ensure that this
+	 * never happens.
+	 */
+	if (!arg->logmsg ||
+	    !refs_resolve_ref_unsafe(&arg->refs->base, arg->target,
+				     RESOLVE_REF_READING, &new_oid, NULL) ||
+	    !should_write_log(&arg->refs->base, arg->refname))
+		return 0;
+
+	fill_reftable_log_record(&log);
+	log.refname = xstrdup(arg->refname);
+	log.update_index = update_index;
+	log.value.update.message = xstrndup(arg->logmsg,
+					    arg->refs->write_options.block_size / 2);
+	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
+	if (refs_resolve_ref_unsafe(&arg->refs->base, arg->refname,
+				    RESOLVE_REF_READING, &old_oid, NULL))
+		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
+
+	ret = reftable_writer_add_log(writer, &log);
+	reftable_log_record_release(&log);
+	return ret;
+
+}
+
 struct reftable_transaction_update {
 	struct ref_update *update;
 	struct object_id current_oid;
@@ -1214,64 +1272,6 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	return ret;
 }
 
-struct write_create_symref_arg {
-	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
-	const char *refname;
-	const char *target;
-	const char *logmsg;
-};
-
-static int write_symref_with_log(struct reftable_writer *writer,
-				 struct write_create_symref_arg *arg,
-				 uint64_t update_index)
-{
-	struct reftable_ref_record ref = {
-		.refname = (char *)arg->refname,
-		.value_type = REFTABLE_REF_SYMREF,
-		.value.symref = (char *)arg->target,
-		.update_index = update_index,
-	};
-
-	struct reftable_log_record log = {0};
-	struct object_id new_oid;
-	struct object_id old_oid;
-	int ret;
-
-	ret = reftable_writer_add_ref(writer, &ref);
-	if (ret)
-		return ret;
-
-	/*
-	 * Note that it is important to try and resolve the reference before we
-	 * write the log entry. This is because `should_write_log()` will munge
-	 * `core.logAllRefUpdates`, which is undesirable when we create a new
-	 * repository because it would be written into the config. As HEAD will
-	 * not resolve for new repositories this ordering will ensure that this
-	 * never happens.
-	 */
-	if (!arg->logmsg ||
-	    !refs_resolve_ref_unsafe(&arg->refs->base, arg->target,
-				     RESOLVE_REF_READING, &new_oid, NULL) ||
-	    !should_write_log(&arg->refs->base, arg->refname))
-		return 0;
-
-	fill_reftable_log_record(&log);
-	log.refname = xstrdup(arg->refname);
-	log.update_index = update_index;
-	log.value.update.message = xstrndup(arg->logmsg,
-					    arg->refs->write_options.block_size / 2);
-	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
-	if (refs_resolve_ref_unsafe(&arg->refs->base, arg->refname,
-				    RESOLVE_REF_READING, &old_oid, NULL))
-		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
-
-	ret = reftable_writer_add_log(writer, &log);
-	reftable_log_record_release(&log);
-	return ret;
-
-}
-
 static int write_create_symref_table(struct reftable_writer *writer, void *cb_data)
 {
 	struct write_create_symref_arg *arg = cb_data;
-- 
2.43.GIT

