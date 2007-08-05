From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sun, 5 Aug 2007 05:36:45 -0400
Message-ID: <20070805093645.GD12507@coredump.intra.peff.net>
References: <20070804070308.GA6493@coredump.intra.peff.net> <Pine.LNX.4.64.0708041636290.14781@racer.site> <20070804160409.GA16326@sigill.intra.peff.net> <7vwswbgphu.fsf@assigned-by-dhcp.cox.net> <20070804175240.GB17113@sigill.intra.peff.net> <7vps23gnpj.fsf@assigned-by-dhcp.cox.net> <20070805080651.GB10863@coredump.intra.peff.net> <7v4pjefkdu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcXa-00050i-Qs
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXHEJgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbXHEJgs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:36:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1281 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbXHEJgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:36:47 -0400
Received: (qmail 15809 invoked from network); 5 Aug 2007 09:36:50 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 09:36:50 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 05:36:45 -0400
Content-Disposition: inline
In-Reply-To: <7v4pjefkdu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54974>

On Sun, Aug 05, 2007 at 01:36:29AM -0700, Junio C Hamano wrote:

> > I see, though the hardlink warning is a bit much.
> >
> > $ git-clone /path/on/fs/one /path/on/fs/two
> > Initialized empty Git repository in /path/on/fs/two/.git/
> > Warning: -l asked but cannot hardlink to /path/on/fs/one/.git
> > 36634 blocks
> 
> True; -l is not given explicitly in your example.  Should be
> trivial to fix.

Ah, indeed, I had assumed that it came from cpio (which also uses the -l
flag!), but reading the code, it's us. Given that "-l" is now the
default, and we silently downgrade to copying anyway, I don't see the
point of having any warning at all. Unless, I guess, for those people
who are still using "-l" even though it's a noop.

-Peff
