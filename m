Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA991FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 22:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbcIBWGt (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 18:06:49 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35548 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcIBWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 18:06:49 -0400
Received: by mail-pf0-f169.google.com with SMTP id x72so46062124pfd.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y8Hp51R/wU0yK56v2uiPOQeq2/DYupHA8RPduRrFG9U=;
        b=FAVrjIGBzih3liXlcMgnXVCVItFRAJb76bJqAc82uy80kErZOEVgxZsHpNlOXuU8Xt
         F8Y8cubOhOKCHXtsmYTtq/fDvqLplZfKvE+ScZemquc8K0JeQC1fwg4gf/NZp6J9503H
         SBzUofcgc71EYD3NlwL8CzQuv4KOR+T1G/NA+SZPJjQc/prp2DYtHyGkwMKXd3NoGDk8
         D5kktr6HCHjyZr6zbJOxYdxymL9127QQ+3zUqO1M0ax713/HmZssqEZNVXlgfR7nKuri
         L0pNTSox7eJ3iszWQIyJ/F8C5Lw0PBed97gd2bJh0FpeREfYT0gMARW0o3gvyhuB6x16
         ++9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y8Hp51R/wU0yK56v2uiPOQeq2/DYupHA8RPduRrFG9U=;
        b=nLFskTbPhg2fLOzzr1XICdHmkALEnguSAqvz+r2/k457QHLsaPl+MdkB0XXi+fFVLT
         /8WlferjfM7X/cjPUp3pjj7c3qhIH987oJ1hqVjRu5wIoRLrGASrizCWI7LbzSxi9/4M
         lS5VhQ/xxE0C/zAqHS8fa5hauAcWIwNa0MZy1zINq4e4bD1VYTjbK+uK96SZw63uU+T9
         /a9kyk4bfyKFqwFIoLcr6lFDBir39zFNqMWs4eGfN7S96cfaF0yZVQCrUrnmOo6LQurZ
         yX4p2z1ZxMHaMXCxGDn7pNlyyx0OY9aoaGYl6LadXtiz2dqf4QRup490aAnxo0BViKp5
         xPmg==
X-Gm-Message-State: AE9vXwODJbl4afHNh5HFDFvgbW/A0PnU4uobbQtnf5/NydhmWHERnCPsDGllGg96L8Motvqb
X-Received: by 10.98.14.208 with SMTP id 77mr40363550pfo.23.1472854008068;
        Fri, 02 Sep 2016 15:06:48 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id h86sm17007557pfh.46.2016.09.02.15.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 15:06:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: [PATCH v2 2/2] connect: advertized capability is not a ref
Date:   Fri,  2 Sep 2016 15:06:12 -0700
Message-Id: <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472853827.git.jonathantanmy@google.com>
References: <cover.1472853827.git.jonathantanmy@google.com>
In-Reply-To: <cover.1472853827.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1472853827.git.jonathantanmy@google.com>
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
Because git client versions without this fix are expected to exist in the wild
for a while, we should not change the server to always send the capabilities^{}
line when there are no refs to advertise yet.  A transition will take multiple
steps:

 1. This patch, which updates the client

 2. Update pack-protocol to clarify that both server behaviors must be
    tolerated.

 3. Add a configuration variable to allow git upload-pack to advertise
    capabilities when there are no refs to advertise.  Leave it disabled
    by default since git clients can't be counted on to have this patch (1)
    yet.

 4. After a year or so, flip the default for that server configuration
    variable to true.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connect.c            |  3 +++
 t/t5512-ls-remote.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/connect.c b/connect.c
index 722dc3f..0c2221e 100644
--- a/connect.c
+++ b/connect.c
@@ -165,6 +165,9 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
+		if (!strcmp(name, "capabilities^{}"))
+			continue;
+
 		if (!check_ref(name, flags))
 			continue;
 		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 819b9dd..2de52f5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -207,5 +207,44 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	test_cmp expect actual
 '
 
+test_lazy_prereq GIT_DAEMON '
+	test_tristate GIT_TEST_GIT_DAEMON &&
+	test "$GIT_TEST_GIT_DAEMON" != false
+'
+
+JGIT_DAEMON_PORT=${JGIT_DAEMON_PORT-${this_test#t}}
+
+# This test spawns a daemon, so run it only if the user would be OK with
+# testing with git-daemon.
+test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
+	JGIT_DAEMON_PID= &&
+	git init --bare empty.git &&
+	touch empty.git/git-daemon-export-ok &&
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
+	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+'
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

