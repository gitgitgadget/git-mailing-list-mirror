From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 06/11] Add support for mark references as path names
Date: Mon, 27 Jul 2009 11:35:17 -0700
Message-ID: <20090727183517.GN11191@spearce.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <1248656659-21415-7-git-send-email-johan@herland.net> <20090727141200.GJ11191@spearce.org> <200907272026.46150.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVV3A-000191-En
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZG0SfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZG0SfS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:35:18 -0400
Received: from george.spearce.org ([209.20.77.23]:60512 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZG0SfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:35:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0E6ED381FD; Mon, 27 Jul 2009 18:35:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907272026.46150.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124181>

Johan Herland <johan@herland.net> wrote:
> On Monday 27 July 2009, Shawn O. Pearce wrote:
> > I think you need to find another back door, something that the
> > language wouldn't have considered as valid previously.
> 
> Ok. One (moderately hideous) option is to introduce new commands m/d/r/c 
> that works just like M/D/R/C, except that they also expand mark 
> references (leaving M/D/R/C with the old behaviour). I don't know how 
> you'd feel about that...

Bleh.  Because I think this has more truth to it:
 
> However, I'm also pondering Dscho's idea of organizing note trees into 
> hierarchies (to limit #entries in tree objects), and (although I have 
> yet to try to implement this) it feels like this transformation should 
> be done in the notes.c code, which means that it must happen on 
> the "git side" of fast-import (at least the transformation should not 
> happen on the "external side" of fast-import). This ultimately means 
> that we cannot handle notes as "regular" trees and commits (which is 
> what I'm trying to do with the help of this patch), and suggests that 
> instead of using 'commit' with 'M' for adding notes, we should probably 
> have a dedicated 'note' fast-import command that collects note objects, 
> and does the tree transformation and subsequent commit upon 
> checkpoint/exit.

Exactly.  We probably want to do this instead.

Though you might want the "note" command to be a subcommand of
commit, like M/D/R/C are, because notes are wrapped up inside of
a commit and you can modify multiple notes in a single commit.

-- 
Shawn.
