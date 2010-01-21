From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http/remote-curl: coddle picky servers
Date: Thu, 21 Jan 2010 17:34:25 +0100
Message-ID: <20100121163425.GB31659@glandium.org>
References: <20100121004756.GA18213@onerussian.com>
 <20100121050850.GA18896@Knoppix>
 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
 <20100121155136.17b59e8f.rctay89@gmail.com>
 <20100121140054.GH18213@onerussian.com>
 <20100121224100.624c9c9d.rctay89@gmail.com>
 <20100121155637.GA19078@spearce.org>
 <20100121160707.GA31276@glandium.org>
 <be6fef0d1001210820u638f5262jaa062a20fdfbc18b@mail.gmail.com>
 <20100121162402.GD19078@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 17:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzzO-0001Wo-DO
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab0AUQed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967Ab0AUQec
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:34:32 -0500
Received: from vuizook.err.no ([85.19.221.46]:56821 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab0AUQea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:34:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NXzzF-0002yW-VV; Thu, 21 Jan 2010 17:34:28 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NXzzF-0008F6-9z; Thu, 21 Jan 2010 17:34:25 +0100
Content-Disposition: inline
In-Reply-To: <20100121162402.GD19078@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137668>

On Thu, Jan 21, 2010 at 08:24:02AM -0800, Shawn O. Pearce wrote:
> Tay Ray Chuan <rctay89@gmail.com> wrote:
> > On Fri, Jan 22, 2010 at 12:07 AM, Mike Hommey <mh@glandium.org> wrote:
> > > Look closely at the start of the requested URL: /gitweb.cgi...
> > > It comes from this rule:
> > >
> > > RewriteCond %{QUERY_STRING} ^(.+)$
> > > RewriteRule ^/(.*)$ /gitweb.cgi$1 [L,PT]
> > >
> > > which is global to the virtual host.
> > >
> > > Anyways, while git.debian.org can certainly be fixed for that, other
> > > servers may want to do some different things with urls with parameters.
> > 
> > heh, I was suspecting some URL rewriting was going on.
> > 
> > Is this an issue that should be fixed in gitweb?
> 
> I don't see why it should be.  gitweb isn't a service CGI.  I find
> it odd that someone would configure their website to route anything
> with a query string into gitweb.  WTF?

There was a good reason for it, but the implementation was too broad:
The main gitweb list (http://git.debian.org/) is made statically,
because it is too long for gitweb to create it in a timely fashion.

So while the main page is made to be a static file, when the request has
a query string, which means it's not the main gitweb list, the cgi is
used.

Except this rule was also used for unrelated urls.

But as I said in my reply to Tay Ray Chuan, it's fixed.

Mike
