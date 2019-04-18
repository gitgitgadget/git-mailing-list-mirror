Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B545120248
	for <e@80x24.org>; Thu, 18 Apr 2019 09:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbfDRJ3t (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 05:29:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44646 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbfDRJ3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 05:29:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so914257pgj.11
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOMXWHIjj2MVzHk6M9WaehbuX7l1w/dtwHflII27r9Y=;
        b=Y/W/2HjJjB0RvmkawdidXKbo+UuNrQVQ22HVJc0WByQ2cKlZrrOK9X1CmZe6iKMODI
         dYcga8e98A0ysQbyHff+V5gTwPgD8m5gvj+gH0LhfAyGchAxDyKdNSy9p/0mOfav0muB
         4R4zv4+/RKpEfn9NkdXdy3ElMH8HaP54UVCRRugx/VI/QyGS75XZob5gJAYXVi8iWl0B
         hRr7vTWv0TxrLOcaSoXGhqJsCAqYgcZh+OB71HHj1fKQCKe/6sI2+uxCdwl3TaXxxpCz
         5QuDSSMsmFy74dnKoP2iJW/GyhotPTi8SlMLjyJkHKyvfAvWIKa1Q6YW69eYrqxrWliq
         dn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOMXWHIjj2MVzHk6M9WaehbuX7l1w/dtwHflII27r9Y=;
        b=p1hc/6jgZMUzAL+LsYqjRgDF0r+Pu6P9zCD4AnS/Grzg1C26bWFkHMOTr3naDwe1aN
         5yIPnkCNS9Yjgo6tS2pJUi5sREpduxbuTBnGkokf/G5VtJEx0LfyaCwx6r5BD3sDV7P3
         u/eChJLAy+6oQg5xDaAVLllDCNeSvK17HNy/NOE796/QzuPPpQzFt+N9IJVpNoj35vxU
         k2vQpPG8+vnEDUGtTuEjNxS4xnaD3jCKI3g86obHikF0JRWUCiJu7PUNCnSmwYL8ldph
         gRAyQ6SzcyfjI3mH42t9stwNuHRTwLly+yvh5+zuUpxI78+2j2Ne/r8m+eqggPSTJa6J
         y7Ww==
X-Gm-Message-State: APjAAAWXQYN71/8gypENP7/DA2/6KPm//LpwaBaaQLWOMKal8UL269+C
        w3F/0zFNqRd65GalwoiNEr4=
X-Google-Smtp-Source: APXvYqxFNcNVFzy6aH43qOcp5mKFj39Yg0BxxLgFXynnOFDWcu61mZ/wcBIAPvSpCPDXVKHxMy27cw==
X-Received: by 2002:a65:5009:: with SMTP id f9mr5075816pgo.390.1555579787992;
        Thu, 18 Apr 2019 02:29:47 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id v19sm2805560pfa.138.2019.04.18.02.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:29:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Apr 2019 16:29:41 +0700
Date:   Thu, 18 Apr 2019 16:29:41 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] parse-options: don't emit "ambiguous option" for
 aliases
Message-ID: <20190418092940.GA13484@ash>
References: <20190325202329.26033-3-avarab@gmail.com>
 <20190417124438.8191-1-avarab@gmail.com>
 <CACsJy8D215hMvfCwz1G9mP2te-ZERVaMMRrnM=MK1_bc0oFsjw@mail.gmail.com>
 <xmqq4l6wjfyw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4l6wjfyw.fsf@gitster-ct.c.googlers.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 09:48:39AM +0900, Junio C Hamano wrote:
> > But on the other hand I can see it's a bit more work to teach
> > parse-options OPT_ALIAS to say "--recursive is just an alias of
> > --recurse-submodules" and chances of --recursive-hard coming up are
> > probably very low.
> 
> The "bit more work" is something that is worth doing in this case, I
> think.

I had a look at it. Linking two options together is not exactly easy
because the way we organize option data. And I also had difficulty
defining the exact semantics of this OPT_ALIAS.

So an alternative is simply outsource the ambiguity decision back to
git-clone. If the same situation appears again elsewhere, we'll need
to sit back and fix it for real. But this way we don't potentially
introduce any new traps.

parse_options_extended() also makes it easier to extend parseopt
functionality without changing all call sites. One thing I have in
mind, which could maybe use this interface, is to remove
parse_options_{start,step,end} from public API, avoid expose the
parse_options_step internal result code. The caller just need to pass
a callback to handle unknown options.

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..041cd43ddc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -145,6 +145,29 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
+/*
+ * Avoid ambiguation error between --recursive and --recurse-submodule
+ * because they are the same. --recurs can be expanded to any of them
+ * and it still works.
+ */
+static int is_abbrev_ambiguous(const struct option *prev,
+			       const struct option *next)
+{
+	const struct option *opts[] = { prev, next };
+	int i, found = 0;
+
+	for (i = 0; i < ARRAY_SIZE(opts); i++) {
+		if (!opts[i]->long_name)
+			continue;
+		if (!strcmp(opts[i]->long_name, "recursive"))
+			found |= 1 << 0;
+		if (!strcmp(opts[i]->long_name, "recurse-submodules"))
+			found |= 1 << 1;
+	}
+
+	return found != 3;
+}
+
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -905,14 +928,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	struct parseopt_options parseopts = { 0 };
 
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	fetch_if_missing = 0;
 
 	packet_trace_identity("clone");
-	argc = parse_options(argc, argv, prefix, builtin_clone_options,
-			     builtin_clone_usage, 0);
+	parseopts.usagestr = builtin_clone_usage;
+	parseopts.is_abbrev_ambiguous = is_abbrev_ambiguous;
+	argc = parse_options_extended(argc, argv, prefix,
+				      builtin_clone_options,
+				      &parseopts);
 
 	if (argc > 2)
 		usage_msg_opt(_("Too many arguments."),
diff --git a/parse-options.c b/parse-options.c
index cec74522e5..c0354e5a92 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -294,7 +294,8 @@ static enum parse_opt_result parse_long_opt(
 			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
 			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
-				if (abbrev_option) {
+				if (abbrev_option &&
+				    p->is_abbrev_ambiguous(abbrev_option, options)) {
 					/*
 					 * If this is abbreviated, it is
 					 * ambiguous. So when there is no
@@ -450,6 +451,12 @@ static void parse_options_check(const struct option *opts)
 		exit(128);
 }
 
+static int abbrev_is_always_ambiguous(const struct option *prev,
+				      const struct option *next)
+{
+	return 1;
+}
+
 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
 			 const struct option *options, int flags)
@@ -466,6 +473,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
+	ctx->is_abbrev_ambiguous = abbrev_is_always_ambiguous;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
 	    !(flags & PARSE_OPT_ONE_SHOT))
@@ -702,13 +710,17 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 	return ctx->cpidx + ctx->argc;
 }
 
-int parse_options(int argc, const char **argv, const char *prefix,
-		  const struct option *options, const char * const usagestr[],
-		  int flags)
+int parse_options_extended(int argc, const char **argv, const char *prefix,
+			   const struct option *options,
+			   const struct parseopt_options *parseopts)
 {
 	struct parse_opt_ctx_t ctx;
+	const char * const * usagestr = parseopts->usagestr;
+	int flags = parseopts->flags;
 
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
+	if (parseopts->is_abbrev_ambiguous)
+		ctx.is_abbrev_ambiguous = parseopts->is_abbrev_ambiguous;
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 	case PARSE_OPT_ERROR:
@@ -734,6 +746,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	return parse_options_end(&ctx);
 }
 
+int parse_options(int argc, const char **argv, const char *prefix,
+		  const struct option *options, const char * const usagestr[],
+		  int flags)
+{
+	struct parseopt_options parseopts = {0};
+
+	parseopts.flags = flags;
+	parseopts.usagestr = usagestr;
+	return parse_options_extended(argc, argv, prefix, options, &parseopts);
+}
+
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
diff --git a/parse-options.h b/parse-options.h
index 74cce4e7fc..31ebf4572c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -198,6 +198,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  const struct option *options,
 		  const char * const usagestr[], int flags);
 
+struct parseopt_options {
+	int flags;
+	const char * const * usagestr;
+	int (*is_abbrev_ambiguous)(const struct option *prev,
+				   const struct option *next);
+};
+
+int parse_options_extended(int argc, const char **argv, const char *prefix,
+			   const struct option *options,
+			   const struct parseopt_options *parseopts);
+
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
@@ -256,6 +267,7 @@ struct parse_opt_ctx_t {
 	const char *opt;
 	int flags;
 	const char *prefix;
+	int (*is_abbrev_ambiguous)(const struct option *, const struct option *);
 };
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
-- 8< --

> 
> Thanks.
