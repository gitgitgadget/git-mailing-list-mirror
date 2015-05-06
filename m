From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] Fixed translation error in config.c file
Date: Wed, 6 May 2015 21:51:07 +0100
Message-ID: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed May 06 23:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq6fJ-0003LB-JD
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 23:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbbEFVPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 17:15:33 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34053 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbEFVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 17:15:32 -0400
Received: by wgso17 with SMTP id o17so24996253wgs.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:resent-date:resent-from:resent-sender:resent-to
         :resent-message-id:from:date:subject;
        bh=cpQ5IGGiOb7dCVTt8igwo0oOhHifjnDMDsH0mahS7J0=;
        b=ruFYS2q5Olqf25HnXUlmxXTUwEWG+EiTX7cH3s5gKyH6EOhgq1+R59GZ63udnudM8P
         1f3IlyFxPzQ0hkQdn2SpiRhUFpVHqDXQQq++7OpWf4UM00eayw+Vo9UUHP8hzFnkMxnu
         e0APzt+l1MB8KJiMVkDbtafh3XgRZvFTRXwPbwij0jBS8vOWbDhKgROXqMoD5todhf7x
         uIWEsVxrF19RLRUfOuRS9eyHhMJ2TVSRb8xFh5YuAWTqGVtIy9JA/pRS/2arVLV/5BYy
         90C5z/AuDfL4GrteT/XMYr7W2tPYTeKS+eHokaRII2ldNx1bFK4jNCx12mcIcHLcON+s
         uWPg==
X-Received: by 10.180.186.99 with SMTP id fj3mr801605wic.10.1430946931355;
        Wed, 06 May 2015 14:15:31 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id z12sm4538895wjq.12.2015.05.06.14.15.29
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 14:15:30 -0700 (PDT)
Apparently-To: <alangiderick@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268499>

There was an existing translation in 'git config' output, that was incorrect in some unspecified way, and this change corrects that breakage

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/config.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index bfd3016..47c1a42 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -85,7 +85,7 @@ static struct option builtin_config_options[] = {
 static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
-	error("wrong number of arguments");
+	error(_("wrong number of arguments"));
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
@@ -193,7 +193,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid key pattern: %s\n", key_);
+			error(_("Invalid key pattern: %s\n"), key_);
 			free(key_regexp);
 			key_regexp = NULL;
 			ret = CONFIG_INVALID_PATTERN;
@@ -214,7 +214,7 @@ static int get_value(const char *key_, const char *regex_)
 
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			fprintf(stderr, "Invalid pattern: %s\n", regex_);
+			error(_("Invalid pattern: %s\n"), regex_);
 			free(regexp);
 			regexp = NULL;
 			ret = CONFIG_INVALID_PATTERN;
@@ -366,10 +366,10 @@ static int get_colorbool(const char *var, int print)
 static void check_write(void)
 {
 	if (given_config_source.use_stdin)
-		die("writing to stdin is not supported");
+		die(_("writing to stdin is not supported"));
 
 	if (given_config_source.blob)
-		die("writing config blobs is not supported");
+		die(_("writing config blobs is not supported"));
 }
 
 struct urlmatch_current_candidate_value {
@@ -477,7 +477,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time.");
+		error(_("only one config file at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
@@ -500,7 +500,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME not set");
+			die(_("$HOME not set"));
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
@@ -530,17 +530,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (HAS_MULTI_BITS(types)) {
-		error("only one type at a time.");
+		error(_("only one type at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
+		error(_("only one action at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
@@ -558,10 +558,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 					    &given_config_source,
 					    respect_includes) < 0) {
 			if (given_config_source.file)
-				die_errno("unable to read config file '%s'",
+				die_errno(_("unable to read config file '%s'"),
 					  given_config_source.file);
 			else
-				die("error processing config file(s)");
+				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions == ACTION_EDIT) {
@@ -569,11 +569,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
-			die("not in a git directory");
+			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
-			die("editing stdin is not supported");
+			die(_("editing stdin is not supported"));
 		if (given_config_source.blob)
-			die("editing blobs is not supported");
+			die(_("editing blobs is not supported"));
 		git_config(git_default_config, NULL);
 		config_file = xstrdup(given_config_source.file ?
 				      given_config_source.file : git_path("config"));
@@ -598,8 +598,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		ret = git_config_set_in_file(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
-			error("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
+			error(_("cannot overwrite multiple values with a single value\n"
+			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
@@ -669,7 +669,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -680,7 +680,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
-- 
2.4.0.dirty
