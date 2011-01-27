From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH v4] fast-import: treat filemodify with empty tree as
 delete
Date: Thu, 27 Jan 2011 21:46:50 +0100
Message-ID: <20110127204649.GB19378@m62s10.vlinux.de>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
 <20110126230608.GA26787@burratino>
 <7vd3nji54o.fsf@alter.siamese.dyndns.org>
 <20110127060749.GA5586@burratino>
 <20110127193353.GA19378@m62s10.vlinux.de>
 <20110127194844.GA20894@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 21:47:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiYkF-0000Mf-Ki
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 21:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab1A0UrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 15:47:00 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:59200 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753089Ab1A0Uq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 15:46:59 -0500
Received: (qmail invoked by alias); 27 Jan 2011 20:46:57 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp064) with SMTP; 27 Jan 2011 21:46:57 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+5+YsaVNm5dXfmYExmSLGFj7a1M96eKhZJ5mky0o
	fFTM6+QqXPebUL
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id C183ED401F; Thu, 27 Jan 2011 21:46:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110127194844.GA20894@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165589>

On Thu, Jan 27, 2011 at 01:48:45PM -0600, Jonathan Nieder wrote:
> Peter Baumann wrote:
> > On Thu, Jan 27, 2011 at 12:07:49AM -0600, Jonathan Nieder wrote:
> 
> >> +++ b/t/t9300-fast-import.sh
> >> @@ -818,6 +818,48 @@ test_expect_success \
> >>  	 compare_diff_raw expect actual'
> >>  
> >> +test_expect_success \
> >> +	'N: delete directory by copying' \
> >> +	'cat >expect <<-\EOF &&
> >> +	OBJID
> >> +	:100644 000000 OBJID OBJID D	foo/bar/qux
> >> +	OBJID
> >> +	:000000 100644 OBJID OBJID A	foo/bar/baz
> >> +	:000000 100644 OBJID OBJID A	foo/bar/qux
> >> +	EOF
> >> +	 empty_tree=$(git mktree </dev/null) &&
> >
> > [ Feel free to ignore me ... ]
> >
> > Just a (stupid?) suggestion: Why not put a $EMPTY_TREE definiton in test-lib.sh
> > (or any other global file sourced in the tests) so if another caller needs this
> > definition it won't waste cpu cycles doing the calculation via mktree < /dev/null
> > again?
> 
> Might be a good idea.  Note, though, that that would mean more cpu
> cycles used rather than less, unless we hardcode the object name
> (which I prefer not to do).
> 

Wny not? It *is* already hardcoded in the GIT source code (see grep -a1 cache.h
output).

> One possibility would be a lib-object-names.sh defining EMPTY_BLOB and
> EMPTY_TREE to be sourced by tests that need it.

Hm. Might be a possibility, but if this file only contains 2 hardcoded variables
I would prefer putting it into test-list.sh instead of an extra file.
