From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Mon, 21 Jul 2008 09:43:17 -0400
Message-ID: <1216647797.3997.6.camel@gaara.bos.redhat.com>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
	 <7vk5fi67dx.fsf@gitster.siamese.dyndns.org>
	 <200807191132.45648.johannes.sixt@telecom.at>
	 <200807191549.56402.johannes.sixt@telecom.at>
	 <alpine.LNX.1.00.0807191333550.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:46:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKvie-00053y-4W
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 15:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbYGUNpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 09:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbYGUNpW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 09:45:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbYGUNpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 09:45:21 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6LDhuhk011117;
	Mon, 21 Jul 2008 09:43:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6LDhuYC015537;
	Mon, 21 Jul 2008 09:43:56 -0400
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6LDhtgU011917;
	Mon, 21 Jul 2008 09:43:55 -0400
In-Reply-To: <alpine.LNX.1.00.0807191333550.19665@iabervon.org>
X-Mailer: Evolution 2.23.4 (2.23.4-2.fc10) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89358>

On Sat, 2008-07-19 at 13:44 -0400, Daniel Barkalow wrote:
> On Sat, 19 Jul 2008, Johannes Sixt wrote:
> 
> > On Samstag, 19. Juli 2008, Johannes Sixt wrote:
> > > On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> > > > Ok, but the surrounding code in this function look very suspicious.
> > >
> > > How about this then?
> > >
> > > -- snip --
> > > builtin-clone: Rewrite guess_dir_name()
> > >
> > > The function has to do three small and independent tasks, but all of them
> > > were crammed into a single loop. This rewrites the function entirely by
> > > unrolling these tasks.
> > 
> > Sigh. I knew it, I knew it. If it had been that trivial, then Daniel had done
> > it this way in the first place. :-(
> > 
> > This needs to be squashed in. It makes sure that we handle 'foo/.git';
> > and .git was not stripped if we cloned from 'foo.git/'.
> 
> I actually got that from Johannes Schindelin, who added bundle support to 
> my clone patch. I remember looking at his change, thinking it looked 
> overly complicated, but finding that anything I tried to do to simplify it 
> failed tests. If this gets through the test suite (lots of the tests other 
> than the clone test try to do a wider variety of odd things than I expect 
> users do in practice most of the time), then it's probably a better 
> implementation.

I wrote the original guess_git_dir(), and it *is* pretty subtle, sorry.
I would not rewrite it unless you really have to, since git clone now is
pretty stable and the dir sep separator change doesn't need this kind of
rewrite to fix the issue.  That said, with the last couple of changes
from Johannes Sixt, I believe it handles the same case that I had in
mind when I first wrote the loop.

cheers,
Kristian
