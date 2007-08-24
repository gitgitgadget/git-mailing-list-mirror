From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 18:06:22 -0400
Message-ID: <9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 00:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOhIQ-0001qT-S8
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 00:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759593AbXHXWG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759558AbXHXWGZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 18:06:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:33945 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759593AbXHXWGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 18:06:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1138998wah
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 15:06:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=boGgjvRX8GBomtc33Kkg33QgRzynj8CzFRLmV9yQrydtAfayw41Ioy1bBQvOklrYi4wFaUJcG2HFshC0sEJECi/hPfNZI9vYRnH8iJlJnlhEIOGcaFPzm8nUPW89iHhHjcN8zM/4avi5qKb3rETL6e0tF2MmjMn7epo1Gxtyc4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RbSNjWAobLtYHyVkb62hEGI6OKuPOiinQ0mM+ziTVR5RVphVN3otZvYQCxGzZYlNG4kxkddvD08xM2q19njCeuOkC091ugH9CFOKhmy/ZmbF2Hk90bcihTxaenoMPKaS6IUcjAAAmXDIQv/IdY6RTfKg+GkpFrivi2pXTo0aPBc=
Received: by 10.114.169.2 with SMTP id r2mr1677025wae.1187993182852;
        Fri, 24 Aug 2007 15:06:22 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 24 Aug 2007 15:06:22 -0700 (PDT)
In-Reply-To: <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56606>

On 8/24/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> We're going something wrong in git-daemon. I can clone the tree in
> five minutes using the http protocol. Using the git protocol would
> take 24hrs if I let it finish.

20Mb/s to kernel.org
time git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
real    2m34.629s

20Mb/s to kernel.org
time git clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
real    3m52.203s

Same kernel from my NSLU2 over http (100Mb/s)
time git clone http://jonsmirl.is-a-geek.net/apache2-default/mpc.git
real    2m36.227s

Using git protocol to nslu2 takes 24hrs

On 8/24/07, Nicolas Pitre <nico@cam.org> wrote:
> Try running "git repack -a" directly on the NSLU2.  You should have the
> same performance problems as with a clone.

This is true, it would take over 24hrs to finish.

Is their a reason why initial clone hasn't been special cased? Why
can't initial clone just blast over the pack file already sitting on
the disk?

I also wonder if a little application of some sorting to in-memory
data structures could help with the random IO patterns. I'm getting
the same data out of a stupid HTTP server and it doesn't go all IO
bound on me so a solution has to be possible.

-- 
Jon Smirl
jonsmirl@gmail.com
