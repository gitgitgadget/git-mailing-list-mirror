Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D26A1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750884AbeBJJ77 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 04:59:59 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:32888 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJJ76 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 04:59:58 -0500
Received: by mail-io0-f176.google.com with SMTP id n7so12443005iob.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 01:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fliu+bOa0pWvY7cZRM22NMGDFj14rl0+wG+ovoCTfNo=;
        b=nxPp0QfqUlEwDi7vnJ+7O+5foPI2lMhiIIq/NDktADn3yQWQXY1q9V7mAuySI5TyYy
         b4Uw5JmnKzMldl9hWshQCg16nKlrktSOG/IWGrJEE9k//9pXFxLnndLS6w3djxHSnnqr
         jkAzotPPUV6FfghTXLHyvFwzGgKHYOtiEw0pYkO/g9ngJLwF2haTxLD3hXdRJohDhnIZ
         S4VbgerQYUQttplhxyz2XWFqVZEj3fH4ZDu4jxTG9qLqJhlYJwmkhxT7V/AugEO/il8X
         QpODd7lo9e/dv55QFR01Z6DeoE7s4G3lepOp8HdO7D7soSCbKLHeBmX2Dm2nyq/bHN3A
         82PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fliu+bOa0pWvY7cZRM22NMGDFj14rl0+wG+ovoCTfNo=;
        b=hmV7alzkYrDY3Y7qd2BO3nwfXhK0Qs+Yio+8l/gxF1b1qPdviRiNEd619O4Pne6KVk
         mLHVun7ySV6bv87vJdedD85e62uOln7mHAfhFAPeIBgTTrNAEX11rHEp090Z87D8BnHI
         IlyAe2WxqLKb0XWuyyuOk4AeNCn8o4et7fkZ32Ow2f1t1xgtjRjCCrqVIXjL00fggZKt
         WLQdnqOKBCPSRhVztHdQnFdpi96h5TBza95mNKqQ2TPvHzGHq2D2y3SUcBhTfLJRtHVF
         XjpvrfvegYHfnySY2zXP+y7UDk0e9YurIdXPZAOIy0crCJIOywX0VERNzLrJ7at8SrlH
         Wd6g==
X-Gm-Message-State: APf1xPBG5AUsRIYB4Zvk+1jWlANxxq3qiY/B/lQR22fq5f7mkaBsqqSW
        c4QG+XIGo0hk6YtKSBeqjig=
X-Google-Smtp-Source: AH8x225mc5iHMTi4YmkrUWd3pq38bKjcRuyNwZ3c+SCBzohde86bugziwFdvpxEcuCeNw3/HFsaJNg==
X-Received: by 10.107.78.17 with SMTP id c17mr6422712iob.18.1518256797700;
        Sat, 10 Feb 2018 01:59:57 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f207sm1780902ita.26.2018.02.10.01.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Feb 2018 01:59:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 10 Feb 2018 16:59:52 +0700
Date:   Sat, 10 Feb 2018 16:59:52 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 3/3] fsck: Check HEAD of other worktrees as well
Message-ID: <20180210095952.GA9035@ash>
References: <20180209231330.4457-1-newren@gmail.com>
 <20180209231330.4457-4-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209231330.4457-4-newren@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 03:13:30PM -0800, Elijah Newren wrote:
> This takes advantage of the fact that "worktrees/$WORKTREE/HEAD" will
> currently resolve as a ref, which may not be true in the future with
> different ref backends.  I don't think it locks us in to supporting
> resolving other worktree HEADs with this syntax, as I view the
> user-visible error message as more of a pointer to a pathname that the
> user will need to fix.  If the underlying ref storage changes, naturally
> both this code and the hint may need to change to match.

I'm leaning more about something like this patch below (which does not
even build, just to demonstrate). A couple points:

- Instead of doing the hacky refs worktrees/foo/HEAD, we get the
  correct ref store for each worktree
- We have an API for getting all (non-broken) worktrees. I realize for
  fsck, we may even want to examine semi-broken worktrees as well, but
  get_worktrees() can take a flag to accomplish that if needed.
- As you can see, I print %p from the ref store instead of something
  human friendly. This is something I was stuck at last time. I need
  better ref store description (or even the worktree name)
- This ref_name() function makes me think if we should have an
  extended sha1 syntax for accessing per-worktree refs from a
  different worktree, something like HEAD@{worktree:foo} to resolve to
  worktrees/foo/HEAD. Then we have a better description here that can
  actually be used from command line, as a regular ref, if needed.

-- 8< --
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4132034170..73cfcbc07a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "worktree.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -451,17 +452,39 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int fsck_head_link(const char **head_points_at,
+static const char *ref_name(struct ref_store *refs, const char *name)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	if (!refs)
+		return name;
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s (from %p)", name, refs);
+	return sb.buf;
+}
+
+static int fsck_head_link(struct ref_store *refs,
+			  const char **head_points_at,
 			  struct object_id *head_oid);
 
 static void get_default_heads(void)
 {
 	const char *head_points_at;
 	struct object_id head_oid;
+	struct worktree **worktrees, **wt;
 
-	fsck_head_link(&head_points_at, &head_oid);
+	fsck_head_link(NULL, &head_points_at, &head_oid);
 	if (head_points_at && !is_null_oid(&head_oid))
 		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
+
+	worktrees = get_worktrees(0);
+	for (wt = worktrees; *wt; wt++) {
+		fsck_head_link(get_worktree_ref_store(*wt), &head_points_at, &head_oid);
+		if (head_points_at && !is_null_oid(&head_oid))
+			fsck_handle_ref(*wt, "HEAD", &head_oid, 0, NULL);
+	}
+	free_worktrees(wt);
+
 	for_each_rawref(fsck_handle_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
@@ -553,34 +576,36 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(struct ref_store *refs,
+			  const char **head_points_at,
 			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
-		fprintf(stderr, "Checking HEAD link\n");
+		fprintf(stderr, "Checking %s link\n", ref_name(refs, "HEAD"));
 
-	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	*head_points_at = refs_resolve_ref_unsafe(refs, "HEAD", 0, head_oid, NULL);
 	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
-		return error("Invalid HEAD");
+		return error("Invalid HEAD from ref-store %p", refs);
 	}
 	if (!strcmp(*head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
 	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
-		return error("HEAD points to something strange (%s)",
-			     *head_points_at);
+		return error("%s points to something strange (%s)",
+			     ref_name(refs, "HEAD"), *head_points_at);
 	}
 	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
-			return error("HEAD: detached HEAD points at nothing");
+			return error("%s: detached HEAD points at nothing",
+				     ref_name(refs, "HEAD"));
 		}
-		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			*head_points_at + 11);
+		fprintf(stderr, "notice: %s points to an unborn branch (%s)\n",
+			ref_name(refs, "HEAD"), *head_points_at + 11);
 	}
 	return 0;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index fa94c59458..3da651be4c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -102,7 +102,7 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	grep "HEAD points to something strange" out
 '
 
-test_expect_failure 'other worktree HEAD link pointing at a funny object' '
+test_expect_success 'other worktree HEAD link pointing at a funny object' '
 	test_when_finished "rm -rf .git/worktrees" &&
 	mkdir -p .git/worktrees/other &&
 	echo 0000000000000000000000000000000000000000 >.git/worktrees/other/HEAD &&
@@ -111,7 +111,7 @@ test_expect_failure 'other worktree HEAD link pointing at a funny object' '
 	grep "worktrees/other/HEAD: detached HEAD points" out
 '
 
-test_expect_failure 'other worktree HEAD link pointing at missing object' '
+test_expect_success 'other worktree HEAD link pointing at missing object' '
 	test_when_finished "rm -rf .git/worktrees" &&
 	mkdir -p .git/worktrees/other &&
 	echo "Contents missing from repo" | git hash-object --stdin >.git/worktrees/other/HEAD &&
@@ -120,7 +120,7 @@ test_expect_failure 'other worktree HEAD link pointing at missing object' '
 	grep "worktrees/other/HEAD: invalid sha1 pointer" out
 '
 
-test_expect_failure 'other worktree HEAD link pointing at a funny place' '
+test_expect_success 'other worktree HEAD link pointing at a funny place' '
 	test_when_finished "rm -rf .git/worktrees" &&
 	mkdir -p .git/worktrees/other &&
 	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&


-- 8< --
