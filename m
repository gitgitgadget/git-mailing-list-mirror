Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F61D1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbcIGXvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:51:24 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36647 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbcIGXvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:51:22 -0400
Received: by mail-pf0-f175.google.com with SMTP id 128so11375074pfb.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DK4IAg/ZJ49WvhtP2QQU/QAQ6iZkRJ89Lf5q41EQ55Q=;
        b=L9W/XsUZHWPUtPtzVGIjyoMvJDBQIwoh/PTTcNK9sCJPOqzvjK/HMZ2sEuOL/3oRGx
         mND0L1jaQLEibkuv0z/jW9oXKqRiVIgoHRh6h8qeXmbrZ+lqNAwKpgG8NqxUjwb/9CVd
         dPhePMsjf3usvS+pP4nzwade7NTuK4x5xqus7uILlRt2yEqJOmZ6yn8ZpBsyDhMAIwuP
         XfdPpU/JzcSdAOq40R2iOx/DfrJaaoqBNW5il+RNlYYrriu5R9utNY8JVO0Ajwqvke//
         0BAFrIUnqGO+2CyKXnH4ev+YNnAIHmNLG+6kJ/ie3GMXH2/VipzR91d3uzmx0Wgeyv/y
         8nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DK4IAg/ZJ49WvhtP2QQU/QAQ6iZkRJ89Lf5q41EQ55Q=;
        b=deEntAU0JOA5wLufp/kYUC74hxNE/utrM0sxWgeqw9hotjwq1UubX+tH1a1xp3R8gA
         nyhk/d3BB521fvbxokC00B/J9ouz9vBq6CSfg0PSFzvb/GTbk4i21HpnA/omvNc/tn4d
         XenUBGfyioVH0yT3E6ig2lCkyfgNZMisUp4xJaoEnptHP7pRaJRM0XoDE3n/8MAzJa4S
         pr3C8ciof/avtbuY5x3Uy/1yimUpqO4COM/0wsGR32hbjBo6OHurSs6d97jgyH0EjBeC
         J/LKGMYjTVqHmhA8ZGgRoQQGzid3tqoLkwSujv915KjsqTG9F0DYEdDHNMRPVeeE2UVv
         ij8g==
X-Gm-Message-State: AE9vXwNHY/bK0+eG/pnHCmgkayjWl6Ngu70j2zX9Ym2gTGiakBXe+QnZJ71SCi+ScNh+U7Oe
X-Received: by 10.98.5.133 with SMTP id 127mr87007371pff.40.1473292281440;
        Wed, 07 Sep 2016 16:51:21 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id 29sm13825669pfp.88.2016.09.07.16.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:51:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v3 2/2] connect: advertized capability is not a ref
Date:   Wed,  7 Sep 2016 16:50:57 -0700
Message-Id: <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473291819.git.jonathantanmy@google.com>
References: <cover.1473291819.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473291819.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473291819.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning an empty repository served by standard git, "git clone" produces
the following reassuring message:

	$ git clone git://localhost/tmp/empty
	Cloning into 'empty'...
	warning: You appear to have cloned an empty repository.
	Checking connectivity... done.

Meanwhile when cloning an empty repository served by JGit, the output is more
haphazard:

	$ git clone git://localhost/tmp/empty
	Cloning into 'empty'...
	Checking connectivity... done.
	warning: remote HEAD refers to nonexistent ref, unable to checkout.

This is a common command to run immediately after creating a remote repository
as preparation for adding content to populate it and pushing. The warning is
confusing and needlessly worrying.

The cause is that, since v3.1.0.201309270735-rc1~22 (Advertise capabilities
with no refs in upload service., 2013-08-08), JGit's ref advertisement includes
a ref named capabilities^{} to advertise its capabilities on, while git's ref
advertisement is empty in this case. This allows the client to learn about the
server's capabilities and is needed, for example, for fetch-by-sha1 to work
when no refs are advertised.

This also affects "ls-remote". For example, against an empty repository served
by JGit:

	$ git ls-remote git://localhost/tmp/empty
	0000000000000000000000000000000000000000        capabilities^{}

Git advertises the same capabilities^{} ref in its ref advertisement for push
but since it never remembered to do so for fetch, the client forgot to handle
this case. Handle it.

In this aspect, JGit is compliant with the specification in pack-protocol.txt.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connect.c            | 17 +++++++++++++++++
 t/t5512-ls-remote.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/connect.c b/connect.c
index 722dc3f..0bb8103 100644
--- a/connect.c
+++ b/connect.c
@@ -116,6 +116,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 {
 	struct ref **orig_list = list;
 	int got_at_least_one_head = 0;
+	int got_dummy_ref_with_capabilities_declaration = 0;
 
 	*list = NULL;
 	for (;;) {
@@ -165,8 +166,24 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
+		if (!strcmp(name, "capabilities^{}")) {
+			if (got_at_least_one_head)
+				warning("protocol error: unexpected dummy ref for "
+				        "capabilities declaration, continuing anyway");
+			if (got_dummy_ref_with_capabilities_declaration)
+				warning("protocol error: multiple dummy refs for "
+				        "capabilities declaration, continuing anyway");
+			got_dummy_ref_with_capabilities_declaration = 1;
+			continue;
+		}
+
 		if (!check_ref(name, flags))
 			continue;
+
+		if (got_dummy_ref_with_capabilities_declaration)
+			warning("protocol error: unexpected ref after "
+			        "dummy ref, using this ref and continuing anyway");
+
 		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
 		oidcpy(&ref->old_oid, &old_oid);
 		*list = ref;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 819b9dd..befdfee 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -207,5 +207,45 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	test_cmp expect actual
 '
 
+test_lazy_prereq GIT_DAEMON '
+	test_tristate GIT_TEST_GIT_DAEMON &&
+	test "$GIT_TEST_GIT_DAEMON" != false
+'
+
+# This test spawns a daemon, so run it only if the user would be OK with
+# testing with git-daemon.
+test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
+	JGIT_DAEMON_PORT=${JGIT_DAEMON_PORT-${this_test#t}} &&
+	JGIT_DAEMON_PID= &&
+	git init --bare empty.git &&
+	>empty.git/git-daemon-export-ok &&
+	mkfifo jgit_daemon_output &&
+	{
+		jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
+		JGIT_DAEMON_PID=$!
+	} &&
+	test_when_finished kill "$JGIT_DAEMON_PID" &&
+	{
+		read line &&
+		case $line in
+		Exporting*)
+			;;
+		*)
+			echo "Expected: Exporting" &&
+			false;;
+		esac &&
+		read line &&
+		case $line in
+		"Listening on"*)
+			;;
+		*)
+			echo "Expected: Listening on" &&
+			false;;
+		esac
+	} <jgit_daemon_output &&
+	# --exit-code asks the command to exit with 2 when no
+	# matching refs are found.
+	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+'
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

