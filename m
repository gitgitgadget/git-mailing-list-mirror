From: "Alf Clement" <alf.clement@gmail.com>
Subject: Re: problem with branches
Date: Mon, 2 Jun 2008 15:59:22 +0200
Message-ID: <556d90580806020659i3cd6ef1dt86bbd4e332f92ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 16:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Aay-0001Hh-HV
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 16:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbYFBN70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 09:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762254AbYFBN70
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 09:59:26 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:11179 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbYFBN7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 09:59:24 -0400
Received: by ik-out-1112.google.com with SMTP id c28so293298ika.5
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=bwDXbOE5SH5XEaA2w55u2xdaJFv37Q51loHMMOxo7hY=;
        b=Y8j81kaguf3QlJEVXKLa2MUGXh+Xf3uxls42fWFZHLS4wbi/ybxUL+KjaVN+HczoIZxbuIE0ho8EnCiU8t1DGeFBa2Piw7pszmQCFEZmv6faCdvEbOhzC6hrTkIEoZjGVlMRsJhzIK58s6yfHcQPorBmwd/Tr+xrAwEx4jsWd/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oNw2py8Ev9F+J6l5NU0nN7OvRlg14X25YL75C/6IKuAHOoLo0+RTaMSqjLHwmD71rRqMiiLv6SnRKYYhkAVv76WQ+s/kcBcJWIFCyUKNAOuMpPhF/xLB/jjrWBpYv6H4qO5S6XMMLXxm48FoeeBnljdm1IKEUnt5gny6PLZAAMw=
Received: by 10.78.138.6 with SMTP id l6mr242760hud.41.1212415162879;
        Mon, 02 Jun 2008 06:59:22 -0700 (PDT)
Received: by 10.78.144.18 with HTTP; Mon, 2 Jun 2008 06:59:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83522>

Hi all,

after debugging quite some while, I found out that the problems comes from
hooks/update script.

It checks for the project description - which I didn't set, default
was present -
and complains. The script  gets the correct paths but the description is empty,
even if I change the description file.

I am working on some 1.5.5.1 version of git.

Would be nice to transport the messages from server to the client to
get better hints what goes wrong...

CU,
Alf

I created 4 branches with a remote repository on a server.
I've changed some files locally, committed and now try to push... but
it fails with hook declined.
Now the status:
$ git pull -v
From git://XXXX/YY
 = [up to date]      TEST       -> origin/TEST
 = [up to date]      master     -> origin/master
 = [up to date]      v1.03      -> origin/v1.03
 = [up to date]      v2.07      -> origin/v2.07
 = [up to date]      v3.11      -> origin/v3.11
Already up-to-date.

$ git push -v
Pushing to git://XXXX/YY
GIT TRANPORT
Looking up XXXX ... done.
Counting objects: 31, done.
Compressing objects: 100% (14/14), done.
Writing objects: 100% (21/21), 2.02 KiB, done.
Total 21 (delta 8), reused 0 (delta 0)
To git://XXXX/YY
 = [up to date]      TEST -> TEST
 ! [remote rejected] master -> master (hook declined)
 ! [remote rejected] v3.11 -> v3.11 (hook declined)
error: failed to push some refs to 'git://XXXX/YY'

I also get a warning when moving between branches:
$ git checkout v3.11
Switched to branch "v3.11"
Your branch is ahead of the tracked remote branch 'origin/v3.11' by 1 commit.

$ git checkout master
Switched to branch "master"
Your branch is ahead of the tracked remote branch 'origin/master' by 2 commits.

Any ideas how to recover from here?
The git-daemon seems to run fine, as I can commit and push from
another test project.
It would be nice if there were more clean failure messages from the
daemon...(Enhancement)

Thanks,
Alf
