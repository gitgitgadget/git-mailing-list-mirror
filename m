From: larsxschneider@gmail.com
Subject: [PATCH v3 2/3] config: add 'type' to config_source struct that identifies config type
Date: Sat, 13 Feb 2016 15:24:15 +0100
Message-ID: <1455373456-64691-3-git-send-email-larsxschneider@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:25:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUb8J-0007rJ-DA
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 15:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbcBMOZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 09:25:01 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32805 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcBMOYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 09:24:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id c200so7726965wme.0
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FnLqgFuVMcQvdzhTsErRLAIZwu1OQGKsi98kZveWWbs=;
        b=o8/6gdWzBV7eBM1Xwjh3HcXupYAnza7vySSlIciodCqf42gabvcs5JJuhdl0CKigbr
         OoITPBscoIhQklHxTxvIw9L1fnaXyKEfpVb02BPHzdE1Hl1NiZaC/CQbSz+GqLC5hqx3
         6kz7UKo2n2L+CuTa6EwT6AV2MjqtUabnoWwvbTF8V0vZDzk64tNKxvXS1Itdl8jgMnxa
         a19iKPsdlr0k3Ob7lm9utrct4UUG59D4apqY66789xxI+dT4gvIKsXIY+uAOvg0zPovw
         FK9ZkNoNMxY+/skaN3Pu3EWX5IoWOoVl4wuJ3iC79/u0ReNnXe6/iU2E/goajFOlPkLb
         U+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FnLqgFuVMcQvdzhTsErRLAIZwu1OQGKsi98kZveWWbs=;
        b=azTandjs1ria3dkKFpQBe1XMTLxl/f7dFplWsbyjbXhEUpxNv4zmVbox8VIYIKa/yx
         +pHPaSmt3QPpErLj3uPWlorQqKnWzlrQ+cqtTyfjn1mb7XqnHvGw8zEZw6sxBCeGSYN8
         RuZlqUJXrZT2j5/NvqdJy6LA6IzQ7U4q2ZKRtQnBcdR29bEsvsVfVtYauOccQNC8iSyO
         YQ2adMHMWg1j0Zguv9dH757ChVoUSfJPOdwf/hzcdQHw+x/ndJcuRQdZWFvAvSN2bHeQ
         zXfKyFf76LTNi5FGD1RJi+noNyFJZPQK7cNqHEYMOL6Y+6LNvRpq3+S4VV1CxLWWgEY+
         CH7w==
X-Gm-Message-State: AG10YOSFQecCwRGtEwvtXuDh/cbOgb6lP77DPSZILhQxe0Kp/3uDFfZa7cerXuFqIOsUBQ==
X-Received: by 10.194.61.42 with SMTP id m10mr7055476wjr.126.1455373462200;
        Sat, 13 Feb 2016 06:24:22 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB53AE.dip0.t-ipconnect.de. [93.219.83.174])
        by smtp.gmail.com with ESMTPSA id os7sm16754763wjc.18.2016.02.13.06.24.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 06:24:21 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286113>

From: Lars Schneider <larsxschneider@gmail.com>

Use the config type to print more detailed error messages that inform
the user about the origin of a config error (file, stdin, blob).

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 config.c               | 17 ++++++++++-------
 t/t1300-repo-config.sh |  8 +++++++-
 t/t1308-config-set.sh  |  4 ++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index 86a5eb2..6a5942f 100644
--- a/config.c
+++ b/config.c
@@ -24,6 +24,7 @@ struct config_source {
 			size_t pos;
 		} buf;
 	} u;
+	const char *type;
 	const char *name;
 	const char *path;
 	int die_on_error;
@@ -471,9 +472,9 @@ static int git_parse_source(config_fn_t fn, void *data)
 			break;
 	}
 	if (cf->die_on_error)
-		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
+		die(_("bad config line %d in %s %s"), cf->linenr, cf->type, cf->name);
 	else
-		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
+		return error(_("bad config line %d in %s %s"), cf->linenr, cf->type, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -588,9 +589,9 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
-	if (cf && cf->name)
-		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cf->name, reason);
+	if (cf && cf->type && cf->name)
+		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
+		    value, name, cf->type, cf->name, reason);
 	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
 }
 
@@ -1066,7 +1067,8 @@ static int do_config_from_file(config_fn_t fn,
 	struct config_source top;
 
 	top.u.file = f;
-	top.name = name;
+	top.type = path ? "file" : "stdin";
+	top.name = name ? name : "";
 	top.path = path;
 	top.die_on_error = 1;
 	top.do_fgetc = config_file_fgetc;
@@ -1078,7 +1080,7 @@ static int do_config_from_file(config_fn_t fn,
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
+	return do_config_from_file(fn, NULL, NULL, stdin, data);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -1104,6 +1106,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
 	top.u.buf.buf = buf;
 	top.u.buf.len = len;
 	top.u.buf.pos = 0;
+	top.type = "blob";
 	top.name = name;
 	top.path = NULL;
 	top.die_on_error = 0;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52678e7..7abdfcb 100755
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
