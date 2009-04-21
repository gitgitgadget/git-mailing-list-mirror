From: skillzero@gmail.com
Subject: How to merge from newer branch to older branches?
Date: Tue, 21 Apr 2009 12:24:26 -0700
Message-ID: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 21:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwLbY-0001hh-HA
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 21:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbZDUTY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZDUTY3
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 15:24:29 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:44981 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZDUTY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 15:24:28 -0400
Received: by qyk16 with SMTP id 16so1405411qyk.33
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=KL39MAolsnlEiz6BoyzZgLAyzHGw8b+/rSLMcto57is=;
        b=Fa1vwoaBmgUyPoEF9+HhqurDUiLZwvjHYjvj2QcoO19EpDZ2aDuotGsy48LWQ5dErK
         +bUw9wmAgjFn4dAi7DiJ+lahpCsv6tmY8KvWSI/VhBlz83L2JXAR8LqVZfjWsV0TS+C9
         TX4Ft+Rp/19FpBoJDsW2qLIkbrm9BoujLjKzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FzEpQenCxDMbsk0aS/RMKIsyQL2gLTC5CnsXNAQm3T+++Zq9Kydd8jhl4yynpX6lhY
         3ldtkdu3Moav3E1B5djTU5Vur8l5asBFZtKh0VDN+8E04CSOL5J6P0o0ccPpBDr4tnCg
         /tfsFU2C1Gjz8o3o9Qc/5CndGgEkhHGJ7pksI=
Received: by 10.224.11.1 with SMTP id r1mr8254678qar.131.1240341866225; Tue, 
	21 Apr 2009 12:24:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117151>

I'm not sure how to merge a topic branch onto multiple branches
without conflicts or unwanted changes. My workflow probably isn't
ideal, but I often run into cases like this and wondered if there's a
way to solve it with git.

We have a "future" branch for new development. I wanted to add a new
feature so I branched from "future" to create a branch named
"feature". I completed the work, but now they've decided they need
that on two older branches. It looks like this:

future o-o-o-o-o-o-o
        \   \       \
1.2          o-o-o   \
          \           \
1.1        o-o-o       \
                        \
feature                  o-o-o
                         a b c

I've read I should have started from the oldest common denominator
branch that I might ever want, but at the time I created the branch,
"future" was it because we thought 1.1 and 1.2 were locked down and
not going to add new features. But things change and I need to roll my
feature into 1.1 and 1.2.

What's the best way to merge changes on the "feature" branch into the
1.1 and 1.2 branches? If I try to checkout 1.1 then 'git merge
feature', it (obviously) merges in a bunch of changes from "future"
that I don't want (and has a bunch of conflicts). I also tried just
cherry-picking commits a, b, and c from the "feature" branch. That
mostly worked, but there were some surprising conflicts. Text that had
been inserted into a couple files (which had been untouched in 1.1 and
1.2) caused a conflict when it seemed like it should have just added
the lines without conflict. I realize it's difficult to know why it
conflicted without seeing the changes, but I'm just asking in a more
general way how I should be doing merges like this.

Is cherry-picking the best way? It seems pretty tedious because I have
to do each commit in reverse order (although I could script it). I was
hoping there was a way to say "apply all the changes from when
"feature" branched up to its tip". I would also like to preserve the
commit history rather than just making making one big commit of all
the changes.
