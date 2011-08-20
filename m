From: nUxi Codes <code@nuxi.name>
Subject: 'git submodule update' w/ .gitmodules 'update=merge' behaves
 differently on git 1.7.6 vs 1.7.2.5
Date: Sat, 20 Aug 2011 00:19:21 -0400
Message-ID: <CAD7xuUmtndhbWz7H0uQJ3gkbqurBGOsK8ATx6og9VifS6kc9fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 06:34:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QudGa-0003Cx-RK
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 06:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab1HTEbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 00:31:40 -0400
Received: from mail-gx0-f194.google.com ([209.85.161.194]:49541 "EHLO
	mail-gx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1HTEbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 00:31:39 -0400
Received: by gxk27 with SMTP id 27so550285gxk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 21:31:39 -0700 (PDT)
Received: by 10.236.176.67 with SMTP id a43mr600166yhm.54.1313813961870; Fri,
 19 Aug 2011 21:19:21 -0700 (PDT)
Received: by 10.236.43.202 with HTTP; Fri, 19 Aug 2011 21:19:21 -0700 (PDT)
X-Originating-IP: [128.61.83.190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179752>

I have a repository with a submodule configured.
In .gitmodules, the "update = merge" option is set for the submodule.
I am cloning the repo down from, for example, GitHub.
After cloning the parent repo down, I run a:

    git submodule init
    git submodule update

With git 1.7.2.5 from Squeeze, the resulting submodule repo is
unexpectedly bare.  The contents aren't there. 1.7.2.5 is printing:

    ... (git clone) ...
    user@oldhost:~/parentdir$ git submodule init
    Submodule 'mysubmodule' (git://github.com/user/submodule.git)
registered for path 'submoduledir'
    user@oldhost:~/parentdir$ git submodule update
    Cloning into submoduledir...
    remote: Counting ....(skipping the obvious).... deltas: 100%
(###/###), done.
    Already up-to-date.
    Submodule path 'submodule': merged in
'450e1a4ca6705c193d92b34e247fb63d32416c81'
    user@oldhost:~/parentdir$ ls submodule
    .git
    user@oldhost:~/parentdir$


With git 1.7.6 built on FreeBSD, the contents of the submodule are
there.  It is not bare.

    ... (Same) ...
    Submodule path 'bundle/pathogen': checked out
'450e1a4ca6705c193d92b34e247fb63d32416c81'
    user@newhost:~/parentdir$ ls submodule
    .git                            Stuff                   Things
     .gitignore ...etc...
    user@newhost:~/parentdir$


Why the difference?  Was this fixed intentionally?
If so, why hasn't Debian backported the fix?  It breaks a very common
way of setting things up.
