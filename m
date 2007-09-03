From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: strbuf API
Date: Mon, 3 Sep 2007 13:29:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031322260.28586@racer.site>
References: <20070902224213.GB431@artemis.corp> <vpqk5r8m9nz.fsf@bauges.imag.fr>
 <20070903084927.GB21759@artemis.corp> <7vejhgksza.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 14:29:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISB3a-0002ST-QQ
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 14:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXICM3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 08:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbXICM3Y
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 08:29:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:60651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751030AbXICM3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 08:29:23 -0400
Received: (qmail invoked by alias); 03 Sep 2007 12:29:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 03 Sep 2007 14:29:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MZfcZNBFM5ZkHLr+oVhUkUWRyjJ0RHGiHm9wVUp
	qyNxM9Xv6NaZW4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejhgksza.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57478>

Hi,

On Mon, 3 Sep 2007, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > On Mon, Sep 03, 2007 at 08:32:16AM +0000, Matthieu Moy wrote:
> >>  ...
> >> For example, it would be very tempting to compare files with
> >> "strcmp(buf1, buf2)", but that would just fail silently when the file
> >> contains a '\0' byte.
> >
> >   Indeed, OTHO doing that would be pretty silly, as embending NULs in a
> > strbuf is wrong, it's a _str_buf, not a random-binary-buffer. It's meant
> > to make the use of strings easier, not to use as generic purpose byte
> > buffers. Of course they can, but well, it's not what they are designed
> > for in the first place.
> 
> People, please realize strbuf "API" is not a serious API.  
> 
> It wasn't even intended to be anything more than just a
> quick-and-dirty implementation of fgets that can grow
> dynamically.  The other callers added by people to have it do
> general string manipulations were just bolted-on, not designed.
> I haven't taken a serious look at bstring nor any of the
> alternatives yet, but defending strbuf as if it was designed to
> be a sane API is just silly.

Two points:

- it can be turned into an API (pretty easy, really, since it is _really_ 
  small), and

- it is easy to hack on, because it is _not_ a full-blown cover-them-all 
  library.  As such, we can tweak it the way _we_ want.  And if that means 
  that we do not NUL terminate, so be it.  And if that means that we turn 
  it into a rope structure, so be it.

IOW it might be utterly incomplete, but at least it can evolve in a manner 
that we like.  It does not need to be a *kaboom-here-we-have-a-big-dump*.

I know that we had something like that with LibXDiff.  I was not 
particularly happy with the process, but it turned out quite well, as 
Davide helped us a lot.

But the diff situation is completely different from the string situation:

- we did not have _anything_ in the way of diff generation,

- it is pretty well defined what a diff generation library should do, and

- diff generation is not trivial, and it would have taken us quite a long 
  time to write it ourselves.

All three points are not true with string manipulation.

But code talks, and as I do not have anything presentable (yet), I'll just 
shut up, until I have.

Ciao,
Dscho
