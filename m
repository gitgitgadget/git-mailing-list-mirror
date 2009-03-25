From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Wed, 25 Mar 2009 01:45:51 +0100
Message-ID: <200903250145.51386.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <sL3rt6iQWyznVMwP2SukD7BiuS1AVuqwVkMR4XSwA5SnK9TLmqyqAg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHIy-0000fA-9O
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560AbZCYAp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759556AbZCYAp5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:45:57 -0400
Received: from mx.getmail.no ([84.208.15.66]:61135 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759553AbZCYApz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 20:45:55 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH100BBGE4GPPE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 01:45:52 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH1007VPE4FSX70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 01:45:52 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.3121
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <sL3rt6iQWyznVMwP2SukD7BiuS1AVuqwVkMR4XSwA5SnK9TLmqyqAg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114528>

On Wednesday 25 March 2009, Brandon Casey wrote:
> Johan Herland wrote:
> > Some colleagues of mine are working on a "secret" project, and they
> > want to create a central/server/integration repo that should be
> > group-writable, but not at all accessible to anybody outside the group
> > (i.e. files should be 0660 ("-rw-rw----"), dirs should be 2770
> > ("drwxrws---")).
> >
> > I started setting this up for them in the following manner:
> >
> >   mkdir foo.git
> >   cd foo.git
> >   git init --bare --shared=group
> >   cd ..
> >   chgrp -R groupname foo.git
> >   chmod -R o-rwx foo.git
> >
> > ...and everything looks good, initially...
> >
> > However, when I start pushing into this repo, the newly created files
> > are readable to everybody (files are 0664 ("-rw-rw-r--"), dirs are 2775
> > ("drwxrwsr-x")).
>
> But nobody has access to anything under foo.git since you did
> 'chmod o-rwx foo.git' above.

Yes, it's hard (impossible???) for outside users to get at the files, since 
they reside in directories that are not readable to them. However, this does 
not at all hide the fact that:

1. The "chmod -R o-rwx" is a command I added myself. Nowhere in Git's 
documentation is it said that it is a good idea to run this command.

2. Preferably, when creating a 0660 repo, "git init" should automatically 
perform this chmod for you, in the same manner that it already sets the 
"set-gid" bit for group-shared repos.

> Unless I'm missing something, I think you already have what you want.

Maybe, but it certainly doesn't fill me with warm, fuzzy, secure feelings.

Am I being overly paranoid?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
