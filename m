From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 15:28:20 -0700
Message-ID: <20090707222820.GC11191@spearce.org>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907072206170.3155@pacific.mpi-cbg.de> <20090707201326.GB11191@spearce.org> <7vk52k9lvw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOJ9I-0006uk-VF
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 00:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbZGGW2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 18:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbZGGW2V
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 18:28:21 -0400
Received: from george.spearce.org ([209.20.77.23]:48187 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbZGGW2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 18:28:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C94BF38195; Tue,  7 Jul 2009 22:28:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk52k9lvw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122882>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> 
> >> > * jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
> >
> > I was thinking about this the other day.  We could use a hash of
> > the commit timestamp as the top level directory.  E.g. if we take
> > the commit time of the commit and convert it to a date string,
> > we could make the note path e.g.:
> >
> >   YYYY/MM/COMMITSHA1
> 
> Is the idea to make the tree object we need to scan for that particular
> SHA-1 hash smaller?

No, the idea was to avoid needing to create a massive hash of all
commit notes just to answer `git log -10` on the current branch.
I remember that was a concern last time we were talking about this.
By putting the notes under a timestamped path we can scan only a
small percentage of the notes before we have sufficient data to
output the first few commits.

> If so, I am not sure how it would help over another approach of say taking
> the first four hexdigits from the SHA-1 to use as the initial fan-out
> YYYY, then two hexdigits for the secondary fan-out MM.

See above, the idea is to avoid scanning all notes at once on
startup.  SHA-1 is bad at this as a fanout because it is too good
at uniform distribution of the names.
 
> But probably I am missing something.
> 
> Besides, trees and blobs cannot be annotated with that approach.

True.  But I didn't realize that was a goal.  :-|

-- 
Shawn.
