From: larsxschneider@gmail.com
Subject: [PATCH v6 3/4] config: add 'origin_type' to config_source struct
Date: Fri, 19 Feb 2016 10:16:01 +0100
Message-ID: <1455873362-66998-4-git-send-email-larsxschneider@gmail.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 10:16:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhBE-0004sz-7d
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948534AbcBSJQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 04:16:34 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36661 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948502AbcBSJQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:16:10 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so66277343wme.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0NeR7lNiv6c2LiePnLSARWHc02q+e0h2W3mzvnGJkg=;
        b=gvvQP3UzzqWEL1bbmsnRkoXu9lCp1rn4ZgsOAnMuW71ZLWyMmL8eJ1JTZUkJja8Ap+
         SI3WFsX0omkpwzsEBzj1zfjB5LsYt14NORaOKRWOS03VkTxS09f6MKNkQTyVBbMIfjKG
         HImi/2CHsEz1Jadbh37ZJUZDQyJBOH6B9aDSotKOCW/N+jpNtFDhbwtQKca98CTDJJja
         KkmicDQs+Yz0gXaPexf70Ozf8R3V4hD6vwi6OD4aTgR7DAFk9z+1+Orr6Kd3xkJKXofC
         cgeQtUQNnYR0YF+GUGC+HNFPr3AjmhhZUWAtFpTKEoiEVJWC8TfTU+clsnEWx+PsNHxt
         GIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0NeR7lNiv6c2LiePnLSARWHc02q+e0h2W3mzvnGJkg=;
        b=W1/FWpIMkviu53evYb3fYx5y2xd/EuGrT5Su/RbCZAqAknGta0x5X7UElSuFHiQHOq
         6YtzDiKUIzgaPqxD97agtMS/TpWSD6x/WENmr7XFM3vt2yluReLwoOnR9r9x5m8mknnr
         U4zAnkBCcB2M04m3JxcSIG9tyG2isfcqz2r59WxqF9ERYUvSfU56D0KV2OhiGDtnNZTF
         t3WvWv4RLcRtozLg40RIbB18l1te813IUY+MV8g/2ExPsqjyyanfVn2f9QpI8L7FXBZ4
         /hKTBNAfcULaRNi6FlPlZEHTLbCYGRt+wRSs9Yz5w0y5JBAz0pUE9X9wKtteJN9xVxJG
         PO+g==
X-Gm-Message-State: AG10YOS4wJ55gZb1LlE8yIGbRrtqPa3WVLqg5xRMvldEDcc0V4+lvn37kfRXRduwVq3dhg==
X-Received: by 10.194.120.229 with SMTP id lf5mr13375850wjb.151.1455873369092;
        Fri, 19 Feb 2016 01:16:09 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB455F.dip0.t-ipconnect.de. [93.219.69.95])
        by smtp.gmail.com with ESMTPSA id ks5sm10301204wjb.13.2016.02.19.01.16.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 01:16:08 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286676>

From: Lars Schneider <larsxschneider@gmail.com>

Use the config origin_type to print more detailed error messages that
inform the user about the origin of a config error (file, stdin, blob).

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Acked-by: Jeff King <peff@peff.net>
---
 cache.h                |  6 ++++--
 config.c               | 36 +++++++++++++++++++++++++-----------
 submodule-config.c     |  4 ++--
 t/t1300-repo-config.sh |  8 +++++++-
 t/t1308-config-set.sh  |  4 ++--
 5 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 6679bb4..ad7fcfc 100644
--- a/cache.h
+++ b/cache.h
@@ -1485,8 +1485,8 @@ struct git_config_source {
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_mem(config_fn_t fn, const char *name,
-			       const char *buf, size_t len, void *data);
+extern int git_config_from_mem(config_fn_t fn, const char *origin_type,
+					const char *name, const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void git_config(config_fn_t fn, void *);
@@ -1525,6 +1525,8 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+extern const char *current_config_origin_type(void);
+extern const char *current_config_name(void);
 
 struct config_include_data {
 	int depth;
diff --git a/config.c b/config.c
index 36b0ddb..3be2cbc 100644
--- a/config.c
+++ b/config.c
@@ -24,6 +24,7 @@ struct config_source {
 			size_t pos;
 		} buf;
 	} u;
+	const char *origin_type;
 	const char *name;
 	const char *path;
 	int die_on_error;
@@ -471,9 +472,9 @@ static int git_parse_source(config_fn_t fn, void *data)
 			break;
 	}
 	if (cf->die_on_error)
-		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
+		die(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
 	else
-		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
+		return error(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -588,9 +589,9 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
-	if (cf && cf->name)
-		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cf->name, reason);
+	if (cf && cf->origin_type && cf->name)
+		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
+		    value, name, cf->origin_type, cf->name, reason);
 	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
 }
 
@@ -1061,11 +1062,13 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 }
 
 static int do_config_from_file(config_fn_t fn,
-		const char *name, const char *path, FILE *f, void *data)
+		const char *origin_type, const char *name, const char *path, FILE *f,
+		void *data)
 {
 	struct config_source top;
 
 	top.u.file = f;
+	top.origin_type = origin_type;
 	top.name = name;
 	top.path = path;
 	top.die_on_error = 1;
@@ -1078,7 +1081,7 @@ static int do_config_from_file(config_fn_t fn,
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
+	return do_config_from_file(fn, "stdin", "", NULL, stdin, data);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -1089,21 +1092,22 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	f = fopen(filename, "r");
 	if (f) {
 		flockfile(f);
-		ret = do_config_from_file(fn, filename, filename, f, data);
+		ret = do_config_from_file(fn, "file", filename, filename, f, data);
 		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
 }
 
-int git_config_from_mem(config_fn_t fn, const char *name, const char *buf,
-			size_t len, void *data)
+int git_config_from_mem(config_fn_t fn, const char *origin_type,
+			const char *name, const char *buf, size_t len, void *data)
 {
 	struct config_source top;
 
 	top.u.buf.buf = buf;
 	top.u.buf.len = len;
 	top.u.buf.pos = 0;
+	top.origin_type = origin_type;
 	top.name = name;
 	top.path = NULL;
 	top.die_on_error = 0;
@@ -1132,7 +1136,7 @@ static int git_config_from_blob_sha1(config_fn_t fn,
 		return error("reference '%s' does not point to a blob", name);
 	}
 
-	ret = git_config_from_mem(fn, name, buf, size, data);
+	ret = git_config_from_mem(fn, "blob", name, buf, size, data);
 	free(buf);
 
 	return ret;
@@ -2385,3 +2389,13 @@ int parse_config_key(const char *var,
 
 	return 0;
 }
+
+const char *current_config_origin_type(void)
+{
+	return cf && cf->origin_type ? cf->origin_type : "cmdline";
+}
+
+const char *current_config_name(void)
+{
+	return cf && cf->name ? cf->name : "";
+}
diff --git a/submodule-config.c b/submodule-config.c
index b85a937..92502b5 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -427,8 +427,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_mem(parse_config, rev.buf, config, config_size,
-			&parameter);
+	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
+			config, config_size, &parameter);
 	free(config);
 
 	switch (lookup_type) {
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 1782add..42ed5cc 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -700,12 +700,18 @@ test_expect_success 'invalid unit' '
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
 	cat >expect <<-\EOF &&
-	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in .git/config: invalid unit
+	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in file .git/config: invalid unit
 	EOF
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'invalid stdin config' '
+	echo "fatal: bad config line 1 in stdin " >expect &&
+	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
+	test_cmp expect output
+'
+
 cat > expect << EOF
 true
 false
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 91235b7..82f82a1 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -195,14 +195,14 @@ test_expect_success 'proper error on error in default config files' '
 	cp .git/config .git/config.old &&
 	test_when_finished "mv .git/config.old .git/config" &&
 	echo "[" >>.git/config &&
-	echo "fatal: bad config file line 34 in .git/config" >expect &&
+	echo "fatal: bad config line 34 in file .git/config" >expect &&
 	test_expect_code 128 test-config get_value foo.bar 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'proper error on error in custom config files' '
 	echo "[" >>syntax-error &&
-	echo "fatal: bad config file line 1 in syntax-error" >expect &&
+	echo "fatal: bad config line 1 in file syntax-error" >expect &&
 	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
 	test_cmp expect actual
 '
-- 
2.5.1
