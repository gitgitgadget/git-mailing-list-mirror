Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343ED46EF98
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448587; cv=none; b=ev0d1d5EE3kX8erX4ABDIfCDrVBh92tkyYoSm7bc6YW/uDwhHD25iULtztxMHAyGBNyLJTvRngPP5ShbGI5EsjYn2TPwBwrKn0HKXwrVIPcZ8X44kWvdwjBoCZFkFwye8kBEoelHf8csnZv1D1Wpq4OdU4HoAMhiqiCbnQoPtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448587; c=relaxed/simple;
	bh=E9wOcLZ50gvIM8Qwuwa6hLqyLxR+1tNwJ6+n9xq7PMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeXFYjpIffxrH9dUx5yvjZPXxok6yuvtVBMdOf2pCyGYo29Q/1cvTfodInpDSxyW5nyfDP+NcjAO1sQdff/MXdwbHe6mj04xvluAPZwHXbYtmuP2bcTxXbOJjHocV7OmjSaio5D37rD+mrnpnyzKEVOc/xXFQS+9ItF1iJx4P9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A99ZGXI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=le8LlGhg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A99ZGXI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="le8LlGhg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FC201400165
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448585;
	 x=1791534985; bh=kJpCbrHvsx9EXZe/Y5Q0bDfcaDUFVFwiEWI69ijpxk8=; b=
	A99ZGXI5D/AtKRht5CPVKgonFRzoojhCdulNgfJaVxCZwbOGXP3I9aLLM+YfDS8z
	BldnbtPy6Hk3W1HFWlipEHW42BKU9t+2glT7oekQ1efcB3Rdg8Nm1yG5pZoOdsiL
	9RCWrLY8xRKc5tiHNmjKadYJq2xuQM3hXtiS85Wqz1W8cDPvrXFTG5WwRJCp3kL1
	A2u4SeiKOo28zRV8EiZ5VPveZaXRhBhOqF7tw72Vs/gxk4uqoko0ypfUYvFHRA2v
	04hNRnaNAsu0QgWvnJKzH8DbdcTYUTkzI4c3y9Mw/P9pYsP+4eQsPKQWB12MQGrW
	zZF9V/eeYn0BKpBLoZdbcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448585; x=
	1791534985; bh=kJpCbrHvsx9EXZe/Y5Q0bDfcaDUFVFwiEWI69ijpxk8=; b=l
	e8LlGhgZVkZe9vdx1Rpt/lG7wAYfxiNdizfkofK8HuMWSXVBMxwTlbmEeIg5x71g
	aKQxo8cfG3+DOPXwVksKVZsFkRehQPfiqPUOnTZhu1dSkIFgFhVmMhzniX0WBCMY
	6UHfNtWdKsELlDZES3dyOHrku6VuC11Lwj+NESbWRB1sOpGy2Vm1uMcLN/gh/agk
	KwN0icivrD9RdcDBnrQNZU50+MZ63W9HvjkFcNkLzMocp6yiqwzwFDHrRoCWmJ23
	b4JcwuvXRJ+gYFyicBXA3ET5N+Gysnn+UbX+TYX/kCObTFzYlCeJcj+b2TC8aOcZ
	B81D1sb5TaRIrn1Jf6tsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448585; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fDXjOVX5hV206Rjn5wBfamyZh+45hAoFGWS1o/j22Akd7LL
	umvXGDI7e8VoZQNtgXuJkn24tJNdLMrNDDEte5DBbugVa+gL6rGdlDquiEySqZuh
	VmQW8MD7v5xL1LwyCkkpRwMfg7//G7AHmFoBZmi2+HvgCf5+0yVPrV0KHzJ9TKvB
	2yZe4r4a1LmByKCRWaMxOpj/vuszJ8zfuQNjWpEyRR3YWCemYtJw2UJ///Ivn2nX
	124m6NZjVpWMcOUdvz7kj0KuMoyXGaN8uVCSPBLQGYpefCRIWEOZc5mXWp3SzjCA
	D3xYUnRxX9DSPPoq5wINzFIUasj1Uz/uxNjOQtQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fVzy+E5O/6oHodLr3bYMk6XnLpYk5KMPqaWjw3cyUt4=:E9wOcLZ50gvIM8Qwuwa6hLqyLxR+1tNwJ6+n9xq7PMM=;
X-ME-Sender: <xms:CVbHaiATHYE2EE0BWOIh_43jxfutLJFZFI_rfZ5c2_uA4qBKOKyNjA>
    <xme:CVbHasvaWK4gbLov0Xw_GvXt0mUTVR0BC-uhc5q0_CUoKQiU8Cdyh3q3H1ry70Z73
    Em0Ojn6BIygzVlO33oCXF472I-O8qgprfyl4Ulhqi0rr-J6SxN59zw>
X-ME-Received: <xmr:CVbHanbTZfV0LZ05ROIJk2YAWvL7uc_mfgrPP2MgHmIseDdFaG7Rgw>
X-ME-Proxy-Cause: dmFkZTEVCRoNmqMD7gGKqYgF4FcRtJpjxypjYaCZtC+fojKCRR2/ov6urLN2WeMIKfYlC8
    g4+qGH3G7lZ5MmWs/h4xzOwu3/TcjoXPJgs7Jax+64L5BePyoY62loMVMd2k+K/ukfQDZe
    AKt/59HIEANyc8RV07pyNKgyz9LWMOVCQHFyyLY9ZxndALS8pV5jBab+vykGrz0GOno9Hi
    fQqTFB8UrPS+gtCo96HjKWqV76q6pliBfGGJqYB/BQfjdd+nJuDW0sLkUCY1dhKgbgSVne
    YD2fsdJQ8GaLk6C4Om17C5JHjYfEYHaQB+MhWuqSujVEOTgnpiUH8srwKuB1VvqOo0o/Ns
    ZeMeLPZAx79tckOTgKm4VfIMHXHx8Os8zQoy4XcglqeV7br76y33O37CqRHaT8EAkgsz6Y
    hgsZjZ6rD59GMXbxfMumjLH6tJ8LszunVgwwcaxyXCuWPWZ/TpbBzhdeUHBIqtacHb7q0u
    wO6u+qn96b+0ZgDPHoq3FWvuxOPr+9JQeWlzI28MwKbLKfX12c4cD5srNYJTTDga2Y6O39
    iX1Lgno3I2h/uKsQHk1Gd9jlye/msHIKSexv6gEhb3YhxsPtL4lxKx28851eptt8poKe1F
    W3ASpiF/zhhqPPpctnPXc+Ghgm1h0N+FzJt46sQ/GuvmO4cFQX44eIyPp/3Q
X-ME-Proxy: <xmx:CVbHavWK5SZaMkludxu74aLdriAuMrZm9vfI_GgQ8Q8jEEJp9wDm8g>
    <xmx:CVbHar4zCPjiSpyXZfYj_WYf9n7vRXFNricQEeYCPYGIdy4RzcKT-g>
    <xmx:CVbHaqhut0yb6tGIP8c6GdRYP_3inY2HsyGzJXq7Cd46jq46SVjoTw>
    <xmx:CVbHaicFN9yMgfTwRB0zSMjf4P7CmwyhzHWRE9xix263X4FwVoNaOg>
    <xmx:CVbHavTRoYVoC-8VtxFZRqOsDb8tGUUU_cPA3m7CSCN_NPGnQtoOUZT->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4715752 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:57 +0200
Subject: [PATCH v2 07/13] tmp-objdir: absorb logic to set and restore
 primary sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-7-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The functions `odb_set_temporary_primary_source()` and
`odb_restore_primary_source()` can be used to adapt the primary object
database source. Nowadays though we only have a single user of this
subsystem left, which is the "tmp-objdir" subsystem.

Despite that, this functionality is also becoming less useful overall as
alternates are becoming an implementation detail of the "files" backend.
And with that change, there will only ever be a single source attached
to the object database anyway.

Move the logic into the "tmp-objdir" subsystem accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 45 ---------------------------------------------
 odb.h        | 17 -----------------
 tmp-objdir.c | 38 ++++++++++++++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 66 deletions(-)

diff --git a/odb.c b/odb.c
index 1dc8647159..8b54271c27 100644
--- a/odb.c
+++ b/odb.c
@@ -239,51 +239,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	return alternate;
 }
 
-struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy,
-						    struct odb_source **prev_source)
-{
-	struct odb_source *source;
-
-	/*
-	 * Make a new primary odb and link the old primary ODB in as an
-	 * alternate
-	 */
-	source = odb_source_new(odb, dir, false);
-
-	/*
-	 * Disable ref updates while a temporary odb is active, since
-	 * the objects in the database may roll back.
-	 */
-	odb->repo->disable_ref_updates = true;
-	source->will_destroy = will_destroy;
-	source->next = odb->sources;
-	odb->sources = source;
-
-	if (prev_source)
-		*prev_source = source->next;
-
-	return source;
-}
-
-void odb_restore_primary_source(struct object_database *odb,
-				struct odb_source *restore_source,
-				const char *old_path)
-{
-	struct odb_source *cur_source = odb->sources;
-
-	if (strcmp(old_path, cur_source->path))
-		BUG("expected %s as primary object store; found %s",
-		    old_path, cur_source->path);
-
-	if (cur_source->next != restore_source)
-		BUG("we expect the old primary object store to be the first alternate");
-
-	odb->repo->disable_ref_updates = false;
-	odb->sources = restore_source;
-	odb_source_free(cur_source);
-}
-
 char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
diff --git a/odb.h b/odb.h
index 5c86572b5d..4143812f55 100644
--- a/odb.h
+++ b/odb.h
@@ -226,23 +226,6 @@ struct odb_fsck_options {
  */
 int odb_fsck(struct object_database *odb, struct odb_fsck_options *opts);
 
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory and return the newly installed primary source. The former
- * primary source is reported via `prev_source` when non-NULL.
- */
-struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy,
-						    struct odb_source **prev_source);
-
-/*
- * Restore the primary source that was previously replaced by
- * `odb_set_temporary_primary_source()`.
- */
-void odb_restore_primary_source(struct object_database *odb,
-				struct odb_source *restore_source,
-				const char *old_path);
-
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/tmp-objdir.c b/tmp-objdir.c
index deaaf6ba2e..31a7920be7 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -51,6 +51,26 @@ static void tmp_objdir_reparent(const char *old_cwd,
 	free(path);
 }
 
+/*
+ * Restore the primary source that was previously replaced by
+ * `tmp_objdir_replace_primary_odb()`.
+ */
+static void tmp_objdir_restore_source(struct tmp_objdir *t)
+{
+	struct odb_source *cur_source = t->repo->objects->sources;
+
+	if (strcmp(t->path.buf, cur_source->path))
+		BUG("expected %s as primary object store; found %s",
+		    t->path.buf, cur_source->path);
+
+	if (cur_source->next != t->prev_source)
+		BUG("we expect the old primary object store to be the first alternate");
+
+	t->repo->disable_ref_updates = false;
+	t->repo->objects->sources = t->prev_source;
+	odb_source_free(cur_source);
+}
+
 int tmp_objdir_destroy(struct tmp_objdir *t)
 {
 	int err;
@@ -62,7 +82,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 		the_tmp_objdir = NULL;
 
 	if (t->prev_source)
-		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
+		tmp_objdir_restore_source(t);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -298,7 +318,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (t->prev_source) {
 		if (t->repo->objects->sources->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
+		tmp_objdir_restore_source(t);
 		t->prev_source = NULL;
 	}
 
@@ -328,6 +348,16 @@ struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
 		BUG("the primary object database is already replaced");
 	t->will_destroy = will_destroy;
 
-	return odb_set_temporary_primary_source(t->repo->objects, t->path.buf,
-						will_destroy, &t->prev_source);
+	/*
+	 * Make a new primary source and link the old primary source in as an
+	 * alternate. Disable ref updates while a temporary source is active,
+	 * since the objects in the database may roll back.
+	 */
+	t->prev_source = t->repo->objects->sources;
+	t->repo->objects->sources = odb_source_new(t->repo->objects, t->path.buf, false);
+	t->repo->objects->sources->next = t->prev_source;
+	t->repo->objects->sources->will_destroy = will_destroy;
+	t->repo->disable_ref_updates = true;
+
+	return t->repo->objects->sources;
 }

-- 
2.56.0.406.ga2d225a756.dirty

