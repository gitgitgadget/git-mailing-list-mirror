From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 08/12] for-each-ref: rename variables called sort to sorting
Date: Thu, 11 Jun 2015 21:39:59 +0530
Message-ID: <1434039003-10928-8-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:23:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z35Fv-0005Tb-8s
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbbFKQW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:22:58 -0400
Received: from mail-pd0-f195.google.com ([209.85.192.195]:32874 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbbFKQW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:22:56 -0400
Received: by pdev10 with SMTP id v10so2237933pde.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2r/NGeHQ4QhPJx7J/mZiNIC8VYPJqvG9vogOlyxWfg8=;
        b=NLezzwQWWhnN/EqYAi+ThjRjSOw91zr0T22mpnUZmfmEsC7FGXbu1A/pY56uwBjggU
         BsoY9C9/fskk3JfFUyUfZt0xjU8qtOkSubUp5N5nYPp8C/468nsLqeXoeoUSY9lncwB1
         J4Qtxkz8ynYUVL4DF05Gm0v7XrbzdsQ0RSykqZFlx1+pRBdjfBlpLw3DAAnKTEYQHfjn
         u455nQRAhUh5TQVva8CmzM+Ghf8tQU5jp0x7x/T7BouJ21YT2nipbm7d6ITmgBUTYGrh
         Lulm63Y8Q8pGszsABRk/NRhVTrdLsrNW5vfAthXaiAO059XE7k7aI7KoVxOXqPtzpPlJ
         UA2Q==
X-Received: by 10.66.157.71 with SMTP id wk7mr15689024pab.99.1434039042614;
        Thu, 11 Jun 2015 09:10:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271436>

Rename all the variables called sort to sorting to match the
function/structure name changes made in the previous patch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4a6eaba..3cf456a 100644
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
2.4.2
