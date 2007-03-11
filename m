From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import: use binary search in tree_content_remove
Date: Sun, 11 Mar 2007 12:54:32 -0400
Message-ID: <20070311165432.GA13555@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net> <20070310192304.GB3416@coredump.intra.peff.net> <20070310194012.GA5126@coredump.intra.peff.net> <20070311033833.GB10781@spearce.org> <20070311163412.GB7110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQRJr-0005tV-KY
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933837AbXCKQyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933839AbXCKQye
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:54:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3452 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933837AbXCKQye (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:54:34 -0400
Received: (qmail 6362 invoked from network); 11 Mar 2007 12:54:54 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Mar 2007 12:54:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Mar 2007 12:54:32 -0400
Content-Disposition: inline
In-Reply-To: <20070311163412.GB7110@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41942>

On Sun, Mar 11, 2007 at 12:34:13PM -0400, Jeff King wrote:

> > I'm plastering over the problem by resorting a tree strictly by
> > name after it has been written out and the deleted entries have
> > been filtered out.
> I wonder if we could make this a bit cleaner by actually using the git
> sort in the first place. I will take a look...

Hrm, it's not that hard to pass the mode around and use
base_name_compare, but I don't think that's enough. Any time we turn an
entry into a tree, we'll have to resort. I think your patch is simpler
and less error prone.

-Peff
