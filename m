From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 14:41:31 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>  <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>  <alpine.LFD.1.10.0804291132060.23581@xanadu.home>  <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com> 
 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>  <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>  <alpine.LFD.1.10.0804291352120.23581@xanadu.home> <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:42:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqumc-0000pj-Hn
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 20:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbYD2Slf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 14:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbYD2Slf
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 14:41:35 -0400
Received: from iabervon.org ([66.92.72.58]:38699 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbYD2Sle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 14:41:34 -0400
Received: (qmail 9692 invoked by uid 1000); 29 Apr 2008 18:41:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2008 18:41:32 -0000
In-Reply-To: <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80717>

On Tue, 29 Apr 2008, Geoffrey Irving wrote:

> On Tue, Apr 29, 2008 at 10:55 AM, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 29 Apr 2008, Geoffrey Irving wrote:
> >
> >
> > > Sorry for the confusion: it would handwaving if I was saying git was insecure,
> >  > but I'm not.  I'm saying that if or when SHA1 becomes vulnerable to collision
> >  > attacks, git will be insecure.
> >
> >  Right.  And if or when that happens then we'll make Git secure again
> >  with a different hash.  In the mean time there is low return for the
> >  effort involved.
> 
> Yes.  I wasn't trying to advocate switching, just making sure people
> know that the "collisions don't matter" argument is bogus.

It's bogus to say they completely don't matter, but I still claim that 
they don't matter for the things people actually care about. If people can 
generate collisions, they can commit a "weak" blob with a conditional that 
can be switched by replacing the blob. But it's almost always true that 
people could commit a blob with a conditional that can be switched by 
something else under the attacker's more direct control. Using a better 
hash function won't save you from a document like:

if (getdate() < 2009)
  render_good_text
else
  render_evil_text

even if it does help with:

if (AA == AA)
  render_good_text
else
  render_evil_text

If you're not checking your files for the former, you shouldn't worry 
about the latter, because the former is much easier and more subtle.

(Now, an arbitrary preimage attack would actually be significant, still, 
because the attacker could replace an honestly-created "restrictive 
security policy" file with garbage that will be ignored, leaving stuff 
unprotected)

	-Daniel
*This .sig left intentionally blank*
