From: Neil <kngspook@gmail.com>
Subject: Adding Missing Tags to a Repository
Date: Tue, 5 Feb 2013 20:45:37 -0800
Message-ID: <CANC5J9F5Pnp08KTem-fdcs_4DcmoN+OgqCHR0=r0y--U8=fdog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 05:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2wtt-0006YV-4L
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 05:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab3BFEqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 23:46:01 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:63811 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3BFEp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 23:45:59 -0500
Received: by mail-bk0-f50.google.com with SMTP id jg9so428892bkc.9
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 20:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Q4CgSJw+XLYiV5Zo1RmqYI25J7qGDOBQrDzdnqefsXY=;
        b=R0syGju8Nrz350h9T9LdK7PJitQU8f9W5YTCjXcZqr0soELVa1qTFX6/qIsan/I9Gc
         AEOGZ3a8IsBh+vkdZcIty6KxuKNbCDHLz4qmZujHAJyaEqZBMvv+ZKdtYzsEvG6MTkcC
         XaRIWp+ZmItyM4EU84ct4bV4nB8c8QGVOut2cb0Yr5l68dxAnawX5hCbC7WTOW7CZaAO
         7fPqlM4aKrsHu61+z0pptYqd0DJ7ucBN6+NQiDPpDQZBbCxDyghg70kmZLQLme6yDQfn
         LuFywdgQPsZyS5JUSmuJzs22T0EWvEQwP1SNAmLY6xRkqdyCTWrrTXHcl6ewAi+ke45V
         RUcA==
X-Received: by 10.204.5.211 with SMTP id 19mr7236882bkw.29.1360125957369; Tue,
 05 Feb 2013 20:45:57 -0800 (PST)
Received: by 10.204.33.77 with HTTP; Tue, 5 Feb 2013 20:45:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215561>

Hi everyone,

A while back I did a svn-to-git migration for my team. Our subversion
repository had about 30K+ commits, 100+ branches, 2K+ tags, all made
over a 20+ year period. I was doing the migration using git-svn, and
my big problem was the tags. git-svn seemed to want to traverse the
entire history of each tag, which was taking a long time. Because time
and resources were limited, I ended up just migrating the branches and
trunk, with the idea that I would handle the tags at a later date. My
original plan to do that was to crawl the subversion log, find where
the tags were made, and apply a git tag to the commit that was the
source of the tag. This was a bad idea.

I've found that over the years, people have made tags that are only
subdirectories of the source tree, made tags off of other tags, and
committed to tags. The latter is the biggest problem, since those
commits don't seem to be stored in the git repository because they
never appeared in the branches/trunk.

So, I'm wondering what my options are to bring back this history. One
idea is to somehow resume the git-svn download, but changing it to
also scan tags (it sounds like it should be possible, but I haven't
tried it yet). Or maybe there's some other tool that will more quickly
clone the repository including tags, and then I can somehow splice the
tags back into the repository we're already using?

Any ideas or suggestions?

Thanks!
