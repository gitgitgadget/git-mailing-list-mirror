From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Tue, 03 May 2005 19:14:07 +0200
Message-ID: <4277B15F.1020102@lsrfire.ath.cx>
References: <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org><E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org> <20050503012921.GD22038@waste.org> <4277A52E.1020601@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>,
	"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Andrea Arcangeli <andrea@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 19:08:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT0sU-0008Vn-Ep
	for gcvg-git@gmane.org; Tue, 03 May 2005 19:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVECROT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 13:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVECROT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 13:14:19 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:13486 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261399AbVECROM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 13:14:12 -0400
Received: from [10.0.1.3] (p508E7DAB.dip.t-dialin.net [80.142.125.171])
	by neapel230.server4you.de (Postfix) with ESMTP id 70D5E222;
	Tue,  3 May 2005 19:14:09 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <4277A52E.1020601@tmr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bill Davidsen schrieb:
> On the theory that my first post got lost, why use /usr/bin/env at 
> all, when bash already does that substitution? To support people who 
> use other shells?
> 
> ie.: FOO=xx perl -e '$a=$ENV{FOO}; print "$a\n"'

/usr/bin/env is used in scripts in the shebang line (the very first line
of the script, starting with "#!", which denotes the interpreter to use
for that script) to make a PATH search for the real interpreter.
Some folks keep their python (or Perl, or Bash etc.) in /usr/local/bin
or in $HOME, that's why this construct is needed at all.

Changing environment variables is not the goal, insofar this usage
exploits only a side-effect of env.  It is portable in practice because
env is in /usr/bin on most modern systems.

So you could replace this first line of a bash script:

   #!/usr/bin/env python

with this:

   #!python

except that the latter doesn't work because you need to specify an
absolute path there. :]

Rene
