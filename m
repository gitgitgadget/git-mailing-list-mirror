Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2002036C
	for <e@80x24.org>; Wed,  4 Oct 2017 19:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdJDTM4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 15:12:56 -0400
Received: from en.tunna.org ([128.199.38.102]:51209 "EHLO en.tunna.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbdJDTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 15:12:54 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Oct 2017 15:12:54 EDT
Received: from david (c83-254-16-224.bredband.comhem.se [83.254.16.224])
        by en.tunna.org (Postfix) with ESMTPSA id 95C6B5FB6D
        for <git@vger.kernel.org>; Wed,  4 Oct 2017 21:06:18 +0200 (CEST)
From:   =?utf-8?Q?David_Sp=C3=A5ngberg?= <david@tunna.org>
To:     git@vger.kernel.org
Subject: Weird behavior/bug for git clean in untracked directory 
Date:   Wed, 04 Oct 2017 21:06:18 +0200
Message-ID: <8760bu7mxh.fsf@tunna.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I'm a little bit confused about the behavior of git clean when trying to
clean multiple files/directories at once. For instance if I create two
directories with an empty file in an new git repository as such:

  mkdir tmprepo
  cd tmprepo
  git init
  mkdir a b
  touch a/file b/file

and try to clean both these files at the same time with git clean as
such:

  git clean -f a/file b/file

then git will not clean any of the files. However, if I separate the
cleaning into two separate calls like this:

  git clean -f a/file
  git clean -f b/file

then both directories will be cleaned. The git clean manual page suggests
git clean should support multiple paths/directories:

  SYNOPSIS
         git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...

  DESCRIPTION
         ...
         If any optional <path>... _arguments_ are given, only those _paths_ are affected.

The expected behavior for me would be that there should be no difference
between the first `git clean...' with two files and the two
`git clean...' with one file each.

I've tested on the following git versions so far:

  * 2.1.4
  * 2.14.2
  * 2.14.2.959.g6663358d3 (currently latest on next branch)


Best regards,
David
