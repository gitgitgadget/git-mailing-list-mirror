From: Johan Herland <johan@herland.net>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 17:03:20 +0200
Message-ID: <200910181703.20607.johan@herland.net>
References: <20091018144158.GA9789@gandalf.dynalias.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Sun Oct 18 17:04:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzXIz-0003Av-NH
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 17:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbZJRPDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 11:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbZJRPDV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 11:03:21 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38830 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751102AbZJRPDV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 11:03:21 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRP00LAVTTLBA10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 18 Oct 2009 17:03:21 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRP00FNBTTKB230@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 18 Oct 2009 17:03:21 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.18.144829
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <20091018144158.GA9789@gandalf.dynalias.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130596>

On Sunday 18 October 2009, Norbert Preining wrote:
> Now, there is one show-stopper I see. From our repository we create a
> set of "packages", and the maximum of the "last-changed" revisions of
> the contained files determine the "version" of the package. This
> guarantees that any change in a file will increase the revision number
> of the package (some tricks for removals have to be done). This is
>  necessary since we are distributing the packages from servers and the
>  version number pf a package determines whether it should be upgraded
>  (well known concept).
> 
> Now my question, is there any way to set up something similar with git?
> 
> My idea is that git - like subversion - could (if asked to) count each
> commit (global to the repository, irrelevant of the branch) and give it
> a version number. Since we all will use a bare repository on a server
> and pull/push from/to there, I think that something similar could be
>  possible.
> 
> So, before I delve into more gitty-nitty conversion, let me know if
> there is any chance for that, or we should stay with subversion.

A global, increasing version number ala SVN is fundamentally impossible in 
any distributed version control system (like Git).

However, you can get a useful version specifier from the "git describe" 
command. It will give you back something like the following:

    $ git describe
    v1.0.4-14-g2414721

where the "v1.0.4" part is the last tag that the current state is based on, 
the "14" part is the number of commit between that tag and the current 
state, and the "2414721" is the abbreviated object name (SHA1 id) for the 
current commit itself.

This is somewhat more complex than a simple version number, but guarantees a 
globally unique name for your current state that works in a distributed 
environment.

Also, I find "v1.0.4-14..." (i.e. 14 commits since v1.0.4) much more useful 
than, say, "12534" (i.e. 12534 commits since the start of the project).

See 'git help describe for more info'


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
