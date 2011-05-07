From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Question about PERL_PATH
Date: Sat, 7 May 2011 18:02:48 +0000
Message-ID: <robbat2-20110507T174237-068953557Z@orbis-terrarum.net>
References: <4DC3F804.3080205@mev.co.uk>
 <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
Reply-To: git@vger.kernel.org, abbotti@mev.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Abbott <abbotti@mev.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 20:03:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIlqE-0007E5-Jh
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 20:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab1EGSCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 14:02:54 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:43683 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1EGSCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 14:02:52 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 417801B4084
	for <git@vger.kernel.org>; Sat,  7 May 2011 18:02:52 +0000 (UTC)
Received: (qmail 16636 invoked by uid 10000); 7 May 2011 18:02:48 -0000
Content-Disposition: inline
In-Reply-To: <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173060>

On Fri, May 06, 2011 at 09:05:08AM -0700,  Junio C Hamano wrote:
> The variable is not PERL_COMMAND_LINE, but is PERL_PATH, so I think it
> should expects the path to the program.
> 
> Our testsuite also rely on it being the path to the program by enclosing
> the reference to it inside double quotes, to make sure that PERL_PATH set
> to "/Program Files/Perl/perl.exe" works.  Didn't Gentoo folks see any test
> breakage before shipping the ebuild procedure?
The entire test suite completes fine with our
PERL_PATH="${EPREFIX}/usr/bin/env perl" setting.

This was originally put into place because of our bug #326625 [1].
From that bug:
====
Git does not compile if local::lib installed in user's home directory if
'sudo' is used to raise privileges. Local::lib exports environment
variable PERL5_MM_OPTS, which contains string INSTALL_BASE='...'.
Variable PREFIX is set in package's Makefile.pl. Package will not
compile if both of these variables are set.
====
(Full logs attached in the bug).

If you can suggest a better way to fix the user's bug, I'll revert the
PERL_PATH change.

1. https://bugs.gentoo.org/show_bug.cgi?id=326625

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
