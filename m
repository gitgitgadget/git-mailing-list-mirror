Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597E422E25
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052353; cv=none; b=ed7LdvpH2x34ndvDOGzxSY+4IDXL6gl1nM7xeCbbzaQinnoM3jeToRz0JmQW6F4GQ5oO63lqATyfDUaSw1THeuAUGO05IMbG8XrWNAM3h/UC80nvPx0nZQ5KNE32jxCv96BpRzN9o0PV9X19IveIL5yW5xrpDIJOoLuGEbC+Icc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052353; c=relaxed/simple;
	bh=dQbNoy1X1zuY4PoTxNIqnT7rQUOdOpnlyjzca2UGxks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/kdJ8/VK2ntAHq1m5HN/14mtkU4L3TT3mksuTmr3/dtoXVewSO7gEi5r6TDoCtbQ3vvWIl8YRKOiHK95/21rxQBU0OgbkHGnpMZyvaJqYlFxO4C+bU1mbPSmnGKkoFoSp6MVnHNURmDYo1ZpteaVia2QHfCIVtdfOn13X0dlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeGYxhxz; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeGYxhxz"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6aeaaef491cso749446eaf.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052346; x=1786657146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zej4B90F+w2VYQPulyF+o9sI2XEqz+F2bpwmAvum6kc=;
        b=jeGYxhxzjUWdgJ4YHkWphs2rJzjikr2Thtnhxoglvc/DG4e0kO5cpL4bQsW1+7i+lJ
         j0wrzcLM+WNnJFVyMDuABbDUrCXfV1pPsuScXmmyFnwD8RrGBd9w47qgVgantcqH9Uls
         F2vPzcr2jOCQc14FZB72Gs0gNiPaRpBteaE/4c8sZ4wNBTUddU7YCNeJn+YA9cHhIv+F
         zkaMYSJF+6xmZ8wHy4UWddGExq45ehcDTCMivwVKB996WNinqG9V/QjGsRI/GkSq9ErQ
         aT3EtrRnuVgQxZ54qPXpIr+fRX1yn3ZkaY3VbeK8G742Ok7+6s9qEFAuBGLnCXMbJ4wZ
         XHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052346; x=1786657146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zej4B90F+w2VYQPulyF+o9sI2XEqz+F2bpwmAvum6kc=;
        b=XNuR0ovFuiyUuZfcLby3phR3jNzQKFEssx8fm/y/qB9x788VegZ8BycTJlEE+eP0j1
         hhVZhtBpPeFXbDqbUgNwt/iMFpDRjVV9QnlXOZso79QZhmvF4CWAIdzoYKOFH+vqEl5t
         kHPR5qePaw1bHO34llFRKaCvV7YnBTZhvJIxVwbySzrQFL+xDW6wxTFcW+sl/YuTDTG4
         NDO6xkRnCYwcd2lAPEslOTEj4NmTA2308O70e8d7iiCMtQCG0StphWraSIGnzFuFeT9R
         WpP/HTlQwNATmIFRHVqqlct9yLPSEmy0ZyNwb8iApMqtOrx2OkC/B0SWnPOHhCKPOiaa
         CiUQ==
X-Gm-Message-State: AOJu0YxkryLLTgobJc7FbX32sVu1jWpiSD/4f3MvgK8akcOHk5Zox/Q0
	bfaHlvQ2TRWOsRkCcAy6jNguInlKB7vxHzRusy08z1Tj4Jm0ef/Dd0gOt6vFIQ==
X-Gm-Gg: AR+sD11yOZ/A2rI5MQ+MD/2rn0Pp+yU0v7DdAY4Po4Dc5KYVfgBZOPUak9eMULGDfNI
	ihdy9LMTksFyzQobJj9AYJCi+usN20fia+H7CyLQ80b169eh5090iESkkeG1KR71d6JKbEdeh3F
	TqRNm1/BdJ3KrtOt+YPigyFafevMkvRPQCqTQdlJsINU2UcnKGBPSRvOoajRo1IAm0QCQBIr0MD
	01GBvqmzGNQz6uyDwkL43xndyd0i+1i+9fCR5csGncRHZk+uMxoUDD/IVreeWM7F0fbsINXr6z3
	TZEOANeET5YalK/nG7uoAbKWlMy8Q7x9KTdRhTOyKHbNWjIoZyAcj7yLflS38657Z6vFkNCAsNn
	GEYHu8WSyzphozWi+4jNxu77dfroRVehBzTU2ZLkEyuHMEZ1X2fRkokoXJ9ZkVjusgKXi+vASRl
	xa5vOQGAksFM1qh9FyuuOGQB5i/Qb0sE3XW8LwzazitcEwAJxZn7Uc0UbXH2ghz6oUG+v7cxgQN
	KqwVwk1
X-Received: by 2002:a05:6820:8183:b0:6a1:8192:4d89 with SMTP id 006d021491bc7-6ae96f82811mr8810919eaf.29.1786052345803;
        Thu, 06 Aug 2026 14:39:05 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:05 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/6] builtin/receive-pack: pass shallow file explicitly
Date: Thu,  6 Aug 2026 16:38:55 -0500
Message-ID: <20260806213859.816157-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260806213859.816157-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
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
index 420de9aa7f..6da854fca2 100644
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
@@ -2427,14 +2425,14 @@ static const char *unpack(int err_fd, struct shallow_info *si,
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
@@ -2443,13 +2441,14 @@ static const char *unpack_with_sideband(struct shallow_info *si,
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
 
@@ -2489,12 +2488,13 @@ static void prepare_shallow_update(struct shallow_info *si)
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
@@ -2513,7 +2513,7 @@ static void update_shallow_info(struct command *commands,
 	si->ref = ref;
 
 	if (shallow_update) {
-		prepare_shallow_update(si);
+		prepare_shallow_update(si, shallow_file);
 		return;
 	}
 
@@ -2705,11 +2705,17 @@ int cmd_receive_pack(int argc,
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

