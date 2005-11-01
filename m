From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Tue, 1 Nov 2005 17:03:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511011646070.25300@iabervon.org>
References: <43678C73.1080601@excelsior-online.org>
 <Pine.LNX.4.64.0511010801370.27915@g5.osdl.org> <7vbr149sbs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 23:05:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX4Ed-0002w8-5O
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVKAWDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVKAWDq
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:03:46 -0500
Received: from iabervon.org ([66.92.72.58]:50957 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751318AbVKAWDq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:03:46 -0500
Received: (qmail 23005 invoked by uid 1000); 1 Nov 2005 17:03:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Nov 2005 17:03:26 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr149sbs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10958>

On Tue, 1 Nov 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Btw, Junio, I thought "git pull" was only supposed to do rename 
> > detection, not copy detection.
> 
> Sorry, but what do you mean by "only rename detection but not
> copy detection" in this case?
> 
> When you have "ce A B; ce A C; ce A D;... ; mv A Z", (ce is like
> cp but "copy+edit") where B-Z are all new files and A disappears
> from the result, trying to detect renames would end up detecting
> copies without extra processing; B through Z are rename
> destination candidates, and A is a rename source candidate
> (there may be others), and it turns out that B-Z all look like
> A.
> 
> Would it be easier to read if we say A was renamed to B, and A
> was renamed to C, and A was renamed to D, ...?  I think the
> current output is easier to understand than that.  B-Y gets
> labelled as copy of A and Z gets labelled as rename.

I think it's more confusing for the system to report Z differently from 
other things, because there's nothing special about what it found, except 
that Z happens to be last. I think it would be easiest to read as:

Rename A =>
  B (80%)
  C (85%)
  D (75%)
  ...
  Z (90%)

(Although I don't know if the results come out of the system sorted that 
way; obviously, if there are different removed things, mixing them 
together would be ambiguous in this format)

	-Daniel
*This .sig left intentionally blank*
