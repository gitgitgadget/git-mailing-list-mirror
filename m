From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 07/11] for-each-ref: rename variables called sort to sorting
Date: Sat,  6 Jun 2015 19:18:12 +0530
Message-ID: <1433598496-31287-7-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 16:00:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1EeN-0008U9-Ig
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 16:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbbFFOAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 10:00:33 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35245 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbFFOAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 10:00:32 -0400
Received: by pabli10 with SMTP id li10so11623506pab.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQwr4/0384r4AVhNhY5I+0XtzUOvP7ZD2dVKb+X4Cfc=;
        b=r8dhzFtDhIdr4q6xW+GLwBWReQLNrIVXnvuuCXz5IF0uOsTtQlz7vjDi2UEiLESPL5
         EJ9TaQYPVbN2ZrhczFF4Q/HBWq4LzJqLWaCqKjh9VUU42y05HR0dbhF9qehdUIGW0KIn
         SbAgkU52c28DWDNLtHvYo2NYlDHWMhTV2UjjmxwWeg5KbB9IfyxA2sC7+hdVWq+SiNJT
         ntlE5IgL0KCC00nt5ceWl2sqS31sw1mZ4QksSBZvGHVnQZ92DtD+Z4kikeoo9pd46Rnt
         qS/WlRt2XH3LEgwJajGtvapAH409r5dk9IaKDuNAqe0hY9VuiKtODFnCnZG7bm3V++aJ
         gVxA==
X-Received: by 10.66.193.228 with SMTP id hr4mr14531988pac.48.1433598534352;
        Sat, 06 Jun 2015 06:48:54 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.48.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:48:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270932>

Rename all the variables called sort to sorting to match the
function name changes made in the previous patch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 11552ad..c0085be 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -984,9 +984,9 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-void ref_array_sort(struct ref_sorting *sort, struct ref_array *array)
+void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
-	ref_sorting = sort;
+	ref_sorting = sorting;
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
@@ -1088,16 +1088,16 @@ struct ref_sorting *ref_default_sorting(void)
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
 
@@ -1105,8 +1105,8 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 		return -1;
 
 	s = xcalloc(1, sizeof(*s));
-	s->next = *sort_tail;
-	*sort_tail = s;
+	s->next = *sorting_tail;
+	*sorting_tail = s;
 
 	if (*arg == '-') {
 		s->reverse = 1;
@@ -1126,7 +1126,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
-	struct ref_sorting *sort = NULL, **sort_tail = &sort;
+	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	int maxcount = 0, quote_style = 0;
 	struct ref_filter_cbdata ref_cbdata;
 
@@ -1143,7 +1143,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
-		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
+		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			    N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_END(),
 	};
@@ -1160,8 +1160,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (verify_ref_format(format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	if (!sort)
-		sort = ref_default_sorting();
+	if (!sorting)
+		sorting = ref_default_sorting();
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
@@ -1170,7 +1170,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_cbdata.filter.name_patterns = argv;
 	for_each_rawref(ref_filter_handler, &ref_cbdata);
 
-	ref_array_sort(sort, &ref_cbdata.array);
+	ref_array_sort(sorting, &ref_cbdata.array);
 
 	if (!maxcount || ref_cbdata.array.nr < maxcount)
 		maxcount = ref_cbdata.array.nr;
-- 
2.4.2
