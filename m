From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Sun, 6 Jul 2008 18:11:01 +0200
Message-ID: <20080706161101.GB23385@jhaampe.org>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFXF4-0006iQ-7Z
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 18:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbYGFQgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 12:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756804AbYGFQgf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 12:36:35 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44102 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686AbYGFQge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 12:36:34 -0400
X-Greylist: delayed 1709 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jul 2008 12:36:34 EDT
Received: from jhaampe.org (p5B3CCD36.dip.t-dialin.net [91.60.205.54])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id F38D433178;
	Sun,  6 Jul 2008 18:11:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4lro7ct.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Sun Jul  6 18:11:03 2008 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.013534, queueID=AEE903317A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87540>

> > +test_expect_success 'adding an already-existing repository deep in the directory hierarchy' '
> > +
> > +        mkdir dir0 &&
> > +        mkdir dir0/dir1 &&
> > +        git clone init dir0/dir1/init &&
> > +        git-submodule add dir0/dir1/init &&
> > +        git-submodule status | grep "dir0/dir1/init"
> > +'
> 
> I am not sure if this is fixing a sane use case.  "submodule add" is
> documented to take:
> 
>     'git submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
> 
> and you are adding at dir0/dir1/init a submodule that will interact with "init"
> repository, so shouldn't that command line be something like:
> 
> 	git submodule add init dir0/dir1/init

 	git submodule add dir0/dir1/init

Is supposed to add the repository already checked-out in dir0/dir1/init as a
submodule, at the same location.

 	git submodule add init dir0/dir1/init
    
Would clone dir0/dir1/init at ./init and add ./init as a submodule. This is
actually what the current git-submodule (wrongly) does.

Sylvain
