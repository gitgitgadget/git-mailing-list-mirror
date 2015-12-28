From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: [PATCH/RFC v2 2/2] describe: add basic and extended posix regex matching for completeness
Date: Mon, 28 Dec 2015 11:30:24 +0100
Message-ID: <f471c683ff54405dc87941b0f157d19a9ba683ed.1451298323.git.mostynb@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
Cc: Mostyn Bramley-Moore <mostynb@opera.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 11:31:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDV5A-0000ux-Hs
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 11:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbbL1KbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 05:31:02 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36850 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbbL1Ka5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 05:30:57 -0500
Received: by mail-wm0-f53.google.com with SMTP id l65so2395469wmf.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2xwv78NiJch5n5IrjLmjamtyDTI5QgVD9voppG5XjUM=;
        b=U7Few9jinmjcJDzFk1R8F7lJ+dOADnQNQDu6j0EOFg7YfMta4wcIHJL7B2twAV5y/H
         HmwwqCyTLawdybEbFcvCD4v/vfpxF4N0l1T0bhOFb9Fjjzfa6UPAQ34vVAmqrw+jJtWj
         X0S7f+nj4Vnq8iQccajSQ5pMaymYOsfA97iMK+tAwZ5K0EIFwyEHFeFlLUteeQ8ckzhn
         FdjZxrAwMoE1YV+DrM9DLTIUKSLOGe6oFuh16CTRlaRTUf78719nM9xxSeQsCMs6+/RP
         dALpEw8pXoT+yevYa9aOMh/XzZ+FrF+3KbWM/Ph9GZDmiDYliVGDGVpxtMSWBoYYGfmD
         iAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2xwv78NiJch5n5IrjLmjamtyDTI5QgVD9voppG5XjUM=;
        b=GXDttaQHicyvnaRlR47m1VRlUOlQvXne4E2ANZTMLI9DpGRk6px4EQDkswBkxLRWEt
         4wpUzBcXkTuplemm6eRCfUi56KlyveU4ED63GFYdDljw7naf8K3Sj/CYUxTkEKFApbsc
         MoxA/4k7aG6N/IS3htcvhxjS9KbaxwY/cx0u7DZY2nAxCZ/c3ayEZ7aqfHLcYup3JHxZ
         zmsQ13gp6/oydYcUCyK8FAPA+dq7/FdrYn+s7gl4NfMhlvCiqDV2nFv8OEnLDyb27nEG
         Io0lBAhzR4eFnv5egPL3FWS5B9XlmYNlqwJLJB+OJT8GQn/Q4gCsyi8OabbAQDKeUdlD
         TUqw==
X-Gm-Message-State: ALoCoQlnX9YniMqvTtFDF3phW1B/5lLpzPRzNLzGctcJGyGesz3cU0J/VGP/7LOY9lO6wIKvmNh8hLDzEMpPouh2VWKL+Cdotw==
X-Received: by 10.28.227.6 with SMTP id a6mr53574484wmh.68.1451298656034;
        Mon, 28 Dec 2015 02:30:56 -0800 (PST)
Received: from teardrop.oslo.osa (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id uw6sm56248541wjc.42.2015.12.28.02.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 02:30:54 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1451298323.git.mostynb@opera.com>
In-Reply-To: <cover.1451298323.git.mostynb@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283035>

Signed-off-by: Mostyn Bramley-Moore <mostynb@opera.com>
---
 Documentation/git-describe.txt |  6 ++++++
 builtin/describe.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 t/t6120-describe.sh            | 14 ++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b8279ec..0c237c3 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -89,6 +89,12 @@ OPTIONS
 --glob::
 	Use `glob(7)` patterns with --match, this is the default.
 
+-E::
+--extended-regexp::
+-G::
+--basic-regexp::
+	Use POSIX extended/basic regexp for patterns with --match.
+
 -P::
 --perl-regexp::
 	Use Perl-compatible regexp for patterns with --match. Requires
diff --git a/builtin/describe.c b/builtin/describe.c
index d9ab5bd..3bff610 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "hashmap.h"
 #include "argv-array.h"
+#include <regex.h>
 
 #ifdef USE_LIBPCRE
 #include <pcre.h>
@@ -25,6 +26,8 @@ static const char * const describe_usage[] = {
 
 enum match_type {
 	MATCH_GLOB = 0,
+	MATCH_BRE,
+	MATCH_ERE,
 	MATCH_PCRE
 };
 
@@ -41,6 +44,7 @@ static const char *pattern;
 static int always;
 static const char *dirty;
 static enum match_type pattern_type_arg = MATCH_GLOB;
+static regex_t posix_regex;
 
 #ifdef USE_LIBPCRE
 static pcre *pcre_regex = NULL;
@@ -134,6 +138,27 @@ static void add_to_known_names(const char *path,
 	}
 }
 
+static void re_init(enum match_type type)
+{
+	int cflags = REG_NOSUB;
+	if (type == MATCH_ERE)
+		cflags |= REG_EXTENDED;
+
+	if (regcomp(&posix_regex, pattern, cflags))
+		die("Invalid regular expression: %s", pattern);
+}
+
+static void re_cleanup()
+{
+	regfree(&posix_regex);
+}
+
+/* return 1 on match, 0 on no match. */
+static int posix_re_match(const char *text)
+{
+	return regexec(&posix_regex, text, 0, NULL, 0) != 0;
+}
+
 #ifdef USE_LIBPCRE
 static void pcre_init()
 {
@@ -180,6 +205,8 @@ static int match(const char *pattern, const char *text, enum match_type t)
 {
 	if (t == MATCH_GLOB) {
 		return wildmatch(pattern, text, 0, NULL);
+	} else if (t == MATCH_ERE || t == MATCH_BRE) {
+		return posix_re_match(text);
 #ifdef USE_LIBPCRE
 	} else if (t == MATCH_PCRE) {
 		return pcre_match(text);
@@ -479,6 +506,12 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "glob", &pattern_type_arg,
 			   N_("use glob patterns with --match (default)"),
 			   MATCH_GLOB),
+		OPT_SET_INT('E', "extended-regexp", &pattern_type_arg,
+			   N_("use extended POSIX regular expressions with --match"),
+			   MATCH_ERE),
+		OPT_SET_INT('G', "basic-regexp", &pattern_type_arg,
+			   N_("use basic POSIX regular expressions with --match"),
+			   MATCH_BRE),
 #ifdef USE_LIBPCRE
 		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
 			   N_("use Perl-compatible regular expressions with --match"),
@@ -507,6 +540,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
 
+	if (pattern && (pattern_type_arg == MATCH_ERE ||
+			pattern_type_arg == MATCH_BRE))
+		re_init(pattern_type_arg);
+
 #ifdef USE_LIBPCRE
 	if (pattern && pattern_type_arg == MATCH_PCRE)
 		pcre_init();
@@ -538,6 +575,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
 
+	if (pattern && (pattern_type_arg == MATCH_ERE ||
+			pattern_type_arg == MATCH_BRE))
+		re_cleanup();
+
 #ifdef USE_LIBPCRE
 	if (pattern && pattern_type_arg == MATCH_PCRE)
 		pcre_cleanup();
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 47427c4..e3d8663 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -184,17 +184,31 @@ test_expect_success 'set-up matching pattern tests' '
 '
 
 check_describe "test-annotated-*" --match="test-*"
+check_describe "test-annotated-*" --match="^test-" --basic-regexp
+check_describe "test-annotated-*" --match="^test-" --extended-regexp
 check_describe_pcre "test-annotated-*" --match="^test-" --perl-regexp
 
 check_describe "test1-lightweight-*" --tags --match="test1-*"
+check_describe "test1-lightweight-*" --tags --match="^test1-" \
+	--extended-regexp
+check_describe "test1-lightweight-*" --tags --match="^test1-" \
+	--basic-regexp
 check_describe_pcre "test1-lightweight-*" --tags --match="^test1-" \
 	--perl-regexp
 
 check_describe "test2-lightweight-*" --tags --match="test2-*"
+check_describe "test2-lightweight-*" --tags --match="^test2-" \
+	--extended-regexp
+check_describe "test2-lightweight-*" --tags --match="^test2-" \
+	--basic-regexp
 check_describe_pcre "test2-lightweight-*" --tags --match="^test2-" \
 	--perl-regexp
 
 check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
+check_describe "test2-lightweight-*" --long --tags --match="test2-*" \
+	--extended-regexp HEAD^
+check_describe "test2-lightweight-*" --long --tags --match="test2-*" \
+	--basic-regexp HEAD^
 check_describe_pcre "test2-lightweight-*" --long --tags --match="^test2-" \
 	--perl-regexp HEAD^
 
-- 
2.5.0
