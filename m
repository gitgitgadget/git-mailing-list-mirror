Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C08220248
	for <e@80x24.org>; Wed,  6 Mar 2019 15:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfCFP5X (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 10:57:23 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35181 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfCFP5X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 10:57:23 -0500
Received: by mail-wm1-f46.google.com with SMTP id y15so6440953wma.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 07:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9CIDZy+NmjdFEaiJn3EzRjvcspxzxhUeboL3ogbCRzc=;
        b=UJ0N+Hn3UPOs2nr4S1LRqJQ/TjvvWCI0hX2TqSLEVWSocgBoy4x3eP0l1OpGANaTsY
         5KmF9KUs2KvUnFBHZ22U4Wv7PS6fiJ1GXLF6ZCyKNuCYWyj+V9KvPj42ndYRuBbsANVG
         2REnHRDFB0whPD7NgwmaVJ2WaHCTsbauAuDmndKgmphTeMUTTyg1M3PFRLU32CX0oIke
         En+2mqHfccruAcjt4lXTpnbLejqvcsKD811DjNm+kEE7Aa7XOHw2GYsKXfVM0fOUMt5y
         xK7TjxEGWrECdhdWtTrG2d4Ib2eWINcTKBmUJv+GFK6zR/vroC6bDpjtsRke6lRJJw95
         YybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:subject:to:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=9CIDZy+NmjdFEaiJn3EzRjvcspxzxhUeboL3ogbCRzc=;
        b=mo15EcbcpGiqKc+pZBj0ZDOPYfP3ZY/+Ap+MYJmK92YeoS1pmdkn7RcjbkCzRR0aYX
         vP9fEjd6NmtDQlk3abfdRXHjfgykWR/iFmN3I4dsMZvQqHOrF4s4u2nxtXk7D+tD64KJ
         DShGrsb++ykZCeZrEyARf7mIJrWoWkDIx52vKN06kT60AXzeGBr77SnN+x5DkrUoEPfS
         rh/RbA1kf6QffXZqxAAT7xXztM/ScNI5gMPxYmrVMy/pNLUfs7PiGQR4PZ9+WjFl8lqL
         Ct1IMdQCG+2f+KGchH+YklE3G2PRwqTWNt7lc2TqKoczMDnGEssfhIR+p6HwO+CRA8dD
         1rUg==
X-Gm-Message-State: APjAAAX+6s6sLsb3Jahjshp4MfZc5jWTdD89cNwJjFBNslQdxbFs67Do
        UQdyTExW8eN+MtQ09yn2bCw=
X-Google-Smtp-Source: APXvYqz+J3+H/kS1tTTv1ZWK0W67nqb6vMFEzqtRWZx7DTaKKUonkIgRvwQhNLS+1O5CdUVei1IGwQ==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr2929810wmi.75.1551887840627;
        Wed, 06 Mar 2019 07:57:20 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.gmail.com with ESMTPSA id y66sm3271955wmd.37.2019.03.06.07.57.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 07:57:19 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: [BUG] worktree local refs weirdness
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Message-ID: <f6e197f2-886a-5e82-7fc4-c53737dd66cc@gmail.com>
Date:   Wed, 6 Mar 2019 15:57:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When it is run in a worktree 'git for-each-ref' only seems to show refs 
under refs/rewritten if that directory also exists under $GIT_COMMON_DIR 
even though they are local to the worktree.

Initially I thought this was due to $GIT_COMMON_DIR pointing to a bare 
repo, but that is not the case. However while writing a test case which 
cloned to a bare repo I noticed it was listing a ref for the HEAD of a 
worktree in the repo I had cloned from, not the clone itself.

The script below reproduces both issues, I've copied the output below 
it. I'm not sure what's going on or the best way to debug it.

Best Wishes

Phillip

# setup initial repo
mkdir repo &&
cd repo &&
git init &&
echo a>a &&
git add a &&
git commit -ma &&
#add a worktree and set a ref under refs/rewritten
git worktree add ../worktree-1 &&
cd ../worktree-1 &&
echo 'worktree-1 adding refs/rewritten/a' &&
git update-ref refs/rewritten/a HEAD &&
git rev-parse --verify refs/rewritten/a &&
echo 'refs/rewritten/a exists but is not shown' &&
git for-each-ref &&
# add a ref under refs/rewritten to the main repo
cd ../repo &&
echo 'repo adding refs/rewritten/z' &&
git update-ref refs/rewritten/z HEAD &&
git for-each-ref &&
cd ../worktree-1 &&
echo 'worktree-1 now shows refs/rewritten/a' &&
git for-each-ref &&
cd .. &&
# create a bare clone with a worktree
git clone --bare --no-local repo bare &&
cd bare &&
git worktree add ../worktree-2 &&
cd ../worktree-2 &&
echo 'worktree-2 adding refs/rewritten/b' &&
echo 'why does this show refs/worktree-1/head' &&
echo 'but not refs/rewritten/b?' &&
git worktree list &&
git update-ref refs/rewritten/b HEAD &&
git rev-parse --verify refs/rewritten/b &&
git for-each-ref


Output
Initialized empty Git repository in 
/home/phil/src/git-utils/dev/git-rewrite/repo/.git/
[master (root-commit) dc2045a] a
  1 file changed, 1 insertion(+)
  create mode 100644 a
Preparing worktree (new branch 'worktree-1')
HEAD is now at dc2045a a
worktree-1 adding refs/rewritten/a
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656
refs/rewritten/a exists but is not shown
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/master
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/worktree-1
repo adding refs/rewritten/z
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/master
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/worktree-1
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/rewritten/z
worktree-1 now shows refs/rewritten/a
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/master
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/worktree-1
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/rewritten/a
Cloning into bare repository 'bare'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (3/3), done.
Preparing worktree (new branch 'worktree-2')
HEAD is now at dc2045a a
worktree-2 adding refs/rewritten/b
why does this show refs/worktree-1/head
but not refs/rewritten/b?
/home/phil/src/git-utils/dev/git-rewrite/bare        (bare)
/home/phil/src/git-utils/dev/git-rewrite/worktree-2  dc2045a [worktree-2]
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/master
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/worktree-1
dc2045a36f38ba4e9bacd8cd86ba74f58a1d4656 commit	refs/heads/worktree-2

