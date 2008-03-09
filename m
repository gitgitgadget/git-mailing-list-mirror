From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 08/11] Allow for having for_each_ref() list some refs
 that aren't local
Date: Sun, 9 Mar 2008 01:23:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803090116430.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081804170.19665@iabervon.org> <7vd4q4sg5r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 07:24:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYExW-0004AI-FI
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 07:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYCIGX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 01:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYCIGX6
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 01:23:58 -0500
Received: from iabervon.org ([66.92.72.58]:34996 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbYCIGXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 01:23:32 -0500
Received: (qmail 26833 invoked by uid 1000); 9 Mar 2008 06:23:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 06:23:30 -0000
In-Reply-To: <7vd4q4sg5r.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76636>

On Sat, 8 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This is useful, for example, for listing the refs in a reference
> > repository during clone, when you don't have your own refs that cover
> > the objects that are in your alternate repository.
> 
> I hate to ask a question that I myself do not have a good answer to, but
> it is a bit worrysome that using these extra refs would cause for-each-ref
> to report different refs with the same name (the alternate's master branch
> and this one's master branch are both called refs/heads/master).
> 
> I think no caller that reads from for_each_ref() keeps track of names that
> it has seen and tries clever things like flagging duplicates as errors,
> but it still feels like it is inviting trouble.

I considered that, and didn't come to any particular conclusion about 
anything to do about it. In the particular case in this series, there are 
no non-extra refs, and the for_each_ref caller doesn't actually look at 
names at all, so it's really not a problem, but the interface could 
definitely generate odd results. For that matter, non-extra refs are 
sorted by name, and the extra refs are just done first. I think additional 
callers are needed before we can determine in more detail how the 
interface should work, since none of these details matters at all to this 
one.

	-Daniel
*This .sig left intentionally blank*
