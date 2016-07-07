Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883BD2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbcGGOfi (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:53939 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbcGGOfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:36 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MQzoI-1aqoUs481m-00ULZX; Thu, 07 Jul 2016 16:35:25
 +0200
Date:	Thu, 7 Jul 2016 16:35:21 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 02/16] Report bugs consistently
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <6ed923d5172ec43d9ec8a8d622398e5666eff505.1467902082.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y2tZh/etv3xUGANw+2NDRFsfGR3rtEoMskPc1wubSjnbHX42o82
 xZ9yYSmfhYcqXPOBJpTJtgydavVWQ4kOPzmhUMZRvdfjGTkqUgwLhb602UpLrY9UT29RsGf
 y6OXmDjqyFu3AvQDMlAyJCJKauhH2enzv0OOHjxtMbMIcsdDireJHTRDpmwfLAHLUuRsiij
 mBWzgnt98+0XAwkQMKmdA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Puui4hEkM/k=:tme5CzH1GaT+/5RClqOBFU
 k38Vle5mem2XbCZ0lgY0rNQvdo71H/C53g+n2ypwAesZ0/Eqmflf8bBuunZR1TXYt9qQ8qKjS
 Um31KX+wMJiETCFBMkldvyI5jppDZkmHR6MCF4yvxooEi3t8hWgdC/pUVVOO+Cuj9Yrf7LAKQ
 KdrrlHiyXGaEiqEO1GOPSZJ1OOU7Qax7CUbKtwMOSpRcY23i5Tz/QbAXGH20F58etqtWNP4Jl
 ORXGnmhmIUhtZOKpK3lLTtUS8A95eT+ZnCI/hjIVmHPaoknuK+jbGSGrhcSPbh+Tw0Z16lDSh
 KNMiP9so7FFsMFmcy3gik0QZci2WlXIZkc1B/C/QWkqo7anZn8QztBptotWMHl0BWcODRvVko
 690ozL3XHjf4mNduG4xsc/3OxXY5snDYv78EuHLmSyAbOhsdDCeiCn1V1b20Dl+Z18/4t99Rt
 Zlo2EgNqluDifULtd9qLdec2ytDyjd2yx2H5D02jXiPyzyUZqJkiejAlytUJcOKfwxKT6WQsT
 cCYt1rqnMIinG2g+YdgyJX/lijRG2hNF4HHkNSzrs9/4PLyOmiWccPI0hG7KlyoHFJX6wmqDz
 TvLzAPraohfwDgAiXOVavZrYNQyMOR+4UGysl+gsCYB07FJGpAh6/EvrO3iFNqwyROBBARDGY
 M92ex7x93XJiwv65P82cx6IRCQDXXhiGay7kDk9l2/aufsEbYr6dSXnkiO0Hbi/ZYjAkDCxEF
 w2ZJNjBpi4qwhedagkXtYc2X1QUbPlsAbxPRbDKJU4siAuERXhNEv8PkzbaIpwEjJathindAC
 pj/dp/5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The vast majority of error messages in Git's source code which report a
bug use the convention to prefix the message with "BUG:".

As part of cleaning up merge-recursive to stop die()ing except in case of
detected bugs, let's just make the remainder of the bug reports consistent
with the de facto rule.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/ls-files.c     |  3 ++-
 builtin/update-index.c |  2 +-
 grep.c                 |  8 ++++----
 imap-send.c            |  4 ++--
 merge-recursive.c      | 15 +++++++--------
 sha1_file.c            |  4 ++--
 trailer.c              |  2 +-
 transport.c            |  2 +-
 wt-status.c            |  4 ++--
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f02e3d2..00ea91a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -118,7 +118,8 @@ static void show_killed_files(struct dir_struct *dir)
 				 */
 				pos = cache_name_pos(ent->name, ent->len);
 				if (0 <= pos)
-					die("bug in show-killed-files");
+					die("BUG: killed-file %.*s not found",
+						ent->len, ent->name);
 				pos = -pos - 1;
 				while (pos < active_nr &&
 				       ce_stage(active_cache[pos]))
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 25af040..881a4b0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1149,7 +1149,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
-		die("Bug: bad untracked_cache value: %d", untracked_cache);
+		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
 	if (use_watchman > 0) {
diff --git a/grep.c b/grep.c
index 394c856..22cbb73 100644
--- a/grep.c
+++ b/grep.c
@@ -693,10 +693,10 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
-			die("bug: a non-header pattern in grep header list.");
+			die("BUG: a non-header pattern in grep header list.");
 		if (p->field < GREP_HEADER_FIELD_MIN ||
 		    GREP_HEADER_FIELD_MAX <= p->field)
-			die("bug: unknown header field %d", p->field);
+			die("BUG: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
 
@@ -709,7 +709,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 		h = compile_pattern_atom(&pp);
 		if (!h || pp != p->next)
-			die("bug: malformed header expr");
+			die("BUG: malformed header expr");
 		if (!header_group[p->field]) {
 			header_group[p->field] = h;
 			continue;
@@ -1514,7 +1514,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		case GREP_BINARY_TEXT:
 			break;
 		default:
-			die("bug: unknown binary handling mode");
+			die("BUG: unknown binary handling mode");
 		}
 	}
 
diff --git a/imap-send.c b/imap-send.c
index db0fafe..67d67f8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -506,12 +506,12 @@ static char *next_arg(char **s)
 
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 {
-	int ret;
+	int ret = -1;
 	va_list va;
 
 	va_start(va, fmt);
 	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
-		die("Fatal: buffer too small. Please report a bug.");
+		die("BUG: buffer too small (%d < %d)", ret, blen);
 	va_end(va);
 	return ret;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 067f656..05b9789 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -259,7 +259,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
-		die("Bug in merge-recursive.c");
+		die("BUG: unmerged index entries in merge-recursive.c");
 	}
 
 	if (!active_cache_tree)
@@ -982,9 +982,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
-		} else {
-			die(_("unsupported object type in the tree"));
-		}
+		} else
+			die(_("BUG: unsupported object type in the tree"));
 	}
 
 	return result;
@@ -1370,7 +1369,7 @@ static int process_renames(struct merge_options *o,
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
 			if (strcmp(ren1_src, ren2_src) != 0)
-				die("ren1_src != ren2_src");
+				die("BUG: ren1_src != ren2_src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
@@ -1404,7 +1403,7 @@ static int process_renames(struct merge_options *o,
 			ren2 = lookup->util;
 			ren2_dst = ren2->pair->two->path;
 			if (strcmp(ren1_dst, ren2_dst) != 0)
-				die("ren1_dst != ren2_dst");
+				die("BUG: ren1_dst != ren2_dst");
 
 			clean_merge = 0;
 			ren2->processed = 1;
@@ -1828,7 +1827,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("Fatal merge failure, shouldn't happen."));
+		die(_("BUG: fatal merge failure, shouldn't happen."));
 
 	return clean_merge;
 }
@@ -1886,7 +1885,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("Unprocessed path??? %s"),
+				die(_("BUG: unprocessed path??? %s"),
 				    entries->items[i].string);
 		}
 
diff --git a/sha1_file.c b/sha1_file.c
index df62eaf..27dadff 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -795,7 +795,7 @@ void close_all_packs(void)
 
 	for (p = packed_git; p; p = p->next)
 		if (p->do_not_close)
-			die("BUG! Want to close pack marked 'do-not-close'");
+			die("BUG: want to close pack marked 'do-not-close'");
 		else
 			close_pack(p);
 }
@@ -2336,7 +2336,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
 		if (data)
-			die("BUG in unpack_entry: left loop at a valid delta");
+			die("BUG: unpack_entry: left loop at a valid delta");
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
diff --git a/trailer.c b/trailer.c
index 8e48a5c..c6ea9ac 100644
--- a/trailer.c
+++ b/trailer.c
@@ -562,7 +562,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	default:
-		die("internal bug in trailer.c");
+		die("BUG: trailer.c: unhandled type %d", type);
 	}
 	return 0;
 }
diff --git a/transport.c b/transport.c
index ad9ac15..d1dd29a 100644
--- a/transport.c
+++ b/transport.c
@@ -577,7 +577,7 @@ void transport_take_over(struct transport *transport,
 	struct git_transport_data *data;
 
 	if (!transport->smart_options)
-		die("Bug detected: Taking over transport requires non-NULL "
+		die("BUG: taking over transport requires non-NULL "
 		    "smart_options field.");
 
 	data = xcalloc(1, sizeof(*data));
diff --git a/wt-status.c b/wt-status.c
index de62ab2..3fb86a4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die("bug: unhandled unmerged status %x", stagemask);
+		die("BUG: unhandled unmerged status %x", stagemask);
 	}
 }
 
@@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die("bug: unhandled diff status %c", status);
+		die("BUG: unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-- 
2.9.0.278.g1caae67


