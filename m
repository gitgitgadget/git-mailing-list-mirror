Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A5C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2BE60F02
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhJXUWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJXUWS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 16:22:18 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Oct 2021 13:19:56 PDT
Received: from viathinksoft.de (viathinksoft.de [IPv6:2001:1af8:4700:a07e:1::1337])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1722C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 13:19:56 -0700 (PDT)
Received: by viathinksoft.de (Postfix, from userid 114)
        id 07C5F61C6EA9; Sun, 24 Oct 2021 22:11:47 +0200 (CEST)
Received: from webmail.viathinksoft.de (localhost [127.0.0.1])
        (Authenticated sender: daniel-marschall@viathinksoft.de)
        by viathinksoft.de (Postfix) with ESMTPA id 59FA061C04B2
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 22:11:46 +0200 (CEST)
MIME-Version: 1.0
Date:   Sun, 24 Oct 2021 22:11:46 +0200
From:   Daniel Marschall <info@daniel-marschall.de>
To:     git@vger.kernel.org
Subject: git-svn bug: Output git directory has uncommitted changes
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <77aacb3b44523223c7647bdae1702a31@daniel-marschall.de>
X-Sender: info@daniel-marschall.de
Organization: ViaThinkSoft
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have found following bug in the latest version of git-svn . I have 
this issue with the old version shipped in Debian stable, as well as 
with the latest version built from source.


What did you do before the bug happened? (Steps to reproduce your issue)

Extract the following SVN repository to GIT: 
https://svn.viathinksoft.com/svn/filter_foundry/
The bug ONLY happens with this single SVN repository. All other SVN 
repositories from my server work perfectly.

$ PERL5LIB=perl/ ./git-svn --authors-file="../../authors.txt" clone 
--trunk="trunk" "https://svn.viathinksoft.com/svn/filter_foundry/" 
"_test"
$ cd _test
$ git status

What did you expect to happen? (Expected behavior)

git status should show that nothing needs to be commited.

What happened instead? (Actual behavior)

You get a long list of files which need to be committed. The list is 
sometimes longer and sometimes shorter. So, the behavior is not 
deterministic. I have the feeling that the list often contains all files 
in the repo.

Anything else you want to add:

This SVN repository was cloned from a foreign server to my own server, 
and then continued there. I think this SVN repository has some specific 
properties that cause the bugs.

Authors.txt file (changed email addresses for privacy reasons):

daniel-marschall = Person 1 <person1@example.com>
www-data = Person 2 <person2@example.com>
root = Person 3 <person3@example.com>
toby = Person 4 <person4@example.com>
ddenk = Person 5 <person5@example.com>
peter = Person 6 <person6@example.com>
dmarschall = Person 7 <person7@example.com>



[System Info]
git version:
git version 2.33.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18) 
x86_64
compiler info: gnuc: 8.3
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
