From: Jeff King <peff@peff.net>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Wed, 28 Jan 2009 02:01:14 -0500
Message-ID: <20090128070114.GB19165@coredump.intra.peff.net>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com> <20090126210027.GG27604@coredump.intra.peff.net> <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com> <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com> <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com> <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4Rf-0000mR-0j
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZA1HBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbZA1HBR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:01:17 -0500
Received: from peff.net ([208.65.91.99]:56060 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbZA1HBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:01:16 -0500
Received: (qmail 19302 invoked by uid 107); 28 Jan 2009 07:01:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:01:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:01:14 -0500
Content-Disposition: inline
In-Reply-To: <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107484>

On Tue, Jan 27, 2009 at 07:35:00PM -0600, Perry Smith wrote:

> Just to be sure we are on the same page.  My directory structure has a
> top/src/git-1.6.1 and top/build/git.1.6.1.  The src/git-1.6.1 is the
> tar ball.  The  build/git-1.6.1 starts out empty.  I cd into it and
> then do: ../../src/git-1.6.1/configure <options>  After this
> completes, you can do "make".

I don't see how this would work without automake support, which git does
not have. The configure script just generates a config.mak.autogen file,
which is included by the Makefile. So you have no Makefile in your build
directory.

> About 90% of the open source configure / autoconf code out there can
> do this with.  The other 10% you can not.  I like it because when
> things die, its easier to grep around the source tree and I blow away
> the build directory and start back over and I know that I'm starting
> fresh.

Another way of solving the same problem:

  cd untarred-sources
  git init
  git add .
  git commit -m 'pristine sources'

Now you can use "git clean" to clean up cruft, not to mention the usual
git stuff like tracking any changes you've made and submitting any
patches upstream.

> I get further.  But now test 10 of t0001.sh fails because test_cmp can
> not be found.
>
> Is that a GNU tool?  (I didn't see it in git or coreutils.)

It's a shell function defined in test-lib.sh (which is sourced by all of
the test scripts).

-Peff
