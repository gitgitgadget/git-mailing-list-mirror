Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25019048D
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279957; cv=none; b=CLNEChDF8veUXnBpjhdRFo9etSH7SpFegwxUMi7a6CyYXn9qdCHXyh7NXbKyT8ryIzaYI5PKXx30EgpZZ6rf+OnqEcL0NLqGjiGkrgQgDOC25PPvdpBh8xL3GHW/h+4zpb1+Dm5IXPyzLOTg8ikGEJhWP5KmHDYEJ4eonp880Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279957; c=relaxed/simple;
	bh=1zQAW1gf6s8EkfhWmsjwMbxZIi5DU5Z49Kos2YDhOaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYhu1vUALdfvM8+kam7BAJSQrbhBM2YARov3c/zTMhacKK0dAY2g7bZei67Q9n+cXauFmXyFZLmolKqesWCMiutwV/ndtgUqPvQh7hjIZPcyzWq/WYD8O1ZO5dbrqWh0aqZMHjH4kDa1YJ6m9RnoFE6KAXAqAEu9B2bQPazZorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUYwXycc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUYwXycc"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa68b513abcso550147966b.0
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279954; x=1734884754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yP66MpHoRJMrRT8Yqjo1czS94YPdDgttlZIZ/ZdMEA=;
        b=RUYwXycc9TQOJGVHOwGfK3yNtOXX6GpMxlgIwTDeEHACGtk06UiS4hCo+S22vNFu5F
         0x1v82yzBVz2CPdEHXahRDJwGNqEXN02BVzPEwBcAVKzmXL/ELAjJS29b9zceBcJKFjD
         IdLLLhxS4AI+WrP204LQ+W4Z7i4nIUSo2yQAecv+CtVjCw8MY5gBxpEDwIyKULdDSwt6
         7uFqjq73BJmAVMS3NY4qq9yFJg1VJmGdDeGBH3IpK41Wx7di35ig7hFyNcQn5VYlTWQR
         lsDdOQp+cdDxhBJeogtfc3q1z8WqlKH4Kfv0wCyQ4E3T6tK/t0QI6Fsuqq1SjjNUSqWL
         fPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279954; x=1734884754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yP66MpHoRJMrRT8Yqjo1czS94YPdDgttlZIZ/ZdMEA=;
        b=outSHc/P+unDn4yDgwEYoNjUTpPVnN+Q+dqVo+niOfxBUubxPPFBX7093jekrGPa5Q
         cB/429NF/HhLYtn9m6p9W0ahilCBeAuTIEHHltEGjjnJ2lr56L/UyRt6VJs+Mv3+urIK
         Rvb2a37aSiyHPwBW6Co46MM6FyomNDnzutzWO8YurtvRw7RfUmvjV5VbQ7Z+ELTLtzMm
         bAETyLQpq9UpTqsOLvFSnMAWDZjzZKQhY2SeMX3otBW6lj24z45UCazjI1v6LXpaEMYM
         5dd7b8gwti3Nbkat1GH/zC5OIQHptKdsNBd6CsFysMy8PpGquXo+k21B2cYcSnn91OeU
         mMIw==
X-Gm-Message-State: AOJu0YzoQpaKc0sfbvIevni+BuTnwDoTCHQeIMLR5XgV9GuB0XdNJxR/
	cST0aRx87PXQNIRWU8pv+xrK6rX70srNmuV16+DPTuq2FQKsVUzU
X-Gm-Gg: ASbGncus9rUOBSVodbMe4YLonz6VT0TSy6ZHOQvRbs1fH03zOy6Fa4qyAgF5JJmex/P
	4iDB5RWUGBQ8siPsIXMQkCEZLgqGAvdhji2p4AcnBOWt1Yc5uXObpshO+C0NWtq0voQjtjxIpOb
	m+tO8Mm0ZwSG8FWV4pMAv8u5hGD8ilfiEZM68W65lW1ypM7cfzsCVvBEKDzGyBq+8jEm03tXjW5
	6h9oJY/ZkWNIrpLkQDYGWeYpKp77557Daa7Kgl+g7ylbKMd72BU78e50wU2QmHfkXrnnA==
X-Google-Smtp-Source: AGHT+IECQ8vxblJuypY/szevXuErHCytawNkw8N4HPlpTw9GZULsegtJCYd7rHPK85xeEelmtHr9Og==
X-Received: by 2002:a17:906:329a:b0:aa6:8602:9514 with SMTP id a640c23a62f3a-aab77e825a0mr918894166b.48.1734279953606;
        Sun, 15 Dec 2024 08:25:53 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:53 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:38 +0100
Subject: [PATCH v3 1/8] refs: include committer info in `ref_update` struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-1-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5688; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1zQAW1gf6s8EkfhWmsjwMbxZIi5DU5Z49Kos2YDhOaQ=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMNdjAbsJp6FDTVgPSv/bXPt7G9p6LW+6ES/
 5d05Gmop1yJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDQAKCRA+1Z8kjkaM
 fxLlDACHzGUWgc3jfthCD0VG28S3UCR4Pbwi1jmCWmX8rvJA0vPr/SKwnJ4c6XQQdmPFJ9EOc0I
 aU/WtnW6VsRE/GxInuNTg/j88D320PQQgcC5ustrgbH43a00cnKr0GQtb208MlcU/j/wGCruzBd
 1eQgSdMq7lFE9S/7zttkrxbQnOr/jRXODAR8HFqtaudI3arN5h5Ngb3CfJf1+e/Oxo8djUdVS5U
 +z58rCFx8+XDICVPtvpAX8urupXycbY43qcbnRODn1EjWiRA6B53s8JEr5cqoBEKEeZ7JgcHw5b
 Kdysf6PMar7muZdJw8WAYywKXM70W32ZZmGZIon4/SkoCLUYJ2DXnEcyF3mYEyaTP4RbB7N1Uyg
 kifErHyjLJHisCXPVbKXMozYZZjOjSeLzbaKDRclfMcoHjZdezqMvCfMMhxtX62og7FYNgVLCJL
 dO3EnhXEfT/LxnxMqqYO8CLbsTw6YnKwqIQQyIfmqlhLgDSAqcjXkhZCpsJAVhF0s0QkA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference backends obtain the committer information from
`git_committer_info(0)` when adding a reflog. The upcoming patches
introduce support for migrating reflogs between the reference backends.
This requires an interface to creating reflogs, including custom
committer information.

Add a new field `committer_info` to the `ref_update` struct, which is
then used by the reference backends. If there is no `committer_info`
provided, the reference backends default to using
`git_committer_info(0)`. The field itself cannot be set to
`git_committer_info(0)` since the values are dynamic and must be
obtained right when the reflog is being committed.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  1 +
 refs/files-backend.c    | 24 ++++++++++++++----------
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c | 12 +++++++++++-
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 762f3e324d59c60cd4f05c2f257e54de8deb00e5..f003e51c6bf5229bfbce8ce61ffad7cdba0572e0 100644
--- a/refs.c
+++ b/refs.c
@@ -1151,6 +1151,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 64f51f0da905a9a8a1ac4109c6b0a9a85a355db7..6078668c99ee254e794e3ba49689aa34e6022efd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1858,6 +1858,9 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
+	if (!committer)
+		committer = git_committer_info(0);
+
 	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
 	if (msg && *msg) {
 		strbuf_addch(&sb, '\t');
@@ -1871,8 +1874,10 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 }
 
 static int files_log_ref_write(struct files_ref_store *refs,
-			       const char *refname, const struct object_id *old_oid,
-			       const struct object_id *new_oid, const char *msg,
+			       const char *refname,
+			       const struct object_id *old_oid,
+			       const struct object_id *new_oid,
+			       const char *committer_info, const char *msg,
 			       int flags, struct strbuf *err)
 {
 	int logfd, result;
@@ -1889,8 +1894,7 @@ static int files_log_ref_write(struct files_ref_store *refs,
 
 	if (logfd < 0)
 		return 0;
-	result = log_ref_write_fd(logfd, old_oid, new_oid,
-				  git_committer_info(0), msg);
+	result = log_ref_write_fd(logfd, old_oid, new_oid, committer_info, msg);
 	if (result) {
 		struct strbuf sb = STRBUF_INIT;
 		int save_errno = errno;
@@ -1974,8 +1978,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 	files_assert_main_repository(refs, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
-	if (files_log_ref_write(refs, lock->ref_name,
-				&lock->old_oid, oid,
+	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid, oid, NULL,
 				logmsg, flags, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
@@ -2007,9 +2010,9 @@ static int commit_ref_update(struct files_ref_store *refs,
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write(refs, "HEAD",
-						&lock->old_oid, oid,
-						logmsg, flags, &log_err)) {
+			if (files_log_ref_write(refs, "HEAD", &lock->old_oid,
+						oid, NULL, logmsg, flags,
+						&log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
@@ -2969,7 +2972,8 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 	}
 
 	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid,
-				&update->new_oid, update->msg, update->flags, err)) {
+				&update->new_oid, update->committer_info,
+				update->msg, update->flags, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 
 		strbuf_addf(err, "cannot update the ref '%s': %s",
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 58aa56d1b27c85d606ed7c8c0d908e4b87d1066b..0fd95cdacd99e4a728c22f5286f6b3f0f360c110 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -113,6 +113,7 @@ struct ref_update {
 	void *backend_data;
 	unsigned int type;
 	char *msg;
+	char *committer_info;
 
 	/*
 	 * If this ref_update was split off of a symref update via
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 647ef9b05b1dc9a376ed054330b487f7595c5caa..e882602487c66261d586a94101bb1b4e9a2ed60e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1379,11 +1379,21 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			}
 
 			if (create_reflog) {
+				struct ident_split c;
+
 				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 				log = &logs[logs_nr++];
 				memset(log, 0, sizeof(*log));
 
-				fill_reftable_log_record(log, &committer_ident);
+				if (u->committer_info) {
+					if (split_ident_line(&c, u->committer_info,
+							     strlen(u->committer_info)))
+						BUG("failed splitting committer info");
+				} else {
+					c = committer_ident;
+				}
+
+				fill_reftable_log_record(log, &c);
 				log->update_index = ts;
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,

-- 
2.47.1

