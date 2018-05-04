Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AA1200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeEDPej (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:39651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeEDPei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:38 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LnfuZ-1ehSVU2M1P-00hrVr; Fri, 04 May 2018 17:34:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/18] Add a function to solve least-cost assignment problems
Date:   Fri,  4 May 2018 17:34:29 +0200
Message-Id: <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:riLquBgoFJ6gwku1C56Y4xTy5dn7PYQUldKGrKc9zZJYduPOz4+
 1X5ops9A//WP5L2O8bdazWsu0ME6GXZWjdZWph7GDqeU7GWOSqTgxdcVnE69PwEqixjgysI
 l4V5iLopqumrmXHzucKFqa77I0AeeDPjD3qMOQUhQkL03cun1MyMusuR761SbrteHKL8guE
 xnB2aeYbAAFLNnMbrXcUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TEJDmQwyWvI=:iboBPhQA1HjAIepIgbE1WJ
 ly058MTsMMTWbQxsWYnQfqQkl+zzGiVEUCLH5DfrZm/TTnsKmfNVai6zgJRCTfv6j/eYv6MoO
 nozOR0BX+gD8/sVcPwDSIFAWpmwwo9xWN29ODVdwyWzBghRkRcdWbGXH8uvHaZHSpvs1WPKHc
 42w1jppa+KfAy9+MVK5u7SQCxZVNdd+mZ/p9ks6xORUG7dJ9u4uuDqX8lZr8yhAqLdJ+8xxYF
 O9KYupuWyBo0tqSnoDHTjDT+vvOM0c3PHVYLiJFBiY+pYZB3OlUx5r99wWtfFmelj6f5gMR5c
 2RHvQtNeUn3KhK9zEi/wgYS9bnnVywHyUvA7p3WSnC/nS/9oKN2fYWffB5H4GJOMZyMFMacmb
 jFhnNpBr9qz0h/kQFzy15xGMBUzr3mXONkyb2zPlODFKwXGzdgrXQ9QnPeS4JoK75AWEQRASF
 3DhFGnyJchplUL4AF0DQ5/+jrimsqXBFrBIraVJQNjuT8XEeSDWYSCwOc2LO1TY5fWNctCAti
 6Kl6Bi6Af5Xl2Cp5uTq5U+RazvHf3mDaELLFtYSQxMykCmX6y/cGLkYcF7CMB91ifb/oqRjvh
 YQfL69R0ZkWXMLXbkRhacG90r2KOzt1RBymYugoltoYVpboaC/HeUbNktOY+IqS72IPR/YwU/
 cMafO39TiHhCcYvWzrKtOXhk0f7gIRdtEDqYhVq5qn/DInqIlIU4LtiCcD49sqmdRGkltclLz
 zE2zdlXnY+1zEdTNAzu4tBltxTFEgII1jc+vi0UEET0iOuYbum8UZhKFhaLvOywIXv8m0Vwfq
 KpSaVvm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Jonker-Volgenant algorithm was implemented to answer questions such
as: given two different versions of a topic branch (or iterations of a
patch series), what is the best pairing of commits/patches between the
different versions?

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile    |   1 +
 hungarian.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hungarian.h |  19 +++++
 3 files changed, 225 insertions(+)
 create mode 100644 hungarian.c
 create mode 100644 hungarian.h

diff --git a/Makefile b/Makefile
index 50da82b0169..96f2e76a904 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,7 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
+LIB_OBJS += hungarian.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
diff --git a/hungarian.c b/hungarian.c
new file mode 100644
index 00000000000..346299a97d9
--- /dev/null
+++ b/hungarian.c
@@ -0,0 +1,205 @@
+/*
+ * Based on: Jonker, R., & Volgenant, A. (1987). <i>A shortest augmenting path
+ * algorithm for dense and sparse linear assignment problems</i>. Computing,
+ * 38(4), 325-340.
+ */
+#include "cache.h"
+#include "hungarian.h"
+#include <float.h>
+
+#define COST(column, row) cost[(column) + column_count * (row)]
+
+/*
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ */
+int compute_assignment(int column_count, int row_count, double *cost,
+		       int *column2row, int *row2column)
+{
+	double *v = xmalloc(sizeof(double) * column_count), *d;
+	int *free_row, free_count = 0, saved_free_count, *pred, *col;
+	int i, j, phase;
+
+	memset(column2row, -1, sizeof(int) * column_count);
+	memset(row2column, -1, sizeof(int) * row_count);
+
+	/* column reduction */
+	for (j = column_count - 1; j >= 0; j--) {
+		int i1 = 0;
+
+		for (i = 1; i < row_count; i++)
+			if (COST(j, i1) > COST(j, i))
+				i1 = i;
+		v[j] = COST(j, i1);
+		if (row2column[i1] == -1) {
+			/* row i1 unassigned */
+			row2column[i1] = j;
+			column2row[j] = i1;
+		} else {
+			if (row2column[i1] >= 0)
+				row2column[i1] = -2 - row2column[i1];
+			column2row[j] = -1;
+		}
+	}
+
+	/* reduction transfer */
+	free_row = xmalloc(sizeof(int) * row_count);
+	for (int i = 0; i < row_count; i++) {
+		int j1 = row2column[i];
+		if (j1 == -1)
+			free_row[free_count++] = i;
+		else if (j1 < -1)
+			row2column[i] = -2 - j1;
+		else {
+			double min = COST(!j1, i) - v[!j1];
+			for (j = 1; j < column_count; j++)
+				if (j != j1 && min > COST(j, i) - v[j])
+					min = COST(j, i) - v[j];
+			v[j1] -= min;
+		}
+	}
+
+	if (free_count ==
+	    (column_count < row_count ? row_count - column_count : 0)) {
+		free(v);
+		free(free_row);
+		return 0;
+	}
+
+	/* augmenting row reduction */
+	for (phase = 0; phase < 2; phase++) {
+		int k = 0;
+
+		saved_free_count = free_count;
+		free_count = 0;
+		while (k < saved_free_count) {
+			double u1, u2;
+			int j1 = 0, j2, i0;
+
+			i = free_row[k++];
+			u1 = COST(j1, i) - v[j1];
+			j2 = -1;
+			u2 = DBL_MAX;
+			for (j = 1; j < column_count; j++) {
+				double c = COST(j, i) - v[j];
+				if (u2 > c) {
+					if (u1 < c) {
+						u2 = c;
+						j2 = j;
+					} else {
+						u2 = u1;
+						u1 = c;
+						j2 = j1;
+						j1 = j;
+					}
+				}
+			}
+			if (j2 < 0) {
+				j2 = j1;
+				u2 = u1;
+			}
+
+			i0 = column2row[j1];
+			if (u1 < u2)
+				v[j1] -= u2 - u1;
+			else if (i0 >= 0) {
+				j1 = j2;
+				i0 = column2row[j1];
+			}
+
+			if (i0 >= 0) {
+				if (u1 < u2)
+					free_row[--k] = i0;
+				else
+					free_row[free_count++] = i0;
+			}
+			row2column[i] = j1;
+			column2row[j1] = i;
+		}
+	}
+
+	/* augmentation */
+	saved_free_count = free_count;
+	d = xmalloc(sizeof(double) * column_count);
+	pred = xmalloc(sizeof(int) * column_count);
+	col = xmalloc(sizeof(int) * column_count);
+	for (free_count = 0; free_count < saved_free_count; free_count++) {
+		int i1 = free_row[free_count], low = 0, up = 0, last, k;
+		double min, c, u1;
+
+		for (j = 0; j < column_count; j++) {
+			d[j] = COST(j, i1) - v[j];
+			pred[j] = i1;
+			col[j] = j;
+		}
+
+		j = -1;
+		do {
+			last = low;
+			min = d[col[up++]];
+			for (k = up; k < column_count; k++) {
+				j = col[k];
+				c = d[j];
+				if (c <= min) {
+					if (c < min) {
+						up = low;
+						min = c;
+					}
+					col[k] = col[up];
+					col[up++] = j;
+				}
+			}
+			for (k = low; k < up; k++)
+				if (column2row[col[k]] == -1)
+					goto update;
+
+			/* scan a row */
+			do {
+				int j1 = col[low++];
+
+				i = column2row[j1];
+				u1 = COST(j1, i) - v[j1] - min;
+				for (k = up; k < column_count; k++) {
+					j = col[k];
+					c = COST(j, i) - v[j] - u1;
+					if (c < d[j]) {
+						d[j] = c;
+						pred[j] = i;
+						if (c == min) {
+							if (column2row[j] == -1)
+								goto update;
+							col[k] = col[up];
+							col[up++] = j;
+						}
+					}
+				}
+			} while (low != up);
+		} while (low == up);
+
+update:
+		/* updating of the column pieces */
+		for (k = 0; k < last; k++) {
+			int j1 = col[k];
+			v[j1] += d[j1] - min;
+		}
+
+		/* augmentation */
+		do {
+			if (j < 0)
+				BUG("negative j: %d", j);
+			i = pred[j];
+			column2row[j] = i;
+			k = j;
+			j = row2column[i];
+			row2column[i] = k;
+		} while (i1 != i);
+	}
+
+	free(col);
+	free(pred);
+	free(d);
+	free(v);
+	free(free_row);
+
+	return 0;
+}
diff --git a/hungarian.h b/hungarian.h
new file mode 100644
index 00000000000..e7cee4bb039
--- /dev/null
+++ b/hungarian.h
@@ -0,0 +1,19 @@
+#ifndef HUNGARIAN_H
+#define HUNGARIAN_H
+
+/*
+ * Compute an assignment of columns -> rows (and vice versa) such that every
+ * column is assigned to at most one row (and vice versa) minimizing the
+ * overall cost.
+ *
+ * The parameter `cost` is the cost matrix: the cost to assign column j to row
+ * i is `cost[j + column_count * i].
+ *
+ * The arrays column2row and row2column will be populated with the respective
+ * assignments (-1 for unassigned, which can happen only if column_count !=
+ * row_count).
+ */
+int compute_assignment(int column_count, int row_count, double *cost,
+		       int *column2row, int *row2column);
+
+#endif
-- 
2.17.0.409.g71698f11835


