Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29950C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF07222C9C
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 17:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406730AbhARRAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405978AbhARQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 11:59:41 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0FC061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 08:59:00 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 143so19193612qke.10
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 08:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=9qWg8W093s9PFxaWvVyak+QbGV+pXx2RHUoBZ6Roqy8=;
        b=jjOrOO5Yl5AqAJ9HboX2cdmHGqjiWB3sJKo0II4ueREhcY7FsmJFuqVc2A54yh0e8g
         +xp3zcQy5lqUphhg9P9AEk9wTYQtr/rEDBCyQIla2CILqva2sLsjPEVw5ZUNzQknufll
         KzWhQ7RwygiNzAHo2xEJ3A4ADVgE/XwMtKNtYuLV5q+WqDwiUYiUWeunguSmV4sUxhwE
         Lz9pSC0FZOBKLaN4k/8QyXHUM7CAVt+NLTvTxI5aXYlAZ8r2cqQTJm7TdSi+JiXSQ0ch
         NxbwzrvwTrZkvEZAFQPl2/rarqxMSK8pOUx8BMc/CQrZxbzBaM6ZCnE1ISSSCzJYzPyy
         LbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=9qWg8W093s9PFxaWvVyak+QbGV+pXx2RHUoBZ6Roqy8=;
        b=boldUD8SIAzFQjjEX32qO3q5PIlC3jl4YQB6yIRQxD3qrAmBO3Ozp14QL5ltu0cT2E
         pMTT9wKc6qzyyXyvW3In2kFE+AdHo72lBMVaEG91Vj/QgP7CLN/EZAqxEqdEIaOoYkN1
         rziQjW/LT6l7ldNckxnorq4db8uYNYdYKOYf1gPny42RkNKwvYxcxg24nWHPC+3/TGUz
         h92voIHbX+kEAGmNmJyETt6fq3Oc1JAELjWF4BPEJyuMaK/8hfjMNieUBQoAR4D3PS/3
         OZPwjmPBFW6w855PYKxYF/fZx33TM4/wIgxOd9Ur+TFMpAVlpwpBdzIU6VXjDwkenvNR
         15GQ==
X-Gm-Message-State: AOAM530t893icUqyD4fAKa0G484PeDP17ubYOrSOenMXco0nV/ErxI0K
        W7YqP4kaLmdoWNRMQljezlwhz6Ezt3hDaQ==
X-Google-Smtp-Source: ABdhPJyrnYli7OpC8V4wvuTOPTMqzs3CDeEWbI88vMnZxA3TTAI8r6xZYEfBCXZoa12jdlBckcEGdA==
X-Received: by 2002:a37:66d8:: with SMTP id a207mr503538qkc.492.1610989139346;
        Mon, 18 Jan 2021 08:58:59 -0800 (PST)
Received: from [192.168.103.12] (cpe00fc8d50b7d3-cm00fc8d50b7d0.cpe.net.fido.ca. [72.141.221.184])
        by smtp.gmail.com with ESMTPSA id s49sm11048594qth.90.2021.01.18.08.58.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:58:58 -0800 (PST)
From:   Utku <ugultopu@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: How to commit without an index file?
Message-Id: <A31FEB7F-0A81-4500-9B1D-F65A5F8823AA@gmail.com>
Date:   Mon, 18 Jan 2021 11:58:56 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my program, I have the file paths, permissions and Git object IDs of
everything that I want to appear in the next commit. Hence, I want to
create a commit without creating an index file.

Essentially it's like to combining `--cacheinfo` from `update-index`
with `commit` like:

	git commit \
		-m "Commit message" \
		--branch my-branch \
		--cacheinfo =
"100644,0123456789abcdef0123456789abcdef01234567,path/to/first/file=E2=80=9D=
 \
		--cacheinfo =
"100755,123456789abcdef0123456789abcdef012345670,path/to/second/file=E2=80=
=9D \
		--cacheinfo =
"100644,23456789abcdef0123456789abcdef0123456701,path/to/third/file"

In this example, the command would not read the index file, but would
get the information necessary to create the commit tree as arguments (or
from STDIN). The command would handle recursively creating trees for the
intermediate directories. The object ID for the final tree would be used
for the `tree` field of the commit.

I tried tricks for simulating standard streams as an index file to Git,
but they didn't work out:

	$ GIT_INDEX_FILE=3D/dev/stdout git read-tree HEAD
	fatal: Unable to create '/dev/stdout.lock': No such file or =
directory

The best I could come up with is creating a no checkout worktree for
`my-branch` and using a FIFO for the index file, instead of a
conventional file. The shell script equivalent of it would be as follows
(I would be happy if you can point out any errors in this script as
well):

	set -e
=09
	git_dir=3D$(git rev-parse --git-dir)
	worktree_name=3Dmy-program
	worktree_location=3D$git_dir/$worktree_name
=09
	# Ran only once
	function init_worktree {
		branch_name=3Dmy-branch
		worktree_gitdir=3D$git_dir/worktrees/$worktree_name
	=09
		git worktree add "$worktree_location" "$branch_name" =
--no-checkout
		rm -f "$worktree_gitdir/index=E2=80=9D
		mkfifo "$worktree_gitdir/index=E2=80=9D
	=09
		echo "Initialized worktree at $worktree_location=E2=80=9D
	}

	# Ran on every commit
	function commit_worktree {
		cd "$worktree_location=E2=80=9D
		git read-tree =E2=80=94empty
		git update-index --add \
		--cacheinfo =
"100644,0123456789abcdef0123456789abcdef01234567,path/to/first/file=E2=80=9D=
 \
		--cacheinfo =
"100755,123456789abcdef0123456789abcdef012345670,path/to/second/file=E2=80=
=9D \
		--cacheinfo =
"100644,23456789abcdef0123456789abcdef0123456701,path/to/third/file=E2=80=9D=

		# etc. Will be received as arguments or from STDIN.
		git commit -m "Commit message=E2=80=9D
	}

So I guess this is the best it gets? If I wanna make it better, I guess
I will need to use libgit2?

Thank you=
