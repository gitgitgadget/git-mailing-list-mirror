Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB441BE251
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086215; cv=none; b=BVL09Xj9RRawNOagvmGuR6FsJZ2PrNNsAtQ4v203kGgxMptJpSfFcIgm1gc1uT7Y/hzdhGZC8f7XuYdfSvSVVEIXQT5luBd3GIWbEy3XFM1krOUAVju0IhubwMO4XfTEZlMvWnFCHUwFOI1VUHjiXmrN5BCc6b5V7JHoHrjzjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086215; c=relaxed/simple;
	bh=1zQAW1gf6s8EkfhWmsjwMbxZIi5DU5Z49Kos2YDhOaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpdLVQ6fGm769byNmcgK4o+yKy+VvPLoHBJ4tM8uKF3N567kzwqWHxmM30XlWNaXUqHIC0Vdt98PBoqJN1gfgWI9BNQxFMtzZhanOQKGnOA/3bYDagBdjA1XJNPiEsPb2iIYFy0RBnC4A5UdP7FFWWTd5fkRQVg/ZMVgcOUtHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU6/rvIE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU6/rvIE"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso287602966b.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086212; x=1734691012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yP66MpHoRJMrRT8Yqjo1czS94YPdDgttlZIZ/ZdMEA=;
        b=TU6/rvIEWR3IZwI3TGL6mlUezUaheBY8VHZSK9a8teFctKqvg/yoAOfe2onYgZip8W
         dAveA3kFxOTPUkNvpWPvNR6ThokA/vszoInwVtWYIJXfDPoEh2CD+NKOHz4zioxNJWd3
         Ns/dv/SP9kZiPQ9KsQDzW2FFCB7kZmFXgLPtFrsST5bpAi5Yaz7aJkS+8WLzQEZ0HFvY
         7nDpdcRjN9/k/vu8E1Mr8v+Lwczo6uetu/b3WmR2vm5m1lLgdZYUWq55rLaAoZuY6kSq
         mPQVc1so1jNFETCGOb/sMkojHELvJ4tGAxiy4kn6fHEApja2ogZF2rUiX3wZ/scotYXf
         66gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086212; x=1734691012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yP66MpHoRJMrRT8Yqjo1czS94YPdDgttlZIZ/ZdMEA=;
        b=P7HFapmqE2+ohct2EjND1shZQtVZ2sb8N/AoAFaOictyeNSyf8zlhPQs63Xo+rSOme
         EecgV5aUua2EKVhsuHYusnEti9x/xwCdZTzD7KuOodkr2m7LzCLTjZ0wsv+U7+4nSZVH
         u6E0gbQSzB1gi2p54Qsv+XgyyyMzXtS04FaND/vf2xvUw9L+f3kvVwd7TSEDxq2PNC3s
         G4Z6wFT4Aq9NxTboIT1fmtUFtJzCqK0ivx6qUo6Vj5C+RzrQtXHJmfdEgcV4+tYHJ+c1
         nmqBnWLhy1GLWxVASukqbgTZz0J/gkhC+3OebpITSPNpyQEKvhrrWQXcHze288diPPRB
         y73Q==
X-Gm-Message-State: AOJu0YwxqX82QpjlrKbCcBjCek1nsHzEq4gPDUHT3tj+HjUtNy59L/ac
	7T0LZSZRkLU+tI5fRHxC1yaX/UglNGqZP8lSflLNFsFuvFhXFZdz
X-Gm-Gg: ASbGnctZ3G0gaGSJ7YhIgmjroMjQuASvh0fJnoQaHYbJdrqogTB9/1yKYsvaG0BEhr4
	k5lRZQ2MKdsZgRou5lI0KF2871y6GCIXhOA492IdHj31W92YdECtpXH7+tCMoFY6pR6DX6EBlRW
	+BSy5AJ3a/dPxk97S+kk6uLBGm8JcZBoeIbcZN/VBtvE/IBggAcMXfFybPBL3F2Yn0+HUPa/6MS
	lZ7qwma0qNsUDtTOsQ7j/iFvQ4T/xMk5RjI5WDM0lzsMie/2hMtWKFe25g5C3bLd/oyZA==
X-Google-Smtp-Source: AGHT+IHD1ss3qRydthDvpeokvQg4m5BQ34B2qytobXwm48isVD+DXXbGb1elPCkQRWyazKieeHlUdg==
X-Received: by 2002:a17:907:7741:b0:aa5:4982:abc8 with SMTP id a640c23a62f3a-aab77989e01mr162590366b.22.1734086211825;
        Fri, 13 Dec 2024 02:36:51 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:51 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:46 +0100
Subject: [PATCH v2 1/8] refs: include committer info in `ref_update` struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-1-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5688; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1zQAW1gf6s8EkfhWmsjwMbxZIi5DU5Z49Kos2YDhOaQ=;
 b=kA0DAAgBPtWfJI5GjH8ByyZiAGdcDkCghjNk1Co6n6ltY6seXiRIcOxWA2E33Ur7K1uln7j5I
 YkBswQAAQgAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnXA5AAAoJED7VnySORox/uVgL/1Mv
 a+bVnzw2D2aKoybeRbLDRv+TDGGLd2R2uq1ps1kbs0HlZqbrYV+dkilnikv7NOU8xW6JVgvt+ML
 2rqT158KkZ/cVJLyZldSuUehk7ZNrv5Yq+yteR05ghYyuVacguEWMvhIAlRAnhqfAFap6oGpr45
 XiwW3XyM3vFtA3rFzOFmuXh5sSNl/WlakGSfkC3GqYKhLU3Xxijgu0w+BBff6CRqfz4l93nnbsF
 eucNXM3EgHm5TpIEmXdJGfPWy+AvUTohyJRCnrZa/HS/YcpTQpX3lZZWlGRp6ksLTuXg7QRQQfc
 Gf74vcJrA4R/aUwjnJYCHzqu/gW+8Lz7mrXtZCPP/kQQUoBmnXd0tkMbiA59YOKhr/1U9tD2MG/
 FW+wIw+VOHLtoourvLui0mnwKEYsRrkBg86NjSYgtWW3iuS4t0Mslcfu4jUyuqy5VMIbpi6Y4ex
 kkOjGMd9q7ICY94BwyamFUaAHYNME7MfeqvQMcl6ctVbm7DrGAkqjefbJOoQ==
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

