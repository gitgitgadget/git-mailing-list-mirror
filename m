Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42CB20899
	for <e@80x24.org>; Tue,  8 Aug 2017 15:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdHHPSS (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 11:18:18 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37736 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbdHHPSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 11:18:17 -0400
Received: by mail-wr0-f180.google.com with SMTP id 33so14171727wrz.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ywW2WOkPsSyHDDmh6WUiz2IGjDGEVZVR0qtblayaLvA=;
        b=SQ3xWkzalGslamvJc5SUME2cZepR9USD1tPIYL7TMw/Cq461o7DTJIk+HHCXtA/oYs
         dMfgpHXCPbNRX2J+H8H8O4WQesEckKuUugknUNpKE3XSJXp+OmBwQfcc7jpoefS575Br
         Hu6wr11OGxL2DBWBSNRgfqzuD0vXKBFt+0EZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ywW2WOkPsSyHDDmh6WUiz2IGjDGEVZVR0qtblayaLvA=;
        b=EWcPz1bVHa3jxwK4I5sOA5qSxYMgup7i7aA7oIYqGdSLLKMtE7gpndzS7mcOo9ghB6
         qSNQKXRlsWrBrycLVxilhi6WOnfNKOvZwBPksdmuFV/67ZnOUYIVgR2z4B0ugef5jIY2
         GYuTwpRRYz+Rew6TYDtk7n67usFxKhJ0FTXQSFoiXXIb3inryrwVEB9rcyJRyzsI2Pd/
         4hcS9nbq6qEk3MzlpRQJ/hcS7YR3i7wqmLlRUvA9MvNPxK4hqXwYZ0qhLcAvOiBtrYqV
         Xr85R0n0sQbZRJ9XJNzSx35Ytwg1vTrjytjCvN8pP6+C0+Zk3K10apWdE8Z9nN8cdUBa
         NuxQ==
X-Gm-Message-State: AHYfb5j+w07x/dq6yk7nBPSUmwlcd2+H6dPxO7ldjFBK+xaeiWflnOyc
        zB7oBU7UIv4RXR+0Mmw7Sg==
X-Received: by 10.223.130.202 with SMTP id 68mr3251839wrc.46.1502205495831;
        Tue, 08 Aug 2017 08:18:15 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 9sm1475505wrl.57.2017.08.08.08.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 08:18:14 -0700 (PDT)
Date:   Tue, 8 Aug 2017 16:18:08 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Emily Xie <emilyxxie@gmail.com>
Subject: t3700 broken on pu on Cygwin
Message-ID: <20170808151808.GA32640@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t3700-add.sh test is currently failing on the pu branch on Cygwin.
To my surprise, the problem appears to have been introduced by a merge,
867fa1d6a.  Both parents of that merge have the test succeeding, but
it's failing on that merge commit.

Failing test output below:

    $ ./t3700-add.sh -i --verbose-only=41 -x
    Initialized empty Git repository in /home/add/vcs/git/x64/t/trash directory.t3700-add/.git/
    ok 1 - Test of git add
    ok 2 - Post-check that foo is in the index
    ok 3 - Test that "git add -- -q" works
    ok 4 - git add: Test that executable bit is not used if core.filemode=0
    ok 5 - git add: filemode=0 should not get confused by symlink
    ok 6 - git update-index --add: Test that executable bit is not used...
    ok 7 - git add: filemode=0 should not get confused by symlink
    ok 8 - git update-index --add: Test that executable bit is not used...
    ok 9 - .gitignore test setup
    ok 10 - .gitignore is honored
    ok 11 - error out when attempting to add ignored ones without -f
    ok 12 - error out when attempting to add ignored ones without -f
    ok 13 - error out when attempting to add ignored ones but add others
    ok 14 - add ignored ones with -f
    ok 15 - add ignored ones with -f
    ok 16 - add ignored ones with -f
    ok 17 - .gitignore with subdirectory
    ok 18 - check correct prefix detection
    ok 19 - git add with filemode=0, symlinks=0, and unmerged entries
    ok 20 - git add with filemode=0, symlinks=0 prefers stage 2 over stage 1
    ok 21 - git add --refresh
    ok 22 - git add --refresh with pathspec
    ok 23 # skip git add should fail atomically upon an unreadable file (missing SANITY of POSIXPERM,SANITY)
    ok 24 # skip git add --ignore-errors (missing SANITY of POSIXPERM,SANITY)
    ok 25 # skip git add (add.ignore-errors) (missing SANITY of POSIXPERM,SANITY)
    ok 26 # skip git add (add.ignore-errors = false) (missing SANITY of POSIXPERM,SANITY)
    ok 27 # skip --no-ignore-errors overrides config (missing SANITY of POSIXPERM,SANITY)
    ok 28 # skip git add 'fo\[ou\]bar' ignores foobar (missing BSLASHPSPEC)
    ok 29 - git add to resolve conflicts on otherwise ignored path
    ok 30 - "add non-existent" should fail
    ok 31 - git add -A on empty repo does not error out
    ok 32 - "git add ." in empty repo
    ok 33 - git add --dry-run of existing changed file
    ok 34 - git add --dry-run of non-existing file
    ok 35 - git add --dry-run of an existing file output
    ok 36 - git add --dry-run --ignore-missing of non-existing file
    ok 37 - git add --dry-run --ignore-missing of non-existing file output
    ok 38 - git add empty string should fail
    ok 39 - git add --chmod=[+-]x stages correctly
    ok 40 - git add --chmod=+x with symlinks

    expecting success:
    		git reset --hard &&
    		echo foo >foo3 &&
    		git add foo3 &&
    		git add --chmod=+x foo3 &&
    		test_mode_in_index 100755 foo3 &&
    		echo foo >xfoo3 &&
    		chmod 755 xfoo3 &&
    		git add xfoo3 &&
    		git add --chmod=-x xfoo3 &&
    		test_mode_in_index 100644 xfoo3

    ++ git reset --hard
    HEAD is now at d12df1f commit all
    ++ echo foo
    ++ git add foo3
    ++ git add --chmod=+x foo3
    ++ test_mode_in_index 100755 foo3
    ++ case "$(git ls-files -s "$2")" in
    +++ git ls-files -s foo3
    ++ echo pass
    pass
    ++ echo foo
    ++ chmod 755 xfoo3
    ++ git add xfoo3
    ++ git add --chmod=-x xfoo3
    cannot chmod 'xfoo3'++ test_mode_in_index 100644 xfoo3
    ++ case "$(git ls-files -s "$2")" in
    +++ git ls-files -s xfoo3
    ++ echo fail
    fail
    ++ git ls-files -s xfoo3
    120000 c5c4ca97a3a080c32920941b665e94a997901491 0       xfoo3
    ++ return 1
    + test_eval_ret_=1
    + want_trace
    + test t = t
    + test t = t
    + set +x
    error: last command exited with $?=1
    not ok 41 - git add --chmod=[+-]x changes index with already added file
    #
    #               git reset --hard &&
    #               echo foo >foo3 &&
    #               git add foo3 &&
    #               git add --chmod=+x foo3 &&
    #               test_mode_in_index 100755 foo3 &&
    #               echo foo >xfoo3 &&
    #               chmod 755 xfoo3 &&
    #               git add xfoo3 &&
    #               git add --chmod=-x xfoo3 &&
    #               test_mode_in_index 100644 xfoo3
    #
