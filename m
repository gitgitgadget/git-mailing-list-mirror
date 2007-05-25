From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 18:23:36 +0200
Message-ID: <200705251823.37062.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> <200705251559.53846.Josef.Weidendorfer@gmx.de> <alpine.LFD.0.98.0705250830220.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 25 18:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrcaI-0007da-He
	for gcvg-git@gmane.org; Fri, 25 May 2007 18:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762693AbXEYQXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 12:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbXEYQXk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 12:23:40 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:38801 "EHLO
	tuminfo2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762693AbXEYQXj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 12:23:39 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id C7D2528DB;
	Fri, 25 May 2007 18:23:37 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.98.0705250830220.26602@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48392>

On Friday 25 May 2007, Linus Torvalds wrote:
 
> On Fri, 25 May 2007, Josef Weidendorfer wrote:
> >
> > * Submodules can appear/disappear any time in the superproject.
> > Therefore, going back in time can make it necessary to have to clone
> > a submodule you did not have before.
> 
> You missed the obvious thing here: if a submodule 
> appears/disappears/moves, then the module info *has* to be versioned.

I never refused the need for a versioned .gitmodules file in-tree;
I totally agree with you here. Perhaps I forgot to mention this
because I took it for granted.

>  - because some people will want to replace repository addresses etc, you 
>    want to have a per-repo (or user, or system) *mapping* of that
>    versioned submodule information,

Yes.
So now we have 2 levels of submodule configuration:
(1) In-tree, versioned together with the superproject tree
(2) Local overrides via .git/config.

AFAICS the whole discussion here is about whether we need
a further configuration level with different visibility:
one which in not versioned together with the superproject
history, but which can be cloned, ie. a superproject-wide
configuration (*1*).
And I can see a need here for submodule URLs.

But as I just said in another mail in this thread, that
would be an additional feature which can be added later
if we see that  - because of whatever strange use cases
for submodules - some git users are forced to constantly
adapt 50 URL rewritings in their local config.

Josef

*1* For project-wide configuration, independent of the
actual project history, a completely separate branch
can be used (lets say refs/projectconfig), which
contains one blob, the config file: "projectconfig".
By making "git-config" to also parse
"refs/projectconfig:projectconfig" before the other
config files if existing, this gives us a natural way
to provide project wide settings.
