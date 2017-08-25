Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5A5208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 19:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755456AbdHYT2T (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 15:28:19 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34828 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754856AbdHYT2S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 15:28:18 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so3823934pgc.2
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDvNn6EM1WM+lyvklI1nVZvHCt1tYBmIn1Rsn1y1U5I=;
        b=INHhxBMtvzJE2CEj77zDLVm+xYCtPVz/p/98WqZTiJBJVHe4za6QpPBvX9wyvQocE+
         VnJVJo6vwW1I5l9hXzLK6+6I/5NtinErb7imTV2/eOSkIq4mXh5QZoaRR/8beVC6yy53
         zFjjSZAoWGbIJs7NO0nmNwUeJqcdriBcIJVQkQEADszquq2d9CM6ZMf4/SoVvGSwyiLj
         GMt1DgTr1A2nw/EiSRkHh2P6jaiulpqrIkVhHkQWtBV+P3Ne2EtC+mheWLX0d82/S2Pa
         FdknWgTicRKJrUy/1F2JaMZodTqu931mPTTuffAcuhYSBSOHJg4paRtz0NkLz38K7f6J
         aqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDvNn6EM1WM+lyvklI1nVZvHCt1tYBmIn1Rsn1y1U5I=;
        b=C7vq/BK9vz+vuVVNdyrbrjC3iUcDscBOzR8DwsmoZOVRr6RbkLbtGRgbwPRd31fFrV
         Fq+nHLKdCGei696h/iAeMpxA5fBRWUIqR8e6Bh+4RgkliXHfuEzT3MGbbLmoz7oClnzB
         4dZioYZUsbsY4uddQpcc90gpdP/o5isxWpgkFHRzsfLtHcAEfbkA1cAhS6Tf46SUZqvK
         4gUYsLi4BEBiyRK5I610MmNvSmGs+24S/SSBjm6cev8Aoy/3u8g1Q5HK6Z850c0++kKZ
         pO+dlort32b4Sz0/cd4lUyz5Uf9uew7oGjTjGG+nrBMvWFVXghPeaRcskTuCxpCpJ6kO
         AT5A==
X-Gm-Message-State: AHYfb5jpHUM3UjQ52AgGDh9bXGH7EAdLwoHZiJJtVxI2x4e8kP5vS2xs
        JYWKolofDyo4cpzPMeHfGA==
X-Google-Smtp-Source: ADKCNb5G88Mkme5wfbxuBK4nKh5NUAI4FkivVXHek8aIzT45RR403J6Dt/RIXfTpobzMrlMekUrhCg==
X-Received: by 10.98.60.74 with SMTP id j71mr10883002pfa.28.1503689296962;
        Fri, 25 Aug 2017 12:28:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c58d:2520:e861:2008])
        by smtp.gmail.com with ESMTPSA id o9sm12809158pfk.91.2017.08.25.12.28.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 12:28:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] usage_with_options: omit double new line on empty option list
Date:   Fri, 25 Aug 2017 12:28:13 -0700
Message-Id: <20170825192813.15697-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqy3q7sge2.fsf@gitster.mtv.corp.google.com/>
References: <xmqqy3q7sge2.fsf@gitster.mtv.corp.google.com/>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the worktree command gives its usage, when no subcommand is
given. However there are no general options, all options are related to
the subcommands itself, such that:

 #    $ git worktree
 #    usage: git worktree add [<options>] <path> [<branch>]
 #       or: git worktree list [<options>]
 #       or: git worktree lock [<options>] <path>
 #       or: git worktree prune [<options>]
 #       or: git worktree unlock <path>
 #
 #
 #    $

Note the two empty lines at the end of the usage string. This is because
the toplevel usage is printed with an empty options list.

Only print a new line after the option list if it is not empty.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> I have this feeling that this patch may not be sufficient.
>
> The reason for the first blank line is because we unconditionally
> emit one, expecting that we would have a list of options to show and
> want to separate the usage from that list, and the fix in this patch
> is correct---it is the right way to suppress it.
>
> But why do we need the second blank line in this case?  There is a
> similar unconditional LF near the end of this function.  Is somebody
> else (other than usage_with_options() which will exit immeidately)
> calls this function and expects to say something more after what
> this function said, and is this extra blank line at the end is to
> prepare for that caller?

Good point, parse_options[_step] also makes use of the 
usage_with_options_internal, such that the regular options
need to work, with a potentially interesting arrangement of OPTION_GROUPs.

I think this one is cleaner, as it omits the correct LF.

Thanks,
Stefan

 parse-options.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 0dd9fc6a0d..2829c16b01 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -580,6 +580,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 				       const char * const *usagestr,
 				       const struct option *opts, int full, int err)
 {
+	int new_line_after_opts;
 	FILE *outfile = err ? stderr : stdout;
 
 	if (!usagestr)
@@ -606,6 +607,8 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 	if (opts->type != OPTION_GROUP)
 		fputc('\n', outfile);
 
+	new_line_after_opts = (opts->type != OPTION_END);
+
 	for (; opts->type != OPTION_END; opts++) {
 		size_t pos;
 		int pad;
@@ -645,7 +648,9 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		}
 		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
 	}
-	fputc('\n', outfile);
+
+	if (new_line_after_opts)
+		fputc('\n', outfile);
 
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fputs("EOF\n", outfile);
-- 
2.14.0.rc0.3.g6c2e499285

