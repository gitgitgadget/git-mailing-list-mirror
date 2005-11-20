From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: still unclear on setting up a repository
Date: 19 Nov 2005 16:40:20 -0800
Message-ID: <86br0g883v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 20 01:41:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EddGM-0008F8-L7
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 01:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKTAk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 19:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKTAk0
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 19:40:26 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:47770 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750802AbVKTAkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 19:40:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id EBEE38F36B
	for <git@vger.kernel.org>; Sat, 19 Nov 2005 16:40:20 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20177-03-3 for <git@vger.kernel.org>;
 Sat, 19 Nov 2005 16:40:20 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 6A95C8F36C; Sat, 19 Nov 2005 16:40:20 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.14.11; tzolkin = 2 Chuen; haab = 9 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12357>


I'm really unclear here if it's me, the code, or the docs...

first, create the "remote"

        % cg-admin-setuprepo remote.git

that works fine, now set up the "local"

        % mkdir local.git
        % cd local-git
        % cg-init -m "junk message why should I have to do this one, it's dumb"

Now here's where I'm unclear.  I need to "push" this into the remote,
so I try this:

        % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"
        % cg-branch-ls

This seems to report the right thing.  I have a branch "origin"
that points at the remote repository.  So far, I think I'm understanding
what's happening.  But now, go boom:

        % cg-push
        cg-push: where to push to?

Huh?  How do I do the initial push?  Not this way?  Is it me, docs, or
code that is broken here?

UPDATE...

aha... "cg-push origin" works.  But "cg-push" is documented to
default to "origin".  Why doesn't it?

And then, another "go-boom" problem:

    % cg-fetch
    Hard links don't work - using copy
    Fetching head...
    cp: illegal option -- d
    usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
           cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN directory
    cg-fetch: unable to get the head pointer of branch master

Any chance you could make this more POSIX-like?  I know you have a big
warning in README.osx, but are you *really* needing all those weird
GNU-isms?  Maybe you could fall back to using rsync to copy exactly
what you need?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
