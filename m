Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4068C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8E02083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDaYrmTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAQP3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:29:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQP3D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:29:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so23077470wrj.12
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 07:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VS9Z32ehNKu8/LZodzMatvtorWuQJns5GuDVT0jPnII=;
        b=cDaYrmTyl4CraGRm6hRspitW0+fqyJ7WkUM3ZHyssJC3V6SNrHWATFm2WpPrA9cKyG
         rkZDMsxLYokNO6QjLQ6WW5ZNG/XqicLbVW/iOiikne7DxMbL3rF3ipxEDnJ8q/D2hK2c
         QwFB5oIUFIhLVUIVApxwSBPkj80nbXOV6TU5yWWM6rRGRIpEj+phUn00UHJh0PTz0TvW
         +6K4IAbE4vMMfDz2pOo07CAwExIaXG+Gr6NL9jYfZp4LX9zaWbOkX7kuHAY1zwFdtXv8
         TFMcvPTNcGnXAVXxv8OWGeB66fxgPs98xdgR/H9CnOkg8vGCF/ifvGzQxZJy5+FABIUd
         WjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VS9Z32ehNKu8/LZodzMatvtorWuQJns5GuDVT0jPnII=;
        b=JGgkTVJjUEzNhOwkxsyNPTOAvYd/grGSCjXduV4iRI11vtrZmHThL/8zgWcJuNI1/W
         vL3G44TjSQvcT/f/VRKbc9b25LINQAP4/GzZb78E1N2nEVC+LbEzdMHNqUeHQjkouXf1
         6WL5wCXS0gNsfP/mRdNs0bNeEwEq+x4Dc7NfqiKdNFhvcMPpHwFcbDHxHS9oNYX5yZU9
         JkR24yWGf9pIi5ZACVBO8DKBxxqr4M05L8UJn4DTxc0ECVkcG13ZjpkkqV3wscZwRJF+
         xX/i+KoP7L5pnSQvhQpUHwWyEjj8cCfGpFAu3TKjs9JhMuPOw4JdAjHyShGeGQvJZPv0
         SkHw==
X-Gm-Message-State: APjAAAU8aTTs2c/bbDZRnSSnsco1ZOFHyL85QmrddKCXcl0qkdT6TW8K
        Uh91VYe8kKryKS7PWo35ghWyWh8j
X-Google-Smtp-Source: APXvYqySsDJX8PSqEfypdMIr04BG7c5DXQftbOGX5QKyFJSGEfU0npEcqhD2+qBkCiNLISmZI2kx2g==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr3766898wru.350.1579274940382;
        Fri, 17 Jan 2020 07:29:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm34567731wrh.5.2020.01.17.07.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:28:59 -0800 (PST)
Message-Id: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 15:28:59 +0000
Subject: [PATCH] fetch: add --no-update-remote-refs
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
However, these runs will update the refs/remotes branches, and
hence the user will not notice when remote refs are updated during
their foreground fetches. In fact, they may _want_ those refs to
stay put so they can work with the refs from their last foreground
fetch call.

Add a --[no-]update-remote-refs option to 'git fetch' which defaults
to the existing behavior of updating the remote refs. This allows
a user to run

  git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*

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

Note: with the default refpsec, the --prune option will override
the --no-update-remote-refs option and will delete the refs that
do not exist on the remote.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    fetch: add --no-update-remote-refs
    
    Here is a new feature for git fetch that hopefully is useful to some
    users. We've been using a patch like this in microsoft/git for about a
    month now, and I've been testing it locally using the custom refspec
    mentioned in the commit message. It's quite refreshing to run git fetch
    --all in my Git repo and see all the branch updates but not actually
    wait for any pack downloads.
    
    There is one question about how --prune and --no-update-remote-refs 
    should interact. Since --prune is not the default, and it works the way
    I'd like with a non-default refspec, I'm currently proposing allowing it
    to delete remote refs even if --no-update-remote-refs is provided.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-532%2Fderrickstolee%2Ffetch-no-update-remote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-532/derrickstolee/fetch-no-update-remote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/532

 Documentation/fetch-options.txt |  7 +++++++
 builtin/fetch.c                 |  6 ++++++
 t/t5510-fetch.sh                | 24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a2f78624a2..0939642dce 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -254,6 +254,13 @@ endif::git-pull[]
 	'git-pull' the --ff-only option will still check for forced updates
 	before attempting a fast-forward update. See linkgit:git-config[1].
 
+--no-update-remote-refs::
+	By default, git updates the `refs/remotes/` refspace with the refs
+	advertised by the remotes during a `git fetch` command. With this
+	option, those refs will be ignored. If the `--prune` option is
+	specified and the default refpsec is used, then a ref that does not
+	appear in the remote will still be deleted from refs/remotes.
+
 -4::
 --ipv4::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b4c6d921d0..bf8000adaf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -78,6 +78,7 @@ static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
+static int update_remote_refs = 1;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -201,6 +202,8 @@ static struct option builtin_fetch_options[] = {
 		 N_("check for forced-updates on all updated branches")),
 	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
 		 N_("write the commit-graph after fetching")),
+	OPT_BOOL(0, "update-remote-refs", &update_remote_refs,
+		 N_("update the refs/remotes/ refspace")),
 	OPT_END()
 };
 
@@ -746,6 +749,9 @@ static int update_local_ref(struct ref *ref,
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
+	if (!update_remote_refs && starts_with(ref->name, "refs/remotes/"))
+		return 0;
+
 	type = oid_object_info(the_repository, &ref->new_oid, NULL);
 	if (type < 0)
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b60282689..35b50b2047 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -174,6 +174,30 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git rev-parse sometag
 '
 
+test_expect_success 'fetch --no-update-remote-refs keeps existing refs' '
+	cd "$TRASH_DIRECTORY" &&
+	git clone "$D" remote-refs &&
+	git -C remote-refs rev-parse remotes/origin/master >old &&
+	git -C remote-refs update-ref refs/remotes/origin/master master~1 &&
+	git -C remote-refs rev-parse remotes/origin/master >new &&
+	git -C remote-refs fetch --no-update-remote-refs origin &&
+	git -C remote-refs rev-parse remotes/origin/master >actual &&
+	test_cmp new actual &&
+	git -C remote-refs fetch origin &&
+	git -C remote-refs rev-parse remotes/origin/master >actual &&
+	test_cmp old actual
+'
+
+test_expect_success 'fetch --no-update-remote-refs --prune with refspec' '
+	git -C remote-refs update-ref refs/remotes/origin/foo/otherbranch master &&
+	git -C remote-refs update-ref refs/hidden/foo/otherbranch master &&
+	git -C remote-refs fetch --prune --no-update-remote-refs origin +refs/heads/*:refs/hidden/* &&
+	git -C remote-refs rev-parse remotes/origin/foo/otherbranch &&
+	test_must_fail git -C remote-refs rev-parse refs/hidden/foo/otherbranch &&
+	git -C remote-refs fetch --prune --no-update-remote-refs origin &&
+	test_must_fail git -C remote-refs rev-parse remotes/origin/foo/otherbranch
+'
+
 test_expect_success 'fetch tags when there is no tags' '
 
     cd "$D" &&

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
