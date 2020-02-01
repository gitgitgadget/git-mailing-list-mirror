Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C82C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 18:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A493920679
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 18:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgBASgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:36:22 -0500
Received: from sdaoden.eu ([217.144.132.164]:45484 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBASgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 13:36:22 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id D0CD616054; Sat,  1 Feb 2020 19:36:20 +0100 (CET)
Date:   Sat, 01 Feb 2020 19:36:19 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     git@vger.kernel.org
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: 2.25.0: git rebase -i fails to --continue with staged data
Message-ID: <20200201183619.tUTI7%steffen@sdaoden.eu>
Mail-Followup-To: git@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.16-104-gcdb7645a
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

  #?1|kent:xxx.git$ git alias|grep rema
  alias.rema rebase -i master
...
  #?0|kent:xxx.git$ git status
  interactive rebase in progress; onto 4a17872e
  Last commands done (39 commands done):
     e 6c7e85ef FIXME src/mx/gen-cmd-tab.h: regenerated
     e 0314b1e7 FIXME src/mx/gen-okeys.h: regenerated
    (see more in file .git/rebase-merge/done)
  Next commands to do (41 remaining commands):
     pick 31fb18fb FIXME NEWS: v14.9.17 ("To bind, or not to bind.."), 2020-02-01
     pick 763c0a26 [v15-compat] Make *v15-compat*=yes a default!
    (use "git rebase --edit-todo" to view and edit)
  You are currently editing a commit while rebasing branch 'notpushed' on '4a17872e'.
    (use "git commit --amend" to amend the current commit)
    (use "git rebase --continue" once you are satisfied with your changes)

  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
          modified:   src/mx/gen-okeys.h

  #?0|kent:xxx.git$ git rebase --continue
  error:
  You have uncommitted changes in your working tree. Please, commit them
  first and then run 'git rebase --continue' again.
  #?1|kent:xxx.git$

So i was "e"diting commit

     e 0314b1e7 FIXME src/mx/gen-okeys.h: regenerated

but cannot simply --continue here --- before 2.25.0 this would now
open the editor and then commit what i have into a.k.a. as the
commit we are editing.  So if i now "commit --amend" i will amend
the commit before the one i want, if i commit anything else
i introduce a new commit.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
