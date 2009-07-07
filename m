From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 13:13:26 -0700
Message-ID: <20090707201326.GB11191@spearce.org>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907072206170.3155@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOH2k-0004y8-FH
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZGGUN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbZGGUN1
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:13:27 -0400
Received: from george.spearce.org ([209.20.77.23]:59229 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbZGGUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:13:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B06238195; Tue,  7 Jul 2009 20:13:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0907072206170.3155@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122867>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 6 Jul 2009, Junio C Hamano wrote:
> 
> > * jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
> >  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
> >  - Add an expensive test for git-notes
> >  - Speed up git notes lookup
> >  - Add a script to edit/inspect notes
> >  - Introduce commit notes
> > 
> > Dscho asked about the performance implications of this; I do not think I 
> > saw any progress on that yet...
> 
> Neither did I.

I was thinking about this the other day.  We could use a hash of
the commit timestamp as the top level directory.  E.g. if we take
the commit time of the commit and convert it to a date string,
we could make the note path e.g.:

  YYYY/MM/COMMITSHA1

The advantage is we only need to scan and hash the subtrees for
the range of commits we are currently producing output for.  As we
go further back in time, we can evict entries for newer dates and
hash the older dates.

-- 
Shawn.
