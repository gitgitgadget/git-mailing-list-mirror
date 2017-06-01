Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36E2D2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 06:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdFAGs1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 02:48:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33264 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdFAGs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 02:48:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so6940810pfe.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dJPwRmGgm+d4op5O1wC4YhJGLWGZeH7Bi8OnFXgNSAI=;
        b=d0BFnNtp+ko9YndUNo9SMtbUuCdIg7eQAJ0P3H5jf1ULOBq47zVsUCu5JgytLqZ3f1
         lqjxpZg+nCOEbMt0zxUDi8A5vHTdKdQNNcoo4Qcb+eIM8mRetUQMsVhTHHY+lfJcZkJQ
         m4RGNQzcQaEw2VjhP8iH5/M67WWEMsHzzWa3z8TBxSxtcaQoAC4tZ/UfFGq1iTqUONgh
         EsEGz4nvxp3ZNJl4zEZCSUIFTr9dTaHXGV8VxEKE7zd4slupzN0g5ZOAJsGgPNfc3uMh
         vxvgvn5ew6IomblpMbv4zLH5zoeiIUiql/gVP1TJsVTxxl2dy0XLygLcfLgT00UrYRE2
         Pr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dJPwRmGgm+d4op5O1wC4YhJGLWGZeH7Bi8OnFXgNSAI=;
        b=bOC5ystJhUBcqv+g51cJIS2TLZh6jv+1Ibjakp6FgjXonW6W2+46rWwOxUukd8ZnJD
         C8WWueVemiu6UAHt0Y1zxfFEkHWK7F2BbGUpxAnzOEeBfPwtcMBqJjPXXkxNa7/T4HUq
         DA4xshUmbA1JpRExMMDqplRbmV7sTn3JRZD74pmg0znUX5FEsS7xsyBuf6IT8NnrLgH0
         UpgYFpRYXNWrxfq4J0ryi0y3TgMqg2hrSDPo/YmgUiy40Jb90ZkaWAj+BJwkB9LBVto0
         pG1zvdFj9DcIL5BrHL2FMaZZOCONI091XPgye8eSWLuerh7QtbctIx1Rsbxp6zMUAomJ
         1qRQ==
X-Gm-Message-State: AODbwcDW//TXtBH+owg94iIjbqPmFdE1z/o6P1cJI+i9koYXRiLabPDd
        Ao4o8712fkwVgw==
X-Received: by 10.98.223.195 with SMTP id d64mr34253487pfl.226.1496299706016;
        Wed, 31 May 2017 23:48:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id a28sm29042875pgd.37.2017.05.31.23.48.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 23:48:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: revision API design, was Re: [PATCH v4 02/10] rebase -i: generate the script via rebase--helper
References: <cover.1493207864.git.johannes.schindelin@gmx.de>
        <cover.1493414945.git.johannes.schindelin@gmx.de>
        <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
        <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705291252080.3610@virtualbox>
        <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705301700440.3610@virtualbox>
        <xmqq1sr6arda.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Jun 2017 15:48:24 +0900
In-Reply-To: <xmqq1sr6arda.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 31 May 2017 07:53:37 +0900")
Message-ID: <xmqqy3tc5hl3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The current API to hide such an embarrasing but necessary
> implementation details from the code that does not need to know
> them, i.e. the consumer of rev-info structure with various settings,
> is to invoke the command line parser.  Bypassing and going directly
> down to the internal implementation detail of rev_info _is_ being
> sloppy.  I would strongly prefer to see that the current series
> written for the API to allow us get it over with the "rebase -i"
> thing, and think revision setup API separately and later.

An updated API that hides the implementation details may look like
a vast enhancement of this patch.

I say "vast" because we need to do this for _all_ of the "else if"
cascade you see in revision.c, and probably for fields set by other
helper functions in the same file.  Otherwise, it doesn't have much
value.

Anybody who is tempted to say "We need to do these only for the
complex ones, like the one that needs to set revs->pretty_given
while setting something else" hasn't learned from the example of
66b2ed09.  Interactions between options start happening when new
options that are added, and that is when handling of a seemingly
unrelated old option that used to be very simple needs to do more in
the new world order.  And that is why this illustration has a
wrapper for "--first-parent-only", which happens to be very simple
today.

We do not want revision traversal API's customers to write

	revs.first_parent_only = 1;

because that's mucking with the implementation detail.  The current
API to hide that detail is:

	memset(&revs, 0, sizeof(revs);
	argv_pushl(&args, "--first-parent-only", NULL);
	... may be more options ...
	setup_revisions(args.argc, args.argv, &revs, ...);

and

	memset(&revs, 0, sizeof(revs);
	rev_option_first_parent_only(&revs);
	... may be more options ...
	setup_revisions(0, NULL, &revs, ...);

would be a more statically-checked rewrite, if such an API was
available.

 revision-internal.h | 18 ++++++++++++++++++
 revision.c          |  9 +++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/revision-internal.h b/revision-internal.h
new file mode 100644
index 0000000000..dea4c48412
--- /dev/null
+++ b/revision-internal.h
@@ -0,0 +1,18 @@
+#ifndef REVISION_INTERNAL_H
+#define REVISION_INTERNAL_H 1
+
+static inline void rev_option_first_parent_only(struct rev_info *revs)
+{
+	revs->first_parent_only = 1;
+}
+
+static inline void rev_option_simplify_merges(struct rev_info *revs)
+{
+	revs->simplify_merges = 1;
+	revs->topo_order = 1;
+	revs->rewrite_parents = 1;
+	revs->simplify_history = 0;
+	revs->limited = 1;
+}
+
+#endif
diff --git a/revision.c b/revision.c
index 265611e01f..9418676264 100644
--- a/revision.c
+++ b/revision.c
@@ -20,6 +20,7 @@
 #include "cache-tree.h"
 #include "bisect.h"
 #include "worktree.h"
+#include "revision-internal.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1807,7 +1808,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_age = approxidate(optarg);
 		return argcount;
 	} else if (!strcmp(arg, "--first-parent")) {
-		revs->first_parent_only = 1;
+		rev_option_first_parent_only(&revs);
 	} else if (!strcmp(arg, "--ancestry-path")) {
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
@@ -1825,11 +1826,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--simplify-merges")) {
-		revs->simplify_merges = 1;
-		revs->topo_order = 1;
-		revs->rewrite_parents = 1;
-		revs->simplify_history = 0;
-		revs->limited = 1;
+		rev_option_simplify_merges(&revs);
 	} else if (!strcmp(arg, "--simplify-by-decoration")) {
 		revs->simplify_merges = 1;
 		revs->topo_order = 1;
