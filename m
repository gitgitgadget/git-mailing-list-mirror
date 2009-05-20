From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 07:17:09 -0700
Message-ID: <20090520141709.GO30527@spearce.org>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 16:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6mbf-0000Gy-0V
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 16:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbZETORK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 10:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZETORI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 10:17:08 -0400
Received: from george.spearce.org ([209.20.77.23]:56282 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbZETORI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 10:17:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 82025381FD; Wed, 20 May 2009 14:17:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119610>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 20 May 2009, Wincent Colaiuta wrote:
> > El 20/5/2009, a las 5:35, Nicolas Pitre escribi?:
> > 
> > > Having a "trash" reflog would solve this unambiguously.  That could also
> > > include your index example above.  However, in the index case, I'd
> > > record a reflog entry only if you're about to discard a previously non
> > > committed entry.  If you do:
> > > 
> > > 	$ git add foo
> > > 	$ git add bar
> > > 	$ git commit
> > > 	$ hack hack hack
> > > 	$ git add foo
> > > 
> > > then in this case there is nothing to be lost hence no additional entry
> > > in the "trash" reflog.
> > 
> > That's true in the example you provide, but it doesn't really handle Jeff's
> > initial example ("git add" twice on the same file), where it is possible to
> > throw away intermediate state (by overwriting).
> 
> Did I disagree with Jeff's original example?

No, but if you don't read closely enough to notice that the first
add affects path "foo" and the second add "bar", you might miss
what you were trying to say.  I almost thought you disagreed with
Peff until I read your example a 2nd time.  :-)

You did say "uncommitted entry causes reflog append", so in Peff's
original example of "git add a; vi a; git add a", we should be
creating a reflog entry for that first added state, which is clearly
not a disagreement.

FWIW, I think this is a great idea, but lack the time to code it
myself, otherwise I probably would start hacking on it right now.

-- 
Shawn.
