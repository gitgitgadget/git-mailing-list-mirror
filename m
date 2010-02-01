From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Sun, 31 Jan 2010 19:34:24 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001311846180.14365@iabervon.org>
References: <20100130020548.GA29343@cthulhu> <7vsk9oysds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 01:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbkFO-0004bz-Qg
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 01:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab0BAAe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 19:34:26 -0500
Received: from iabervon.org ([66.92.72.58]:37586 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075Ab0BAAe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 19:34:26 -0500
Received: (qmail 23420 invoked by uid 1000); 1 Feb 2010 00:34:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Feb 2010 00:34:24 -0000
In-Reply-To: <7vsk9oysds.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138568>

On Fri, 29 Jan 2010, Junio C Hamano wrote:

> As I said in my review during the earlier rounds, I do not know if it is
> safe to use the flags and do the traversal inside this same process.  You
> may be clearing the flags to protect your traversal (one per branch) from
> stepping on each other, but how would this affect the use of object flags
> in existing parts of the "push" machinery?  Is the reasoning that even if
> push calls into traversal code and after it walked the commit ancestry for
> its own purpose, your addition will clear the flags and existing code will
> never look at object flags again, so this new code is free to use them and
> all is Ok?  As long as you made sure that nobody looks at object flags you
> modified, then I am fine with that---I just don't know if that is what is
> happening here, and that is why I am asking.
> 
> I'd need help from the usual "transport" suspects for this patch.

I'm pretty sure that the built-in transport implementations all clear the 
flags themselves before using them. The fetch side has to be able to fetch 
twice in order to handle tags, and the push side has to be able to push to 
multiple destinations. So both parts should be defending themselves 
against flags that are specificly confusing to that part.

	-Daniel
*This .sig left intentionally blank*
