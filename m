Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3876CC2D0CE
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 22:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E985B206DA
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 22:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STxFaf+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLaWxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 17:53:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43538 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLaWxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 17:53:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so36109349edb.10
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0I0ZMihxUFKH2LPuI4X2hlgsnlyrs5c/yTQ2Ojmr6yU=;
        b=STxFaf+luGSUY3sKZ7AC7x/sVVj0xP9L5himKqmwV3myVe/2KLrITXc0DiCRWNlcOz
         hHoyu4UPtsiGlegHs952HgGKfKPziMBgo2+2erFQaG7LR1Cjg2ERvo/jp3ulXJSK4MRF
         YtHZMn21pZ9k45YUhzow5rpopivIXXiEdhU/yU22+PlfOnfn9jlfcxulrViftoGcXqJo
         Lbs2WYGj9SqGtyLzuIRxJRdsMhCxpyfQ3tNrpGlVe9t+hJsI6uhWsekHlcN7Meb7ckOg
         L0TdYUeBzGcEkzC9VJzSP/BtCzfhHpB3LwSoMyXu+n23fZmjoEbL8Vq8miV8LW59Trgg
         SQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0I0ZMihxUFKH2LPuI4X2hlgsnlyrs5c/yTQ2Ojmr6yU=;
        b=p+cHlpN5zBmfbwoZEgd7tSh81xG395K8RZyDff6xF7qtSZOWflGu9kEtGgqfN+Lx0d
         C08PKyB2IiAA44vlrhu45Qryp0bP1x+PwFsB6NHv4M50UCFhAyJp9A3h7vNwjJOg2ckh
         HhbtdhcMOshQiP5QtRlLyrAS7YqDGWUPNCpIdj4J4uw/wVzh6KAJwjO9CTm9E5b+RWsh
         dI3wMTQlcOE5XlC2VJqcVS2aUeHkhYB/qlv1/TMYIHmZTumLv3Wx2Iv5qjT4ezdGH9GC
         sT8cDioykU5B6iB1KsYneShGoaTuUJnqDOC1VHjVkE18CFKSk5ttBPZPofIcXd+FgkX2
         PotQ==
X-Gm-Message-State: APjAAAXoJo9XI7Pd3jy/rEwz0Umh6VztKbp4CxEPzizs6pkgPEqtuxcc
        SKtksPQN37nQ6K5lVk0OupUQpBaw
X-Google-Smtp-Source: APXvYqyIDSlfni1QjKt5M2Ldaru7pDFlQhcY8jF5OpQwbOZfTmrQTuOa9vsMAVAKvATRq1TaSzc2CA==
X-Received: by 2002:aa7:d50e:: with SMTP id y14mr78598308edq.265.1577832831890;
        Tue, 31 Dec 2019 14:53:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id of23sm6309265ejb.30.2019.12.31.14.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 14:53:51 -0800 (PST)
Message-Id: <pull.682.v2.git.git.1577832830.gitgitgadget@gmail.com>
In-Reply-To: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 22:53:49 +0000
Subject: [PATCH v2 0/1] Disallow writing, but not fetching commits with file names containing
 backslashes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of Git for Windows, v2.24.1(2). cloning a repository that contained a
file with a backslash in its name some time in the past, the command will 
succeed but at the same time print errors like this:

    error: filename in tree entry contains backslash: '\'

A corresponding git fetch will also show those errors, but fail.

The reason is that v2.24.1 is much more strict about backslashes in tree
entries than earlier versions. The intention was actually to prevent 
checking out such files, though: if there was a mistake in a repository long 
ago that has been fixed long since, there is actually no reason why we
should require the history to be rewritten.

This fixes https://github.com/git-for-windows/git/issues/2435.

The idea of this patch is to stop complaining about tree entries, and focus
instead on the index: whenever a file is added to the index, we do not want
any backslashes in the file name on Windows.

As before, this check is only performed on Windows, and only under 
core.protectNTFS. On other platforms, even if core.protectNTFS is turned on,
the backslash is not a directory separator, therefore the Operating System's
syscalls will (should?) refuse to create files on NTFS with backslashes in
their file name.

I would appreciate reviews with a particular eye on keeping users safe: I am
not 100% certain that all relevant file writes go through the index (I think 
that they all go through the index, but I might have well missed a corner
case).

Changes since v1:

 * Clarified the commit message (what is the goal, explain that the
   requirement is now loosened, explain why the code is still 
   GIT_WINDOWS_NATIVE-only, etc).

Johannes Schindelin (1):
  mingw: only test index entries for backslashes, not tree entries

 read-cache.c               | 5 +++++
 t/t7415-submodule-names.sh | 7 ++++---
 tree-walk.c                | 6 ------
 3 files changed, 9 insertions(+), 9 deletions(-)


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-682%2Fdscho%2Fmingw-only-error-on-backslash-in-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-682/dscho/mingw-only-error-on-backslash-in-index-v2
Pull-Request: https://github.com/git/git/pull/682

Range-diff vs v1:

 1:  4a120fd0b3 ! 1:  d6da8315d3 mingw: only test index entries for backslashes, not tree entries
     @@ -8,14 +8,31 @@
      
                  error: filename in tree entry contains backslash: '\'
      
     -    While the clone still succeeds, a similar error prevents the equivalent
     -    `git fetch` operation, which is inconsistent.
     +    The idea is to prevent Git from even trying to write files with
     +    backslashes in their file names: while these characters are valid in
     +    file names on other platforms, on Windows it is interpreted as directory
     +    separator (which would obviously lead to ambiguities, e.g. when there is
     +    a file `a\b` and there is also a file `a/b`).
      
     -    Arguably, this is the wrong layer for that error, anyway: As long as the
     -    user never checks out the files whose names contain backslashes, there
     -    should not be any problem in the first place.
     +    Arguably, this is the wrong layer for that error: As long as the user
     +    never checks out the files whose names contain backslashes, there should
     +    not be any problem in the first place.
      
     -    So let's instead prevent such files to be added to the index.
     +    So let's loosen the requirements: we now leave tree entries with
     +    backslashes in their file names alone, but we do require any entries
     +    that are added to the Git index to contain no backslashes on Windows.
     +
     +    Note: just as before, the check is guarded by `core.protectNTFS` (to
     +    allow overriding the check by toggling that config setting), and it
     +    is _only_ performed on Windows, as the backslash is not a directory
     +    separator elsewhere, even when writing to NTFS-formatted volumes.
     +
     +    An alternative approach would be to try to prevent creating files with
     +    backslashes in their file names. However, that comes with its own set of
     +    problems. For example, `git config -f C:\ProgramData\Git\config ...` is
     +    a very valid way to specify a custom config location, and we obviously
     +    do _not_ want to prevent that. Therefore, the approach chosen in this
     +    patch would appear to be better.
      
          This addresses https://github.com/git-for-windows/git/issues/2435
      

-- 
gitgitgadget
