From: Rogan Dawes <lists@dawes.za.net>
Subject: Git doesn't like symlinks?
Date: Fri, 20 Jul 2007 13:19:07 +0200
Message-ID: <46A09A2B.3030205@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 13:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBqX2-0004fC-Uk
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 13:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbXGTLTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 07:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755883AbXGTLTp
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 07:19:45 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:40104
	"EHLO spunkymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755074AbXGTLTo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 07:19:44 -0400
Received: from [192.168.201.100] (dsl-146-26-37.telkomadsl.co.za [165.146.26.37])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id DE9A2FFD5F
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 04:19:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53085>

Hi folks,

I have been tasked with doing some development against an external SVN 
repo, and keeping it largely in sync with an internal directory.

Seeing as how this is a git list, I obviously decided to do this using 
git :-)

So, I have a local git repo with my local changes from the SVN repo, and 
I can push them to the SVN repo without too many problems. The problem 
arises when I try to sync with the local directory.

Since the local directory's structure doesn't match the repo exactly, I 
figured I could work around that by using a symlink to get to the right 
place.

ie. the local dir is
C:\local\blah\release\5.2\<contents>

and the structure of the SVN (and hence git) repo is:
/top/main/<contents>

where <contents> is/should be identical between the two places.

Obviously, git won't work correctly in the local dir, so I tried the 
following (on Cygwin)

$ cd /tmp
$ ~/git/contrib/workdir/git-new-workdir /my/git/repo/ repo-local
$ cd repo-local/top
$ rm -rf main/
$ ln -s /c/local/blah/release/5.2/ main/
$ git status

This worked, and showed me that there were a few files out of sync.

I decided to copy over one of the files from git to the local dir:

$ git checkout top/main/some/file

And git deleted my "main" symlink, and replaced it with a real dir, 
containing "some/file".

Everything _else_ was now "missing".

Any ideas on how I can get this to work? I know this is not strictly 
what git was designed for, but it could do a really good job if it would 
only leave my symlink alone.

Rogan
