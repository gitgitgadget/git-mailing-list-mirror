From: Caio Marcelo de Oliveira Filho <caio.oliveira@openbossa.org>
Subject: Re: Different behaviour of rebase -i
Date: Thu, 09 Oct 2008 20:25:11 -0300
Message-ID: <m3vdw1e4h4.fsf@openbossa.org>
References: <6beb92080810091204n6df4338fs3b182194a8d6454e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 01:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko4yc-0002ww-2b
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 01:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbYJIXaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbYJIXaL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 19:30:11 -0400
Received: from main.gmane.org ([80.91.229.2]:46935 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbYJIXaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 19:30:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ko4xG-00013H-SE
	for git@vger.kernel.org; Thu, 09 Oct 2008 23:30:02 +0000
Received: from 200.184.118.132 ([200.184.118.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 23:30:02 +0000
Received: from caio.oliveira by 200.184.118.132 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 23:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 200.184.118.132
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:QlszHXj3CUvH9lck6BEOJDh8nzY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97904>


"Leonardo Sobral Cunha" <sobral@gmail.com> writes:
> Is this different behaviour of rebase -i expected or is this a bug?
> This is still happening in git version 1.6.0.2.443.g52e83

To illustrate the problem:

----8<----
~$ git --version
git version 1.6.0.2.514.g23abd3
~$ mkdir a
~$ cd a
~/a$ git init
Initialized empty Git repository in /home/cmarcelo/a/.git/

~/a$ touch A && git add A && git commit A -m "First commit"
Created initial commit d956e0c: First commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 A

~/a$ touch B && git add B && git commit B -m "Second commit"
Created commit 7b6512d: Second commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 B

~/a$ cd ..
~$ git clone a b
Initialized empty Git repository in /home/cmarcelo/b/.git/

~$ cd b
~/b$ git reset --hard HEAD~1
HEAD is now at d956e0c First commit

~/b$ git rebase -i origin/master
Nothing to do

~/b$ git show
commit d956e0ca33e10bac8a0a14200b1e13d84535d728
Author: Caio Marcelo de Oliveira Filho <caio.oliveira@openbossa.org>
Date:   Thu Oct 9 20:18:53 2008 -0300

    First commit

diff --git a/A b/A
new file mode 100644
index 0000000..e69de29

~/b$ git rebase origin/master
First, rewinding head to replay your work on top of it...
Fast-forwarded master to origin/master.
~/b$ git show
commit 7b6512d5f4b2c51753f4d06033651cee8e6d1460
Author: Caio Marcelo de Oliveira Filho <caio.oliveira@openbossa.org>
Date:   Thu Oct 9 20:19:11 2008 -0300

    Second commit

diff --git a/B b/B
new file mode 100644
index 0000000..e69de29
---->8----

Wasn't the first "rebase -i" supposed to get to "Second commit"?


-- 
Caio Marcelo de Oliveira Filho
OpenBossa Labs - INdT
