From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: using .gitmodule as default (was: git submodule init and redundant data in .gitmodules/.git/config)
Date: Thu, 16 Aug 2007 15:53:10 +0200
Message-ID: <200708161553.10991.Josef.Weidendorfer@gmx.de>
References: <20070815162005.GA18463@piper.oerlikon.madduck.net> <20070815163822.GC1070MdfPADPa@greensroom.kotnet.org> <20070815222907.GA7395@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 15:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILfnC-0007fL-S7
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 15:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757741AbXHPNxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 09:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492AbXHPNxP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 09:53:15 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:59083 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756885AbXHPNxO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2007 09:53:14 -0400
Received: from dhcp-3s-47.lrr.in.tum.de (dhcp-3s-47.lrr.in.tum.de [131.159.35.47])
	by mail.in.tum.de (Postfix) with ESMTP id 471C5282C;
	Thu, 16 Aug 2007 15:53:13 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070815222907.GA7395@piper.oerlikon.madduck.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56015>

On Thursday 16 August 2007, martin f krafft wrote:
> also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.15.1838 +0200]:
> > The (most appropriate) URL from which to get updates of a submodule
> > may be different for different people and therefore has to be stored
> > in .git/config.  It was then decided that the default value
> > for this URL should be stored in .gitmodules.  git submodule init
> > simply initializes the URL using this default value.  You are free
> > to not call git submodule init and set a (more) appropriate URL manually.
> 
> Ah. I shall prepare a patch against the manpage to make this more
> clear then. Thanks for your explanation.
> 
> I have one open question though: why require init? It makes perfect
> sense to allow for a local override, but unless I need to override
> it, git-submodule update should really just keep using the default,

The information in .gitmodules is only a default value for the URL,
and not to be actually used. The URL in the config has to exist and
will be used for updating. So the config value is not about overriding
anything, but is required information.

The URL should not depend on the current revision you have checked out
at the moment; otherwise, if the default URL in .gitmodules changed at
some point in the history, and you check out some earlier commit in the
superproject, the update of the submodule would not work: the
submodule project still resides on the new URL, regardless of the old
information in .gitmodules at the time of the old commit.

Josef
