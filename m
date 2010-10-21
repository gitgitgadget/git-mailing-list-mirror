From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 21 Oct 2010 10:44:41 +0200
Message-ID: <4CBFFD79.1010808@alum.mit.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <m3ocar5fmo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 10:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8qlX-0000a7-BF
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 10:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab0JUIop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 04:44:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56372 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0JUIoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 04:44:44 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o9L8igmI021993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 10:44:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.14) Gecko/20101006 Lightning/1.0b1 Thunderbird/3.0.9
In-Reply-To: <m3ocar5fmo.fsf@localhost.localdomain>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159489>

On 10/18/2010 11:57 PM, Jakub Narebski wrote:
> Well, there is different suggestion: make `git stage`, `git track` and
> `git mark-resolved` to be *specializations* of `git add`, with added
> safety checks: 'git stage' would work only on files known to git /
> under version control already, 'git track' would work only on
> untracked files (and do what 'git add -N' does), and 'git mark-resolved'
> would work only on files which were part of a merge conflict.

I think that is a great idea.  The thing that I found most confusing
when learning git is that variations on a single command often have very
different effects.  My pet peeve is the over-versatile "git checkout":

git checkout BRANCH : Check out a branch.  This is the functionality
that I would expect from a "checkout" command.

git checkout -b NEWBRANCH OLDBRANCH : For me this was unintuitive,
because (IMO) the main effect of the command is to create a new branch.
 (I consider that more significant than the checkout because it has a
persistent effect on the repository.)  Therefore, I would expect this
functionality to be provided by "git branch" (something like "git branch
--checkout NEWBRANCH OLDBRANCH").

git checkout -b NEWBRANCH : This is even more unintuitive, because no
content is being checked out at all.  This should be written "git branch
--checkout NEWBRANCH".

git checkout -- PATH : To me this is again a totally different
operation.  The other uses of "git checkout" are safe; they don't lose
any information.  But this usage discards the working copy changes
irretrievably.  Such a different operation deserves a different command
with a "dangerous-sounding" name.  I think this functionality should be
made more easily accessible via "git reset", as has been suggested
elsewhere on this thread.  (Unfortunately "git revert" is already taken.)

git checkout BRANCH -- PATH : This is even more perverse.  Usually
"check out" makes the working copy more similar to a version in the
repository.  But this command makes it more different.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
