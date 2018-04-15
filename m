Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EDB1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeDOQpx (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:45:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33028 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeDOQpt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id m14-v6so6744787lfc.0
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBJF/uGTSyQ+GA9oakeYPwH/Hr7pJNiT8EI4grBjUEM=;
        b=JzhTu/ZF/D+78sxOfk3BXchHvZ665bVb1l56EFRaKv2ebjILvGsrBHO3mDY4WHvO+z
         nF4ALdAnFTQU+U7HsNJDWv2V6qt7Rsd8pPbjVDK0+ftjSp9n43/dp/im6wVg+M4uhfKF
         MhxM5c3x4MnMX0rqkypb9Sss6F46huInJ+R85EI3BYoJOQv37BPJkXEUiMsO6+t1Kh3T
         Sp1gM8LlrGeXhlYRbbT476tI8QMPwXz1nr8xfOx6wYnwKRTR/8cr/yaMjT/aTsGdkjS0
         7f4UMUAcpl8aKm1gM4JbHDEAyXHB+bg53vYEHPm1b1N7m5YB3dq0Hn2sHm9SWwO+EjM4
         35sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBJF/uGTSyQ+GA9oakeYPwH/Hr7pJNiT8EI4grBjUEM=;
        b=PjYbJRRx4MDa3mgJFIBXKYIdFKdBvlScYUZvnOGsP7oMCE4SmuAJae1A2kaUw9KVTC
         aMn/IVguMbJGRdnwO/4iVjp2QT8CO0I0ZURMheH/OMJhIENyvWT9nTGUu0U/tyueZWme
         XXSeNJBk68MbmqBgZ7eLGOMgLnG1uH7SGLbiZ46VZs1G6hDsEFSD83MQV8SCFX9kh35j
         kJt+z/O0r/9eXhHmU7jJ02mqu8490/ROz0KjBQiQIpw+URc+bb+1eABep23FhYirnmvf
         466xFFtm/pl96NelL4NS9Sxw4rbjCKhjs8jCMAy0RP3AcRNIRi7rDnUJugbWSDCR0vsK
         Gm+Q==
X-Gm-Message-State: ALQs6tAUSDgcfd5ryyUSvyG9orq//Ei58rUcFLscoJ0hNL9tWfdEXX7X
        /3mCb43I5dbqfCdkLpCbjUk=
X-Google-Smtp-Source: AIpwx48Fj1QfnbGDWYvQne0Q6ls5F3Hz1sG/b4d4qdoIhmynjbEm4zguazL+4fD/tM17S35KpT19iw==
X-Received: by 2002:a19:a60a:: with SMTP id p10-v6mr13167799lfe.41.1523810747626;
        Sun, 15 Apr 2018 09:45:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
Date:   Sun, 15 Apr 2018 18:42:35 +0200
Message-Id: <20180415164238.9107-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415164238.9107-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180415164238.9107-1-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 generate-cmdlist.sh | 61 +++++++++++++++++++++++++++++++++------------
 help.c              | 42 ++++++++++++++++++++++++++-----
 2 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index eeea4b67ea..e0893e979a 100755
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
@@ -23,28 +36,44 @@ sed -n '
 	' "$1"
 printf '};\n\n'
 
+echo "#define GROUP_NONE 0xff /* no common group */"
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
+echo '/*'
+printf 'static const char *cmd_categories[] = {\n'
+category_list "$1" |
+while read category; do
+	printf '\t\"'$category'\",\n'
+done
+printf '\tNULL\n};\n\n'
+echo '*/'
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
+	name=${cmd/git-}
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
index e155c39870..b5da7fa013 100644
--- a/help.c
+++ b/help.c
@@ -190,6 +190,27 @@ void list_commands(unsigned int colopts,
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
+		if (cmd->category != CAT_mainporcelain)
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
@@ -206,17 +227,21 @@ void list_common_cmds_help(void)
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
@@ -226,6 +251,7 @@ void list_common_cmds_help(void)
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
 	}
+	free(common_cmds);
 }
 
 void list_all_cmds(void)
@@ -301,8 +327,9 @@ static const char bad_interpreter_advice[] =
 
 const char *help_unknown_cmd(const char *cmd)
 {
-	int i, n, best_similarity = 0;
+	int i, n, best_similarity = 0, nr_common;
 	struct cmdnames main_cmds, other_cmds;
+	struct cmdname_help *common_cmds;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
@@ -317,6 +344,8 @@ const char *help_unknown_cmd(const char *cmd)
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
 
+	extract_common_cmds(&common_cmds, &nr_common);
+
 	/* This abuses cmdname->len for levenshtein distance */
 	for (i = 0, n = 0; i < main_cmds.cnt; i++) {
 		int cmp = 0; /* avoid compiler stupidity */
@@ -331,10 +360,10 @@ const char *help_unknown_cmd(const char *cmd)
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
@@ -347,6 +376,7 @@ const char *help_unknown_cmd(const char *cmd)
 		main_cmds.names[i]->len =
 			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
 	}
+	FREE_AND_NULL(common_cmds);
 
 	QSORT(main_cmds.names, main_cmds.cnt, levenshtein_compare);
 
-- 
2.17.0.367.g5dd2e386c3

