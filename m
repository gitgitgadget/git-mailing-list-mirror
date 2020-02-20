Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF58C5ACC4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 00:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11FF207FD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 00:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgBTA3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:29:39 -0500
Received: from vuizook.err.no ([178.255.151.162]:37550 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgBTA3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 19:29:39 -0500
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1j4Zih-000096-Oa
        for git@vger.kernel.org; Thu, 20 Feb 2020 00:29:35 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1j4Zie-000XOt-Uu
        for git@vger.kernel.org; Thu, 20 Feb 2020 09:29:32 +0900
Date:   Thu, 20 Feb 2020 09:29:32 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: git rebase allows branches to be checked out in multiple worktrees
Message-ID: <20200220002932.5jws6qpnivlvxckw@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed a quirk with git rebase vs. worktrees. While using e.g.
git checkout will prevent a same branch from being checked out from
multiple worktrees, that's not the case for git-rebase, so the following
scenario ends up with two checkouts of the same branch:

$ git checkout -b foo HEAD~
$ git commit --allow-empty -m foo 
$ git worktree add /tmp/bar master
$ cd /tmp/bar
$ git rebase master foo

Mike
