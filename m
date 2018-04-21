Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8B91F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDUQyi (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44668 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDUQye (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:34 -0400
Received: by mail-lf0-f66.google.com with SMTP id g203-v6so9198511lfg.11
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rw5Q+iPIDh6R4dAQcyt/mhlZtdvhtcOwVV1eDwoFVt4=;
        b=HXBs1H9MW/m3krJ95afcOUhUimONcXmk1NeYS8DeYc+5P3JxSYe6HS/SBe/dc4k0HO
         Ia23VPl+R9fMw2+7eNlegvNhOre7FIEUEyUu+hQ/6sPGjzGLTXRalWPHs4/5Y0eDpxZl
         /VuuWmqIFHjrtvIwdG8W+28etpMUc4+INSI0g1mR3j9DbJqSww+Rk+F1bGJhGrhkP8tG
         JsljhT8XVdaXPjxEYJ2bt5MMbRSRTHbOnWoLLB9Ty0HKBebAuuDIorNnuRdS6CAiLKTc
         NPlakFVrm3EOKC87Wom45Nj883Bep9tO65AAXG4lzNmyK6Ul33QxCegWAWcv3irb/cKx
         cygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rw5Q+iPIDh6R4dAQcyt/mhlZtdvhtcOwVV1eDwoFVt4=;
        b=gV7bj0tottn1Zo1cZepWvwZyvtVqB+W+xLb9fOG+CJjP8BDpb0uqD/MX3dQ4EIv24v
         w4qeSFhMdT5aidqxkOT9bbXCWZsRB32PNPJBUQqMjPERD3bQlE9kzGB4eaT0MGduhnDg
         7IMvWFrySjiz9afkAk14PoWGtt+5spxTeJ5bYqaWcrLhns17feQUP4GmjLBVhFk0+iyF
         4K17Q4RVGvGEsdpnMZo3TG7KGCeeIjhyeFR+oIX/Nhm25ZrJsxWAcAJts03riLoPRbaw
         1muHiely+9tEdUlUrRtLeHxkjlWIkoOpi9gXey/ey6pmjOo2HekL3flvlmlr0Gh7A4Wf
         Yvww==
X-Gm-Message-State: ALQs6tBG0fQwMhSWyFyDA5NzqSGhT7Y0FLxYjZ5S9CCQZVea7JcMYBO8
        NNwflQ+r8TrWcobg1BtyOk1/sg==
X-Google-Smtp-Source: AIpwx4/ohRjUDjTpQYX2x9HcrkxYKuScGmQZP4ofgDhAUKrdYO100FlFBnjxsC1IrxYA++IkyATjSQ==
X-Received: by 10.46.89.212 with SMTP id g81mr10309336ljf.4.1524329673008;
        Sat, 21 Apr 2018 09:54:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
Date:   Sat, 21 Apr 2018 18:54:11 +0200
Message-Id: <20180421165414.30051-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

common-cmds.h is used to extract the list of common commands (by
group) and a one-line summary of each command. Some information is
dropped, for example command category or summary of other commands.
Update generate-cmdlist.sh to keep all the information. The extra info
will be used shortly.

The "deprecated" column is dropped from command-list.txt since it's
not really used and the new parsing code can't deal with it. When we
do need deprecated attribute, we could add it back and adjust
generate-cmdlist.sh at the same time.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt    |  2 +-
 generate-cmdlist.sh | 53 +++++++++++++++++++++++++++++++--------------
 help.c              | 43 +++++++++++++++++++++++++++++++-----
 3 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index a1fad28fd8..2c81d8db74 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -9,7 +9,7 @@ history      grow, mark and tweak your common history
 remote       collaborate (see also: git help workflows)
 
 ### command list (do not change this line)
-# command name                          category [deprecated] [common]
+# command name                          category                [common]
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index eeea4b67ea..05722b1392 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,17 +1,30 @@
 #!/bin/sh
 
+# Don't let locale affect this script.
+LC_ALL=C
+LANG=C
+export LC_ALL LANG
+
+command_list () {
+	sed '1,/^### command list/d;/^#/d' "$1"
+}
+
+category_list () {
+	command_list "$1" | awk '{print $2;}' | sort | uniq
+}
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
-	char name[16];
+	char name[32];
 	char help[80];
-	unsigned char group;
+	unsigned int category;
+	unsigned int group;
 };
 
 static const char *common_cmd_groups[] = {"
 
 grps=grps$$.tmp
-match=match$$.tmp
-trap "rm -f '$grps' '$match'" 0 1 2 3 15
+trap "rm -f '$grps'" 0 1 2 3 15
 
 sed -n '
 	1,/^### common groups/b
@@ -23,28 +36,36 @@ sed -n '
 	' "$1"
 printf '};\n\n'
 
+echo "#define GROUP_NONE 0xff"
 n=0
-substnum=
 while read grp
 do
-	echo "^git-..*[ 	]$grp"
-	substnum="$substnum${substnum:+;}s/[ 	]$grp/$n/"
+	echo "#define GROUP_${grp:-NONE} $n"
 	n=$(($n+1))
-done <"$grps" >"$match"
+done <"$grps"
+echo
+
+n=0
+category_list "$1" |
+while read category; do
+	echo "#define CAT_$category $n"
+	n=$(($n+1))
+done
+echo
 
-printf 'static struct cmdname_help common_cmds[] = {\n'
-grep -f "$match" "$1" |
-sed 's/^git-//' |
+printf 'static struct cmdname_help command_list[] = {\n'
+command_list "$1" |
 sort |
-while read cmd tags
+while read cmd category tags
 do
-	tag=$(echo "$tags" | sed "$substnum; s/[^0-9]//g")
+	prefix=git-
+	name=$(echo $cmd | sed "s/^${prefix}//")
 	sed -n '
-		/^NAME/,/git-'"$cmd"'/H
+		/^NAME/,/'"$cmd"'/H
 		${
 			x
-			s/.*git-'"$cmd"' - \(.*\)/	{"'"$cmd"'", N_("\1"), '$tag'},/
+			s/.*'"$cmd"' - \(.*\)/	{"'"$name"'", N_("\1"), CAT_'$category', GROUP_'${tags:-NONE}' },/
 			p
-		}' "Documentation/git-$cmd.txt"
+		}' "Documentation/$cmd.txt"
 done
 echo "};"
diff --git a/help.c b/help.c
index e155c39870..e63006c333 100644
--- a/help.c
+++ b/help.c
@@ -190,6 +190,28 @@ void list_commands(unsigned int colopts,
 	}
 }
 
+static void extract_common_cmds(struct cmdname_help **p_common_cmds,
+				int *p_nr)
+{
+	int i, nr = 0;
+	struct cmdname_help *common_cmds;
+
+	ALLOC_ARRAY(common_cmds, ARRAY_SIZE(command_list));
+
+	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
+		const struct cmdname_help *cmd = command_list + i;
+
+		if (cmd->category != CAT_mainporcelain ||
+		    cmd->group == GROUP_NONE)
+			continue;
+
+		common_cmds[nr++] = *cmd;
+	}
+
+	*p_common_cmds = common_cmds;
+	*p_nr = nr;
+}
+
 static int cmd_group_cmp(const void *elem1, const void *elem2)
 {
 	const struct cmdname_help *e1 = elem1;
@@ -206,17 +228,21 @@ void list_common_cmds_help(void)
 {
 	int i, longest = 0;
 	int current_grp = -1;
+	int nr = 0;
+	struct cmdname_help *common_cmds;
+
+	extract_common_cmds(&common_cmds, &nr);
 
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+	for (i = 0; i < nr; i++) {
 		if (longest < strlen(common_cmds[i].name))
 			longest = strlen(common_cmds[i].name);
 	}
 
-	QSORT(common_cmds, ARRAY_SIZE(common_cmds), cmd_group_cmp);
+	QSORT(common_cmds, nr, cmd_group_cmp);
 
 	puts(_("These are common Git commands used in various situations:"));
 
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+	for (i = 0; i < nr; i++) {
 		if (common_cmds[i].group != current_grp) {
 			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
 			current_grp = common_cmds[i].group;
@@ -226,6 +252,7 @@ void list_common_cmds_help(void)
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
 	}
+	free(common_cmds);
 }
 
 void list_all_cmds(void)
@@ -301,8 +328,9 @@ static const char bad_interpreter_advice[] =
 
 const char *help_unknown_cmd(const char *cmd)
 {
-	int i, n, best_similarity = 0;
+	int i, n, best_similarity = 0, nr_common;
 	struct cmdnames main_cmds, other_cmds;
+	struct cmdname_help *common_cmds;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
@@ -317,6 +345,8 @@ const char *help_unknown_cmd(const char *cmd)
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
 
+	extract_common_cmds(&common_cmds, &nr_common);
+
 	/* This abuses cmdname->len for levenshtein distance */
 	for (i = 0, n = 0; i < main_cmds.cnt; i++) {
 		int cmp = 0; /* avoid compiler stupidity */
@@ -331,10 +361,10 @@ const char *help_unknown_cmd(const char *cmd)
 			die(_(bad_interpreter_advice), cmd, cmd);
 
 		/* Does the candidate appear in common_cmds list? */
-		while (n < ARRAY_SIZE(common_cmds) &&
+		while (n < nr_common &&
 		       (cmp = strcmp(common_cmds[n].name, candidate)) < 0)
 			n++;
-		if ((n < ARRAY_SIZE(common_cmds)) && !cmp) {
+		if ((n < nr_common) && !cmp) {
 			/* Yes, this is one of the common commands */
 			n++; /* use the entry from common_cmds[] */
 			if (starts_with(candidate, cmd)) {
@@ -347,6 +377,7 @@ const char *help_unknown_cmd(const char *cmd)
 		main_cmds.names[i]->len =
 			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
 	}
+	FREE_AND_NULL(common_cmds);
 
 	QSORT(main_cmds.names, main_cmds.cnt, levenshtein_compare);
 
-- 
2.17.0.367.g5dd2e386c3

