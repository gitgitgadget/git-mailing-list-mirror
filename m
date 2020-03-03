Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B58C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442A620848
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgCCOBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:01:37 -0500
Received: from vps.thesusis.net ([34.202.238.73]:43526 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgCCOBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:01:36 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 09:01:36 EST
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 140A72AA2F
        for <git@vger.kernel.org>; Tue,  3 Mar 2020 08:53:32 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (ip-172-26-1-203.ec2.internal [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1OsGnURqi4xM for <git@vger.kernel.org>;
        Tue,  3 Mar 2020 08:53:31 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id CB1CF2AA32; Tue,  3 Mar 2020 08:53:31 -0500 (EST)
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Phillip Susi <phill@thesusis.net>
To:     git@vger.kernel.org
Subject: GIT_WORK_TREE; a recipe for disaster
Date:   Tue, 03 Mar 2020 08:53:31 -0500
Message-ID: <875zflh7dw.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git for windows version 2.25.0.windows.1.  Yesterday I was in
a bash command line and changed directories to another project.  I ran
git status and it complained about basically everything being deleted
when the files were sitting there just fine.  I thought that maybe it is
confused since I upgraded git recently and so I ran git checkout -f and
git clean -xfd to make sure that the working directory would be restored
to a pristine state.  I later changed back to the first project
directory where I was horrified to see that all of the files from the
second project had been checked out, and the changes in that project
that I had been working on for a few days had been deleted.

It seems the cause of this is that I had opened git bash from the git
gui menu instead of from the windows explorer menu.  In previous
releases, this cause GIT_DIR to be set ( I believe ), and so that
session of git bash was tied to that repoistory even if you changed
directories to another repository.  I always thought this was rather
annoying, but things seem to be worse now that I have upgraded, because
git now uses the index and hisotry log etc from the cwd, but compares
that index to files elsewhere.  This seems like a recipe for disaster.
Why does git gui set these environment variables at all, and could it
please stop?

