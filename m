From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: git-svn clone on a central server
Date: Sat, 15 Mar 2008 19:38:40 +0000
Message-ID: <frh8k1$lc8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 20:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JacFl-0004yA-44
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 20:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbYCOTkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 15:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYCOTkF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 15:40:05 -0400
Received: from main.gmane.org ([80.91.229.2]:40125 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbYCOTkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 15:40:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JacEc-0003sW-S9
	for git@vger.kernel.org; Sat, 15 Mar 2008 19:40:02 +0000
Received: from 87-194-245-197.bethere.co.uk ([87.194.245.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 19:40:02 +0000
Received: from Bruno.Harbulot by 87-194-245-197.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 19:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87-194-245-197.bethere.co.uk
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77339>

Hello,

I'm trying to follow example 3 of the git-svn manpage, since I'd like to 
keep a "central" clone of a subversion repository (and rebase it 
regularly) on a server and work on local git repositories based on that 
server's git repository.
However, I can't get this example to work:

# Do the initial import on a server
    ssh server "cd /pub && git-svn clone http://svn.foo.org/project
# Clone locally - make sure the refs/remotes/ space matches the server
    mkdir project
    cd project
    git-init
    git remote add origin server:/pub/project
    git config --add remote.origin.fetch=+refs/remotes/*:refs/remotes/*
    git fetch
# Initialize git-svn locally
    git-svn init http://svn.foo.org/project
# Pull the latest changes from Subversion
    git-svn rebase

('--add' doesn't work in git config, but I guess that's not required).

I get this error:

$ git-svn rebase
fatal: ambiguous argument 'HEAD': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions
log --no-color HEAD: command returned error: 128


I've then tried:

$ git checkout origin/master
warning: You appear to be on a branch yet to be born.
[...]
$ git branch master
$ git checkout master
$ git-svn rebase

However, this produces this error:
'Unable to determine upstream SVN information from working tree history'


Any idea how to solve this?

Best wishes,


Bruno.
