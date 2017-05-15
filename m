Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCB9201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966392AbdEOTO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:14:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35973 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966317AbdEOTOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:14:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so17333017qta.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xJqa19aufFinXe/Vryl2uMbHzc0jGq55vdJrbsTJg/E=;
        b=JjcMAOSNIwcreMGw6Z2hHQsone/LROgVY21ZYuka2gouz5XIstX2DFj8je+RYqTqqB
         nOjtDj7IfEKkKgT/CmJI8AkEfZh3t84+7CAM88Q2oiBHrFAGNAQeROuVSlj7VS9pc0Ir
         50/yIPKbFiZbq+DSbjCPYVZqhXqNSIogM+YzOLgNzfNoR/U0ZfIzBWY+r5xa8Lqv05gV
         gIBlPMQb4VAaHDx+N5HeLGNJ4fU/wu/QDUH0K6mN8w8dE0quhgrw3bLIEpJ3XvT2IWVl
         FzicAsxvl8pq2rHrCYFX1msSpXCRrY6NKUB83W4E/frpp484nb+Ao+vSpWSR3sEJvDfZ
         jiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xJqa19aufFinXe/Vryl2uMbHzc0jGq55vdJrbsTJg/E=;
        b=ZSp4SrAbwFFBWQDfVUTJgU+cjfJPy2o9tmRdXo7cZhy6kcNTM+26mB+/AWmUcuEhU8
         2jnJs9V731i8+T+OkhRxpan3f8ruwLCtmysQTpGQ8AaG/MLbDTKVy09eVErJhm0B9M4o
         r0bMo0Bz2tjLny/nnystBTtF93EpDToDSOTrhQ6ay9oC+fuJ0ozP1YyOiBgNesqjDdXv
         8Yq4QrndUx9DN9Jf8pptixuYztOTZt1w9EoF395DDdvgFK72n5qjG69QLzvevRedGKdH
         BeRj5n6eEymLW3TczVy3qa3tSSjJ5Z8j9LK8jKlpxpNndNcfWShqjhV9SC/QM/IumI48
         S1Lw==
X-Gm-Message-State: AODbwcDIdMrM3ZEAKfCe0xjcn2j3Gv3peEIXoNOoLJ/pr11dzXDa/z3H
        j8NTF+tEEmcpPA==
X-Received: by 10.200.50.143 with SMTP id z15mr6891308qta.114.1494875658875;
        Mon, 15 May 2017 12:14:18 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 47sm9086903qts.26.2017.05.15.12.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:14:18 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v1 5/5] Add a sample query-fsmonitor hook script that integrates with the cross platform Watchman file watching service.
Date:   Mon, 15 May 2017 15:13:47 -0400
Message-Id: <20170515191347.1892-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170515191347.1892-1-benpeart@microsoft.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To use the script:

Download and install Watchman from https://facebook.github.io/watchman/
and instruct Watchman to watch your working directory for changes
('watchman watch-project /usr/src/git').

Rename the sample integration hook from query-fsmonitor.sample to
query-fsmonitor.

Configure git to use the extension ('git config core.fsmonitor true')
and optionally turn on the untracked cache for optimal performance
('git config core.untrackedcache true').

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 templates/hooks--query-fsmonitor.sample | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 templates/hooks--query-fsmonitor.sample

diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
new file mode 100644
index 0000000000..4bd22f21d8
--- /dev/null
+++ b/templates/hooks--query-fsmonitor.sample
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to provide fast
+# git status.
+#
+# The hook is passed a time_t formatted as a string and outputs to
+# stdout all files that have been modified since the given time.
+# Paths must be relative to the root of the working tree and
+# separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-fsmonitor"
+
+# Convert unix style paths to escaped Windows style paths
+case "$(uname -s)" in
+MINGW*|MSYS_NT*)
+  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
+  ;;
+*)
+  GIT_WORK_TREE="$PWD"
+  ;;
+esac
+
+# Query Watchman for all the changes since the requested time
+echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1, \"fields\":[\"name\"]}]" | \
+watchman -j | \
+perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'
-- 
2.13.0.windows.1.6.g4597375fc3

