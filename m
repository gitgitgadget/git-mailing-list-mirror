From: Theodore Tso <tytso@mit.edu>
Subject: Re: remote#branch
Date: Mon, 29 Oct 2007 23:01:04 -0400
Message-ID: <20071030030104.GK21133@thunk.org>
References: <20071016021933.GH12156@machine.or.cz> <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src> <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src> <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 04:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImhMp-0007rg-Mx
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 04:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbXJ3DBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 23:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbXJ3DBx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 23:01:53 -0400
Received: from THUNK.ORG ([69.25.196.29]:57975 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbXJ3DBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 23:01:52 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1ImhWT-0007qs-Qs; Mon, 29 Oct 2007 23:12:10 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1ImhLk-0002Q9-PU; Mon, 29 Oct 2007 23:01:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62652>

On Mon, Oct 29, 2007 at 03:57:41PM -0700, Linus Torvalds wrote:
> Sure, but "URL" in human-speak has nothing to do with an RFC.
> 
> I dislike language-lawyerese. Why the hell do people think that human 
> language should follow the RFC's?
> 
> Git addresses look like URL's, and they act like URL's, but dammit, git 
> isn't a web browser, and it's not interested in acting like one. 

The quoting rules aren't specific to a web browser; the whole point of
URL's is that they are uniform so that programs know how to handle
them without needing information specific to the URL type.  Hence the
quoting rules apply to all applications using URL's, whether it's CUPS
using a url such as: ipp://example.com/printer/tiger/bob or LDAP using
a url such as: ldap://ldap.example.com/dc=example,dc=com?postalAddress.

It's just git which is different here.  Having a uniform set of
processing rules are *useful* for applications and libraries that are
parsing URL's, not just for language-lawyer wanking.  Not that git
addresses that are layered on top of http is all that well supported
any more, but in that case we really are using an http-style URL ---
but yet git doesn't do URL quoting, because, well, it doesn't.  Yet in
that case it's very clear the http address is really a URL, and it's
arguably a defect that git doesn't handle an http address the way all
other applications handle http URL's.

At the very least, if we aren't going to change git, we should hang a
big fat sign in the documentation saying that although git location
names that begin git:// look like URL's, and smell like URL's, they
aren't treated the same way that all other applications treat URL's,
and the user shouldn't be surprised by this.  Furthermore, choosing
pathnames so that git:// and gitweb http:// addresses don't require
URL-style quoting, will probably save the user a fair amount of pain
and confusion because git refuses to treat git addresses as URL's.

It would probably also be a good idea to expurgate URL's from the
documentations, because, well, they aren't URL's.  Git doesn't treat
them like URL's, and you've said you aren't interested in changing git
to treat them like URL's, and finally git:// isn't a registered URL
scheme name with the IANA registration authority.  So let's not call
them URL's, since they're clearly not.

    	      	      	  	     - Ted
