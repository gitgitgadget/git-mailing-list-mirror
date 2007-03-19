From: Theodore Tso <tytso@mit.edu>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 02:25:25 -0400
Message-ID: <20070319062525.GH11371@thunk.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org> <20070319032130.GF11371@thunk.org> <20070319035351.GI20658@spearce.org> <alpine.LFD.0.83.0703182355570.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 07:25:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTBJW-0000Kh-PV
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 07:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965692AbXCSGZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 02:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965694AbXCSGZs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 02:25:48 -0400
Received: from THUNK.ORG ([69.25.196.29]:42038 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965692AbXCSGZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 02:25:48 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HTBPD-0002Bh-Go; Mon, 19 Mar 2007 02:31:44 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HTBJ7-00038D-El; Mon, 19 Mar 2007 02:25:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.83.0703182355570.18328@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42594>

On Mon, Mar 19, 2007 at 12:08:47AM -0400, Nicolas Pitre wrote:
> > Its a little ugly here as I'm not sure we should always update
> > HEAD's reflog if HEAD points at a branch we are actually updating.
> > Maybe we should though in receive-pack ?
> 
> If the meaning of HEAD changed (although indirectly) because HEAD 
> happens to point to the branch that just got updated then logically the 
> HEAD reflog should be updated too.  On the other hand the HEAD reflog 
> should reflect operations performed on HEAD.  Since the push updates the 
> branch directly it is not exactly performing some operation on HEAD 
> since HEAD could point anywhere and that wouldn't change the push at 
> all.
> 
> Meaning that for the discussion of pushing to a non-bare repository with 
> a dirty working tree... If the branch being pushed into is not pointed 
> to by HEAD then no consideration what so ever about the working tree 
> should be made, and no update to the HEAD reflog made of course.

Right, but if the branch being pointed to is pointed to by HEAD I
would argue that the reflog for HEAD should be updated, since
operations that reference HEAD will see a new commit, and and it will
be confusing when "git reflog" shows no hint of the change.

Of couse, if the branch being pushed to isn't one which is pointed by
HEAD, of course HEAD's reflog shouldn't be updated.

						- Ted
