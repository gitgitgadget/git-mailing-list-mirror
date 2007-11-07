From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 7 Nov 2007 15:30:16 +0000
Message-ID: <e2b179460711070730w4ca95989y14872665ddc8bfca@mail.gmail.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
	 <20071106210210.GA32159@glandium.org>
	 <Pine.LNX.4.64.0711062324590.4362@racer.site>
	 <e2b179460711070617h7e9af64egcde5122808a4d924@mail.gmail.com>
	 <Pine.LNX.4.64.0711071446190.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>,
	"Mike Hommey" <mh@glandium.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmrV-0003El-Ap
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbXKGPaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXKGPaU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:30:20 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:41078 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXKGPaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:30:18 -0500
Received: by an-out-0708.google.com with SMTP id b36so318255ana
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ytyiKOEjvQUi0awZIBxAsperxgdhqSXXK40S6Dfyvsc=;
        b=sqFxtF9WUu6VdwBV/ozeXQSd16QOMtBvnwex6wMyvl8f6HO79y5ZkyYWNlFHgtCZaZ9hTjp+g1PuchzMkVp94GhRzIaK7sdXyPjq9vBxY16NCkevfasyTXCo2bAqAKioikT5t3Xhofn1mHFx9oqCA0SJB3WDza3H3CRF5V+zIKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sV54snd+4+2ZuGyt64tDrtdts7gn9HsLWuK5wcmDzslIi/2Y390PcgyEILEn+e5uwnw05qgTokAHnUtibt9YjlAaPSO2B/mdX7mIjAdPlDA/oPN8IXwc4TZf1tsEEVS+5JTuKufr3thSkFLK4lIzRHVLmhcjEGytrYdqAwhncnI=
Received: by 10.90.86.10 with SMTP id j10mr5341415agb.1194449416688;
        Wed, 07 Nov 2007 07:30:16 -0800 (PST)
Received: by 10.90.51.10 with HTTP; Wed, 7 Nov 2007 07:30:16 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711071446190.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63825>

On Nov 7, 2007 2:47 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Equally GNU sed is available as a drop-in rpm for AIX. I wonder if it
> > would be worth adding Makefile support for a PATH prefix for the git
> > scripts, so they could prepend (in this case) something like
> > /opt/freeware/bin or /usr/linux/bin ?
> >
> > In our AIX environment many GNU tools are installed but I can't
> > guarantee they come first in the paths of the git users.
> >
> > I'm willing to work up a patch if there's any interest.
>
> Would that be a task for configure?  Because I am not sure if the GNU
> tools are installed in the same place on all AIX boxen...

Well let's say the patch would arrive earlier if it was based on the
shipped Makefile rather than the unholy abomination that is
autoconf... If the GNU tools have been installed via the IBM AIX
Toolbox for Linux Applications[1] then they'll be installed in
/opt/freeware/bin and /usr/linux/bin will be a set of symlinks to
them.

That said, there may be 32/64bit differences and of course anyone
could have rolled their own sed, awk, diff, patch, grep, sort etc in
/usr/local/bin or anywhere else, and I'd guess this might be useful
for Solaris / HPUX users etc.

I was thinking along the lines of the existing $SHELL_PATH, i.e. a
build-time manually-set Makefile/environment variable. I'd also like
to be able to override gitexecdir in the same way without having my
builds marked dirty.

Cheers, Mike

[1] http://www-03.ibm.com/systems/p/os/aix/linux/download.html
