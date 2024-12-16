Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606F1C9B9B
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367480; cv=none; b=Kx9Cb3Ntl5VlX1VCUp+/cAD2ba4pFeEIjpqawmQp74p4ccMZD75d/HZvhzoO7AhISCVJqRlgfdDNvtpz3mQzjMBTol6y+exOUDIvc0pCGXwYtXW74cptWMQmEDy7hNFHa89R+A84khRNGUlrgzw/er0kqRDNSUkpUl3Ynh6wFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367480; c=relaxed/simple;
	bh=1zQAW1gf6s8EkfhWmsjwMbxZIi5DU5Z49Kos2YDhOaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vE/5AgtDwZtDP7kJ5MT8BMnOi4poy9NbNUlWvr3sQy3IBrZQUM1p6o5FZCCusSJRTy5vrnyJnkdWtkPr1cKS4vdliNxQ1+zh93UiyR8eaF33dytG7xTN6g46O5ESeFRvJ83MNuqV24BIJqCdowpIDvCqF1lZkmjwlzgL0nGLo2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex0PFIWT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex0PFIWT"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aab925654d9so530452166b.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367476; x=1734972276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yP66MpHoRJMrRT8Yqjo1czS94YPdDgttlZIZ/ZdMEA=;
        b=ex0PFIWTlPxXsDyleEJN/igNI2hntKubPdnOiv0v5LkKtvXjo2dBpHiMMkNdOV8dtR
         TZCj6xFZEx77KbXjk4OWcJ0rS7jj1jkdYkfc8TIYo/e5Rq77lmPhFt5TlBPW9FUzS4qC
         iva2KOXO9sP04yAGe+FkJxRiqYta6PFtVUH2mUgmHSkU6eso660nmLMYUuiTZOR2SHIo
         Zr9Z76vM5zxsr/ZHgpPpkli0Mc0JpSRqcR2H3k/UEuavDWzIZHLsUIqIXKrJIBl6OVnP
         6+3F2ng1h+LgGaiLVVaPncDMPZ328qisgJjMTfc1EPpwl35GcTtyJvRGXEtAM9oIl0XX
         XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367476; x=1734972276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yP66MpHoRJMrRT8Yqjo1czS94YPdDgttlZIZ/ZdMEA=;
        b=WYTQTfM+0KzpLloIVbWDx7fGs5AWSwZ+z/BVpGoNpXO2EM0oPNzsp6qPl7InluTEfo
         f1x5O0/bArqQ8eVts3OUkphnNTPepaFb5yVbDcakSFBwIVODydq9qvVoPFeXEgGBjy3n
         f9Ui4Bn1X6GTk13ys8mEKMjTWeplXMBULNk/wlVAhQznSbZ8BdyjSIa4F+Be59FerF2c
         GPqnC2zUtTcsiG9zhtQ1IFPhlp4+CzHhEgDzCexF3XhOiwIxj0UwFj5cHqhLKuIv3IEy
         mp5whRLDG8y0jvzKJ/bR/fPKyVpKmDDdXN6t18LHLr9Kd4zHJz/aMsrS6hP4r7SJeR56
         vTUQ==
X-Gm-Message-State: AOJu0YwFm/J5kOuy3pzGjWvu2+8JSDYVUnl9aTGjeG0io5dPccG2Ji4o
	4Es0r9D7/R7DIh9gv81uhyWQqZbPZ+hDrwqzy96lOe9lCwqLaHdnOyKLwbpM
X-Gm-Gg: ASbGnctVY1rTDjZfYCFv36ZKIuoqonPrUYX3kPRGmeC2bjL52got+8ubFhZL9WjD0BW
	/6LK8neNKGhgrnKprY+NjuHsY64oaiYlw+YqL+NW7nykSnq4hBghOrv4aTAe30zFubFsJbJ7xO4
	v8Ft33juOqibdsNDhUz9FdwaYvQnTdPSQG4GjN1mDIbIul6sE5SEhNJscGLwpIOdvP44WoaYmSv
	M1pmS2vYTs53T1PLf27myzPaBxjeooWt1x/b2dKDxraNUJJMpH9WEVGIqc=
X-Google-Smtp-Source: AGHT+IFIku0Ar/4NE+lk0Z+DUnnqDxOEj8bsduBsQXhLIw4RLajlFQIGsm/r/O5WyAiDNsyZaMg3ow==
X-Received: by 2002:a17:906:1313:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-aabdc3e1f33mr8908166b.17.1734367475408;
        Mon, 16 Dec 2024 08:44:35 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:26 +0100
Subject: [PATCH v4 1/8] refs: include committer info in `ref_update` struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-1-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5688; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1zQAW1gf6s8EkfhWmsjwMbxZIi5DU5Z49Kos2YDhOaQ=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwekNcbQ9vXgeJRSCHbamOq5/HU8q6IoxN/
 4a2DqPGcHOJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 f25RC/wMmo4rqDhYO7/zup3fS9QV7s7sneRsZpm/UcEo43J36SKpSNR3T7jocxYcoHogy3mI9/8
 +D7TIanyODSel0cS9O7GzMYR7or+r6Vz7NpFW9Kb95/agDE1r/bOI61YBgMrIwzforUrailDIfh
 gIMR5xO3FtnN+t0NTeMCGmSwuDeI+pLxoQfUA/BH5JlC9onpaQC4QP5wrKrS0eVw3sPt8QTnrCT
 uag81hmBdd7ekA4y2QG3kk31/hNBGzUKHQ+rX93C9TUhZDCnP2VMNmDEqkw5ms51RDf9W7YmLK1
 o6T3KtwME38NrmhdB8Q+TkCBe/9z0a1kag+DyLGcsJRAEq6tz/ZpibF0UwToRL6hrnJMlQYsk/8
 LxrRIGlrFV+u3aGTiydNqPKowoWLapgq/Kbja5IPgsDeRqgBh8+aHMJQL+JbBBKPFt3/OhN5gcs
 U6/9B9TULYELia7D8qk6ezKz71+L3YXwTPP1L8bzKC9uCjV+cIgDya6ReVKZFcOPWAQAM=
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

