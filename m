Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0037A1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755474AbeDYQbg (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45361 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeDYQbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id q5-v6so26353057lff.12
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbS5BP8+WsFamcmCw3+uhk62h4p12M6dfndsF5szwI4=;
        b=M+HMqT61PiGb5qHC3MCSoVZaJ32Eu/zBa/f8R225cv6qA1RQqWlkBPB3ABhcLgoZFm
         pDWNYJNnLdcPMaxvazjCxmFM6ybuoRPRCQE3YG6u9baAYLyja1CtKQy0FfQlNLC1CcDt
         89Kae0oNQSn89+Ztff6C/Nk5+9OA20qk3mJDNm93T5CRnH/JPq/l8Ypfc9jyu3BAQW3I
         3WCQDtMZhSLnNbD7FiOfJVlAKciAzfVHu098GQxWJmiGDkFAMNa6lbMSUjvir3StebXe
         TvA9wxQnGMr3S1ZWpHOt4h+ufAMAPacLmU3nq2Zdt5bdXQkn2TsrJIwN2xYJg7HnAX2S
         v3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbS5BP8+WsFamcmCw3+uhk62h4p12M6dfndsF5szwI4=;
        b=j9SPMWdaPV2NiuDtqOZrsP+stEb1bQlrFJs8YuZhq19J3umttkfon8NfsTiC9CcDPL
         xNmftiZ03Q1ODwnZjdekEmpmOjuVEEp0UIlXrWF55fQDJEL8cjCQm7tp3ZOW5O8JM6pb
         kOCTcwTcYt0c36SYI2ZZxw8iKB56RJ64y7YF9cJBrNIAxOOuxy23xFu5CGHd2+Y6KLHI
         DLe77Z+mNYbunFH66+Up9olNqfkMoAPAoqiCbbzGm8lh1YcCilLCshXOi1aaKqqa50UO
         VHkCzS+2BQjnmlPgr3ZezFXlFbWjzglAiWsoXjhptGMAeUDHHLyL11kwdlLNFXKYbgqq
         zUJA==
X-Gm-Message-State: ALQs6tAvWyF0NNgQcsH3e21g0S5O4YCxUfvpfJaWAa8BmavxW/3mDVj5
        rGTEHnc9KiZsAlShIMOsEKQ=
X-Google-Smtp-Source: AIpwx4/SfdfcVABgfI2KHscW4G9rE7061oMmB2zy8+7OLhiXPH1Qg5x+aMN51f1jIeTfNUvLHiagMA==
X-Received: by 10.46.21.11 with SMTP id s11mr20817163ljd.98.1524673889507;
        Wed, 25 Apr 2018 09:31:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 02/12] generate-cmds.sh: export all commands to command-list.h
Date:   Wed, 25 Apr 2018 18:30:57 +0200
Message-Id: <20180425163107.10399-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current generate-cmds.sh generates just enough to print "git help"
output. That is, it only extracts help text for common commands.

The script is now updated to extract help text for all commands and
keep command classification a new file, command-list.h. This will be
useful later:

- "git help -a" could print a short summary of all commands instead of
  just the common ones.

- "git" could produce a list of commands of one or more category. One
  of its use is to reduce another command classification embedded in
  git-completion.bash.

The new file can be generated but is not used anywhere yet. The plan
is we migrate away from common-cmds.h. Then we can kill off
common-cmds.h build rules and generation code (and also delete
duplicate content in command-list.h which we keep for now to not mess
generate-cmds.sh up too much).

PS. The new fixed column requirement on command-list.txt is
technically not needed. But it helps simplify the code a bit at this
stage. We could lift this restriction later if we want to.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore          |  1 +
 Makefile            | 13 ++++++---
 command-list.txt    |  4 +--
 generate-cmdlist.sh | 67 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..d4c3914167 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,6 +180,7 @@
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /common-cmds.h
+/command-list.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Makefile b/Makefile
index f181687250..2a8913ea21 100644
--- a/Makefile
+++ b/Makefile
@@ -757,7 +757,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
-GENERATED_H += common-cmds.h
+GENERATED_H += common-cmds.h command-list.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1938,6 +1938,11 @@ $(BUILT_INS): git$X
 common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt COMMON >$@+ && mv $@+ $@
+
+command-list.h: generate-cmdlist.sh command-list.txt
+
+command-list.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
@@ -2148,7 +2153,7 @@ else
 # Dependencies on header files, for platforms that do not support
 # the gcc -MMD option.
 #
-# Dependencies on automatically generated headers such as common-cmds.h
+# Dependencies on automatically generated headers such as common-cmds.h or command-list.h
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
@@ -2527,7 +2532,7 @@ sparse: $(SP_OBJ)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: common-cmds.h
+check: common-cmds.h command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -2775,7 +2780,7 @@ clean: profile-clean coverage-clean
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo common-cmds.h command-list.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..786536aba0 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -8,8 +8,8 @@ info         examine the history and state (see also: git help revisions)
 history      grow, mark and tweak your common history
 remote       collaborate (see also: git help workflows)
 
-### command list (do not change this line)
-# command name                          category [deprecated] [common]
+### command list (do not change this line, also do not change alignment)
+# command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 17d6809ef5..9ba9911f09 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,5 +1,27 @@
 #!/bin/sh
 
+die () {
+	echo "$@" >&2
+	exit 1
+}
+
+command_list () {
+	sed '1,/^### command list/d;/^#/d' "$1"
+}
+
+get_categories() {
+	tr ' ' '\n'|
+	grep -v '^$' |
+	sort |
+	uniq
+}
+
+category_list () {
+	command_list "$1" |
+	cut -c 40- |
+	get_categories
+}
+
 get_synopsis () {
 	local cmd="$1"
 
@@ -12,14 +34,51 @@ get_synopsis () {
 		}' "Documentation/$cmd.txt"
 }
 
+define_categories() {
+	echo
+	echo "/* Command categories */"
+	bit=0
+	category_list "$1" |
+	while read cat
+	do
+		echo "#define CAT_$cat (1UL << $bit)"
+		bit=$(($bit+1))
+	done
+	test "$bit" -gt 32 && die "Urgh.. too many categories?"
+}
+
+print_command_list() {
+	echo "static struct cmdname_help command_list[] = {"
+
+	command_list "$1" |
+	while read cmd rest
+	do
+		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
+		for cat in $(echo "$rest" | get_categories)
+		do
+			printf " | CAT_$cat"
+		done
+		echo " },"
+	done
+	echo "};"
+}
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
-	char name[16];
-	char help[80];
-	unsigned char group;
+	const char *name;
+	const char *help;
+	uint32_t group;
 };
+"
+if [ -z "$2" ]
+then
+	define_categories "$1"
+	echo
+	print_command_list "$1"
+	exit 0
+fi
 
-static const char *common_cmd_groups[] = {"
+echo "static const char *common_cmd_groups[] = {"
 
 grps=grps$$.tmp
 match=match$$.tmp
-- 
2.17.0.519.gb89679a4aa

