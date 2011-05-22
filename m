From: Christopher Wilson <cwilson@cdwilson.us>
Subject: Why does adding an existing repo as a submodule modify .git/config?
Date: Sun, 22 May 2011 13:02:54 -0700
Message-ID: <irbq5a$h38$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 22:03:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOErm-0000ng-7H
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 22:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab1EVUDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 16:03:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:49556 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab1EVUDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 16:03:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QOErd-0000hF-Ab
	for git@vger.kernel.org; Sun, 22 May 2011 22:03:01 +0200
Received: from c-98-210-218-165.hsd1.ca.comcast.net ([98.210.218.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 May 2011 22:03:01 +0200
Received: from cwilson by c-98-210-218-165.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 May 2011 22:03:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-210-218-165.hsd1.ca.comcast.net
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174199>

(I posted this question below on
http://stackoverflow.com/questions/6083357/why-does-adding-an-existing-repo-as-a-submodule-modify-git-config
and was recommended to ask the mailing list)

If I add a submodule that does not currently exist, no submodule
information is added to .git/config.

$ mkdir testing
$ cd testing
$ git init
$ git submodule add git@git.server:submodule.git
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true

However, if I add a repo that currently exists as a submodule, the url
is added to .git/config:

$ mkdir testing
$ cd testing
$ git init
$ git clone git@git.server:submodule.git
$ git submodule add git@git.server:submodule.git
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
[submodule "submodule"]
    url = git@git.server:submodule.git

I would have assumed that in both cases, git submodule add would have
only modified .gitmodules, and that git submodule init would have
updated the project's .git/config.

I'm aware this is intentional behavior
(https://github.com/git/git/commit/c2f939170c65173076bbd752bb3c764536b3b09b),
but I don't understand why.

Why is .git/config modified in the second case but not the first? Can
somebody explain the rational for this behavior?
