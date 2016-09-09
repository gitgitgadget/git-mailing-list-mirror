Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB981F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbcIIRg4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:36:56 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34644 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbcIIRgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:36:53 -0400
Received: by mail-pf0-f175.google.com with SMTP id p64so31533493pfb.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=j3dn699RDxVOZddDckqMIHg3vMsw8zCj8w/EumYHLwI=;
        b=FsRg8mks6QJ5BurLxWPLKJU+yXu4NLF3uqIejg9+qPGepmDyZZ/UV3MHW27l0ZM9WB
         8yFVQ9/kzj4ZJXfKhHbGDxv5KETg6WQJUEHW60FXyPTAqFd91f/cE0BdP/x5linLcPVF
         Rmfzn+3eqFtq60sNmkqadRYo7PZ1rXmsOUzbC/QK6Jaz7EI78MOw0tndG9HajhCjiqTt
         Mq9AcMPQPEoQMkwH/oFB3mRf/MIoMxIezBlbFiD491ZQoDrY3AIpOjT3QToCmWXvY6+O
         HdKtkkwVHu33BDCYpLzMNgb503khuTfWetincRuD+kV1ua+zrXGwoxckHS3BYqhqZ4j4
         EFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j3dn699RDxVOZddDckqMIHg3vMsw8zCj8w/EumYHLwI=;
        b=V/griav+cFnmeDo8w+YaJSd0q8rpZZmgVAMmoiI2nqi9Qfyc+cC89p1HidVKq8He8P
         G20i+cboSLWFqzsh1ESoHSFSQUVtrherzfrM6cAa6o7SJSs9A8NCyLGHrj0cUfSlJBBG
         E/0wixwn9i0sxudP3LxMWo4v9z1QhTOXKTMzhcz0fyAjhg4u77E6W7HSSJPteRJFk5Qc
         Gsq+dhTSu3/ou86t9F0BiJ/JbRmIC1r9J3Qn5stI9zscEMulxYuygMHaK8hi0BQ4sXKp
         rwi/swT1MZSFULBb5mG4eP3Pb0ggbcSeCuoJyGjDVd8mjP3nL/Rgi1UAgZ1dFFdPdkcy
         ROOA==
X-Gm-Message-State: AE9vXwOy1RIdyiIpou4STenEyXHBdeaQWN7oQjHWlzZW9asVFUYCbF3bB/jL53EJbeMl0cZG
X-Received: by 10.98.101.1 with SMTP id z1mr8595851pfb.53.1473442613042;
        Fri, 09 Sep 2016 10:36:53 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id d5sm6759803pfc.4.2016.09.09.10.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 10:36:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 3/3] connect: advertized capability is not a ref
Date:   Fri,  9 Sep 2016 10:36:30 -0700
Message-Id: <ac55dc281e6875df8abcc6ed06d5f258a53dd251.1473441620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473441620.git.jonathantanmy@google.com>
References: <cover.1473441620.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473441620.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473441620.git.jonathantanmy@google.com>
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
but since it never did so for fetch, the client didn't need to handle this
case. Handle it.

In this aspect, JGit is compliant with the specification in pack-protocol.txt.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connect.c            | 17 +++++++++++++++++
 t/t5512-ls-remote.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/connect.c b/connect.c
index 0c01a49..cb3cd97 100644
--- a/connect.c
+++ b/connect.c
@@ -123,6 +123,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * response does not necessarily mean an ACL problem, though.
 	 */
 	int saw_response;
+	int got_dummy_ref_with_capabilities_declaration = 0;
 
 	*list = NULL;
 	for (saw_response = 0; ; saw_response = 1) {
@@ -172,8 +173,24 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
+		if (!strcmp(name, "capabilities^{}")) {
+			if (saw_response)
+				warning("protocol error: unexpected capabilities^{}, "
+					"continuing anyway");
+			if (got_dummy_ref_with_capabilities_declaration)
+				warning("protocol error: multiple capabilities^{}, "
+					"continuing anyway");
+			got_dummy_ref_with_capabilities_declaration = 1;
+			continue;
+		}
+
 		if (!check_ref(name, flags))
 			continue;
+
+		if (got_dummy_ref_with_capabilities_declaration)
+			warning("protocol error: unexpected ref after capabilities^{}, "
+				"using this ref and continuing anyway");
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

