Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B3839FD
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416876; cv=none; b=BHgHd/q6uhDFXbOF6+5E0gwJl501vYJHx/tr1Gz2u5WVjr0vDgP8ERG2w74YX/7bkMFJnh4u3qzK5SflvU2G0krudepWKrSm/OedwvmDTvH5T1E7Q1l3eG6ND7I6WYh3e3JtArTQV9ukFTTHhN1zdu0AKskvEfX70qSv2R6bJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416876; c=relaxed/simple;
	bh=TxgrDXgBR6peUDIOrz/LC5azWDWHbid7TcqwiLI1BEM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HxlFCal5Jzxu/GLLC13c5o7q/l/J4+CEeQRrai0E8yYPF2nzUBi2+Jb+45sjvig1n7foWIVTxjJZT4ojSXoxKsTVSTgT/vylRy+VnMGc3O5dAkKS2TgGjZ/pK+J3OKWGh1kQiVIAUGtaqJXdnyYIWRWjir1x/Fen0Mp6eJC33ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkLdiTI9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkLdiTI9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d0c053bf0so889799f8f.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714416872; x=1715021672; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02frPrWzfGtxN75KpIeUTaf9Q6doHBREWIigArQ/ACY=;
        b=fkLdiTI9ckzC/mqmw24FhqmFqBZP5yZHmYTVsfDhb4xSd+KGpUGxEZzpVn1bu92gUq
         P+4p+XhimIeuquu/P2q+ipzPjQmy7pxBbRl8zZid/OrdAULi+ADjtLpthZ04Y4ENBEin
         GRb2kFreJ/RsN4aDPSrV2gzIQVgjdHX+dok9JXL0Y2/x9O+1Xjms1vvwkSFiAz7+WO6l
         +RDALuFL45x/l75YzcO8V/ixxsibxLSRPfi6/m0Hri1f4F6zfsXeqF/QCR2ILBfq2Zvu
         xZLjJftHxqV6vX5Y3+uNYyo7wOaTUOQJbNQGWmcnsjdvE+dJFMyopZN3UnK4FDjae4MZ
         tUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416872; x=1715021672;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02frPrWzfGtxN75KpIeUTaf9Q6doHBREWIigArQ/ACY=;
        b=VjPHepvcKHn98RkHroP8V0NR3otf9627cUlFOxxIYBSyjlczGdX8dnConvuyVuf3Xe
         2SMIP0Kin9ZuI9UZNZkEcbUY6bxppbi38m+n6kQB19PsPLVc2T4VkIIgBHFemF7KTSoa
         FVHAPDNrEENuwsbNNMYjtKP1pgkGd+iA4ta/X9Z5BMLUFicdWCeGFb7/iWxwqUdj3dtk
         WyYTiImWkp9whqwUvTN6SWu2PPYTIY8kUB6cywUfi/q9qGWi8Yn0NKLXzUoN6pVMs//w
         atMP2hCEPrsBAhymzzqjxN7EzlEdiblelgKsw5P4h3ophSxt+JzkVAKL14LkYE3MBq9W
         ekvw==
X-Gm-Message-State: AOJu0YwlJztiRjXFUwoJGkl2ylzHScLToUDCPc9C8VbQTrRU+PLilVJc
	VO24xz17bAp57YBs8VqOsQzU1RYm/M6lU6B2v4+BmwgdkmO4FndTPFGiLQ==
X-Google-Smtp-Source: AGHT+IEKfougNFMXqK/xPoHigMvaerMtctEodGBsXem0FBYrN2cxzZDfZgYoKnz6Wcyfp72PzJN9EA==
X-Received: by 2002:a05:6000:e0d:b0:349:793e:b89 with SMTP id dx13-20020a0560000e0d00b00349793e0b89mr6706262wrb.63.1714416871986;
        Mon, 29 Apr 2024 11:54:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6286000000b0034c124b80f7sm11804276wru.61.2024.04.29.11.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:54:31 -0700 (PDT)
Message-Id: <0c9517f434aa5456dbde129f0514e3e3f50a095d.1714416865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
	<pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Apr 2024 18:54:21 +0000
Subject: [PATCH v3 1/3] builtin/commit.c: refactor --trailer logic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

git-commit adds user trailers to the commit message by passing its
`--trailer` arguments to a child process running `git-interpret-trailers
--in-place`. This logic is broadly useful, not just for git-commit but
for other commands constructing message bodies (e.g. git-tag).

Let's move this logic from git-commit to a new function in the trailer
API, so that it can be re-used in other commands.

Additionally, replace git-commit's bespoke callback for --trailer with
the standard OPT_PASSTHRU_ARGV macro. This bespoke callback was only
adding its values to a strvec and sanity-checking that `unset` is always
false; both of these are already implemented in the parse-option API.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 20 +++-----------------
 trailer.c        | 12 ++++++++++++
 trailer.h        |  8 ++++++++
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6e1484446b0..63cd090b6f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -38,6 +38,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "pretty.h"
+#include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
@@ -142,14 +143,6 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
-static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
-{
-	BUG_ON_OPT_NEG(unset);
-
-	strvec_pushl(opt->value, "--trailer", arg, NULL);
-	return 0;
-}
-
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -1038,14 +1031,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	fclose(s->fp);
 
 	if (trailer_args.nr) {
-		struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-		strvec_pushl(&run_trailer.args, "interpret-trailers",
-			     "--in-place", "--no-divider",
-			     git_path_commit_editmsg(), NULL);
-		strvec_pushv(&run_trailer.args, trailer_args.v);
-		run_trailer.git_cmd = 1;
-		if (run_command(&run_trailer))
+		if (amend_file_with_trailers(git_path_commit_editmsg(), &trailer_args))
 			die(_("unable to pass trailers to --trailers"));
 		strvec_clear(&trailer_args);
 	}
@@ -1673,7 +1659,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
+		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/trailer.c b/trailer.c
index c72ae687099..843c378199e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "trailer.h"
 #include "list.h"
+#include "run-command.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -1170,3 +1171,14 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
+
+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args) {
+	struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+	run_trailer.git_cmd = 1;
+	strvec_pushl(&run_trailer.args, "interpret-trailers",
+		     "--in-place", "--no-divider",
+		     path, NULL);
+	strvec_pushv(&run_trailer.args, trailer_args->v);
+	return run_command(&run_trailer);
+}
diff --git a/trailer.h b/trailer.h
index 9f42aa75994..55f85b008ee 100644
--- a/trailer.h
+++ b/trailer.h
@@ -3,6 +3,7 @@
 
 #include "list.h"
 #include "strbuf.h"
+#include "strvec.h"
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -158,4 +159,11 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+/*
+ * Augment a file to add trailers to it by running git-interpret-trailers.
+ * This calls run_command() and its return value is the same (i.e. 0 for
+ * success, various non-zero for other errors). See run-command.h.
+ */
+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args);
+
 #endif /* TRAILER_H */
-- 
gitgitgadget

