Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28921771D
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346261; cv=none; b=GAd66jj/oh8CNVo+NMH+60TSzmaIhQCbZ91CnxxsbtNvu5O5Jb8zQnCQ7V97gIYVS2DbOKpDCWCaQxQaIGyWcTgHQKkDwEBonh2Os5Ys+3kJy5f4u8bXuNp1Gw0CiNi7jgBPjc/BmMk3JJ4TI/fBfHEw09ky8xQXD7pFuNEoGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346261; c=relaxed/simple;
	bh=0ARivOJYw5HH/tjqlIAJQpwqlP4QpHGn/maGR+B9Y6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBmIu4esUjjDsblCwxbexvuG/vQaeJuQDaXaYxrqMM+EE+tN2r0yt5TIx825Tn/54EfCSSdBPaT3X2rIzQ3lRIo0hc6dCisWas4W9jov226YAA0nz11pGfor3ZuJvPTtFg5DMfaxmUxAQw0e+vnlvHHI+VTANpdC7KPnhzkbQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTZbmoxu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTZbmoxu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso578760666b.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346258; x=1741951058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMF9erA64E7nyWXBNUGrz6bvNYlYBlODA8zBPHI0gO8=;
        b=aTZbmoxuPk/B7everS94YAvTORQ4nRsADBMmqr7FTlF3L7Rj0hHZo2IPwMyFJlMYvn
         Rs63Q2+6Ing3eNxLR2B+yOJvYktjYLdPgWYxaONLevgyCDN5b+qJEOVHTpXzFDpRTWWB
         tczJubyb692jUdNawcMF3b7OhqHPORKgxg0NOBgyOmKPGOHING3hrw6W3Nom2qDGCbKx
         iVIOSvNCqRaSJYnV2FdNqk27aVKhEHRrUvu/XO0FHIUCfIEwEl9phsC7QP1t4awytLiu
         vJ89Bh4abzsfXeEwEE/O226+nKLlTKMYo3ZKCIIVKIXpUure10rnYokqkwFSxD6l3x+M
         cYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346258; x=1741951058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMF9erA64E7nyWXBNUGrz6bvNYlYBlODA8zBPHI0gO8=;
        b=E3uAkm4dz0mZOaokoITM1SmmdwmwOmIGj2nGpTjUujg/FJSvdwChNkqBpT4v9qwad+
         UCsi4GpbhIRidu1KIXMTsk2o75p2rlWiLMQNxZe4ymm3yW0nfKpwN6apG7tVVugjSyvr
         nQrMYK8HmrLszf9OjAdhRAhCj3fbZMPFshcq8+nt65S+4iQSTmROZVtCyzJCmea4hRqg
         nqxDxDCJyj7qtYdfcrDanxc/3fP/MSj62U1lqMS0U9h9KadnoJMpsQSmGcF5yXbAMpHl
         kudpAiEtuzZHTBtUaZezeyUy0QsOuAHVUaayEfYiwpXMnzA4VBD+g49IVobfzil7ka3q
         Zujw==
X-Gm-Message-State: AOJu0YyO7x0sFO5FppXPyIP4TxlEoU6963EHm3SnVD4MhkbYyImwYtQe
	BPeOnWZDTxF1z9MJCpjf108v/fduBQeDdw8oGbhQEs3qbBLiC2dUbMf4VggA
X-Gm-Gg: ASbGncueprPJl35ykUTxgcQo5WXPpvZeWTZOP3JEIvbujS/ndZlXcp+etH10aqBQh1l
	uz2eynq8Z5YTjpCJEQMX6kbt9l+iXDd+RekG6XHdAPYnodRa4/BWa6Yl1xPtkM8fB9d6mqKng4/
	G05k2rLfdq2qwOKup/YfhR2YErOq82nmxn12NaKigXEnFqLniiwjYiFDNDrxItG5csbTsQpVneW
	WLKC+enZKac92PevYD+aNut02nzfCJUrCVkk3aHCdRvUst1+W/DY3uFhbZZ4qwh/1rBOiX1DGuw
	QJEZOVS370jfGrdaIvrqSKW2DaaZ2WrE5OLIU/oPmiNP
X-Google-Smtp-Source: AGHT+IFTH35/kmi+FI3ZwFrVJmHAemDAh7VVsulBVwRESn9V213CZsU1Ph/kv9EOiJdA7+ANYOsCyw==
X-Received: by 2002:a17:906:c00d:b0:ac2:4f30:5033 with SMTP id a640c23a62f3a-ac24f305493mr394276366b.15.1741346257715;
        Fri, 07 Mar 2025 03:17:37 -0800 (PST)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdc7sm261464266b.133.2025.03.07.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:17:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Mar 2025 12:17:25 +0100
Subject: [PATCH 1/2] reflog: drop usage of global variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-493-add-command-to-purge-reflog-entries-v1-1-84ab8529cf9e@gmail.com>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
In-Reply-To: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4805; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0ARivOJYw5HH/tjqlIAJQpwqlP4QpHGn/maGR+B9Y6w=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfK1c+MDaCkqNCqDQpMqBjXG9Z+OalUNfc+Y
 +LW6dBUtdPrbIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnytXPAAoJED7VnySO
 Rox/PC4L/jTTWTGz73ykaG6IdNeR9CKIJdwD/hralLAjjZdfxsmE6CanI5nqNdmHQENzyMQ74Bh
 lhDYL/O7GuLjgwzWO5LBzhvdbpdFhejKxGjSGqio5eprr7jgppMdjtGgAo6/g5tLkVWA+T1cf8f
 jQMjwBSpntNLTNYPhMqMqkT7jdZ9+GGb5eDBatOCuOzbkU7gmcN7tS7atOQ5OXKFlGgQuYOK4WN
 DGiTDzfbSDorYyjtxrhXzZdTA8cG19aIpdykzl16/prFvPVnzPjxaQhT4VbpSlmz9cBbQTA0h11
 SR2NuCZ62QtvIz8OO/s6pSnD+nc3HF7HJJqlzthD62REUqz0/y9VlR8hOJmaWm7TZW7oeyrqNCx
 rwK3KSaOc2wPZpitfjPj8VcsaRYV7OYmGFljrcDssQrz55yy6E27iPWG5DNj/UUfuHO0/1EzInV
 /sTiJ0Au7xWqK/OcaWpOWiLqkylyzgoYVDzllytdyFpbTZTv1p38ewtBnMxCKsPmKH6l/US8yn7
 rE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'builtin/reflog.c' file uses the 'the_repository' global variable
directly and also via 'git_config()'. Since this is a builtin command
which has access to the 'struct repository', drop usage of the global
variable and use the available repository struct.

With this, remove the 'USE_THE_REPOSITORY_VARIABLE' macro from the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/reflog.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 95f264989b..f92258f6b6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -236,7 +234,7 @@ static int expire_total_callback(const struct option *opt,
 }
 
 static int cmd_reflog_show(int argc, const char **argv, const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	struct option options[] = {
 		OPT_END()
@@ -246,7 +244,7 @@ static int cmd_reflog_show(int argc, const char **argv, const char *prefix,
 		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
 		      PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	return cmd_log_reflog(argc, argv, prefix, the_repository);
+	return cmd_log_reflog(argc, argv, prefix, repo);
 }
 
 static int show_reflog(const char *refname, void *cb_data UNUSED)
@@ -256,7 +254,7 @@ static int show_reflog(const char *refname, void *cb_data UNUSED)
 }
 
 static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	struct option options[] = {
 		OPT_END()
@@ -268,13 +266,13 @@ static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
 		return error(_("%s does not accept arguments: '%s'"),
 			     "list", argv[0]);
 
-	ref_store = get_main_ref_store(the_repository);
+	ref_store = get_main_ref_store(repo);
 
 	return refs_for_each_reflog(ref_store, show_reflog, NULL);
 }
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
-			     struct repository *repo UNUSED)
+			     struct repository *repo)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	timestamp_t now = time(NULL);
@@ -310,7 +308,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
-	git_config(reflog_expire_config, NULL);
+	repo_config(repo, reflog_expire_config, NULL);
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
@@ -332,7 +330,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	if (cmd.stalefix) {
 		struct rev_info revs;
 
-		repo_init_revisions(the_repository, &revs, prefix);
+		repo_init_revisions(repo, &revs, prefix);
 		revs.do_not_die_on_missing_objects = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
@@ -368,7 +366,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 			};
 
 			set_reflog_expiry_param(&cb.cmd,  item->string);
-			status |= refs_reflog_expire(get_main_ref_store(the_repository),
+			status |= refs_reflog_expire(get_main_ref_store(repo),
 						     item->string, flags,
 						     reflog_expiry_prepare,
 						     should_prune_fn,
@@ -382,12 +380,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		char *ref;
 		struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
-		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
+		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, ref);
-		status |= refs_reflog_expire(get_main_ref_store(the_repository),
+		status |= refs_reflog_expire(get_main_ref_store(repo),
 					     ref, flags,
 					     reflog_expiry_prepare,
 					     should_prune_fn,
@@ -430,7 +428,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix,
 }
 
 static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
-			     struct repository *repo UNUSED)
+			     struct repository *repo)
 {
 	struct option options[] = {
 		OPT_END()
@@ -445,7 +443,7 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
 	refname = argv[0];
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die(_("invalid ref format: %s"), refname);
-	return !refs_reflog_exists(get_main_ref_store(the_repository),
+	return !refs_reflog_exists(get_main_ref_store(repo),
 				   refname);
 }
 

-- 
2.48.1

