From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 12/9] column: support grouping entries
Date: Tue, 13 Mar 2012 19:11:36 +0700
Message-ID: <c3c9422bcfccad34e7b97c39a267207cfb41c0b7.1331638664.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com> <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com> <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com> <dc618ca926bdbdbb96ae59615cbbe57cde9f763f.1331638663.git.pclouds@gmail.com> <d7319b7a0445fc476ae1e928bdc0750287f7fb42.1331638663.git.pclouds@gmail.com> <45b5fc83af9ef53f79eb66742eedcbfe14a3d532.1331638664.git.pclouds@gmail.com> <b1d1aead1851563dbab0cb98db27db07a1addf19.1331638664.git.pclouds@gmail.com> <79a9a0dd
 76d72d9cda14378acb16a2fc6456dd0e.1331638664.git.pclouds@gmail.com> <25ba0cdc7d4898e65af12b584c0e9ebf4e412557.1331638664.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QXa-00075A-UI
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759395Ab2CMMJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:09:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51940 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758240Ab2CMMI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:08:59 -0400
Received: by yenl12 with SMTP id l12so440747yen.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XTENATHHxI1TCtvq836WMlMnm0kPEWfWq8/Y/4v0ajE=;
        b=O6S4TKaDagqbObUEJCp3UTyd6izSbpn8EJqM5aPhsU6zIkZHrkuvdKjLV+ddvv6bVu
         Ol/0gvaPuLGHuFC0Hf0P1gFIFF8E9twMo7hdwq+x03iYgjgWFspq4bu0d+iUe4r+sVhZ
         ckthP9GjRsxu04OoPgMfq7uOekksmVy5YfMyrtHaI3mKf783531lClmR8l6yy5W2kzRw
         XV4k0vH4dzLjx2J0TvjrBcHAwmM/3SSBd4SuNdCIkBF4NuwCJ/8wI2ALyKJbblwYiBBR
         9S2ZHaUX06x0YJXrxjAD3RS97kc3eavj6yFMKWuZVq5AOBuIPxDrOhSeMVDip1Iujqmu
         F8Rw==
Received: by 10.68.129.100 with SMTP id nv4mr6028804pbb.109.1331640538517;
        Tue, 13 Mar 2012 05:08:58 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id f5sm636456pbq.43.2012.03.13.05.08.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:08:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:12:06 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <25ba0cdc7d4898e65af12b584c0e9ebf4e412557.1331638664.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193010>

If many entries share the same prefix (e.g. "git ls-files Documentation=
/"),
cutting out the prefix helps put more information on the same space.

If "group" is specified, the list of entries will be searched for
largest non-overlapping rectangles of text. Estimation is done on each
rectangle to see if there are any savings in rows if we group them.
Groups are printed first, then the remaining as the last group.

Handling the remaining part this way may not be ideal but I don't want
to split all directories like "ls -R". That takes too many lines.
Maybe I should prepend ".../" to all grouped items to make it clear
they are grouped.  There's also problem with ansi escape codes that
I'll need to handle if this sounds like a good way to go.

This code may be used for diffstat too (e.g. when most of the diff is
in Documentation/).

=46or demonstration, this is what
"COLUMNS=3D80 git ls-files --column=3Dgroup -- '*.[ch]'" looks like

builtin/:
add.c                gc.c                 read-tree.c
annotate.c           grep.c               receive-pack.c
<snip>
for-each-ref.c       prune.c              verify-tag.c
fsck.c               push.c               write-tree.c

compat/:
basename.c                  regex/regexec.c
bswap.h                     setenv.c
<snip>
regex/regex_internal.c      win32mmap.c
regex/regex_internal.h      winansi.c

contrib/:
convert-objects/convert-objects.c
credential/osxkeychain/git-credential-osxkeychain.c
examples/builtin-fetch--tool.c
svn-fe/svn-fe.c

vcs-svn/:
fast_export.c    line_buffer.h    sliding_window.c svndiff.h
fast_export.h    repo_tree.c      sliding_window.h svndump.c
line_buffer.c    repo_tree.h      svndiff.c        svndump.h

xdiff/:
xdiff.h      xemit.c      xinclude.h   xpatience.c  xtypes.h
xdiffi.c     xemit.h      xmacros.h    xprepare.c   xutils.c
xdiffi.h     xhistogram.c xmerge.c     xprepare.h   xutils.h

=2E..:
abspath.c                  pack-check.c
advice.c                   pack-refs.c
<snip>
object.c                   xdiff-interface.h
object.h                   zlib.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c |  229 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 column.h |    1 +
 2 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/column.c b/column.c
index 80eefa0..8214a9b 100644
--- a/column.c
+++ b/column.c
@@ -19,6 +19,11 @@ struct column_data {
 	int *width;	      /* index to the longest row in column */
 };
=20
+struct area {
+	int start, end;		/* in string_list */
+	int size;
+};
+
 /* return length of 's' in letters, ANSI escapes stripped */
 static int item_length(unsigned int colopts, const char *s)
 {
@@ -223,9 +228,9 @@ static int display_table(const struct string_list *=
list,
 		i =3D break_long_line(&data);
 		if (i !=3D -1) {
 			printf("%s%s" "%s%s%s" "%s%s",
-			       indent, nl,
-			       indent, list->items[i].string, nl,
-			       indent, nl);
+			       opts->indent, opts->nl,
+			       opts->indent, list->items[i].string, opts->nl,
+			       opts->indent, opts->nl);
 			free(data.len);
 			free(data.width);
 			return i + 1;
@@ -248,6 +253,218 @@ static int display_table(const struct string_list=
 *list,
 	return list->nr;
 }
=20
+/*
+ * Find out the contiguous list of entries sharing the same directory
+ * prefix that nr * (prefix_len - skip) is largest, where nr is the
+ * number of entries and prefix_len is the shared directory prefix's
+ * length.
+ */
+static int largest_block(const struct string_list *list, int start, in=
t skip, int *len)
+{
+	const char *str =3D list->items[start].string;
+	const char *slash;
+	int largest_area =3D 0;
+
+	for (slash =3D str + strlen(str) - 1; slash > str + skip; slash--) {
+		int i, area;
+		if (*slash !=3D '/')
+			continue;
+		for (i =3D start; i < list->nr; i++) {
+			const char *s =3D list->items[i].string;
+			if (strlen(s) < slash + 1 - str ||
+			    memcmp(str + skip, s + skip, slash + 1 - (str + skip)))
+				break;
+		}
+		area =3D (i - start) * (slash + 1 - str - skip);
+		if (area > largest_area) {
+			largest_area =3D area;
+			*len =3D i - start;
+		}
+	}
+	return largest_area;
+}
+
+static int area_size_cmp(const void *a, const void *b)
+{
+	const struct area *area1 =3D a;
+	const struct area *area2 =3D b;
+	return area2->size - area1->size;
+}
+
+/*
+ * Make a sorted list of non-overlapping blocks, largest ones first
+ */
+static struct area *find_large_blocks(const struct string_list *list, =
int *nr_p)
+{
+	int i, nr =3D 0, alloc =3D 16;
+	struct area *areas =3D xmalloc(sizeof(*areas) * alloc);
+	struct area last;
+	memset(&last, 0, sizeof(last));
+
+	for (i =3D 0; i < list->nr; i++) {
+		int len, size =3D largest_block(list, i, 0, &len);
+		if (!size || len =3D=3D 1)
+			continue;
+		/* the new found area is overlapped with the old one,
+		   but smaller, skip it */
+		if (i < last.end) {
+			if (size < last.size)
+				continue;
+			last.start =3D i;
+			last.end =3D i + len;
+			last.size =3D size;
+			continue;
+		}
+		if (last.size) {
+			if (nr + 1 < alloc)
+				ALLOC_GROW(areas, nr + 1, alloc);
+			areas[nr++] =3D last;
+		}
+		last.start =3D i;
+		last.end =3D i + len;
+		last.size =3D size;
+	}
+	if (last.size) {
+		if (nr + 1 >=3D alloc)
+			ALLOC_GROW(areas, nr + 1, alloc);
+		areas[nr++] =3D last;
+	}
+	qsort(areas, nr, sizeof(*areas), area_size_cmp);
+	*nr_p =3D nr;
+	return areas;
+}
+
+static int area_start_cmp(const void *a, const void *b)
+{
+	const struct area *area1 =3D a;
+	const struct area *area2 =3D b;
+	return area1->start - area2->start;
+}
+
+/*
+ * Assume list is split into two tables: one from "start" to "stop",
+ * where all strings are truncated "skip" bytes, the other the rest of
+ * the strings. Calculate how many rows required if all cells of each
+ * table are of the same width.
+ */
+static int split_layout_gain(const struct string_list *list, int *leng=
ths,
+			     const struct column_options *opts,
+			     int start, int stop, int skip)
+{
+	int i, width0, width1, width2, cols, rows0, rows1;
+	int indent =3D strlen(opts->indent);
+
+	width0 =3D width1 =3D width2 =3D 0;
+	for (i =3D 0; i < list->nr; i++) {
+		int len =3D lengths[i];
+		if (width0 < len)
+			width0 =3D len;
+		if (i >=3D start && i < stop) {
+			len -=3D skip;
+			if (width2 < len)
+				width2 =3D len;
+		} else {
+			if (width1 < len)
+				width1 =3D len;
+		}
+	}
+
+	width0 +=3D opts->padding;
+	cols =3D (opts->width - indent) / width0;
+	if (cols =3D=3D 0)
+		cols =3D 1;
+	rows0 =3D DIV_ROUND_UP(list->nr, cols);
+
+	width1 +=3D opts->padding;
+	cols =3D (opts->width - indent) / width1;
+	if (cols =3D=3D 0)
+		cols =3D 1;
+	rows1 =3D DIV_ROUND_UP(list->nr - (stop - start), cols);
+
+	width2 +=3D opts->padding;
+	cols =3D (opts->width - indent) / width2;
+	if (cols =3D=3D 0)
+		cols =3D 1;
+	rows1 +=3D DIV_ROUND_UP(stop - start, cols);
+	return rows0 - rows1;
+}
+
+static void group_by_prefix(const struct string_list *list, unsigned i=
nt colopts,
+			    const struct column_options *opts)
+{
+	int i, nr;
+	struct area *areas =3D find_large_blocks(list, &nr);
+	struct string_list new_list =3D STRING_LIST_INIT_NODUP;
+	struct area *dst;
+	int *len;
+
+	assert(colopts & COL_GROUP);
+	/* avoid inifinite loop when calling print_columns again */
+	colopts &=3D ~COL_GROUP;
+
+	len =3D xmalloc(sizeof(*len) * list->nr);
+	for (i =3D 0; i < list->nr; i++)
+		len[i] =3D item_length(colopts, list->items[i].string);
+
+	/*
+	 * Calculate and see if there is any saving when print this as
+	 * a group. Base our calculation on non-dense mode even if
+	 * users want dense output because the calculation would be
+	 * less expensive.
+	 */
+	dst =3D areas;
+	for (i =3D 0; i < nr; i++) {
+		struct area *area =3D areas + i;
+		int rows, skip =3D area->size / (area->end - area->start);
+		rows =3D split_layout_gain(list, len, opts,
+					 area->start, area->end, skip);
+
+		if (rows > 3) {
+			if (areas + i !=3D dst)
+				*dst =3D *area;
+			dst++;
+		}
+	}
+	free(len);
+
+	nr =3D dst - areas;
+	if (!nr) {
+		print_columns(list, colopts, opts);
+		return;
+	}
+	qsort(areas, nr, sizeof(*areas), area_start_cmp);
+
+	/*
+	 * We now have list of worthy groups, sorted by offset. Print
+	 * group by group, then the rest.
+	 */
+	for (i =3D 0; i < nr; i++) {
+		struct area *area =3D areas + i;
+		int j, skip =3D area->size / (area->end - area->start);
+
+		for (j =3D area->start; j < area->end; j++)
+			string_list_append(&new_list,
+					   list->items[j].string + skip);
+		printf("\n%.*s:\n", skip, list->items[area->start].string);
+		print_columns(&new_list, colopts, opts);
+		string_list_clear(&new_list, 0);
+	}
+
+	printf("\n%s:\n", "...");
+	for (i =3D 0; i < nr; i++) {
+		struct area *area =3D areas + i;
+		int j;
+		for (j =3D i ? area[-1].end : 0; j < area->start; j++)
+			string_list_append(&new_list, list->items[j].string);
+	}
+	for (i =3D areas[nr-1].end; i < list->nr; i++)
+		string_list_append(&new_list, list->items[i].string);
+	print_columns(&new_list, colopts, opts);
+	string_list_clear(&new_list, 0);
+
+	free(areas);
+}
+
 void print_columns(const struct string_list *list, unsigned int colopt=
s,
 		   const struct column_options *opts)
 {
@@ -264,6 +481,11 @@ void print_columns(const struct string_list *list,=
 unsigned int colopts,
 	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";
 	nopts.padding =3D opts ? opts->padding : 1;
 	nopts.width =3D opts && opts->width ? opts->width : term_columns() - =
1;
+
+	if (colopts & COL_GROUP) {
+		group_by_prefix(list, colopts, &nopts);
+		return;
+	}
 	if (!COL_ENABLE(colopts)) {
 		display_plain(list, "", "\n");
 		return;
@@ -318,6 +540,7 @@ static int parse_option(const char *arg, int len, u=
nsigned int *colopts,
 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
 		{ "dense",  COL_DENSE,    0 },
 		{ "denser", COL_DENSER,   0 },
+		{ "group",  COL_GROUP,    0 },
 	};
 	int i;
=20
diff --git a/column.h b/column.h
index dbc5da2..f3934cf 100644
--- a/column.h
+++ b/column.h
@@ -7,6 +7,7 @@
 #define COL_DENSE         0x0080   /* Shrink columns when possible,
 				      making space for more columns */
 #define COL_DENSER        0x0100
+#define COL_GROUP         0x0200
=20
 #define COL_ENABLE(c) ((c) & COL_ENABLE_MASK)
 #define COL_DISABLED      0x0000   /* must be zero */
--=20
1.7.8.36.g69ee2
