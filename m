Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67983203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbcGZQGT (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:51828 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbcGZQGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:16 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0PdN-1bBERD2vrZ-00ubfU; Tue, 26 Jul 2016 18:06:02
 +0200
Date:	Tue, 26 Jul 2016 18:05:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 02/16] Report bugs consistently
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <95ea7dc3b4a382c24a6e63844525922a8305464c.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/7mBnjiZI/bVuZBDO//IyHF/+k9qYcalTcaWBQnI0JVFAUOo7kK
 dKr9okgxznGF8OSoEwBvsgVvAOw3FSuoaoIev+zQgnR4XEVkf5Q3XCVFJZqvhce1vR4QGcZ
 fPtvJbRB3k574hyBgInado/rALHooV2Q9kAlGA82ZjOZSAoLlNdDHOpzbkjPgFvkFdlRnfA
 OQ6zA3uLfoVrJBGmjYMDQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:X7a1EyP+U8I=:75pEyADJ9CVGMz8umFyHu2
 033MPCxR0zsYiW7FR8cYYIKvmdighRg3sYi/VcQ3iAV7wYSCLc3YKhDGMdYSFrjaq87vpQx3M
 fVdN+23xe27eY8OU+Og+PbAvE1YRWMTMTAMBfc4Ei/5XgNp6AD9UFGxF6bYuzpCO2Z9HFinf7
 +jSq4sAGoOFG2nv7WAmVyBA+OPLF0PJcwfB/osn79bCetoaQ1qjRr0THrzzG8gTlJ3ygIzewB
 QjMVgt4n9rTgoOqTNAUg0NKRvdk49A8NmEbhjN5LJjzZMJ1zs15KFd6cp1fNt71xraTa/+aYz
 mOp0+DzJPsdQ6KAA7kdRl4/yOUTyJ40Ue96KKbpVtUJOVRSMX4It0xDLpcuDfauvsn0PNRAuu
 RZRu/hN/7Q2odMtamSaNlUFAa5CVKEfPiRW4QF9je9Mg3lWJO+GU4bSV2n55QJWMpNQ39Spp+
 o4NOsSFuKHOn4bQZSB5tU3FuhxDT9kifE3qohPlGyzpw74qPUyfeg8Ze6dMWROBrKXjLr5T05
 O48qhhVyHHqk5kWh3/D0EuauyVzzD8040yoH7wF4U/W58RRrMOx6br1BOYC5mqsy7RakCgF2o
 ArnEatzcECFiUX3nMoFHHEedwp1TF3Ywoe+wkV/hatkub3G8N0I5VOiFBMTKKrnQIL6z0rHtX
 6ZgjTE1FXW0ClPmeF5Tvv7Bvmg9HYvDUaNS2A/BhIbv5nqjUX48bCmUI28152zOZW9XUiRSBo
 OEvWVDJz9D8eSYI4DBfgnwPh8R4oMpgf/O0vJJo1kiNbE1OSEljvTn5wHP9zIzLvpilBdZAwk
 FFtQp7J
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
 imap-send.c            |  2 +-
 merge-recursive.c      | 15 +++++++--------
 sha1_file.c            |  4 ++--
 trailer.c              |  2 +-
 transport.c            |  2 +-
 wt-status.c            |  4 ++--
 9 files changed, 21 insertions(+), 21 deletions(-)

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
index 6cdfd5f..ba04b19 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1146,7 +1146,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
-		die("Bug: bad untracked_cache value: %d", untracked_cache);
+		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
 	if (active_cache_changed) {
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
index db0fafe..0f5f476 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -511,7 +511,7 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 
 	va_start(va, fmt);
 	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
-		die("Fatal: buffer too small. Please report a bug.");
+		die("BUG: buffer too small. Please report a bug.");
 	va_end(va);
 	return ret;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index a4a1195..4338b73 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -268,7 +268,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
-		die("Bug in merge-recursive.c");
+		die("BUG: unmerged index entries in merge-recursive.c");
 	}
 
 	if (!active_cache_tree)
@@ -966,9 +966,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
-		} else {
-			die(_("unsupported object type in the tree"));
-		}
+		} else
+			die(_("BUG: unsupported object type in the tree"));
 	}
 
 	return result;
@@ -1354,7 +1353,7 @@ static int process_renames(struct merge_options *o,
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
 			if (strcmp(ren1_src, ren2_src) != 0)
-				die("ren1_src != ren2_src");
+				die("BUG: ren1_src != ren2_src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
@@ -1388,7 +1387,7 @@ static int process_renames(struct merge_options *o,
 			ren2 = lookup->util;
 			ren2_dst = ren2->pair->two->path;
 			if (strcmp(ren1_dst, ren2_dst) != 0)
-				die("ren1_dst != ren2_dst");
+				die("BUG: ren1_dst != ren2_dst");
 
 			clean_merge = 0;
 			ren2->processed = 1;
@@ -1812,7 +1811,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("Fatal merge failure, shouldn't happen."));
+		die(_("BUG: fatal merge failure, shouldn't happen."));
 
 	return clean_merge;
 }
@@ -1870,7 +1869,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("Unprocessed path??? %s"),
+				die(_("BUG: unprocessed path??? %s"),
 				    entries->items[i].string);
 		}
 
diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..5085fe0 100644
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
@@ -2330,7 +2330,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
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
index b233e3e..04d9454 100644
--- a/transport.c
+++ b/transport.c
@@ -566,7 +566,7 @@ void transport_take_over(struct transport *transport,
 	struct git_transport_data *data;
 
 	if (!transport->smart_options)
-		die("Bug detected: Taking over transport requires non-NULL "
+		die("BUG: taking over transport requires non-NULL "
 		    "smart_options field.");
 
 	data = xcalloc(1, sizeof(*data));
diff --git a/wt-status.c b/wt-status.c
index 19cbc39..f8ae0c2 100644
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
2.9.0.281.g286a8d9


