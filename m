From: Jeff King <peff@peff.net>
Subject: Re: checking sha1's of files
Date: Sun, 8 Feb 2009 07:27:31 -0500
Message-ID: <20090208122731.GA24442@coredump.intra.peff.net>
References: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com> <7veiy9z1v8.fsf@gitster.siamese.dyndns.org> <81bfc67a0902080253x5082201co7da3319b8237f5a0@mail.gmail.com> <20090208111343.GC14359@coredump.intra.peff.net> <81bfc67a0902080422s7f12d86ft5196c184c06385f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 13:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW8mS-0002Iv-Vt
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 13:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZBHM1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 07:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZBHM1d
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 07:27:33 -0500
Received: from peff.net ([208.65.91.99]:41445 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbZBHM1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 07:27:33 -0500
Received: (qmail 27569 invoked by uid 107); 8 Feb 2009 12:27:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 07:27:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 07:27:31 -0500
Content-Disposition: inline
In-Reply-To: <81bfc67a0902080422s7f12d86ft5196c184c06385f9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108968>

On Sun, Feb 08, 2009 at 07:22:31AM -0500, Caleb Cushing wrote:

> >  $ git hash-object --stdin < Makefile
> >  27b9569746179e68c635bdaab8e57395f63faf01
> 
> is there anyway built in way to do that and check to see if the hash
> matches HEAD? (before I go and write a string comparison so that it
> does)

If you want to know whether a file matches HEAD, just do:

  git diff --quiet HEAD -- $LIST_OF_FILES

which will return '0' for no changes or '1' if there are changes.

Which really has nothing to do with hashes at all (though git will use
them internally to avoid actually running a textual diff at all).  I was
assuming that you didn't necessarily _have_ the git repository at
verification time. So the hash becomes an easy way of saying "this is
what the file _should_ look like".

But again, I'm not sure I really understand the workflow you're trying
to perform.

-Peff
