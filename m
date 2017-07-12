Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89334202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 13:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbdGLNqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 09:46:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36149 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbdGLNqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 09:46:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so5924069wrb.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RF1fj0iKpRnjjU3Olp+1SH+aD6aot3Qdk9bhbRLjJVg=;
        b=UFb0WAZioesH/SQ/Jx59kI3Sx8xhBBw63cW8HWvEI+TFiamsB6aWInBsAn4QfkG1Qn
         9VNE3PlAVdNhdm1m9k6BOpJIWZrK8VV1vpK4CoJ3388ZRkyotJLBINte+/NoYRld11jz
         pDcFhs3SYDQHxjr5PPFhNxCd9LzqVwLlqJe2elCnjZ4o6K8ODTLpobeDIAZblfASDmad
         4hzt+me535CpuECW/qx1ouptVR0ZqTE3+BLR/SkfJJhISSKrU+n1l458cYKgHnxap7pT
         huQFkI3E9sn0uzROqbv22WIREDeA/KN6CQL4PeKhuyVU6hpfqpC/pNF+jdovhvQozYcD
         on3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RF1fj0iKpRnjjU3Olp+1SH+aD6aot3Qdk9bhbRLjJVg=;
        b=d6TLj5pG8xcxMp3jMd1bekkFaxiYPrUQcIrfr91RnxTMFfiLueFj/Rz3pCdBdPjI3j
         O0rVgw+3kaKJd6tB5+mhmjQ7y9ZbPB0l8/3EsfW+N+SWle5bRMiuIqqwj6Bxt/tpVK0/
         536a0r6MXrg+TSs6PNjZDJj+RVowZ8lNftxx1I4PC5vLTVXvAScoRT6fnirdAzSk4Gk+
         9X6zSKMYoSon36X4lblSdf7syOIb4pw7ouI7SnjcSC4Iawcl40FHrEgTDRXdLAUWBXko
         H7v6dww+RuQSEcaQ9kyZZikBQxx6bW123Zio6PxXMbh+qJnkF65mzblgkazqglT86RdX
         tBlQ==
X-Gm-Message-State: AIVw113b6kh91nbixVgIQh9EiTS5AWhpFMJ0ntf2HUF+Th8DMWMQ2X5j
        3onBjWbCj+e58n/4W7c=
X-Received: by 10.28.220.212 with SMTP id t203mr2725719wmg.13.1499867211487;
        Wed, 12 Jul 2017 06:46:51 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id 55sm3437950wrt.36.2017.07.12.06.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 06:46:50 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] trailers: create struct trailer_opts
Date:   Wed, 12 Jul 2017 15:46:44 +0200
Message-Id: <20170712134646.17179-2-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170712134646.17179-1-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Pass the command-line arguments as a pointer to a new struct.  This
will be extended soon to include more options.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 builtin/interpret-trailers.c | 13 ++++++-------
 trailer.c                    | 14 ++++++++------
 trailer.h                    |  7 ++++++-
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 175f14797..6528680b5 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -18,13 +18,12 @@ static const char * const git_interpret_trailers_usage[] = {
 
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
-	int in_place = 0;
-	int trim_empty = 0;
+	struct trailer_opts opts = { 0 };
 	struct string_list trailers = STRING_LIST_INIT_NODUP;
 
 	struct option options[] = {
-		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
-		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
+		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
+		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
 		OPT_END()
@@ -36,11 +35,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], in_place, trim_empty, &trailers);
+			process_trailers(argv[i], &opts, &trailers);
 	} else {
-		if (in_place)
+		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, in_place, trim_empty, &trailers);
+		process_trailers(NULL, &opts, &trailers);
 	}
 
 	string_list_clear(&trailers, 0);
diff --git a/trailer.c b/trailer.c
index 751b56c00..a3eb42818 100644
--- a/trailer.c
+++ b/trailer.c
@@ -164,13 +164,14 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
+static void print_all(FILE *outfile, struct list_head *head,
+		      struct trailer_opts *opts)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct trailer_item, list);
-		if (!trim_empty || strlen(item->value) > 0)
+		if (!opts->trim_empty || strlen(item->value) > 0)
 			print_tok_val(outfile, item->token, item->value);
 	}
 }
@@ -968,7 +969,8 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, struct trailer_opts *opts,
+		      struct string_list *trailers)
 {
 	LIST_HEAD(head);
 	LIST_HEAD(arg_head);
@@ -980,7 +982,7 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	read_input_file(&sb, file);
 
-	if (in_place)
+	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
@@ -990,14 +992,14 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 
 	process_trailers_lists(&head, &arg_head);
 
-	print_all(outfile, &head, trim_empty);
+	print_all(outfile, &head, opts);
 
 	free_all(&head);
 
 	/* Print the lines after the trailers as is */
 	fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
 
-	if (in_place)
+	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
diff --git a/trailer.h b/trailer.h
index 65cc5d79c..e90ba1270 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,11 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
+struct trailer_opts {
+	int in_place;
+	int trim_empty;
+};
+
 struct trailer_info {
 	/*
 	 * True if there is a blank line before the location pointed to by
@@ -22,7 +27,7 @@ struct trailer_info {
 	size_t trailer_nr;
 };
 
-void process_trailers(const char *file, int in_place, int trim_empty,
+void process_trailers(const char *file, struct trailer_opts *opts,
 		      struct string_list *trailers);
 
 void trailer_info_get(struct trailer_info *info, const char *str);
-- 
2.13.0


