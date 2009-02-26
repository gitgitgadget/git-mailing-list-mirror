From: Jeff King <peff@peff.net>
Subject: Re: `./configure --XXdir=` ignored?
Date: Thu, 26 Feb 2009 10:00:13 -0500
Message-ID: <20090226150013.GA9785@coredump.intra.peff.net>
References: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lchk9-00089r-Ul
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbZBZPAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 10:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZBZPAS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:00:18 -0500
Received: from peff.net ([208.65.91.99]:39859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbZBZPAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 10:00:17 -0500
Received: (qmail 5350 invoked by uid 107); 26 Feb 2009 15:00:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 10:00:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 10:00:13 -0500
Content-Disposition: inline
In-Reply-To: <c115fd3c0902260648g3cc9bfeap58823e53a9dc72e6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111570>

On Thu, Feb 26, 2009 at 09:48:29AM -0500, Tim Visher wrote:

> I'm working on getting git 1.6.2-rc2 built.  I have a bin, man, info,
> and html directory in my home folder that I'd like to use as the
> defaults for git.  I attempted to do this through
> 
>     make configure
>     ./configure --XXdir=/full/path/to/dir
>     make all man info html
>     make install install-man install-info install-html
> 
> But other than the binaries (and I'm not even totally convinced they
> got in correctly) and the man pages, everything else seems to be
> attempting to go to the typical places in /usr/local.
> 
> What am I doing wrong?

The configure support is notoriously incomplete (AFAIK, very few of the
active developers use it regularly). Probably you need something like
this (but I didn't test it):

diff --git a/config.mak.in b/config.mak.in
index 7cce0c1..505d5c7 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -18,6 +18,8 @@ datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates
 
 mandir=@mandir@
+htmldir=@htmldir@
+infodir=@infodir@
 
 srcdir = @srcdir@
 VPATH = @srcdir@
