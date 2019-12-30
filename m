Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD84C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D9120722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs5P5mlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfL3PdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:33:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45098 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfL3PdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:33:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so32841925edw.12
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EFUYQMkdUdRl0Db/dajaO4qiUeRmbr3p2F6Dxxyefd8=;
        b=Bs5P5mlPIcP+wkzvjoMe099h/kXpXNzVza5FoZzflcJP6nmgSmB4AP1TcD9xph3EOg
         7VNzG1zp4MIJHBBmetA5XQg6DASSGcxB7I49k/L4c0gPlQ16QJGczRvqYqfzm3PcdonY
         jD3v7pKPz+gGQ3FSiiTIb5Un8hAIRnzrllCMAIi6Ic0WgDvPjO93r0uMESTTr1htzGwG
         5X1Z2Ao4pcB3nnMGU/Jo8YCwW5wXJIM7pfeKQewYaiDgH+mqy6LKj1mB7DO89W0SLNtE
         HpWts4eYdTHDKkCYSJylWoEyf+WR5hDZlCT9zirE45OtxRDIcXlBsw0hSAEHuzeHocq/
         8DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EFUYQMkdUdRl0Db/dajaO4qiUeRmbr3p2F6Dxxyefd8=;
        b=dUFjLStwn354EjzO00oNNHLl0W+bJoBAsDarVTyLIba3g10OMj+rBhhjTjR7SuKVx5
         P9fjZBFOnYs8lsfat/Z8lwuNpOC27N7tDDasmYrpXhy898DEC9NA8C72Yevd4+tiscsC
         sFgqLIAP/AZcE7j8kLQmk+A9oGbZBb3+0+9VqS1hMT69ToB9iz7F619LjOT/hNZWjl3h
         Z5uraSHjcwas2Xq6McBvcCdrg1uMMQI5xN8mP6MnxWYHvq6YDkF2pfiY2zkHe0GsvMqz
         a9PX5suoKOvf9obg2RrRO0Q8IwUx32M/gHZOffQKVFJWjTtNbr8FOzVON2R4vDG1KGZu
         IYBA==
X-Gm-Message-State: APjAAAWQxoeXGBtIVX8hYt7EtXhckuemmxWOrSkr/kHrw/JT6s6LZwdW
        dFZLdCeG2mbj9eD5YfNnyfnPiJQQ
X-Google-Smtp-Source: APXvYqxdrNF65OQd+Xrf6dEs3owuHR4lt/b4sd38s1VUREDh/i9x7Kk8mgkWJ2DnExUJwGlXJrM0qA==
X-Received: by 2002:a50:d69a:: with SMTP id r26mr73449364edi.148.1577719995198;
        Mon, 30 Dec 2019 07:33:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm4413202ejl.5.2019.12.30.07.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:33:14 -0800 (PST)
Message-Id: <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
References: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:33:11 +0000
Subject: [PATCH v3 0/2] sparse-checkout: list directories in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When in cone mode, "git sparse-checkout set" takes a list of folders and
constructs an ordered list of patterns for the sparse-checkout file. The
"git sparse-checkout list" subcommand outputs the contents of the
sparse-checkout file in a very basic way.

This patch changes the behavior of "git sparse-checkout list" when
core.sparseCheckoutCone=true. It will output the folders that were used in
"git sparse-checkout set" to create the patterns, instead of the patterns
themselves.

I believe this was requested in the initial review, but I cannot find that
message now.

I was going to include this as part of a longer follow-up series, but I
think this may be worth considering for the 2.25.0 release. Hence, it is
included by itself.

Update in V2:

 * Fixed typos/word choice in commit message.
   
   
 * Added a second commit including clarification on interactions with
   submodules.
   
   

Thanks, -Stolee

Derrick Stolee (2):
  sparse-checkout: list directories in cone mode
  sparse-checkout: document interactions with submodules

 Documentation/git-sparse-checkout.txt | 21 ++++++++++++++-
 builtin/sparse-checkout.c             | 21 +++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 39 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)


base-commit: 761e3d26bbe44c51f83c4f1ad198461f57029ebd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-500%2Fderrickstolee%2Fsparse-checkout-list-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-500/derrickstolee/sparse-checkout-list-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/500

Range-diff vs v2:

 1:  d6f4f40486 ! 1:  7d4295bd06 sparse-checkout: list folders in cone mode
     @@ -1,17 +1,17 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    sparse-checkout: list folders in cone mode
     +    sparse-checkout: list directories in cone mode
      
          When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
     -    command takes a list of folders as input, then creates an ordered
     -    list of sparse-checkout patterns such that those folders are
     -    recursively included and all sibling entries along the parent folders
     +    command takes a list of directories as input, then creates an ordered
     +    list of sparse-checkout patterns such that those directories are
     +    recursively included and all sibling entries along the parent directories
          are also included. Listing the patterns is less user-friendly than the
     -    folders themselves.
     +    directories themselves.
      
          In cone mode, and as long as the patterns match the expected cone-mode
          pattern types, change the output of 'git sparse-checkout list' to only
     -    show the folders that created the patterns.
     +    show the directories that created the patterns.
      
          With this change, the following piped commands would not change the
          working directory:
     @@ -41,8 +41,8 @@
       based algorithms to compute inclusion in the sparse-checkout.
       
      +In the cone mode case, the `git sparse-checkout list` subcommand will list the
     -+folders that define the recursive patterns. For the example sparse-checkout file
     -+above, the output is as follows:
     ++directories that define the recursive patterns. For the example sparse-checkout
     ++file above, the output is as follows:
      +
      +--------------------------
      +$ git sparse-checkout list
 2:  331bb7d6fb ! 2:  74bbd0f84d sparse-checkout: document interactions with submodules
     @@ -2,11 +2,6 @@
      
          sparse-checkout: document interactions with submodules
      
     -    Junio asked what the behavior is between the sparse-checkout feature
     -    and the submodule feature. The sparse-checkout builtin has not changed
     -    the way these features interact, but we may as well document it in
     -    the builtin docs.
     -
          Using 'git submodule (init|deinit)' a user can select a subset of
          submodules to populate. This behaves very similar to the sparse-checkout
          feature, but those directories contain their own .git directory
     @@ -61,14 +56,14 @@
      +		git sparse-checkout set folder1
      +	) &&
      +	list_files super >dir &&
     -+	cat >expect <<-EOF &&
     ++	cat >expect <<-\EOF &&
      +		a
      +		folder1
      +		modules
      +	EOF
      +	test_cmp expect dir &&
      +	list_files super/modules/child >dir &&
     -+	cat >expect <<-EOF &&
     ++	cat >expect <<-\EOF &&
      +		a
      +		deep
      +		folder1

-- 
gitgitgadget
