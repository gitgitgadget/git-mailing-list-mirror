From: Theodore Tso <tytso@mit.edu>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 00:40:26 -0400
Message-ID: <20071030044026.GA9600@thunk.org>
References: <20071016210904.GI26127@efreet.light.src> <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src> <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imiv0-0001zW-MK
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbXJ3ElV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbXJ3ElV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:41:21 -0400
Received: from THUNK.ORG ([69.25.196.29]:40451 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbXJ3ElU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:41:20 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Imj4Z-000881-UT; Tue, 30 Oct 2007 00:51:28 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Imitu-0002c6-MA; Tue, 30 Oct 2007 00:40:26 -0400
Content-Disposition: inline
In-Reply-To: <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62660>

On Mon, Oct 29, 2007 at 08:40:06PM -0700, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > It would probably also be a good idea to expurgate URL's from the
> > documentations, because, well, they aren't URL's.  Git doesn't treat
> > them like URL's, and you've said you aren't interested in changing git
> > to treat them like URL's, and finally git:// isn't a registered URL
> > scheme name with the IANA registration authority.  So let's not call
> > them URL's, since they're clearly not.
> 
> Are you playing reverse psychology, encouraging us to switch to
> RFC-conforming quoting?

Well, URL's have a specific meaning and they're not for web browsing.
They are used to specify the addresses of printers, e-mail addresses,
LDAP servers, and much more.  Git is using something that looks like
URL's, but they they don't follow the URL rules.  So this brings up
interesting questions when a git webpage displayes something like
this (taken from repo.or.cz):

Mirror URL  git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
            http://repo.or.cz/r/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
Push URL    git+ssh://repo.or.cz/srv/git/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git

Quick!  Which of the URL-like strings follow the URL quoting rules,
and which ones don't?  And if you have a character that must be quoted
in the pthname, should be quoted in in the http:// line?  And does it
matter if you are passing that URL-like string to a web browser or to
git-clone?

This is not language lawyering; this is a consistency issue that
matters.  But if Linus is going to say that git isn't going to follow
the URL quoting rules because it isn't a web browser, then clearly
what we are using aren't URL's.  So let's not *call* them URL's in our
documentation, because we're not following the URL rules.  That way is
only going to spawn more confusion.

Is this reverse psychology?  Well, I think git needs to pick whether
we operate on URL's or just things that *look* like URL's.  Either
way, the documentation should be specific about what's going on.  Me,
I'd prefer that git be liberal in what it accepts, and conservative in
what it sends.  That means that it would be useful if git could accept
URL's that are correctly quoted, and let things slide if characters
that should be quoted, aren't.  Git rarely actually emits URL's, and
mercifully people rarely use things like '#' characters in their
pathnames, so I don't think it would be that hard to make the
transition.

     	 	       	      	 	  - Ted
