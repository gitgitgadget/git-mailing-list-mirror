Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE3C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAC9608FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhJ0Xqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Xqh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 19:46:37 -0400
X-Greylist: delayed 785 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Oct 2021 16:44:11 PDT
Received: from outpost.hi.is (outpost.hi.is [IPv6:2a00:c88:4000:1650::165:166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D768C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 16:44:10 -0700 (PDT)
Received: from krafla.rhi.hi.is (krafla.rhi.hi.is [IPv6:2a00:c88:4000:1480::148:57])
        by outpost.hi.is (8.14.7/8.14.7) with ESMTP id 19RNV1QY006687
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 23:31:01 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 outpost.hi.is 19RNV1QY006687
Received: from krafla.rhi.hi.is (localhost [127.0.0.1])
        by krafla.rhi.hi.is (8.15.2/8.15.2) with ESMTPS id 19RNV1oG762931
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 23:31:01 GMT
Received: (from bjarniig@localhost)
        by krafla.rhi.hi.is (8.15.2/8.15.2/Submit) id 19RNV1Em762930
        for git@vger.kernel.org; Wed, 27 Oct 2021 23:31:01 GMT
Date:   Wed, 27 Oct 2021 23:31:01 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     git@vger.kernel.org
Subject: "git describe --debug" does not show the latest tag for "groff"
Message-ID: <20211027233101.GA762862@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bjarniig@hi.is
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

  I do not know, it could have happened anytime after the latest tag
was committed (11th Nov. 2020).

What did you expect to happen? (Expected behavior)

  Seeing the latest tag "1.23.0.rc1" in the version string of "groff"
(and in the output of "git describe --debug")

What happened instead? (Actual behavior)

  "groff --version" shows for example "1.22.4.3317-8f8c8-dirty"

  "git describe --debug" shows:

describe HEAD
No exact match on refs or tags, searching to describe
finished search at 2ac1f9ba5578cad27dc547d5be3c91753db436ea
 annotated       3318 1.22.4
 annotated       3319 1.22.4.rc5
 annotated       3352 1.22.4.rc4
 annotated       3464 1.22.4.rc3
 annotated       3485 1.23.0.rc1
 annotated       3572 1.22.4.rc2
 annotated       3619 1.22.3.rc1
traversed 3833 commits
1.22.4-3318-g3a1e750d

What's different between what you expected and what actually happened?

  The latest tag is not shown for the groff version.

Anything else you want to add:


  The latest tag in "git log" is 1.23.0.rc1 in my branch.
  It is 1.23.0.rc1 in branch master.

  Search for "tag:" in "git log" in my branch shows:

commit c05b538c504106d55b81caa6400ea80797f03775 (tag: 1.23.0.rc1)
Author: Bertrand Garrigues <...>
Date:   Wed Nov 11 01:58:55 2020 +0100

  "git show-ref 1.23.0.rc1" in my branch shows:

faa3dff8d011e61721e763c71b6ccbf20a4675bc refs/tags/1.23.0.rc1

####

  "git-version-gen" (gnulib) does not get the latest tag.

  The call in configure.am is:

AC_INIT([GNU Troff],[m4_esyscmd(build-aux/git-version-gen --prefix ""
.tarball-version)],[http://savannah.gnu.org/bugs/?group=g$

  The files ".git/packed-refs" and ".git/info/refs" are the same in both
branches.

#####

[System Info]
git version 2.33.0 (Debian/testing Version: 1:2.33.0-1)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.9-2 #1 SMP Sun Oct 10 01:53:44 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


-- 
Bjarni I. Gislason
