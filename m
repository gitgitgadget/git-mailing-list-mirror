From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 07/11] for-each-ref: rename variables called sort to sorting
Date: Sun, 14 Jun 2015 01:07:25 +0530
Message-ID: <1434224249-21476-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:38:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGV-0002Nj-FB
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbFMTio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:44 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34986 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbFMTil (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:41 -0400
Received: by pacyx8 with SMTP id yx8so40813384pac.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oSrX1w3/gamyXXxabeew+V0VAGnX6MBVUZS5ptELDeQ=;
        b=yG0/XOxDvQneB20IDnwQbv7MySUR8kH3MkqcRQ+nn0gm37nZP2eU36yG00Y+6boio1
         N3jCsrMnit53W/U2LlQqJtMbYG2OQzTuj5YATu4u6Rueobu2TfihtxCAEwbay6bwDf3G
         RIOXYQNENnp1LXfifmolgIqmy9nt3cIx5nSCiPPNplfG9JMEozpqyuBti+AW0Bpc3ioE
         Wv1EWu+urcxuHOMcmPCzdw+BsuKbRghG7/ypxVjO8+AmOOrcuGdi72cUkRCaAIZFq0/n
         WtDsC6uC0oldRFORer/PuzRT49HYJOihcXtEY0SVRTFQ5BSibIdbCJg6ecMuZ/4L3acA
         QH+A==
X-Received: by 10.69.19.129 with SMTP id gu1mr34390118pbd.162.1434224320628;
        Sat, 13 Jun 2015 12:38:40 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271571>

Rename all the variables called sort to sorting to match the
function/structure name changes made in the previous patch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5700b25..d11059b 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -985,9 +985,9 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-void ref_array_sort(struct ref_sorting *sort, struct ref_array *array)
+void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
-	ref_sorting = sort;
+	ref_sorting = sorting;
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
@@ -1089,16 +1089,16 @@ struct ref_sorting *ref_default_sorting(void)
 {
 	static const char cstr_name[] = "refname";
 
-	struct ref_sorting *sort = xcalloc(1, sizeof(*sort));
+	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));
 
-	sort->next = NULL;
-	sort->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
-	return sort;
+	sorting->next = NULL;
+	sorting->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
+	return sorting;
 }
 
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 {
-	struct ref_sorting **sort_tail = opt->value;
+	struct ref_sorting **sorting_tail = opt->value;
 	struct ref_sorting *s;
 	int len;
 
@@ -1106,8 +1106,8 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 		return -1;
 
 	s = xcalloc(1, sizeof(*s));
-	s->next = *sort_tail;
-	*sort_tail = s;
+	s->next = *sorting_tail;
+	*sorting_tail = s;
 
 	if (*arg == '-') {
 		s->reverse = 1;
@@ -1127,7 +1127,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
-	struct ref_sorting *sort = NULL, **sort_tail = &sort;
+	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	int maxcount = 0, quote_style = 0;
 	struct ref_filter_cbdata ref_cbdata;
 
@@ -1144,7 +1144,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
-		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
+		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			    N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_END(),
 	};
@@ -1161,8 +1161,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (verify_ref_format(format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	if (!sort)
-		sort = ref_default_sorting();
+	if (!sorting)
+		sorting = ref_default_sorting();
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
@@ -1171,7 +1171,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_cbdata.filter.name_patterns = argv;
 	for_each_rawref(ref_filter_handler, &ref_cbdata);
 
-	ref_array_sort(sort, &ref_cbdata.array);
+	ref_array_sort(sorting, &ref_cbdata.array);
 
 	if (!maxcount || ref_cbdata.array.nr < maxcount)
 		maxcount = ref_cbdata.array.nr;
-- 
2.4.3.435.g2403634.dirty
