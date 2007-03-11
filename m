From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 15:05:53 +0100
Message-ID: <20070311140553.GA18947@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com> <20070311133350.GA12553@moooo.ath.cx> <fcaeb9bf0703110646p5417048bx27f119679c01e988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 15:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQOgS-0001Ig-Kd
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 15:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933631AbXCKOF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933633AbXCKOF5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 10:05:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:42563 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933631AbXCKOF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 10:05:56 -0400
Received: (qmail invoked by alias); 11 Mar 2007 14:05:54 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp020) with SMTP; 11 Mar 2007 15:05:54 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+pmI1NCaWpkEet66HIvTtkIx697y8WAdC78oZODP
	fHpaR4MS4QFZU9
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703110646p5417048bx27f119679c01e988@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41925>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Yes I expected it to move the specified working directory as described
> in the previous mail (copied/pasted below). However the patch requires
> me to be in workdir somewhere already (which is fine if that is your
> expectation). If that's the case, maybe you should tell users
> something about GIT_WORK_DIR not applicable.

Let's say we have GIT_DIR=/tmp/git GIT_WORK_DIR=/tmp/foo and are in
/tmp.  You want `git add bar` to chdir to /tmp/foo and add the file
bar from /tmp/foo?

> >Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> >> By the way, is it plausible to add --git-workdir option to specify
> >> working directory? With that option, I won't need to _chdir_ to the
> >> working directory, run git commands and _chdir back_.
I thought you meant the chdir to the toplevel directory when you're in
a subdirectory.  For this case I'd rather suggest
mygit() {
    old=$(pwd)
    cd "$MYTOPDIR"
    git "$@"
    ret=$?
    cd "$old"
    return $ret
}
