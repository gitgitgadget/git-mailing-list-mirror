Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1325F1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 17:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbcIBRPy (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 13:15:54 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36243 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbcIBRPs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 13:15:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id h186so44146057pfg.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=j7225IXHTdcQAYiW+O3JJ9YcV/lOMVaFvbIavccwLak=;
        b=WDONvEBL9/8ui2SfKrBf9ZbsPI9IJDL7Lf8EVdidx5WDFN0wU5Txk8GN5BkNqhtu7l
         FqVjbxuWAPCgYk5aBF8G0cg56jyry+POVGSToHVo85P/qHvyTJOSZkgHqxe3KD8XRTzb
         e1uo+HThrNLTcd3a9tururyCK5yZ7uF69y77XuxPGWYdUMDY0YxEqmyytY3LQKGgE+8k
         O1sXFTPllnP3bvXGnbzNG8lHdr3O46iYZD1+ZTzrYC3bfeDUGXoCfTK96Yf+Y9PIxIVP
         pILaZ0HPJFGrJ/8uPdO4VctAwBPsLNr96xo4KGLU4IVlWH1Ml02dH4iAzNSPi6+CPSOO
         YVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j7225IXHTdcQAYiW+O3JJ9YcV/lOMVaFvbIavccwLak=;
        b=ClslaxvgUQymy2RKb0ZoeFEIpN14GbxVRfv1FVtbK8F3KGGC/go9t8WRYnmuZtucFL
         vnT7n/gFOqyrQSKVrsnNGaJCu8I/S0G4DME8QlDtEzx4RlStv6IQKtwtKKPasrqVjLNF
         Wyo8SpQzxK06a+0cZdGF6EFVeY4HIZ3Zwz8Ok2ATIjsIEGQhrFI1jQbGZs/AEF+YNu+l
         QeoSiHwv2RsvL65LVU84T4ia4a+8iTlCGY2c2rTgk7wXA0BGT+jDPzZ/Y0q7cYBRR2CR
         ppkXQvyDEbdOuNIgn6nl6w+HomKXx7qcNYuvDlnZPOHIVpyF+nrl4B7xYYsJczKXL8Uv
         6nZQ==
X-Gm-Message-State: AE9vXwPCro8EfdJF327DPiuWf6PL0rZq0vMucaL0juy9YRwqxoV4qCrZnGOyNGuBTXQGhaG4
X-Received: by 10.98.194.82 with SMTP id l79mr13523276pfg.113.1472836547151;
        Fri, 02 Sep 2016 10:15:47 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v16sm13914710pfd.32.2016.09.02.10.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 10:15:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] connect: know that zero-ID is not a ref
Date:   Fri,  2 Sep 2016 10:15:39 -0700
Message-Id: <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

connect.c, when processing packfiles, treats a zero ID (with
`capabilities^{}` in place of the refname) as an actual ref instead of a
placeholder for a capability declaration, contrary to the specification
in Reference Discovery in Documentation/technical/pack-protocol.txt.
This is an issue when interacting with Git implementations that follow
this specification. For example, `ls-remote` (against a git://
repository served by such a Git implementation) will report a ref when
there are none, and `clone` (against something similar) will fail its
checkout.

Make connect.c follow the specification with respect to this, while
maintaining compatibility with existing implementations that do not
serve the zero ID when a repository has no refs.

(git-daemon should probably also be changed to serve zero IDs, but such
a change can be considered independently from this change; even if both
the client and server changes were made in one commit, it is nearly
impossible that all Git installations are updated at the same time - an
updated client would still need to deal with unupdated servers and vice
versa.)

The test uses JGit's daemon feature, which is specification-compliant.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connect.c            |  7 +++++++
 t/t5512-ls-remote.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/connect.c b/connect.c
index 722dc3f..d4a58de 100644
--- a/connect.c
+++ b/connect.c
@@ -165,6 +165,13 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
+		if (is_null_oid(&old_oid)) {
+			if (strcmp(name, "capabilities^{}"))
+				warning("zero object ID received that is not accompanied by a "
+				        "capability declaration, ignoring and continuing anyway");
+			continue;
+		}
+
 		if (!check_ref(name, flags))
 			continue;
 		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 819b9dd..c6f8b6f 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -207,5 +207,27 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	test_cmp expect actual
 '
 
+test_lazy_prereq GIT_DAEMON '
+	test_have_prereq JGIT &&
+	test_tristate GIT_TEST_GIT_DAEMON &&
+	test "$GIT_TEST_GIT_DAEMON" != false
+'
+
+JGIT_DAEMON_PORT=${JGIT_DAEMON_PORT-${this_test#t}}
+
+# This test spawns a daemon, so run it only if the user would be OK with
+# testing with git-daemon.
+test_expect_success JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
+	JGIT_DAEMON_PID= &&
+	git init --bare empty.git &&
+	touch empty.git/git-daemon-export-ok &&
+	{
+		jgit daemon --port="$JGIT_DAEMON_PORT" . &
+		JGIT_DAEMON_PID=$!
+	} &&
+	test_when_finished kill "$JGIT_DAEMON_PID" &&
+	sleep 1 && # allow jgit daemon some time to set up
+	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+'
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

