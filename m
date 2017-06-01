Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2B520D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdFAPvl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:51:41 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34161 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdFAPva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:51:30 -0400
Received: by mail-qk0-f196.google.com with SMTP id d14so3039662qkb.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCR9ouULWstfMWQlMpFAiNiUV154OVEWNrxiW6dPHD0=;
        b=D0hfz8i2O6wBx9FlzocILITJxkIbcFomDLfkvKqS2djpsYu/IFqzyEAZp+3F+qQAwN
         fwOHTMcRxmFVzDNDPfeZUTzhJM0ZkTBUcdAFwFYvJR2Kiw5D2S+8dDUMVcAPvKYBPV9r
         vPFiog2Q3ii91a3qFbNtxhvdZx0pgsbOReVzTRp9o4ShI8WTUoIk0hfPVE5sqWgcw4PF
         2fm1AG6wSYsvfJRKE4alhASqx9Nt56PcvGRIl6iVpVkXQ4hXFTv1tzJzuVl5PtWiuiQC
         zeEcgN0RTOgH1B9MSGFp97Ss3auw013kk5hprrRHk+7dkcYBIJKlvvb6OABnbCxrPLmX
         ZL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCR9ouULWstfMWQlMpFAiNiUV154OVEWNrxiW6dPHD0=;
        b=nT/8tHu0t2HTWLc67f10d9y3jKa5sttSSN8hwulKtu4/8T18UNWzLiqIxNe4sHMuhC
         oOu2C+zWCXedidJuEat+IVjm7/V+nLFqK5qbdXl73VvBbm77ZFz9w/zYlD0vBkdsl1lL
         qT3mqt0aWjZrnnk31/jXBayKk1JAwnBEZCY67IqK/2R/bOVr4poTBnj/TYhll0pIKAvo
         g76+mIbaTFNAlS6FKBbzLIaJzCA7i9CyQ1prjiz2B80kqOZAJsVZjYFc4Yr1N7bmh4gm
         KeQ17kxZ6fguztxp3BD8fMSh4o9Q1c4Xlvw5pHRZMYsmO34PGbIlbiGgll+siWEB+fVh
         mklA==
X-Gm-Message-State: AODbwcAaXFak5/3h7v4V9WRrCDCAIgZ1z12y33jsdhLjwczI3mJJIYaU
        IrGPmPJcVnk0r8warRo=
X-Received: by 10.55.98.135 with SMTP id w129mr2738121qkb.90.1496332284657;
        Thu, 01 Jun 2017 08:51:24 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w41sm12715524qtg.34.2017.06.01.08.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 08:51:24 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v4 6/6] fsmonitor: add a sample query-fsmonitor hook script for Watchman
Date:   Thu,  1 Jun 2017 11:51:05 -0400
Message-Id: <20170601155105.28356-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hook script integrates the new fsmonitor capabilities of git with
the cross platform Watchman file watching service. To use the script:

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 templates/hooks--query-fsmonitor.sample | 60 +++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 templates/hooks--query-fsmonitor.sample

diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
new file mode 100755
index 0000000000..941c4c5b57
--- /dev/null
+++ b/templates/hooks--query-fsmonitor.sample
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to provide fast
+# git status.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-fsmonitor"
+
+# check the hook interface version
+if [ $1 -eq 1 ]
+then
+	# convert nanoseconds to seconds
+	time_t=$(($2/1000000000))
+else
+	echo -e "Unsupported query-fsmonitor hook version.\nFalling back to scanning...\n" >&2
+	exit 1;
+fi
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
+echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $time_t, \"fields\":[\"name\"]}]" | \
+	watchman -j |
+	perl -0666 -e '
+		use strict;
+		use warnings;
+
+		my $stdin = <>;
+		die "Watchman: command returned no output.\nFalling back to scanning...\n" if $stdin eq "";
+		die "Watchman: command returned invalid output: $stdin\nFalling back to scanning...\n" unless $stdin =~ /^\{/;
+
+		my $json_pkg;
+		eval {
+			require JSON::XS;
+			$json_pkg = "JSON::XS";
+			1;
+		} or do {
+			require JSON::PP;
+			$json_pkg = "JSON::PP";
+		};
+
+		my $o = $json_pkg->new->utf8->decode($stdin);
+		die "Watchman: $o->{error}.\nFalling back to scanning...\n" if $o->{error};
+
+		local $, = "\0";
+		print @{$o->{files}};
+	'
-- 
2.13.0.windows.1.9.gc201c67b71

