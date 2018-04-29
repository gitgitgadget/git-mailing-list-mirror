Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DDD1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeD2STJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36680 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeD2STF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id w8-v6so9382723lfe.3
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjCiVO5STliUnZBJ5AGjL6TKyrMSwGgIzkxpfKb/Ymw=;
        b=lU/+pwlOLLWGr7/4snluGDJp9hlqMe8HG7uThHsERfXi6JQalVPdGSeKnEcDELccBU
         XWIFAl+KCizAxGuauEKT6RrGZL57w+RUdz0ujKwUFirpA2j4utltLwtmzY2FKD5Z60u1
         Sv/MKiA4Y2Xy9d1DB3smLiiNZwMi4uqkwrD/COBng8DCikfGTTorhH5uuwZV7dtbwmr3
         IRTjjHcBRaE+aAS/xpsP7km0ptxGkAs5AmPB5ZB0CCqE2fUjO3vBLFNiD/Ac/EqmNRcu
         3X0G5Qwj3/QvEf6JpRjDtoHtaq9vowD2YgyrVyf+KUywMIDwtGmOdAUpKxoJI6LLKGjJ
         DjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjCiVO5STliUnZBJ5AGjL6TKyrMSwGgIzkxpfKb/Ymw=;
        b=eld1sSPD7Q18zSXh+PO3kEoCWJrIYqfr+pnT7ycvEfGzOkgMUPc8JYJ+toJvyu8l7C
         VVP8ukKvzDRwGYr7fuJ7MdBK8QlAHeQw9EFKEJ7d8IOy032cuC1oAI8quXXm6jXrofL6
         ZJQL5EUG+z2hETiMM+VHXNoB9RlUahkcTxRKSr0Sj/qPNql/h7lsJBUSc6Zfls/5OG/C
         ekW6gWEDYDju+R6g5JigX6MdrMGHzrRozXpclzVW8Ys+Ofuf+NHE4u0VavjgCTsGjkvU
         Oa/mbBpWpi9cqefayh1Gc3YuDjPiA9cPREuGgg4soJjzNSUQdR/fKuzkCqs/FmQiUu+i
         naRA==
X-Gm-Message-State: ALQs6tCsZiIDCkqJllyRLjivLR7Yri4M0tzgd+dNzJ3lnqLx3MdBzERr
        elmUPS2MCtwrKdXngADS9cc=
X-Google-Smtp-Source: AB8JxZroMqpo6BzAl/Iv8vnwwiKijK4R418jweOvP+A1CSd+jjFL2O1MIf5Nnljae46mCYSgoAdIzw==
X-Received: by 2002:a19:9f10:: with SMTP id i16-v6mr5589265lfe.29.1525025943896;
        Sun, 29 Apr 2018 11:19:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 02/10] generate-cmds.sh: export all commands to command-list.h
Date:   Sun, 29 Apr 2018 20:18:36 +0200
Message-Id: <20180429181844.21325-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180429181844.21325-1-pclouds@gmail.com>
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
index 50da82b016..bb29470f88 100644
--- a/Makefile
+++ b/Makefile
@@ -757,7 +757,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
-GENERATED_H += common-cmds.h
+GENERATED_H += common-cmds.h command-list.h
 
 LIB_H = $(shell $(FIND) . \
 	-name .git -prune -o \
@@ -1940,6 +1940,11 @@ $(BUILT_INS): git$X
 common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt COMMON >$@+ && mv $@+ $@
+
+command-list.h: generate-cmdlist.sh command-list.txt
+
+command-list.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
@@ -2150,7 +2155,7 @@ else
 # Dependencies on header files, for platforms that do not support
 # the gcc -MMD option.
 #
-# Dependencies on automatically generated headers such as common-cmds.h
+# Dependencies on automatically generated headers such as common-cmds.h or command-list.h
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
@@ -2529,7 +2534,7 @@ sparse: $(SP_OBJ)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: common-cmds.h
+check: common-cmds.h command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -2777,7 +2782,7 @@ clean: profile-clean coverage-clean
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
index 31b6d886cb..c9fd524760 100755
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
 	sed -n '
 		/^NAME/,/'"$1"'/H
@@ -10,14 +32,51 @@ get_synopsis () {
 		}' "Documentation/$1.txt"
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
2.17.0.664.g8924eee37a

