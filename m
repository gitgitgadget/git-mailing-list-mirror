Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED862055E
	for <e@80x24.org>; Sat, 28 Oct 2017 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdJ1Q7A (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 12:59:00 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:50892 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdJ1Q67 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 12:58:59 -0400
Received: by mail-pf0-f175.google.com with SMTP id b6so7266780pfh.7
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=phXJWlI6Qfb3J40m5X05STT6GNitV0r+vvLooz1hDjs=;
        b=XUQi9vDjdC4BXIUvnkTdIm111nLiQ3zb2rVg2PiGxcp+BW3FZNn2l+MzIzqrUI1dj+
         Ga/PCwJLZzWXi5/lpgYfpQ3C4/FQI/CJDhEU3zGqQf02oQMmHJ1ZtNUKernkrS0loBl5
         u349zmzg29J+eS79E2D9jFcvmThMtQuZdBizod4nQrWp51YzD7S3MnXbMwJgm51bwi+m
         RCdXNE8GtDJldKDhBVx3YVcua1xBU2iBj4lJ4CverNagSp3VXHNgem7nGG4woz6X8A1w
         +7LM3HUWYqXMo92M07dRKw4mPDFi1YGoJsAUFbdm+sHwwpLTTdaqJLVYejg6x/oBAefi
         U4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=phXJWlI6Qfb3J40m5X05STT6GNitV0r+vvLooz1hDjs=;
        b=p+uXM4ydY8zrsJrDI+Ve0Bnj1bM52WGAXHBRVMm2cZBuRoEUihwiYxKmneZvRZXZ43
         ACybayt1oml4m87BM6V8bSkWDJDxJ1h7oI4ktsb3wdWqZKJ5EvSwRiX6SZl4KfeuDyf/
         MtIEJcDOajpG3mwcklnOuJ4sLsyyweYA7yqF2fr3klpvuANG+KSgj6hnOD2s1ZL2+Cy4
         oZYbxyBYbN3PfYR6yjuL2tksyuhpd4FoQd6p8EzWaLMKsMo/GCieV7iz4pDIbvwu6iOC
         SvNIgM7pXb9omWsTit6o0vmufewQdrr0qS7XUOk+9K3K7NGU7mr9vg15Yb3xO4NNJdfH
         lhEg==
X-Gm-Message-State: AMCzsaVRpWp2J3U69oLz+qTve9OJ0fFZJJMikIh2aHBYS0ZGefU4oyxc
        aWlv5Ijd0zJ16/FPwSmriuhdjpE7
X-Google-Smtp-Source: ABhQp+QfuQMk8i9rPC45yMMhRs4JReAkPY8QlX+3SrnkrO9yKrM70VWb4ml7B9YpN1fXVWyRnqnKww==
X-Received: by 10.98.76.147 with SMTP id e19mr3845292pfj.73.1509209938483;
        Sat, 28 Oct 2017 09:58:58 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.googlemail.com with ESMTPSA id 204sm20734386pfu.8.2017.10.28.09.58.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Oct 2017 09:58:57 -0700 (PDT)
Message-ID: <1509209933.2256.4.camel@gmail.com>
Subject: [BUG] Incosistent repository state when trying to rename HEAD in
 the middle of a rebase
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 28 Oct 2017 22:28:53 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just noticed this recently while trying to see if a recent change [1]
that disallowed the possibility of creating HEAD also allowed renaming
branches named "HEAD" that were created using previous versions that
allowed it. Unfortunately (or fortunately (?)), I was in the middle of
an interactive rebase while trying this out and as a consequence
observed weird behaviour as shown in the following output,

    $ git branch -m HEAD head-1
    warning: Renamed a misnamed branch '|�?' away

The most interesting thing with the above output was that I really
didn't have any branch named "HEAD" while trying this. Further, the
most crucial thing about the above issue is it left the repository in
an inconsistent state by removing ".git/HEAD" and thus leaving the
repository in an inconsistent state. This results in git not
recognizing it as a git repository itself! I had to do a "git init" to
fix this (I guess I lose at least something as a consequence as it
checks out the 'master' by default; though I'm not sure).

git 2.11.0 shows a "branch doesn't exist" error (not exactly) in the
above case,

    $ hgit b -m HEAD head-1
    error: refname refs/heads/HEAD not found
    fatal: Branch rename failed

My reproduction recipe for the above issue is as follows,

    git init test &&
    cd test &&
    echo "Test file" >test &&
    git add test &&
    git commit -m "Initial commit" &&echo "Test" >test &&git add test &&
    git c -m "Second commit" &&
    git rebase-i HEAD~

At this point use the 'edit' command for "Second commit" and close the
editor and try the following,

    $ git branch -m HEAD head-1

This should show the issue. Any git operation after this should report
the following error,

    fatal: Not a git repository (or any parent up to mount point /)
    Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)

Re-initializing the repository should bring the repository back to the
position it was before the issue (to some extent though the staging
area might become cluttered as the 'master' branch is checked out by
default.)

I'm still surprised as to why ".git/HEAD" was treated as a branch. I
thought of digging into this but didn't get the time now so thought of
informing to the people in the mailing list. One last thing, I suspect
this to be a consequence of that change I specified in the beginning,
though I might be just guessing around.

[1]: https://public-inbox.org/git/20171013051132.3973-1-gitster@pobox.com/

-- 
Kaartic
