From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 09:27:58 +0200
Message-ID: <20070524072758.GG942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <11799589922243-git-send-email-skimo@liacs.nl>
 <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com>
 <20070524071819.GN28023@spearce.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 09:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7jy-0003mv-GW
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbXEXH2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755952AbXEXH2A
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:28:00 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:49116 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913AbXEXH17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:27:59 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ004EPBEMWE@psmtp04.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 09:27:59 +0200 (MEST)
Received: (qmail 10129 invoked by uid 500); Thu, 24 May 2007 07:27:58 +0000
In-reply-to: <20070524071819.GN28023@spearce.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48233>

On Thu, May 24, 2007 at 03:18:19AM -0400, Shawn O. Pearce wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:
> > 
> > >+       args[argc++] = "checkout";
> > >+       if (state->force)
> > >+           args[argc++] = "-f";
> > >+       args[argc++] = sha1_to_hex(ce->sha1);
> > >+       args[argc] = NULL;
> > 
> > You should consider passing "-v" if the superprojects read-tree
> > had it. Some submodules will be annoyingly big
> 
> In 1.5.2 that -v shouldn't be necessary.  The read-tree should
> start a timer, and if it has not reached 50% of its processing
> within 2 seconds it starts showing progress.  Unless !istty(2),
> in which case it just sits there, chugging away at your drive.

Well, git-checkout.sh has this line:

    merge_error=$(git-read-tree $submodules -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (

so actually you don't see anything right now when a submodule
checkout is going on during a checkout of the supermodule.

skimo
