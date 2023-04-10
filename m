Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CFFC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDJWS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJWSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:18:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C9E53
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:18:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so11238846wmb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681165132;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yREQqfk5xfKqm3sHLjwtup7wktG27G6COK04tmVaw94=;
        b=LWwdMScq5nd92NY4o1c56wlgRtu1zydlVkKGZKNVj6Ov64DVwJ5OmALcgM0RHt1Ad9
         mm4GqdETjXJE1+oziBln9fA5KHHRrWJCf6+Tpcq2hf/+vEqqf9iPntBRxEWDJ/LTXZsq
         F96xXFCiAajfOUzbdrErfGvAL/nQ+3Dor292vRNLA9rnOxQaOto/CGNsfTnG4D/OIcJL
         udRAoCxtaTZoe1EWr8cY1MSPvDXlOYskjuPQ2BPOicetCwi8cDF719NY959qeb0l7sgz
         5MEvuDQRNifvK5CHJ0/5pzZ9s+JxXX1I2aLnIJzXd9dJKEKBXYQ1V3iFVRHz0zkJUbS7
         c8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165132;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yREQqfk5xfKqm3sHLjwtup7wktG27G6COK04tmVaw94=;
        b=m67J5kddmt0+/RJn/38gl09vjBNLlf5uELrdQ+DBDuFR1qITWYl+vKcPOGnJjt7+5E
         hL9m2wpYRjTE6wbFqHWkGKGK2HRa2HeSE/UAJidCXJ6bvhK1WAs+SxOyORM2y75pqiDR
         b0YNGw3ItCTOuGaNaCDpWmWEoovxmnMCvFOzRaREWKYKMoVUpm2INTV1tuHy9qlVtU0Z
         WqSEBqncu7BzQvqBHXQ5lmZaFM/B1+kiQPmxDF04s9lF0ZyI4LIycCcWHevcdeocxQzL
         yKWX9N2cumLuWzQeHxWAEuX/kpTAddvmCX6NNtsvzJLe0n5RW+x07z7xCeC7pEbTKoTH
         1zdg==
X-Gm-Message-State: AAQBX9fOnnbeG7JktRGi/WnuolZ6Ezo7aE4OzX0ci1ydWNpPh/Fjlhrd
        5FsSOSgw9EgdqmpEWm929ENKYVpQry0=
X-Google-Smtp-Source: AKy350ZqmsOJf2qq9vbUqRwISkEwXiw+NjNbQ7mqfykvGShPmzQx/xMU6r8lx2HPJyGOQV3YBIdtfA==
X-Received: by 2002:a05:600c:2057:b0:3ee:1bd5:de41 with SMTP id p23-20020a05600c205700b003ee1bd5de41mr8488977wmg.13.1681165131966;
        Mon, 10 Apr 2023 15:18:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm18951269wmo.44.2023.04.10.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:18:51 -0700 (PDT)
Message-Id: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 22:18:50 +0000
Subject: [PATCH v2] clone: error specifically with --local and symlinked
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
    
    Thanks for the close review on v1, folks.
    
    I tried teaching dir_iterator_begin() to return an exit code to indicate
    that we found a symlink, but it ended up looking quite ugly when I
    started to consider plain files as well as generic lstat failures. I
    think the extra lstat() is fine as a one-off, but if we need another
    instance of this, we'd be better off doing the refactor.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1488%2Fchooglen%2Fpush-nymnqqnttzxz-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1488/chooglen/push-nymnqqnttzxz-v2
Pull-Request: https://github.com/git/git/pull/1488

Range-diff vs v1:

 1:  5c2d5eb10cd ! 1:  574cea062cf clone: error specifically with --local and symlinked objects
     @@ builtin/clone.c: static void copy_or_link_directory(struct strbuf *src, struct s
       
      -	if (!iter)
      +	if (!iter) {
     -+		struct stat st;
     -+		if (lstat(src->buf, &st) >= 0 && S_ISLNK(st.st_mode))
     -+			die(_("'%s' is a symlink, refusing to clone with --local"),
     -+			    src->buf);
     ++		if (errno == ENOTDIR) {
     ++			int saved_errno = errno;
     ++			struct stat st;
     ++			if (lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))
     ++				die(_("'%s' is a symlink, refusing to clone with --local"),
     ++				    src->buf);
     ++			errno = saved_errno;
     ++		}
       		die_errno(_("failed to start iterator over '%s'"), src->buf);
      +	}
       


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
index 462c286274c..46f6f689c85 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -327,8 +327,17 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 	iter = dir_iterator_begin(src->buf, DIR_ITERATOR_PEDANTIC);
 
-	if (!iter)
+	if (!iter) {
+		if (errno == ENOTDIR) {
+			int saved_errno = errno;
+			struct stat st;
+			if (lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))
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
