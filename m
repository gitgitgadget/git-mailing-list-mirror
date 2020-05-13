Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C252C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E7020769
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlWFhziu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgEMAlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 20:41:03 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE1C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 17:41:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l17so9411847qvm.12
        for <git@vger.kernel.org>; Tue, 12 May 2020 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5WoW7+77jREDM2DKJXwaN1JSQIBSiiWfXheTnfmx8js=;
        b=vlWFhziu5qL2RlyUSxSkBJlg53Bu01JXN5zHlQ8glT4kOJTLDRDb0Qsb7WhsixZ+bE
         AEoY8hn7SdfhKXJhSprNUw0l5+j/f83qN8RlQgKpVlFDW07lu82UGEeUlWbTHIkzgNyl
         8GpMgiy0nB+YccHCwuhI6fV8RQPfv00h9IfR1bZwoLm/z02HWXRi1t6qDH1GpOAfcuTF
         S/+FCu5QFr0aoVzU0BYm7Qn0dpgdlzRJnJoHP7C6IWG66EzpB6JIqMaY+1ulGOcdgwtp
         W3KZBhgrVPMJNIttlqQH0Mhb5SSiwBN1feOMTSpaCPPxdL5bVEIKmTz/pzxyfoeuMJbd
         V36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5WoW7+77jREDM2DKJXwaN1JSQIBSiiWfXheTnfmx8js=;
        b=fNrCTE8OaLUgVzjd+RiY/q+6FoxVRj2Oq/K3THyZ30Igs89gljGZb8DFig9anGfeRi
         14W+a7bh7wr40NErJv60t7LZdI1sQsPU66bGAW9dlf3EFDFxvUR41jNWAte1Lpgmf6qZ
         xzI6P+hxhTEjumnObV3/i3BCEnZEbU/rsuiyk+LAClAEJ+R1+3NL387iAVrAgaa1j/kg
         ubcc8/KOOHtgmdE9901SRIQyvgsrGjb5o1Xw5SGGNnPl5GK5lrbShZyKdhxC6+aUABup
         Q/M2n6B9jIkAWVX47KdoSY941ycoINczi8hC7Ve+GUft3fPZiJPXarcBvSpoA5U5oz4D
         bo8Q==
X-Gm-Message-State: AGi0Pub8P3VThgpHvk3mND/3KitH0E0MMYvU9oOl768zdcmys4Ssnti/
        qa8Y/gwuEJ4IllhaNfOakqQ65ayiQ3yApbjFWhm5UqbqWE0smDB9ifLC+Dy26NlI+9H7a+HhNg+
        ZshYC0nn2GQLR6EmhAkcKNalJZ+utc36tv6cAt9ISCIYSpPyUcK1lK8+CPLAPGpTGlQGDMnPR7d
        k8
X-Google-Smtp-Source: APiQypINHtVTMRd8xfERIwWcPZHgrbpm14HJucvauwWYsPHmUpbGNaCwrjE8Hqi+tRNhfyjH6LfcZG2gdprMpGeN6wYB
X-Received: by 2002:a0c:f8c4:: with SMTP id h4mr23790274qvo.15.1589330462594;
 Tue, 12 May 2020 17:41:02 -0700 (PDT)
Date:   Tue, 12 May 2020 17:40:58 -0700
Message-Id: <20200513004058.34456-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] wt-status: expand, not dwim, a "detached from" ref
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user checks out the upstream branch of HEAD and then runs "git
branch", like this:

  git checkout @{u}
  git branch

an error message is printed:

  fatal: HEAD does not point to a branch

(This error message when running "git branch" persists even after
checking out other things - it only stops after checking out a branch.)

This is because "git branch" attempts to DWIM "@{u}" when determining
the "HEAD detached" message, but that doesn't work because HEAD no
longer points to a branch.

Therefore, when calculating the status of a worktree, only expand such a
string, not DWIM it. Such strings would not match a ref, and "git
branch" would report "HEAD detached at <hash>" instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I tried to track down other uses of wt_status_get_detached_from()
(called from wt_status_get_state() with get_detached_from=1) but there
seemed to be quite a few, so I stopped.

One alternative is to plumb down a flag from dwim_ref() to
interpret_branch_mark() that indicates that (1) don't read HEAD when
processing, and (2) when encountering a ref of the form "<optional
ref>@{u}", don't die when the optional ref doesn't exist, is not a
branch, or does not have an upstream. (We cannot change the
functionality outright because other parts of Git rely on such a message
being printed.) But this seems too complicated just for diagnosis.
---
 t/t3203-branch-output.sh | 10 ++++++++++
 wt-status.c              |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 71818b90f0..c5d3d739e5 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -209,6 +209,16 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch shows detached HEAD properly after checking out upstream branch' '
+	git init upstream &&
+	test_commit -C upstream foo &&
+
+	git clone upstream downstream &&
+	git -C downstream checkout @{u} &&
+	git -C downstream branch >actual &&
+	test_i18ngrep "HEAD detached at [0-9a-f]\\+" actual
+'
+
 test_expect_success 'git branch `--sort` option' '
 	cat >expect <<-\EOF &&
 	* (HEAD detached from fromtag)
diff --git a/wt-status.c b/wt-status.c
index 98dfa6f73f..f84ebc3e2c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1562,7 +1562,7 @@ static void wt_status_get_detached_from(struct repository *r,
 		return;
 	}
 
-	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
+	if (expand_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
 	    /* sha1 is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-- 
2.26.2.645.ge9eca65c58-goog

