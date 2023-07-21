Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C2EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 15:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGUPzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGUPzM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 11:55:12 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59003359F
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:54:49 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 36LFqfCs646084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 15:52:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG?] Confusion with git stash list
Date:   Fri, 21 Jul 2023 11:54:34 -0400
Organization: Nexbridge Inc.
Message-ID: <046c01d9bbeb$a8680bc0$f9382340$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adm766S6OUzDA0r1QxOwFl3MDdn1TQ==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

When using git stash list --all, I end up with every commit showing up in
the list of stash entries. I do not know whether this is intended.

It is simple to set up. You do need at least one stash, but the contents are
irrelevant. So given any repository, use git stash push. Then use git stash
list --all.

When no stashes exist, nothing is output:
$ git stash list --all

When adding a stash (the type of stash does not matter):
$ touch test1
$ git stash push -u
$ git stash list --all
stash@{0}: WIP on PROJ-710-allow-sub-volumes-to-split-arbitrary: 6909776a
t2406: add pattern sync test
HEAD@{0}: reset: moving to HEAD
stash@{0}: WIP on PROJ-710-allow-sub-volumes-to-split-arbitrary: 6909776a
t2406: add pattern sync test
origin/ PROJ-710-allow-sub-volumes-to-split-arbitrary@{0}: push:
forced-update
PROJ-710-allow-sub-volumes-to-split-arbitrary@{0}: commit: t2406: add
pattern sync test
HEAD@{1}: commit: t2406: add pattern sync test
origin/PROJ-710-allow-sub-volumes-to-split-arbitrary@{1}: update by push
PROJ-710-allow-sub-volumes-to-split-arbitrary@{1}: rebase (finish):
refs/heads/PROJ-710-allow-sub-volumes-to-split-arbitrary onto
fea6b45d8671660014d84f5b4538d66c1b91deab
HEAD@{2}: rebase (finish): returning to
refs/heads/PROJ-710-allow-sub-volumes-to-split-arbitrary
HEAD@{3}: rebase (fixup): PROJ-710: Prototype structure for mapping multiple
directories to a subvolume
HEAD@{4}: rebase (fixup): # This is a combination of 17 commits.
HEAD@{5}: rebase (fixup): # This is a combination of 16 commits.
HEAD@{6}: rebase (fixup): # This is a combination of 15 commits.
HEAD@{7}: rebase (fixup): # This is a combination of 14 commits.
HEAD@{8}: rebase (fixup): # This is a combination of 13 commits.
HEAD@{9}: rebase (fixup): # This is a combination of 12 commits.
etc...

This happens in 2.39.0.

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



