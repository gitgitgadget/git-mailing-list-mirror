Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4717E1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfENJys convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 May 2019 05:54:48 -0400
Received: from mx4.uni-regensburg.de ([194.94.157.149]:60282 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:54:48 -0400
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 69C3A6000051
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:54:45 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 3EB07600004E
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:54:45 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Tue, 14 May 2019 11:54:44 +0200
Message-Id: <5CDA9063020000A10003131D@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Tue, 14 May 2019 11:54:43 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: some git confusion (where git's advice didn't help)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I was fighting with a remote branch being missing:
> git branch
  f-systemd
  integration
  master
* next
> git pull
Already up-to-date.
> git pull --all
Fetching origin
Already up-to-date.
> git fetch f-gcc-4.8
fatal: 'f-gcc-4.8' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
> git fetch origin
> git branch
  f-systemd
  integration
  master
* next
> git branch -r
  origin/HEAD -> origin/f-systemd
  origin/backport-0.0
  origin/backport-0.1
  origin/f-gcc-4.8
  origin/f-manual-peak-reset
  origin/f-read-failure
  origin/f-spec-RA
  origin/f-start-notice
  origin/f-status-dir
  origin/f-systemd
  origin/f-systemd-generator
  origin/f-usage
  origin/master
  origin/next
> git branch --track origin/f-gcc-4.8
Branch origin/f-gcc-4.8 set up to track local branch next.
> git fetch
> git branch
  f-systemd
  integration
  master
* next
  origin/f-gcc-4.8
> git merge f-gcc-4.8
merge: f-gcc-4.8 - not something we can merge

Did you mean this?
        origin/f-gcc-4.8
> git merge origin/f-gcc-4.8
warning: refname 'origin/f-gcc-4.8' is ambiguous.
Already up-to-date.

### So actually this advice wasn't helpful at all. Cause of the problem most likely was "git branch --track origin/f-gcc-4.8" that "imported" the branch under the same name as the remote branch is referenced.

Actually this was just an addition to my previous message about missing remote branches after clone...
(Seen with git 2.12.3)

My local "solution" was: git branch -d origin/f-gcc-4.8

Regards,
Ulrich



