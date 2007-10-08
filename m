From: Sam Vilain <sam@vilain.net>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 08 Oct 2007 15:28:23 +1300
Message-ID: <470995C7.40606@vilain.net>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>	 <20071007213817.GJ31659@planck.djpig.de>	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>	 <Pine.LNX.4.64.0710080018270.4174@racer.site>	 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>	 <Pine.LNX.4.64.0710080028301.4174@racer.site>	 <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>	 <Pine.LNX.4.64.0710080129480.4174@racer.site> <51419b2c0710071747w14d0c265x2de42fca50552394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 04:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeiMQ-00026z-Tf
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 04:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbXJHC2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 22:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXJHC2d
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 22:28:33 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58840 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbXJHC2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 22:28:33 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id B200C205A74; Mon,  8 Oct 2007 15:28:30 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 0F571205487;
	Mon,  8 Oct 2007 15:28:26 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <51419b2c0710071747w14d0c265x2de42fca50552394@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60280>

Elijah Newren wrote:
> On 10/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> It should be as easy as git filter-branch and git clone.
> 
> Yes, a git filter-branch, git clone, AND git gc in the clone avoids
> all those funny ref editing commands.  However, cloning a 5.6GB repo
> (the size of one of the real repos I'm dealing with) will likely take
> a long time (and may push me past the limits of disk space), so using
> other steps to avoid the need to clone actually seems nicer.

You can just delete the logs and references that you don't want and run
git gc --prune.

However.

git gc creates a new pack before deleting the old one.  Garbage
collection usually does this; make a copy of everything to a new place
and then free all of the old space.  If *that* is a problem, ie you
don't have enough space for two copies of the repository and the junk,
you'll have to do a partial import, leave the junk you don't want
unpacked, cleanup and prune, then finish the import.  Which sounds like
a lot of hassle when you should really just find a place with more space
to work with!

Sam.
