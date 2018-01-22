Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991FF1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeAVXv1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:51:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36508 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeAVXv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:51:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so20162017wmc.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 15:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fSzmUx7C8nw77YVNG536q9jNulQoCYXY8754WHov8O8=;
        b=FilG0bN6wIB1CAu9SvOxmGQUL6c77R3oLFe3KORgZAMIC7STHfv1Oc7EDGC5h0AfQI
         8YeSoFUYxaE9YRH7wPyVDEHrkxVoJmEIGBr3+k/3Lw7U40CjUP0wz3T12/DPlb5HxqlQ
         yqyDnRlJnA9AvCqUUNseFdX/0iyntjjkfcSvswjniSnTXJV52oQdBFvj7pti1/fcYou/
         Y/Mql1OSZbmkRfGJH2qunhN75saWZx9yvP4lpyt6Qz8s/NTGrYQRdzurN3Fa8SM0MOwM
         IKFL4JK8Ey6JrWWgYoifriog7RoS34OVrGycH1Ggy7jGDUCT1CV41LD9OMRzgu1/XEOy
         mqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fSzmUx7C8nw77YVNG536q9jNulQoCYXY8754WHov8O8=;
        b=O547meNSFRieUZ3eDnz2hflmj70ZOdeam+zZf6yH3ZU/WBq00CXt71l8OUj1/IYUMv
         llPpAkP4FU5JExfRihIYXRbNafEqyaej3bvKomturG5cix27eAP6LvTirhra6xIbGPZR
         JilPRf/VdhC66qj/Qnuw07Jyc5xRRFMAQVrLAt480Ag1OmInyeDizEgYY2fhFOqjhwny
         qgWKvAQWTdG6ZkR0+NNBgJlN4eL4aERQUi0FnKXr0MymhJFYsfO6SbGLNgfDwVbF+sbg
         BiVtQ0J9A9BWD4GRLxJNYf9HAAwhChMlE39S1cve/HNcv+HvdVgscAMTCVEArRi4Uiuh
         DbbQ==
X-Gm-Message-State: AKwxytcj0N/VR6NNL/T+LpvLs8V/w0GRkteJI/ulHJ/vYDdR8ELGCRtj
        Zx02HyoTmN/qadbPTSx6k7yExDeeDl4=
X-Google-Smtp-Source: AH8x2244d2f+k09hP1fcCl1YV/2bnVj7kkMSbcuGBOxW807yB861mWZWNK7KX1jvxc9wHm17tPCyzQ==
X-Received: by 10.80.181.197 with SMTP id a63mr6200583ede.138.1516665084369;
        Mon, 22 Jan 2018 15:51:24 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.100.8.34])
        by smtp.gmail.com with ESMTPSA id m1sm11221530ede.74.2018.01.22.15.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 15:51:22 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
Date:   Mon, 22 Jan 2018 23:51:18 +0000
Message-Id: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch add explicit fallthrough compiler attribute
when needed on switch case statement eliminating
the compile warning [-Werror=implicit-fallthrough=].
It does this by means of a macro that takes into account
the versions of the compilers that include that attribute.

The fallthrough (or clang::fallthrough) attribute is used to annotate
intentional fall-through between switch labels.
Traditionally these are marked with a specific comment, but
this attribute is meant to replace comments with a more strict
annotation, which can be checked by the compiler (gcc-7 or clang).
The flags in question were introduced in gcc 7 and are also enabled
with -Wextra.

It would also have been possible to introduce a specific comment
accepted by gcc 7 instead of the fallthrough attribute for this warning,
but clang does not have a similar implementation. The macro replaces
the previous, not uniform, comments and can acts as a comment itself.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 apply.c                     |  6 +++---
 builtin/blame.c             |  2 +-
 builtin/cat-file.c          |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/fast-export.c       |  4 ++--
 builtin/fetch.c             |  2 +-
 builtin/init-db.c           |  2 +-
 builtin/log.c               |  4 ++--
 builtin/ls-files.c          |  2 +-
 builtin/remote-ext.c        |  2 +-
 builtin/reset.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 config.c                    |  4 ++--
 connect.c                   |  6 +++---
 convert.c                   |  4 ++--
 diff.c                      |  2 +-
 dir.c                       |  2 +-
 fsck.c                      |  2 +-
 git-compat-util.h           | 17 +++++++++++++++++
 ll-merge.c                  |  2 +-
 mailinfo.c                  |  2 +-
 notes.c                     |  4 ++--
 pretty.c                    |  2 +-
 quote.c                     |  4 ++--
 read-cache.c                |  4 ++--
 refs/files-backend.c        |  2 +-
 revision.c                  |  2 +-
 send-pack.c                 |  2 +-
 strbuf.c                    |  2 +-
 streaming.c                 |  2 +-
 upload-pack.c               |  3 +--
 wildmatch.c                 |  2 +-
 wt-status.c                 |  4 ++--
 33 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68..a22fb2881 100644
--- a/apply.c
+++ b/apply.c
@@ -1450,7 +1450,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
 		switch (*line) {
 		case ' ': case '\n':
 			newlines++;
-			/* fall through */
+			GIT_FALLTHROUGH;
 		case '-':
 			oldlines++;
 			continue;
@@ -2896,7 +2896,7 @@ static int apply_one_fragment(struct apply_state *state,
 			if (plen && (ws_rule & WS_BLANK_AT_EOF) &&
 			    ws_blank_line(patch + 1, plen, ws_rule))
 				is_blank_context = 1;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		case '-':
 			memcpy(old, patch + 1, plen);
 			add_line_info(&preimage, old, plen,
@@ -2904,7 +2904,7 @@ static int apply_one_fragment(struct apply_state *state,
 			old += plen;
 			if (first == '-')
 				break;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		case '+':
 			/* --no-add does not add new lines */
 			if (first == '+' && state->no_add)
diff --git a/builtin/blame.c b/builtin/blame.c
index 005f55aaa..acc2c1e93 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -834,7 +834,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			argv[1] = argv[3];
 			argv[3] = argv[2];
 			argv[2] = "--";
-			/* FALLTHROUGH */
+			GIT_FALLTHROUGH;
 		case 1: /* (1a) */
 			path = add_prefix(prefix, argv[--argc]);
 			argv[argc] = NULL;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cf9ea5c79..eb4fa9247 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -113,7 +113,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 		if (textconv_object(path, obj_context.mode, &oid, 1, &buf, &size))
 			break;
-		/* else fallthrough */
+		GIT_FALLTHROUGH;
 
 	case 'p':
 		type = sha1_object_info(oid.hash, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c54c78df5..2db0e16d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -441,7 +441,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 		 * update paths in the work tree, and we cannot revert
 		 * them.
 		 */
-		/* fallthrough */
+		GIT_FALLTHROUGH;
 	case 0:
 		return 0;
 	default:
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 796d0cd66..972f0a3f0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -385,7 +385,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 				    ospec->mode == spec->mode)
 					break;
 			}
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 
 		case DIFF_STATUS_TYPE_CHANGED:
 		case DIFF_STATUS_MODIFIED:
@@ -733,7 +733,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			case WARN_STRIP:
 				warning ("Stripping signature from tag %s",
 					 oid_to_hex(&tag->object.oid));
-				/* fallthru */
+				GIT_FALLTHROUGH;
 			case STRIP:
 				message_size = signature + 1 - message;
 				break;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2..320fd54de 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -848,7 +848,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			switch (rm->fetch_head_status) {
 			case FETCH_HEAD_NOT_FOR_MERGE:
 				merge_status_marker = "not-for-merge";
-				/* fall-through */
+				GIT_FALLTHROUGH;
 			case FETCH_HEAD_MERGE:
 				fprintf(fp, "%s\t%s\t%s",
 					oid_to_hex(&rm->old_oid),
diff --git a/builtin/init-db.c b/builtin/init-db.c
index c9b7946ba..6554172da 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -511,7 +511,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 					break;
 				case SCLD_EXISTS:
 					errno = EEXIST;
-					/* fallthru */
+					GIT_FALLTHROUGH;
 				default:
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
diff --git a/builtin/log.c b/builtin/log.c
index 46b4ca13e..ae6f2257a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1902,10 +1902,10 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	switch (argc) {
 	case 3:
 		limit = argv[2];
-		/* FALLTHROUGH */
+		GIT_FALLTHROUGH;
 	case 2:
 		head = argv[1];
-		/* FALLTHROUGH */
+		GIT_FALLTHROUGH;
 	case 1:
 		upstream = argv[0];
 		break;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2fc836e33..57aac6024 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -448,7 +448,7 @@ void overlay_tree_on_index(struct index_state *istate,
 		switch (ce_stage(ce)) {
 		case 0:
 			last_stage0 = ce;
-			/* fallthru */
+			GIT_FALLTHROUGH;
 		default:
 			continue;
 		case 1:
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 6a9127a33..909f8995e 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -57,7 +57,7 @@ static char *strip_escapes(const char *str, const char *service,
 				special = str[rpos];
 				if (rpos == 1)
 					break;
-				/* fallthrough */
+				GIT_FALLTHROUGH;
 			default:
 				die("Bad remote-ext placeholder '%%%c'.",
 					str[rpos]);
diff --git a/builtin/reset.c b/builtin/reset.c
index e15f59579..00e21958f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -65,7 +65,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		break;
 	case HARD:
 		opts.update = 1;
-		/* fallthrough */
+		GIT_FALLTHROUGH;
 	default:
 		opts.reset = 1;
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a5c4a8a69..bc2fb2ebd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1425,7 +1425,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 						break;
 					die("HEAD does not match the named branch in the superproject");
 				}
-				/* fallthrough */
+				GIT_FALLTHROUGH;
 			default:
 				die("src refspec '%s' must name a ref",
 				    rs->src);
diff --git a/config.c b/config.c
index 70ce6e704..6f89f3925 100644
--- a/config.c
+++ b/config.c
@@ -2286,7 +2286,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 		ALLOC_GROW(store.offset, store.seen + 1,
 			   store.offset_alloc);
 		store.offset[store.seen] = cf->do_ftell(cf);
-		/* fallthru */
+		GIT_FALLTHROUGH;
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
@@ -2387,7 +2387,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value)
 		case '"':
 		case '\\':
 			strbuf_addch(&sb, '\\');
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		default:
 			strbuf_addch(&sb, value[i]);
 			break;
diff --git a/connect.c b/connect.c
index c3a014c5b..3b4a30520 100644
--- a/connect.c
+++ b/connect.c
@@ -251,7 +251,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				break;
 			}
 			state = EXPECTING_FIRST_REF;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		case EXPECTING_FIRST_REF:
 			process_capabilities(&len);
 			if (process_dummy_ref()) {
@@ -259,12 +259,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 				break;
 			}
 			state = EXPECTING_REF;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		case EXPECTING_REF:
 			if (process_ref(len, &list, flags, extra_have))
 				break;
 			state = EXPECTING_SHALLOW;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		case EXPECTING_SHALLOW:
 			if (process_shallow(len, shallow_points))
 				break;
diff --git a/convert.c b/convert.c
index 1a41a48e1..81c2098a4 100644
--- a/convert.c
+++ b/convert.c
@@ -72,7 +72,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 				break;
 			case 0:
 				stats->nul++;
-				/* fall through */
+				GIT_FALLTHROUGH;
 			default:
 				stats->nonprintable++;
 			}
@@ -1554,7 +1554,7 @@ static int ident_filter_fn(struct stream_filter *filter,
 		switch (ident->state) {
 		default:
 			strbuf_add(&ident->left, head, ident->state);
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		case IDENT_SKIPPING:
 			/* fallthrough */
 		case IDENT_DRAINING:
diff --git a/diff.c b/diff.c
index 0a9a0cdf1..b632d6fde 100644
--- a/diff.c
+++ b/diff.c
@@ -3869,7 +3869,7 @@ static void fill_metainfo(struct strbuf *msg,
 				    set, similarity_index(p), reset);
 			break;
 		}
-		/* fallthru */
+		GIT_FALLTHROUGH;
 	default:
 		*must_show_header = 0;
 	}
diff --git a/dir.c b/dir.c
index a605e0169..146b40c96 100644
--- a/dir.c
+++ b/dir.c
@@ -700,7 +700,7 @@ static void trim_trailing_spaces(char *buf)
 			p++;
 			if (!*p)
 				return;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		default:
 			last_space = NULL;
 		}
diff --git a/fsck.c b/fsck.c
index 032699e9a..3b2d07cbb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -588,7 +588,7 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 		case S_IFREG | 0664:
 			if (!options->strict)
 				break;
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		default:
 			has_bad_modes = 1;
 		}
diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531..158f5fffb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1214,4 +1214,21 @@ extern void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) do {} while (0)
 #endif
 
+/*
+ *  Define a generic macro for suppress implicit case fall-through 
+ *  warning for different versions of C/C++ compiler.
+ *
+ */
+#if defined(__cplusplus) && __cplusplus >= 201703L
+#define GIT_FALLTHROUGH [[fallthrough]]
+#elif defined(__cplusplus) && __cplusplus >= 201103L && defined(__clang__)
+#define GIT_FALLTHROUGH [[clang::fallthrough]]
+#elif defined(__cplusplus) && __cplusplus >= 201103L && __GNUC__ >= 7
+#define GIT_FALLTHROUGH [[gnu::fallthrough]]
+#elif  __GNUC__ >= 7 // gcc 7
+#define GIT_FALLTHROUGH __attribute__ ((fallthrough))
+#else // C++11 on gcc 6, and all other cases
+#define GIT_FALLTHROUGH
+#endif
+
 #endif
diff --git a/ll-merge.c b/ll-merge.c
index a6ad2ec12..be7a21975 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -59,7 +59,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 		default:
 			warning("Cannot merge binary files: %s (%s vs. %s)",
 				path, name1, name2);
-			/* fallthru */
+			GIT_FALLTHROUGH;
 		case XDL_MERGE_FAVOR_OURS:
 			stolen = src1;
 			break;
diff --git a/mailinfo.c b/mailinfo.c
index a89db22ab..4e4fd31c5 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -827,7 +827,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 		if (!handle_commit_msg(mi, line))
 			break;
 		mi->filter_stage++;
-		/* fallthrough */
+		GIT_FALLTHROUGH;
 	case 1:
 		handle_patch(mi, line);
 		break;
diff --git a/notes.c b/notes.c
index c7f21fae4..7e4b73086 100644
--- a/notes.c
+++ b/notes.c
@@ -128,7 +128,7 @@ static void **note_tree_search(struct notes_tree *t, struct int_node **tree,
 			free(l);
 			return note_tree_search(t, tree, n, key_sha1);
 		}
-		/* fall through */
+		GIT_FALLTHROUGH;
 	default:
 		return &((*tree)->a[i]);
 	}
@@ -326,7 +326,7 @@ static void note_tree_free(struct int_node *tree)
 		switch (GET_PTR_TYPE(p)) {
 		case PTR_TYPE_INTERNAL:
 			note_tree_free(CLR_PTR_TYPE(p));
-			/* fall through */
+			GIT_FALLTHROUGH;
 		case PTR_TYPE_NOTE:
 		case PTR_TYPE_SUBTREE:
 			free(CLR_PTR_TYPE(p));
diff --git a/pretty.c b/pretty.c
index f7ce49023..c942ce8dd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -274,7 +274,7 @@ static void add_rfc822_quoted(struct strbuf *out, const char *s, int len)
 		case '"':
 		case '\\':
 			strbuf_addch(out, '\\');
-			/* fall through */
+			GIT_FALLTHROUGH;
 		default:
 			strbuf_addch(out, s[i]);
 		}
diff --git a/quote.c b/quote.c
index de2922ddd..f1733de19 100644
--- a/quote.c
+++ b/quote.c
@@ -99,7 +99,7 @@ static char *sq_dequote_step(char *arg, char **next)
 				*dst++ = c;
 				continue;
 			}
-		/* Fallthrough */
+		GIT_FALLTHROUGH;
 		default:
 			if (!next || !isspace(*src))
 				return NULL;
@@ -431,7 +431,7 @@ void tcl_quote_buf(struct strbuf *sb, const char *src)
 		case '{': case '}':
 		case '$': case '\\': case '"':
 			strbuf_addch(sb, '\\');
-			/* fallthrough */
+			GIT_FALLTHROUGH;
 		default:
 			strbuf_addch(sb, c);
 			break;
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b..abe655024 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -225,7 +225,7 @@ static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
 	case S_IFDIR:
 		if (S_ISGITLINK(ce->ce_mode))
 			return ce_compare_gitlink(ce) ? DATA_CHANGED : 0;
-		/* else fallthrough */
+		GIT_FALLTHROUGH;
 	default:
 		return TYPE_CHANGED;
 	}
@@ -840,7 +840,7 @@ static int verify_dotfile(const char *rest)
 		if (rest[2] != 't' && rest[2] != 'T')
 			break;
 		rest += 2;
-	/* fallthrough */
+		GIT_FALLTHROUGH;
 	case '.':
 		if (rest[1] == '\0' || is_dir_sep(rest[1]))
 			return 0;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f75d960e1..d6a2f8129 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -562,7 +562,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		/* Maybe another process was tidying up. Try again. */
 		if (--attempts_remaining > 0)
 			goto retry;
-		/* fall through */
+		GIT_FALLTHROUGH;
 	default:
 		strbuf_addf(err, "unable to create directory for %s",
 			    ref_file.buf);
diff --git a/revision.c b/revision.c
index 236d0d579..e34c2dfe1 100644
--- a/revision.c
+++ b/revision.c
@@ -702,7 +702,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					    oid_to_hex(&p->object.oid));
 				p->parents = NULL;
 			}
-		/* fallthrough */
+		GIT_FALLTHROUGH;
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
 			if (relevant_commit(p))
diff --git a/send-pack.c b/send-pack.c
index 2112d3b27..58f1dcbea 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -487,7 +487,7 @@ int send_pack(struct send_pack_args *args,
 				strbuf_release(&cap_buf);
 				return atomic_push_failure(args, remote_refs, ref);
 			}
-			/* else fallthrough */
+			GIT_FALLTHROUGH;
 		default:
 			continue;
 		}
diff --git a/strbuf.c b/strbuf.c
index 1df674e91..281f6e254 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -838,7 +838,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 				fmt++;
 				break;
 			}
-			/* FALLTHROUGH */
+			GIT_FALLTHROUGH;
 		default:
 			strbuf_addch(&munged_fmt, '%');
 		}
diff --git a/streaming.c b/streaming.c
index 5892b50bd..ac46c9079 100644
--- a/streaming.c
+++ b/streaming.c
@@ -124,7 +124,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 	case OI_PACKED:
 		if (!oi->u.packed.is_delta && big_file_threshold < size)
 			return pack_non_delta;
-		/* fallthru */
+		GIT_FALLTHROUGH;
 	default:
 		return incore;
 	}
diff --git a/upload-pack.c b/upload-pack.c
index f51b6cfca..3ff2a0f06 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1105,8 +1105,7 @@ int cmd_main(int argc, const char **argv)
 		 */
 		if (advertise_refs || !stateless_rpc)
 			packet_write_fmt(1, "version 1\n");
-
-		/* fallthrough */
+		GIT_FALLTHROUGH;
 	case protocol_v0:
 		upload_pack();
 		break;
diff --git a/wildmatch.c b/wildmatch.c
index d074c1be1..594f7585c 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -71,7 +71,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 			/* Literal match with following character.  Note that the test
 			 * in "default" handles the p[1] == '\0' failure case. */
 			p_ch = *++p;
-			/* FALLTHROUGH */
+			GIT_FALLTHROUGH;
 		default:
 			if (t_ch != p_ch)
 				return WM_NOMATCH;
diff --git a/wt-status.c b/wt-status.c
index f5debcd2b..f35452119 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -473,7 +473,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			d->rename_source = xstrdup(p->one->path);
 			d->rename_score = p->score * 100 / MAX_SCORE;
 			d->rename_status = p->status;
-			/* fallthru */
+			GIT_FALLTHROUGH;
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 		case DIFF_STATUS_UNMERGED:
@@ -550,7 +550,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			d->rename_source = xstrdup(p->one->path);
 			d->rename_score = p->score * 100 / MAX_SCORE;
 			d->rename_status = p->status;
-			/* fallthru */
+			GIT_FALLTHROUGH;
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			d->mode_head = p->one->mode;
-- 
2.16.0.312.g896df04.dirty

