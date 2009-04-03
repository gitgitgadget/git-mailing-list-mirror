From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 11:46:08 -0400
Message-ID: <20090403154608.GA27089@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 17:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpldX-0004hj-Mz
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 17:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898AbZDCPqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934424AbZDCPq3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 11:46:29 -0400
Received: from peff.net ([208.65.91.99]:48431 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934464AbZDCPq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 11:46:27 -0400
Received: (qmail 32490 invoked by uid 107); 3 Apr 2009 15:46:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 11:46:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 11:46:08 -0400
Content-Disposition: inline
In-Reply-To: <20090403T065545Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115538>

Also, a few meta-issues with this patch.

One is that the usual practice is to send patches inline rather than
attaching them.

Another is that this text:

> The attached patch adds NO_PERL to the build system, in the same fashion
> as NO_TCLTK.
> 
> Effects:
> - No perl-based scripts or code are installed:
> 	$SCRIPT_PERL
> 	git-instaweb
> 	gitweb
> 	git-cvsserver
> 	git-svn
> - git-add does NOT have interactive support.
> - None of the tests for the disabled stuff gets run.
> 
> This patch has been a optional part of the Gentoo build of Git for a
> full year now, originally introduced with v1.5.4.4.

should go with the patch as part of the commit message along with this:

> Implement 95% of the NO_PERL functionality, to build Git without any Perl
> support, because some Gentoo users want a Git without any Perl whatesoever
> (Gentoo bug #214168).
> 
> Remaining bits are doing configure.ac as well as git-remote usage in:
> t5502-quickfetch.sh
> t5512-ls-remote.sh
> t5520-pull.sh
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> Updated-by: Bernd Lommerzheim <bernd@lommerzheim.com>
> Bugzilla-URL: http://bugs.gentoo.org/show_bug.cgi?id=214168
> Notes: Ported from 20080423-git-1.5.5.1-noperl.patch
> Notes: Ported from 20080322-git-1.5.4.5-noperl.patch
> Notes: Ported from 20080528-git-1.5.6.1-noperl.patch
> Notes: Ported from 20080626-git-1.5.6.1-noperl.patch and 20081123-git-1.6.0.4-noperl-cvsserver.patch
> Notes: Ported from 20090126-git-1.6.1.1-noperl.patch
> Notes: t3701-add-interactive.sh block added 2009/04/02 as it was missed, broke
>        testsuite with USE=-perl.

If you are using git to prepare your patch, then "git format-patch"
should generate the right output.

And finally, these two hunks:

> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index 6a37f71..84a0d31 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -17,6 +17,12 @@ then
> [...]
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index 6ed10d0..d4580a4 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh

did not apply for me, to the current 'master' or 'next'. Furthermore,
the blobs they are based on aren't even present in my repo, so a 3-way
merge was impossible. What did you base this patch on?

-Peff
