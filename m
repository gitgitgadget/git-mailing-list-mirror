From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 8/8] branch: add '--points-at' option
Date: Wed, 19 Aug 2015 00:45:45 +0530
Message-ID: <1439925345-9969-9-git-send-email-Karthik.188@gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 21:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRmMj-0003qn-TW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 21:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbbHRTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 15:16:06 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33420 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbbHRTQD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 15:16:03 -0400
Received: by pdrh1 with SMTP id h1so72032222pdr.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTdYxUASa7EQjFhqeg0+A6SC1XvIR2AqGXoSqxOLDKs=;
        b=I9Xc77QJCD7FJLCyLE70eu7Pu2zqH6wp3Smirlq+MDTj5Jxh2XWHtTncO9z2npjGjP
         01G8R9NcadiSPEVvrTD/qNgUAdMJkl7XqE5OopCm+Aos9Ymi0CD4VW+85eGojq3DV/yU
         3BzXy5oEnsqlGe4gbUCNQa7K8MaCYSRjXdc5kwV+ImMVKuCjF8UTqzcMK213B8koSV6E
         SnuiIH6wMmErpxx9fhLDGqniRmHCqtUlzW2YDnvhZ5kUjtv4SEVW9De6JCHmMrPEXtr+
         yJDF1lgDprI2NLp2mF6t8Jzw8N6IIK14g54K8LnIzv9kVJvt4kliDuD+scBf43Tvpe3E
         scIA==
X-Received: by 10.70.64.131 with SMTP id o3mr16349721pds.111.1439925362593;
        Tue, 18 Aug 2015 12:16:02 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id v2sm43800pda.34.2015.08.18.12.16.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 12:16:02 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276152>

Add the '--points-at' option provided by 'ref-filter'. The option lets
the user to list only branches which points at the given object.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-branch.txt | 6 +++++-
 builtin/branch.c             | 7 ++++++-
 t/t3203-branch-output.sh     | 9 +++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 897cd81..211cfc3 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
-	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]
+	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
+	[--points-at <object>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -237,6 +238,9 @@ start-point is either a local or remote-tracking branch.
 	for-each-ref`. Sort order defaults to sorting based on branch
 	type.
 
+--points-at <object>::
+	Only list branches of the given object.
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 61b1c40..dd2fdbe 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
 };
 
@@ -654,6 +655,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		{
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
+			N_("print only branches of the object"), 0, parse_opt_object_name
+		},
 		OPT_END(),
 	};
 
@@ -682,7 +687,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
+	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 38c68bd..1deb7cb 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -154,4 +154,13 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch --points-at option' '
+	cat >expect <<EOF &&
+  master
+  branch-one
+EOF
+	git branch --points-at=branch-one >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
