Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22C21B8F5
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742447; cv=none; b=tJqX2gYTm7n293hSMe6J9JlMY+ivS2cgjmKUiZyizsS/mFG4cPnPpuE3cyRYkaegEVDpZ6Fr4PofpKfjGeT+N60MkeENWmWiqShiWgjyfB5f/YoIiggD5tRw/HCqftJzMWIk9j7+1mn7x+kaSsgXR4hpCdQoAfSwfPvrpLWDDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742447; c=relaxed/simple;
	bh=/XjJV0LYQeg4I9hOsy8SjFCeo5ZquFL0ZugMDhGlLLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooH6LjdLe7CGKYcVynCeylWL/7SMYAySL2F7pUz7L38EnCB6Y3QhijXdbHCu/ljfwUSGRtrh/ixn0TfS/Z/EYasAVfauu2WGSmDFOxSulEWkfu9LeBb5eIi1rA+yOoUgVfz0JoDLEK0OWiLZg5QG6kD1uOwhEzAW9TryhBFrL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdiVx2/a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdiVx2/a"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso798886966b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742443; x=1734347243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqCUFtoQIVaYaTWtnFeSnYm3Lb6j6vYL1NqxANp+6Oo=;
        b=OdiVx2/az1vOAcy8tj90b0ZQJ/fHH62mPYWN3upjeMXN0HO0UUfexipHDNhaqX/45d
         D3qnRB8bvHNic6WdkdkS4OGr76axsXg5+42fR2LkcuzUsVl27wlKrSRRFxGq5S/GgNPo
         5t3EoA8AuSx/SUOyYaefY34ZDxQ5Qzdr7ocE7tI0JTRRmF973Lr/Fi6mSdOru9Z4gRN3
         iRvCeTUwDqRBwHDFQPr2WVf0SjWQK1MFxc5/4xzmmUjuYLsLsYhypi6T99/Vstw1tpLc
         OrJ5VOX7Pbtt6w2Chq1LAMSNBrakSX4kHEB4C5aeqenO5XiC9Cr6DCBNlI85LWRqF9sH
         BhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742443; x=1734347243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqCUFtoQIVaYaTWtnFeSnYm3Lb6j6vYL1NqxANp+6Oo=;
        b=uAU3dRAz0WEoB8Oq9k7WIMeoE0hXDWWCpY6MIF1R9w+r9tj2Rniz5XEbbrJpKwRdUX
         sRQwnSyFI4s2I7BqKCQGf4yOOIoTgKbCGCxH1tdVx6MItxZ/y42WEcvVt9f3wOKvvS2Y
         rheHi7ficGoJO9Lm7J9a3nH9VVWu5euBvrqlzzIKKSKWqtx0NRbBUxOaVNW3uGSxA9IP
         fGBUBqTzCUMeQHJ5IIr+wZPPCDpX19crmx2tQ3ZK09luonj+Mppd3vgc3tNwQjr8GxAi
         GJL4fYf9BgADEShb2SA5FUMKjlAOv8dskJU5J5OvWHiHXsG0GJVkwNx4ZG7ywK6s//4+
         ji+w==
X-Gm-Message-State: AOJu0YyPgXQjg8wupHzSl8KUS8BcAPZNnHmMFrqsJ5Qv+9SOh+5Uaqw8
	jK08iob4HGWyjN3cMD0VgWHGibWDSjZh3XmGY6Unntd0QWCaJzY+F1JguKGc
X-Gm-Gg: ASbGncvoUTgrkevlLylL4Rfm4uc6QKpiOXfeve53PNPsRAoi4r4yb3qRxNe6n21KdVh
	C4BYWVPyFLkEeSOnnjC+i4BaMFjUxbjYGjrcfKW6WXQYMWw8M2S9/i2zI+OjUfcPWFMh0Yyk2VX
	wvQPAarNl3NMBQk6I2zhDP9RGskwDoHoEBhPWlnTc+UspKQATZ2+E5/rD/iVG5uPyP6k0iapBAh
	KAyqGy9Wpfdz8WdxSfs7AQKe8gyLku041Et8wueGEm+aNSpJomKAHwDoleET1A=
X-Google-Smtp-Source: AGHT+IH/LGwku0+z26M1LkmYjoAhMZknSKDEDqcKg0u6PY4+vK2VHNlfCPJUJ6O8DurLKgNjrm1Qpg==
X-Received: by 2002:a17:906:3092:b0:aa6:75e1:186b with SMTP id a640c23a62f3a-aa675e1433emr441932066b.53.1733742443200;
        Mon, 09 Dec 2024 03:07:23 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:22 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:15 +0100
Subject: [PATCH 1/7] refs: include committer info in `ref_update` struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-1-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5660; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=/XjJV0LYQeg4I9hOsy8SjFCeo5ZquFL0ZugMDhGlLLA=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9nRglhuUcpGwqSf34DJv7UMeHH3xD9gi9A7
 XDaLxRi5fKJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 f2ADC/48BdrgEu4Egsnfeb0tY4io55CqLIS61+nsnLyaXjXpBrSh4TWT4R75VZ2k2eYfEyyVCf2
 r4KKDlObsI6yfXMbxDJICMcFyjughnKsMDzzOgYxHz/zKfc/N9qixFlapymipVwlSX0MPr/ujbN
 PvUdDm2TOd241ZBxhC+evBaZMW32M99fShUbi9KYsfQYbQidCHKMSi/Jq5VviXE0t/PX8a+BOq5
 56G0A4rtSdiwMzZGHSmsAm/+HeE2IKBdqIteCXhw6sv2RLSFAVq3zzQQ2s4eWxSbjRshAylUzfW
 9saLf4172gupUrPDeUfURG7ju7+Nvui+9gdWW14qBMt78+xBjNrn2mEhSyVdrDh4Gr4ynXlYGrt
 eMTRAt5VQx9XbFhYl9I/d4hQo/cAY/Ts/o9iKOJ6dpzilXMU60sYBcn1NHonMjXqR1FzL/fW7+Z
 rBpweUJNJfSjbQSColhryBAduSZDGH55YHQuV0ng/taTXYEekE03jjEGCyXVSohuxRrNE=
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
 refs/files-backend.c    | 22 +++++++++++++---------
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c | 12 +++++++++++-
 4 files changed, 26 insertions(+), 10 deletions(-)

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
index 64f51f0da905a9a8a1ac4109c6b0a9a85a355db7..13f8539e6caa923cd4834775fcb0cd7f90d82014 100644
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
@@ -2007,8 +2010,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write(refs, "HEAD",
-						&lock->old_oid, oid,
+			if (files_log_ref_write(refs, "HEAD", &lock->old_oid,
+						oid, git_committer_info(0),
 						logmsg, flags, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
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

