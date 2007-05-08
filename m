From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to git-gc
Date: Mon, 7 May 2007 23:21:22 -0400
Message-ID: <20070508032122.GA10940@thunk.org>
References: <E1HlFqU-0002ir-GK@candygram.thunk.org> <alpine.LFD.0.99.0705072305270.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 08 05:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGGe-0007uf-Vf
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966337AbXEHDVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXEHDVc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:21:32 -0400
Received: from THUNK.ORG ([69.25.196.29]:47038 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256AbXEHDVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:21:31 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlGNJ-0000JV-Gr; Mon, 07 May 2007 23:28:29 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlGGQ-0006gs-PF; Mon, 07 May 2007 23:21:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705072305270.24220@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46524>

On Mon, May 07, 2007 at 11:13:58PM -0400, Nicolas Pitre wrote:
> On Mon, 7 May 2007, Theodore Ts'o wrote:
> 
> > Sometimes users might want to use more aggressive packing options
> > when doing a git-gc.  This allows them to do so without having
> > to use the low-level plumbing commands.
> 
> The 'git repack' command isn't _that_ low level, is it?  
> git-pack-objects is plumbing for sure, but not git-repack?
> 
> Especially if you're aware and interested in those options, you won't be 
> afraid of 'git repack -a -f -d --window=...".
> 
> In the context of "gc", having an option that reads "window" looks a bit 
> strange too.

I suppose, but you either need to then know all of the other commands
which git-gc runs, and do them manually, skipping git-gc altogether,
or use git-gc, and end up rewriting the pack twice, ince using the
git-repack in git-gc, and then once manually so you can give the
options that you really want to give to git-repack.

Maybe the right approach is to have a way to specify default --window
and --depth as git configuration variables?  Looks like there is a
pack.window already, but not a pack.depth.

What if we add a pack.depth configuration option, and add only
--no-reuse-delta to git-gc?   Would that be better?

						- Ted
