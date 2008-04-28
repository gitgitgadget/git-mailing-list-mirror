From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: About git and the use of SHA-1
Date: Mon, 28 Apr 2008 15:34:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Henrik Austad <henrikau@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:36:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZ8j-0004Hw-OT
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936031AbYD1Tez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbYD1Tey
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:34:54 -0400
Received: from iabervon.org ([66.92.72.58]:36909 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935156AbYD1Tew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:34:52 -0400
Received: (qmail 6773 invoked by uid 1000); 28 Apr 2008 19:34:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2008 19:34:50 -0000
In-Reply-To: <200804281829.11866.henrikau@orakel.ntnu.no>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80597>

On Mon, 28 Apr 2008, Henrik Austad wrote:

> Hi list!
> 
> As far as I have gathered, the SHA-1-sum is used as a identifier for commits, 
> and that is the primary reason for using sha1.  However, several places 
> (including the google tech-talk featuring Linus himself) states that the id's 
> are cryptographically secure.
> 
> As discussed in [1], SHA-1 is not as secure as it once was (and this was in 
> 2005), and I'm wondering - are there any plans for migrating to another 
> hash-algorithm? I.e. SHA-2, whirlpool..

No. The cryptographic security we care about is that it's impractical to 
come up with another set of content that hashes to the same value as a 
given set of content. The known attacks on SHA-1 (and more broken earlier 
hashes in the same general class) only allow the attacker to produce two 
files that will collide. Now, it's true that this would allow somebody to 
produce a commit where some people see the "good" blob and some people see 
the "evil" blob, but (a) the "good" blob contains some large chunk of 
random data, which is a major red flag by itself, and (b) all of these 
people have to be taking data from the attacker.

If somebody gives you some source, and it's got some large random chunk in 
it, and the behavior of the object depends on the content of this chunk, 
and it's unspecified where this chunk comes from, you should be aware 
that they might be able to swap this chunk for a different chunk. But such 
a file is pretty blatantly malicious anyway.

	-Daniel
*This .sig left intentionally blank*
