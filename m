Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44FF3A6F1A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176399; cv=none; b=QWFFELqTlT6eGYeKK1tSTLOEeYFsTRHO/16l3Aq7qa/qLX/9G2Y4zFmypvGIF6BXKs2CZft+vGQYTcqE4YQQF721zHeaQbxulvLVKarYICDWkbh+lfEfniqymmpm8HAXNQoymAuPU3eBu6b2XQ3O1jWrwgzh3Ir6Wf9sFYha4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176399; c=relaxed/simple;
	bh=OUcPbGuzbb8pyxjQfjzDOet+UytgnIupsjg34HviTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PztWclKHP/qQ2ixnoUleAQHiFEJlpvg2egmvWPS5faTbSI/i0MS4F6gSSUfBZjXC5CUQMr5ufY2EBbKF2oUpwI4zijqP3n/ARZmtqiA3Ssvc1KGojUYlonbnwqNZimqI6OQLKodH+IB7iW5W2+PTck0j7Pehj4rqLO5OMHwDiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQtOekje; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQtOekje"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ec3b429a3aso1147241a34.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176396; x=1787781196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nR0aPcfVmssE2DVb9TZbTLcTDzeN9M3h3j9cx5My4TA=;
        b=qQtOekjegQjBGADWqSVtQapaLEjnJ10emgmCcWt16P1sVffxZtLUk6Z1eUHCcrMQBF
         VDthxNwDJclGeuYgHw6S6m49AuRTOGIrdgDs6X5Dg1GId5RyOr+LomAi+hZ2dalVTZjP
         ZABzJpBGrZ6I4+tHz6aK9j7xQQiGh8ufC6vbKfHnSPm03Dr8TvhcViV9FhiZgIkZB493
         aDf32de2X2WHZV15LWailqNlZepEuUi/Y5E3yJaIU3hKndfWrmI54xABaVqK9UtgC+di
         AEh6wqh/yEm1Z5XXegSKTpN+a/Lh3Jm6b/O3sYHcjhnH/ykQEKh4XUFR4/XyOm4Lgo51
         e/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176396; x=1787781196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nR0aPcfVmssE2DVb9TZbTLcTDzeN9M3h3j9cx5My4TA=;
        b=tSCfzmkksnPRHK6ILWXy3/Vn7Wj8u0JiQUHdfjabmNnY65s9sI+27nYrv+vPkLwyz4
         iKIZNmdii1CM3kmY0I2yQnc/7QCFjRO9GE+QA5p+TTYI0N9u1L03+lhO6/NEEgWgimIK
         DSjK84t9+G0rC9T2z7DESkoPrhMPyXLQeTYLtNoycTlKTqzUX7TomkduLkkYOu99yekL
         I0wj3Q75M5/lh9Mr6O3A2xvBSFiJY1RqndXYHPCaeDU+vmNoiP19pAL8NCIRHc2vMCwY
         PMO+CVhDw1g32StrbiC0eIDeP1UjgqZV/F5kJ+7IgL6jfoFcV1jmO7Ds0RjN3ZPDXbj9
         pabg==
X-Gm-Message-State: AOJu0YzOjnjMNqrRI+EV1pkR36YRbnWtli/4SXeHU5VdxN+qkx/dbfO5
	RSj1NsklUQCVP9W8qJ3oQkSzcv8DoD4eVc+PlfWQHuHzrHnNdlwrBLY7W3f3qA==
X-Gm-Gg: AR+sD11DxcswdndWFXZw1HXQDwXsVlmGU0Xj/jH8qCqb9tidrw42G8chtVsUHtirFnV
	KpYHeq4MdGnIKnOGE7EYNQBdxaW2sXjnIxuw7UK34ReqfyjcRt8ki0A/i0xKSU93h0OYxVKqT/K
	WlGDzouWNQp0d5z2bnmrpbw4EX28Tw6RPlrHWRJf6fL7mrmuuefB4QMFeLSFzTXjQQ4EYSuhTNA
	PhEbFstFjciTXr39Sk/8t91aSkJIDEZP9izJrcXTwxlzfsHSyLTN2WN1AX0XYJz70bvUE7tXIE8
	q47x1lIMLT6OI6bQ4trjY3HhrwFa/Yc6jQ2lBqqgVN/CBVFhdxfMVtW0mYmp+IH2+wSCxpqcs5X
	qkXWF3/we9ynoASGsX3rub4GDBFaeVfK4fdQgZSCSYp/6LwCChoWgUMIuVbVIB4IQ8uxWzl0qze
	VIDuBlFhecnUh7DZJeA3GszpTYO+615NJdbMA/Wqu2gfS3WXf6Thowf/4snzZavgampaBn
X-Received: by 2002:a05:6820:1c98:b0:6aa:cce3:ab61 with SMTP id 006d021491bc7-6b13c317650mr6329548eaf.9.1787176396180;
        Wed, 19 Aug 2026 14:53:16 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:15 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/9] builtin/receive-pack: pass shallow file explicitly
Date: Wed, 19 Aug 2026 16:53:05 -0500
Message-ID: <20260819215311.3880274-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If shallow information is provided during `unpack()`, a temporary
shallow file is created and stored in global state. In a subsequent
commit, the `unpack()` logic is moved behind a generic ODB transaction
interface to handle writing packfiles and thus can no longer rely on
such global state. Lift the setup of the temporary shallow file out of
`unpack()` and wire it through to its call sites explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ed1edcbe93..135105deae 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -86,7 +86,6 @@ static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
-static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
@@ -2334,8 +2333,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
-static const char *unpack(int err_fd, struct shallow_info *si,
-			  struct odb_transaction *transaction)
+static const char *unpack(struct odb_transaction *transaction,
+			  const char *shallow_file, int err_fd)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2354,10 +2353,9 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		return hdr_err;
 	}
 
-	if (si->nr_ours || si->nr_theirs) {
-		alt_shallow_file = setup_temporary_shallow(si->shallow);
+	if (shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, alt_shallow_file);
+		strvec_push(&child.args, shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2433,14 +2431,14 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 	return NULL;
 }
 
-static const char *unpack_with_sideband(struct shallow_info *si,
-					struct odb_transaction *transaction)
+static const char *unpack_with_sideband(struct odb_transaction *transaction,
+					const char *shallow_file)
 {
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(0, si, transaction);
+		return unpack(transaction, shallow_file, 0);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2449,13 +2447,14 @@ static const char *unpack_with_sideband(struct shallow_info *si,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(muxer.in, si, transaction);
+	ret = unpack(transaction, shallow_file, muxer.in);
 
 	finish_async(&muxer);
 	return ret;
 }
 
-static void prepare_shallow_update(struct shallow_info *si)
+static void prepare_shallow_update(struct shallow_info *si,
+				   const char *shallow_file)
 {
 	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
 
@@ -2495,12 +2494,13 @@ static void prepare_shallow_update(struct shallow_info *si)
 	 * command. check_connected() will be done with
 	 * true .git/shallow though.
 	 */
-	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
+	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, shallow_file, 1);
 }
 
 static void update_shallow_info(struct command *commands,
 				struct shallow_info *si,
-				struct oid_array *ref)
+				struct oid_array *ref,
+				const char *shallow_file)
 {
 	struct command *cmd;
 	int *ref_status;
@@ -2519,7 +2519,7 @@ static void update_shallow_info(struct command *commands,
 	si->ref = ref;
 
 	if (shallow_update) {
-		prepare_shallow_update(si);
+		prepare_shallow_update(si, shallow_file);
 		return;
 	}
 
@@ -2711,11 +2711,17 @@ int cmd_receive_pack(int argc,
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
 		if (!delete_only(commands)) {
+			const char *alt_shallow_file = NULL;
+
+			if (si.nr_ours || si.nr_theirs)
+				alt_shallow_file = setup_temporary_shallow(si.shallow);
+
 			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
 				unpack_status = "unable to start object transaction";
 			else
-				unpack_status = unpack_with_sideband(&si, transaction);
-			update_shallow_info(commands, &si, &ref);
+				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
+
+			update_shallow_info(commands, &si, &ref, alt_shallow_file);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
-- 
2.55.0.424.g13c7afec21

