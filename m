From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 07:29:34 -0800
Message-ID: <20090108152934.GA16840@spearce.org>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de> <20090108143257.GX21154@genesis.frugalware.org> <alpine.DEB.1.00.0901081541041.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 08 16:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKwqa-0008EZ-TF
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbZAHP3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbZAHP3g
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:29:36 -0500
Received: from george.spearce.org ([209.20.77.23]:34862 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZAHP3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 10:29:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8112738210; Thu,  8 Jan 2009 15:29:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901081541041.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104924>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 8 Jan 2009, Miklos Vajna wrote:
> 
> > On Thu, Jan 08, 2009 at 12:27:59PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > like git://your-host/repository.git
> > > 
> > > If the people are on different IPs, a hook can restrict who may clone, 
> > > since commit v1.6.1-rc1~109.
> > 
> > Hmm, but I think there is no hook called "pre-send" or so that could 
> > return status code 1 to prevent receiving, so that commit on its own 
> > does not does what Emily needs here.
> 
> Oops.  I assumed there is a pre-upload hook, but apparently I was wrong.
> 
> Would be easy to introduce that hook, though...

Well, sure, but Emily is asking about "no clone".

Does that mean that users can ask for incremental updates, but not
initial clones where there is nothing in common?

If so then any sort of hook needs an input parameter and needs
to be called after the commit negotation is complete, so the hook
can be told "the other side has some stuff" or "the other side has
nothing at all".

FWIW I was just yesterday talking to a co-worker about adding this
sort of behavior to Gerrit2.  Cloning the Linux kernel over its
internal sshd is quite a bit slower than doing it over native git,
so we were talking about blocking initial clones.  Everything in
a Gerrit server should be opensource and available over git://,
so its just a limit to save server resources.

-- 
Shawn.
