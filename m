Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA2AC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2383261410
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhDWVRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:17:18 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:50457 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232479AbhDWVRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:17:17 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 13NLGdWc085585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:16:41 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: [feature suggestion] Improve stash descriptions
Message-ID: <ff84d047-c0ae-86d1-c210-b2b777fd8184@rawbw.com>
Date:   Fri, 23 Apr 2021 14:16:38 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My current stash looks like this:

$ git stash list
stash@{0}: WIP on main: 12c63aaa3b13 www/yt-dlp: Update 2021.04.11 -> 
2021.04.22 Reported by: portscout
stash@{1}: WIP on main: 140f08246898 devel/py-PeachPy: Update g20180225 
-> 0.0.1
stash@{2}: WIP on main: d42e82e4a336 security/hs-cryptol: Update 2.10.0 
-> 2.11.0
stash@{3}: WIP on main: 62851ab415cd dns/subfinder: Update 2.4.6 -> 2.4.7
stash@{4}: WIP on main: 4eec712dfdae math/gretl: Correct PKGNAME to be 
2021a, not 2021.a to reflect how Gretl is versioned.
stash@{5}: WIP on main: 725e4e9a07f0 devel/py-fypp: Update 3.0 -> 3.1
stash@{6}: WIP on main: 200eb286c368 misc/py-orange3-educational: Update 
0.1.8 -> 0.4.0
stash@{7}: WIP on main: 364ab57861e2 misc/urh: Update 2.9.1 -> 2.9.2
stash@{8}: WIP on main: 52c6d02708d0 science/py-nilearn: Update 0.7.0 -> 
0.7.1
stash@{9}: WIP on main: a9d5d9e05bbf New port: biology/seqkit: 
Cross-platform and ultrafast toolkit for FASTA/Q file manipulation
stash@{10}: WIP on main: ffa307fb4dc3 games/iqpuzzle: Update 1.2.2 -> 1.2.3
stash@{11}: WIP on main: 195f2e27fd72 math/py-libpoly: Update 0.1.8 -> 0.1.9
stash@{12}: WIP on main: 4c2cc95952a6 graphics/mesa-devel: update to 
21.0.b.4390
stash@{13}: WIP on main: 4c2cc95952a6 graphics/mesa-devel: update to 
21.0.b.4390
stash@{14}: On main: audio/tuxguitar -- .
stash@{15}: On main: math/[py-]python-igraph

None of the above descriptions are relevant to actual items, for example:

$ git stash show stash@{2}
  devel/google-perftools/Makefile                      |  2 +-
  devel/google-perftools/distinfo                      |  6 +++---
  devel/google-perftools/files/patch-Makefile.am       |  4 ++--
  devel/google-perftools/files/patch-src_stacktrace.cc | 11 +++++++++++
  devel/google-perftools/pkg-plist                     | 12 ++++++------
  5 files changed, 23 insertions(+), 12 deletions(-)

- description mentions cryptol but actual items are related to perftools.


My suggestion:

In case all changes are grouped in one ditectory, like in my case, git 
should append this directory name to description:

 > stash@{2}: WIP on main: d42e82e4a336 security/hs-cryptol: Update 
2.10.0 -> 2.11.0, all changes are in devel/google-perftools


In many cases it is possible to do so.

In case many directories are affected it could say "changes are in 
path1/dir1, path2/dir2, etc."

This would be a lot better than stash items descriptions it prints now.


Thank you,

Yuri

