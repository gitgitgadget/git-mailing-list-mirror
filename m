Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95015208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeHDDwP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:15 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:50384 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:14 -0400
Received: by mail-qt0-f202.google.com with SMTP id e14-v6so5671240qtp.17
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C28dA414HElwXP/g+aSVB6BOoC4DoMdt/nNw9PD1xu4=;
        b=C9+STNiTo+H3dGFn88sU+E+q5drop/fIy/6HS7dPzE3O01yPvdNlwftJo5vJK8BhjO
         2442obQKvVKVUkSooXR65XYUciLGzxattmbp19W3iAynVtmeWwJ6dJiL4qzhSjObwhQ8
         WPB9A2zpPVbQj0cqVD5cP6r3//HuZEAarXLQXmCq8oXVLR1tCkAP/6Uxk/DazP5JKdEo
         bi3/zS3D16PxeuEGFd6FpFdH4fozYWtmEdBImqjAZQyzRHVJgMKKgT0Ih8zUrAs4v87n
         wigqkf34bcJeVQ0tgssrtsKLLctC53jumpaT3ZVi3bauuZygeBfIlZL//x2TnJJwAt/6
         7/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C28dA414HElwXP/g+aSVB6BOoC4DoMdt/nNw9PD1xu4=;
        b=apT/v1DogMzEZZhJO/6FFtuKu0ueqytTeqLme8HQTf5DumS39du8Mbub5zu3ENg6Ch
         tWNUmvzupN8DAb1LLI84j5uY/0+G6x7y8fKSwaKCc7wU/Z8qZPBHdyu075Q+li+15F1e
         4GKtrlc2C351Bpd61Np+dzYrMg+kNt46siwR0DO50KHrgU4nmTsEHRhXrM0OQgtEGP5Y
         ijKQID47tMH4jmz1g1qKnzHhnqvUK2qmI8oydIpto/zn1aCTVT0LI5Og17v1Ayi89tTz
         H+5mMfYakBd0PnLL3Xh1ZDDgGjt8M66x4lyScKifDyozzj2j+2+3ZRp3cKLfdTJCrRDw
         v4FA==
X-Gm-Message-State: AOUpUlELGKzX6ociBOULKPcQ5zaBcgt0lMQIh9uxaimoBK6PdrXf7flo
        Guci/PvHZcAwgAgLpHajfFaDYJcDkJhxXjtyM+HgXX0o46s36cCEgEHWUAaY6/d16ed3pyeXFQS
        UaJfyo9ErCpYdqRYwISD1ouBqXoOdk2ZtvcPDblDQ4pVZwXihSvsNEWhd+GO7
X-Google-Smtp-Source: AAOMgpc4vTSvmXqQdtHS/c9u8gUQlluLagtxgxt6xg5BMadf/8GvEUpKsQEY5mwR94ylf33/ImVsSnJvl/P5
X-Received: by 2002:aed:3e10:: with SMTP id l16-v6mr5364502qtf.4.1533347606131;
 Fri, 03 Aug 2018 18:53:26 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:12 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/7] diff.c: add --output-indicator-{new, old, context}
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will prove useful in range-diff in a later patch as we will be able to
differentiate between adding a new file (that line is starting with +++
and then the file name) and regular new lines.

It could also be useful for experimentation in new patch formats, i.e.
we could teach git to emit moved lines with lines other than +/-.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 21 +++++++++++++++++----
 diff.h |  5 +++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 57a8a38755e..2e711809700 100644
--- a/diff.c
+++ b/diff.c
@@ -1032,7 +1032,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
+	const char *context, *reset, *set, *set_sign, *meta, *fraginfo, *first;
 	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
@@ -1083,7 +1083,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, " ", line, len,
+		first = o->output_indicators[OI_CONTEXT] ?
+			o->output_indicators[OI_CONTEXT] : " ";
+		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1126,7 +1128,10 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags |= WS_IGNORE_FIRST_SPACE;
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, "+", line, len,
+
+		first = o->output_indicators[OI_NEW] ?
+			o->output_indicators[OI_NEW] : "+";
+		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1169,7 +1174,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set_sign, set, reset, "-", line, len,
+		first = o->output_indicators[OI_OLD] ?
+			o->output_indicators[OI_OLD] : "-";
+		emit_line_ws_markup(o, set_sign, set, reset, first, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
@@ -4670,6 +4677,12 @@ int diff_opt_parse(struct diff_options *options,
 		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--no-compact-summary"))
 		 options->flags.stat_with_summary = 0;
+	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+		options->output_indicators[OI_NEW] = arg;
+	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
+		options->output_indicators[OI_OLD] = arg;
+	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
+		options->output_indicators[OI_CONTEXT] = arg;
 
 	/* renames options */
 	else if (starts_with(arg, "-B") ||
diff --git a/diff.h b/diff.h
index a08a3b2a293..b8bbe7baeb8 100644
--- a/diff.h
+++ b/diff.h
@@ -194,6 +194,11 @@ struct diff_options {
 	FILE *file;
 	int close_file;
 
+#define OI_NEW 0
+#define OI_OLD 1
+#define OI_CONTEXT 2
+	const char *output_indicators[3];
+
 	struct pathspec pathspec;
 	pathchange_fn_t pathchange;
 	change_fn_t change;
-- 
2.18.0.597.ga71716f1ad-goog

