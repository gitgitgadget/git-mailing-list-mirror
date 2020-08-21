Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE85C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F22075E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 13:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="isJKQQ03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgHUNhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:37:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:59065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgHUNhU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 09:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598017036;
        bh=8BNMH/T81T0CBXF6Qur6Bj6gmo6aDHBYi8wfMHZXPTU=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=isJKQQ03JPI91nQJAeClAnGpqeuvCOk335wD2q0QGMpPKPiwhPmpZFSvLf7hniQyI
         ieAYXevPQbRBEOpmheMrWvQmCtsc1B6yiMPtYrh69qeCWJKZah/zXbqON8BwKBeZ0K
         fCdeqZKb49jnkcWpSQHc32gkVaxOekCAKlRxhnsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.42] ([91.61.196.29]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1k3d3Q0uHM-005apK for
 <git@vger.kernel.org>; Fri, 21 Aug 2020 15:37:16 +0200
To:     git@vger.kernel.org
From:   voxspox <voxspox@gmx.net>
Subject: gitignore does not ignore wildcard directory if it is a link
Message-ID: <0179b688-576b-7423-8824-9b57fe8f92fc@gmx.net>
Date:   Fri, 21 Aug 2020 15:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7sSoNrJfOprNNIOMtKA4cRjuGV+k9GxHTZF7PP8H/CNEXJ4qEj2
 KRhivKiJaN7KFcuF/dJyAmX5apuRZwaykwJYQUIkmlSX96siJzvos7t9OjC6n9VLppm1WFM
 CY0Q/y79TfN61ArTLoFH6ucXlXqNzrtZHl7atRl63ge8fohR8hx/VgeWHeniwKkLrZrA8B8
 Bi170CJrC8Rdy43Qf3XGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VUXy3kRc1b0=:l8eSipZ/tZEdsR7WcWluiv
 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
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

I start with a scenario:

contents of working copy:

/somefile1
/test/dir1  (directory)
/test/dir2  (link to directory)
/test/dir3  (link to directory)
/test/file1

I want to ignore all subfolders in "test", thus I modified my .gitignore to:

/test/*/


> git status

Untracked files:
  test/dir2
  test/dir3


Putting "/test/dir3" into .gitignore will work fine.


-> It seems that directories are not ignored by a wildcard pattern if
the directory is a link
using: 2.25.1 on Linux


regards Knut



