From: Theodore Tso <tytso@mit.edu>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Sun, 15 Apr 2007 23:01:03 -0400
Message-ID: <20070416030103.GB27533@thunk.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com> <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org> <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org> <20070416021729.GH2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 05:01:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdHTJ-0003mF-EO
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 05:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbXDPDB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 23:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbXDPDB3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 23:01:29 -0400
Received: from THUNK.ORG ([69.25.196.29]:57958 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351AbXDPDBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 23:01:18 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdHZB-0005e7-Md; Sun, 15 Apr 2007 23:07:46 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdHSh-0006rr-OG; Sun, 15 Apr 2007 23:01:03 -0400
Content-Disposition: inline
In-Reply-To: <20070416021729.GH2689@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44563>

On Sun, Apr 15, 2007 at 07:17:29PM -0700, Robin H. Johnson wrote:
> Nobody has addressed the single problem that I have with adding it when
> it's leaving the environment, and that's still of paramount concern to
> me. Simply put, there is a conflict between being able to add revision
> information of stuff leaving the environment, and those additions
> breaking previous checksums (which may be digitally signed, and thus
> breaking the signatures).
> 
> I'll reduce it further from my previous example.
> 
> 1. Developer commits some change to file A.
> 2. The checksum file is updated because A changed (the checksum file
>    explicitly does not contain keywords).
> 3. Developer signs the checksum file, and commits it.
> 
> If during the export process (which is undertaken elsewhere, by a
> different person or script), file A now has an expansion applied to it,
> you break the checksum file, which you CANNOT redo, because you lose the
> developer's digital signature on the checksum file!

Simple, the release engineer runs a script which exports the tree,
expanding any keywords and updating the checksum file as necessary,
and then the release engineer signs the checksum file!  As has already
been stated, if this doesn't work, you probably don't have a well
defined and formal release process. 

Just because a developer has signed a checksum doesn't mean that the
tree is suitable for release; that's the job of the release engineer
to confirm, probably after running a set of regression test suites.
And in fact, with git, it's pointless for the developer to sign a
checksum file and then commit it, since git is already maintaining
checksums as an integral part of how revisions are named.  

					- Ted
