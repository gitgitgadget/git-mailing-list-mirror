Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FFC32771
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 01:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603F22522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 01:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGWSHSPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAUBiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:38:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43894 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUBiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 20:38:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so1422456wre.10
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 17:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7G60dvA/dLKmu1OozAP+gBQbmH6L9v3tdK6kxuUdY80=;
        b=UGWSHSPXGC6+simIEMjpe18cChOXihLSnxl8s0awPJju3eTUe6Zut1L9189GJtJRKj
         Cjon23tve8xoCeRDv1UZqCBSjLWGd0xgqBLck7cDQiKDdsTwG5vMeaJ2sF+9XMvRJ047
         R8QyNesKyJ5GwDUmf3hI7Nq+Q9wp8Fh5EBoEbthCb4IVHnEa9RkG85dexViZPuSXKKIp
         rfR43zTsjkGgwZkAibl1zJJwr1tGkS+xazF5gXfqDjcVZcUVpVUgRrb+i03DvmlnrIwR
         IrYikw3AYXqpQT00x2hD7eyxclKy8efYj1odCzcNxv085pjs4aLDh/rUMqZs6ouuDGFg
         xHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7G60dvA/dLKmu1OozAP+gBQbmH6L9v3tdK6kxuUdY80=;
        b=ImTCdvp1Yay+MDZLebE6M39aBuiARZ8SHA1ydBj89DUlT9FLgxwiIYPG5WzDO8Fdjj
         RiLAZ3JoVUF7/iW4Ywan4vCboH7pRaQA5KQV73APi8rezuZ42/u6Bg5NjYCpOPfGxaQC
         z2S560V1/n3HCTLCYRemwSqMbP3U6k642ZxGYvdcptkbBcXy0LqIDxsTdXwYbV0YQTCt
         in4/2FVVpoivUyJmQ8bvox/WBm1GVDU1vrQL30lHiRSQvmDJMLXlcSa9sdwLS0MPsWyO
         LFztFfE62x3kZxlxNocE08xB+nnaq3xpxXVpJ91K12pkOfE1mDg8NvQcW1RnjvtvBj+J
         aBYQ==
X-Gm-Message-State: APjAAAXcYHuGnRP6Ev93GXffwI3imzW71XaDecCA3v7rTlVX9KrtpISX
        7A4tBg9BxNwik4sOUS8fX1xCaOo2
X-Google-Smtp-Source: APXvYqzS791/7fb5tG9UQGQAlG7duT8CW0IjqIXjQmGYxMNMvIkiiIu307srb92hmaQ7HkWUy2fX/A==
X-Received: by 2002:adf:b193:: with SMTP id q19mr2276936wra.78.1579570694187;
        Mon, 20 Jan 2020 17:38:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm50915895wrt.37.2020.01.20.17.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 17:38:13 -0800 (PST)
Message-Id: <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
In-Reply-To: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 01:38:12 +0000
Subject: [PATCH v2] fetch: document and test --refmap=""
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To prevent long blocking time during a 'git fetch' call, a user
may want to set up a schedule for background 'git fetch' processes.
However, these runs will update the refs/remotes branches due to
the default refspec set in the config when Git adds a remote.
Hence the user will not notice when remote refs are updated during
their foreground fetches. In fact, they may _want_ those refs to
stay put so they can work with the refs from their last foreground
fetch call.

This can be accomplished by overriding the configured refspec using
'--refmap=' along with a custom refspec:

  git fetch <remote> --refmap= +refs/heads/*:refs/hidden/<remote>/*

to populate a custom ref space and download a pack of the new
reachable objects. This kind of call allows a few things to happen:

1. We download a new pack if refs have updated.
2. Since the refs/hidden branches exist, GC will not remove the
   newly-downloaded data.
3. With fetch.writeCommitGraph enabled, the refs/hidden refs are
   used to update the commit-graph file.

To avoid the refs/hidden directory from filling without bound, the
--prune option can be included. When providing a refspec like this,
the --prune option does not delete remote refs and instead only
deletes refs in the target refspace.

Update the documentation to clarify how '--refmap=""' works and
create tests to guarantee this behavior remains in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    fetch: document and test '--refmap=""'
    
    Thanks for all the feedback leading to absolutely no code change. It's
    good we already have the flexibility for this. I'm a bit embarrassed
    that I did not discover this, so perhaps this doc change and new tests
    will help clarify the behavior.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-532%2Fderrickstolee%2Ffetch-no-update-remote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-532/derrickstolee/fetch-no-update-remote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/532

Range-diff vs v1:

 1:  26f13ea5f5 ! 1:  51c6221a31 fetch: add --no-update-remote-refs
     @@ -1,20 +1,20 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    fetch: add --no-update-remote-refs
     +    fetch: document and test --refmap=""
      
          To prevent long blocking time during a 'git fetch' call, a user
          may want to set up a schedule for background 'git fetch' processes.
     -    However, these runs will update the refs/remotes branches, and
     -    hence the user will not notice when remote refs are updated during
     +    However, these runs will update the refs/remotes branches due to
     +    the default refspec set in the config when Git adds a remote.
     +    Hence the user will not notice when remote refs are updated during
          their foreground fetches. In fact, they may _want_ those refs to
          stay put so they can work with the refs from their last foreground
          fetch call.
      
     -    Add a --[no-]update-remote-refs option to 'git fetch' which defaults
     -    to the existing behavior of updating the remote refs. This allows
     -    a user to run
     +    This can be accomplished by overriding the configured refspec using
     +    '--refmap=' along with a custom refspec:
      
     -      git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*
     +      git fetch <remote> --refmap= +refs/heads/*:refs/hidden/<remote>/*
      
          to populate a custom ref space and download a pack of the new
          reachable objects. This kind of call allows a few things to happen:
     @@ -30,9 +30,8 @@
          the --prune option does not delete remote refs and instead only
          deletes refs in the target refspace.
      
     -    Note: with the default refpsec, the --prune option will override
     -    the --no-update-remote-refs option and will delete the refs that
     -    do not exist on the remote.
     +    Update the documentation to clarify how '--refmap=""' works and
     +    create tests to guarantee this behavior remains in the future.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -40,50 +39,17 @@
       --- a/Documentation/fetch-options.txt
       +++ b/Documentation/fetch-options.txt
      @@
     - 	'git-pull' the --ff-only option will still check for forced updates
     - 	before attempting a fast-forward update. See linkgit:git-config[1].
     + 	specified refspec (can be given more than once) to map the
     + 	refs to remote-tracking branches, instead of the values of
     + 	`remote.*.fetch` configuration variables for the remote
     +-	repository.  See section on "Configured Remote-tracking
     ++	repository.  Providing an empty `<refspec>` to the
     ++	`--refmap` option causes Git to ignore the configured
     ++	refspecs and rely entirely on the refspecs supplied as
     ++	command-line arguments. See section on "Configured Remote-tracking
     + 	Branches" for details.
       
     -+--no-update-remote-refs::
     -+	By default, git updates the `refs/remotes/` refspace with the refs
     -+	advertised by the remotes during a `git fetch` command. With this
     -+	option, those refs will be ignored. If the `--prune` option is
     -+	specified and the default refpsec is used, then a ref that does not
     -+	appear in the remote will still be deleted from refs/remotes.
     -+
     - -4::
     - --ipv4::
     - 	Use IPv4 addresses only, ignoring IPv6 addresses.
     -
     - diff --git a/builtin/fetch.c b/builtin/fetch.c
     - --- a/builtin/fetch.c
     - +++ b/builtin/fetch.c
     -@@
     - static struct string_list server_options = STRING_LIST_INIT_DUP;
     - static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
     - static int fetch_write_commit_graph = -1;
     -+static int update_remote_refs = 1;
     - 
     - static int git_fetch_config(const char *k, const char *v, void *cb)
     - {
     -@@
     - 		 N_("check for forced-updates on all updated branches")),
     - 	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
     - 		 N_("write the commit-graph after fetching")),
     -+	OPT_BOOL(0, "update-remote-refs", &update_remote_refs,
     -+		 N_("update the refs/remotes/ refspace")),
     - 	OPT_END()
     - };
     - 
     -@@
     - 	const char *pretty_ref = prettify_refname(ref->name);
     - 	int fast_forward = 0;
     - 
     -+	if (!update_remote_refs && starts_with(ref->name, "refs/remotes/"))
     -+		return 0;
     -+
     - 	type = oid_object_info(the_repository, &ref->new_oid, NULL);
     - 	if (type < 0)
     - 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
     + -t::
      
       diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
       --- a/t/t5510-fetch.sh
     @@ -92,13 +58,13 @@
       	git rev-parse sometag
       '
       
     -+test_expect_success 'fetch --no-update-remote-refs keeps existing refs' '
     ++test_expect_success '--refmap="" ignores configured refspec' '
      +	cd "$TRASH_DIRECTORY" &&
      +	git clone "$D" remote-refs &&
      +	git -C remote-refs rev-parse remotes/origin/master >old &&
      +	git -C remote-refs update-ref refs/remotes/origin/master master~1 &&
      +	git -C remote-refs rev-parse remotes/origin/master >new &&
     -+	git -C remote-refs fetch --no-update-remote-refs origin &&
     ++	git -C remote-refs fetch --refmap= origin "+refs/heads/*:refs/hidden/origin/*" &&
      +	git -C remote-refs rev-parse remotes/origin/master >actual &&
      +	test_cmp new actual &&
      +	git -C remote-refs fetch origin &&
     @@ -106,13 +72,13 @@
      +	test_cmp old actual
      +'
      +
     -+test_expect_success 'fetch --no-update-remote-refs --prune with refspec' '
     ++test_expect_success '--refmap="" and --prune' '
      +	git -C remote-refs update-ref refs/remotes/origin/foo/otherbranch master &&
      +	git -C remote-refs update-ref refs/hidden/foo/otherbranch master &&
     -+	git -C remote-refs fetch --prune --no-update-remote-refs origin +refs/heads/*:refs/hidden/* &&
     ++	git -C remote-refs fetch --prune --refmap="" origin +refs/heads/*:refs/hidden/* &&
      +	git -C remote-refs rev-parse remotes/origin/foo/otherbranch &&
      +	test_must_fail git -C remote-refs rev-parse refs/hidden/foo/otherbranch &&
     -+	git -C remote-refs fetch --prune --no-update-remote-refs origin &&
     ++	git -C remote-refs fetch --prune origin &&
      +	test_must_fail git -C remote-refs rev-parse remotes/origin/foo/otherbranch
      +'
      +


 Documentation/fetch-options.txt |  5 ++++-
 t/t5510-fetch.sh                | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a2f78624a2..a115a1ae0e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -139,7 +139,10 @@ ifndef::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.*.fetch` configuration variables for the remote
-	repository.  See section on "Configured Remote-tracking
+	repository.  Providing an empty `<refspec>` to the
+	`--refmap` option causes Git to ignore the configured
+	refspecs and rely entirely on the refspecs supplied as
+	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 
 -t::
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b60282689..5f8f1c287f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -174,6 +174,30 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git rev-parse sometag
 '
 
+test_expect_success '--refmap="" ignores configured refspec' '
+	cd "$TRASH_DIRECTORY" &&
+	git clone "$D" remote-refs &&
+	git -C remote-refs rev-parse remotes/origin/master >old &&
+	git -C remote-refs update-ref refs/remotes/origin/master master~1 &&
+	git -C remote-refs rev-parse remotes/origin/master >new &&
+	git -C remote-refs fetch --refmap= origin "+refs/heads/*:refs/hidden/origin/*" &&
+	git -C remote-refs rev-parse remotes/origin/master >actual &&
+	test_cmp new actual &&
+	git -C remote-refs fetch origin &&
+	git -C remote-refs rev-parse remotes/origin/master >actual &&
+	test_cmp old actual
+'
+
+test_expect_success '--refmap="" and --prune' '
+	git -C remote-refs update-ref refs/remotes/origin/foo/otherbranch master &&
+	git -C remote-refs update-ref refs/hidden/foo/otherbranch master &&
+	git -C remote-refs fetch --prune --refmap="" origin +refs/heads/*:refs/hidden/* &&
+	git -C remote-refs rev-parse remotes/origin/foo/otherbranch &&
+	test_must_fail git -C remote-refs rev-parse refs/hidden/foo/otherbranch &&
+	git -C remote-refs fetch --prune origin &&
+	test_must_fail git -C remote-refs rev-parse remotes/origin/foo/otherbranch
+'
+
 test_expect_success 'fetch tags when there is no tags' '
 
     cd "$D" &&

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
