Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA5C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDKRIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDKRIn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:08:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9860F1991
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:08:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l26-20020a05600c1d1a00b003edd24054e0so6455688wms.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMRF5FXAcb0qKIrj2PtXi84jbfg9l6ogWW6e+LIfETE=;
        b=QwKE/gprCNeAWqjwc16h4Jb9IplniXH8a3XIG5XULuJ6hgckwCVsVtZzJgxA0wwdLW
         ONCwfjt0FAsZLXfJ93E1CKo2s6F9MS1tBGvfIAhVll8UuzR3heh0FMo488abiYEvWniU
         wBV6CmbHI8TOQmqQX+Ivv6+6Jq92vQqF9VpbCXzZkuMVThih+0hOfCxbocMCDmrSPoy3
         fLB84ey2vO+0HrPdeKxstN746i0oTm40hlcUcGVjCeSDEEqG5j9ZsvbO1x96+OwS+JP2
         t/shl9eGydvpBl9zgrdvqgiF5IXlxWSkZM8Y7cMzAX2OnhJNo0fj5ArQWCfGdcvN5rT0
         ZL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMRF5FXAcb0qKIrj2PtXi84jbfg9l6ogWW6e+LIfETE=;
        b=ymwln9HUYBf2mYyzUDNgZd+XoniwjqopPJAMThFbqzn3rAKNQ4JceXYNh7Fiu8XDUO
         LmtcPvHxBYbrkKoAwuVba9o3slgCMWvs/D19q1RGjIWOY0IBrjwk/XWlujJMoiPr9OT/
         ogVqEP26mPfVkU9lKHN/cxPbhdM1KrZGWSeRKgBoqdsCpV9zZezn4ST4Svkti3Mm+eiE
         1u7Ia0gNJGk+Mr90jaNL57lazmq2MGLTjEYJn7NtKOg2XexFEYDFEXq1erzP+o6h9Nr2
         zgKMTbxpjmn8+mqKLk8Yr1rdipvC61nAbr8oBR14k027BNj46J8YLGThBETXnhscTU0w
         n0CQ==
X-Gm-Message-State: AAQBX9fh1s3RojyOWsW30GWqW+1TxrSiV9gKS97ZgnRaBiXbUU8UAYXQ
        3tOxMkRlQNf5iQOAjD+o5ryWQ00jdAA=
X-Google-Smtp-Source: AKy350aI17fxacaJ5A0HHl3SKNxWGbdB1WvNvelwAa36PC6xtZo4AHovu5U1Jicklsji5PrxO6qVFw==
X-Received: by 2002:a7b:ce97:0:b0:3eb:399f:6b70 with SMTP id q23-20020a7bce97000000b003eb399f6b70mr7634846wmj.31.1681232919698;
        Tue, 11 Apr 2023 10:08:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bc5c6000000b003f072b22dbbsm16622629wmk.16.2023.04.11.10.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:08:39 -0700 (PDT)
Message-Id: <pull.1488.v3.git.git.1681232918484.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
References: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 17:08:38 +0000
Subject: [PATCH v3] clone: error specifically with --local and symlinked
 objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

6f054f9fb3 (builtin/clone.c: disallow --local clones with
symlinks, 2022-07-28) gives a good error message when "git clone
--local" fails when the repo to clone has symlinks in
"$GIT_DIR/objects". In bffc762f87 (dir-iterator: prevent top-level
symlinks without FOLLOW_SYMLINKS, 2023-01-24), we later extended this
restriction to the case where "$GIT_DIR/objects" is itself a symlink,
but we didn't update the error message then - bffc762f87's tests show
that we print a generic "failed to start iterator over" message.

This is exacerbated by the fact that Documentation/git-clone.txt
mentions neither restriction, so users are left wondering if this is
intentional behavior or not.

Fix this by adding a check to builtin/clone.c: when doing a local clone,
perform an extra check to see if "$GIT_DIR/objects" is a symlink, and if
so, assume that that was the reason for the failure and report the
relevant information. Ideally, dir_iterator_begin() would tell us that
the real failure reason is the presence of the symlink, but (as far as I
can tell) there isn't an appropriate errno value for that.

Also, update Documentation/git-clone.txt to reflect that this
restriction exists.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    clone: error specifically with --local and symlinked objects
    
    A quick reroll to fix the style issue Taylor spotted in v2 (good
    catch!). I didn't spot this patch in 'next' or 'seen', so hopefully I'm
    still in time :)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1488%2Fchooglen%2Fpush-nymnqqnttzxz-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1488/chooglen/push-nymnqqnttzxz-v3
Pull-Request: https://github.com/git/git/pull/1488

Range-diff vs v2:

 1:  574cea062cf ! 1:  4c5fc42594b clone: error specifically with --local and symlinked objects
     @@ builtin/clone.c: static void copy_or_link_directory(struct strbuf *src, struct s
      +		if (errno == ENOTDIR) {
      +			int saved_errno = errno;
      +			struct stat st;
     -+			if (lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))
     ++			if (!lstat(src->buf, &st) && S_ISLNK(st.st_mode))
      +				die(_("'%s' is a symlink, refusing to clone with --local"),
      +				    src->buf);
      +			errno = saved_errno;


 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 11 ++++++++++-
 t/t5604-clone-reference.sh  |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d6434d262d6..c37c4a37f74 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -58,6 +58,11 @@ never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
 Git transport instead.
 +
+If the repository's `$GIT_DIR/objects` has symbolic links or is a
+symbolic link, the clone will fail. This is a security measure to
+prevent the unintentional copying of files by dereferencing the symbolic
+links.
++
 *NOTE*: this operation can race with concurrent modification to the
 source repository, similar to running `cp -r src dst` while modifying
 `src`.
diff --git a/builtin/clone.c b/builtin/clone.c
index 462c286274c..dd2b4e130e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -327,8 +327,17 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 	iter = dir_iterator_begin(src->buf, DIR_ITERATOR_PEDANTIC);
 
-	if (!iter)
+	if (!iter) {
+		if (errno == ENOTDIR) {
+			int saved_errno = errno;
+			struct stat st;
+			if (!lstat(src->buf, &st) && S_ISLNK(st.st_mode))
+				die(_("'%s' is a symlink, refusing to clone with --local"),
+				    src->buf);
+			errno = saved_errno;
+		}
 		die_errno(_("failed to start iterator over '%s'"), src->buf);
+	}
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 83e3c97861d..9845fc04d59 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -358,7 +358,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked objects directory' '
 	test_must_fail git clone --local malicious clone 2>err &&
 
 	test_path_is_missing clone &&
-	grep "failed to start iterator over" err
+	grep "is a symlink, refusing to clone with --local" err
 '
 
 test_done

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
