From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: FYI: Reply from HP-UX
Date: Thu, 17 Jan 2008 14:11:43 +0100
Message-ID: <20080117141143.38a88c7a@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 14:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFUXb-0002T3-SZ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbYAQNLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 08:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbYAQNLv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:11:51 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:2334 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYAQNLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 08:11:49 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id m0HDBicf068048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 17 Jan 2008 14:11:48 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.2.0cvs27 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70858>

Just for the record, here is a reply from the HP Porting center. It's
up to you to value it's content ...

--8<---
Subject: Re: HP Porting center: VCS git
Date: Thu, 17 Jan 2008 11:21:52 +0000 (GMT)
Message-Id: <200801171121.m0HBLqrc010962@linux01.cis>
X-Mailer: ELM [version 2.5 PL7]

> I got git running on HP-UX 11.00, which still is our base for our Version
> Control System (VCS)s. Most of the changes I made were incorporated into
> the git mainline.  

I've had a look at the git 1.5.3.8 source code and there are several
HP-UX issues with it:

* Use of gcc-specific features. Doesn't seem to want to compile nicely
  with HP's ANSI C compiler.

* Failure of the configure/make to handle the lack of unsetenv() in
  pre-11.31 HP-UX releases. Bizarrely, it does handle the lack of setenv()
  and also has a compat/unsetenv.c for use by non-unsetenv()-capable OS'es,
  but then configure and config.mak.in completely fail to use a NO_UNSETENV
  variable like they should!

* Use of "-include config.mak.autogen" in the top-level Makefile doesn't
  seem to actually include that file. I had to remove the leading "-" to
  include it. Also had to stop "gmake clean" from deleting config.mak.autogen
  otherwise a second "gmake clean" would fail :-(

* Have to force use of /usr/local/bin/perl, otherwise it picks up /usr/bin/perl
  which the build system doesn't like.

* "gmake check" requires porting "sparse" at
  http://www.kernel.org/pub/software/devel/sparse/ which could be "fun".

I think not building with a non-gcc C compiler could be a showstopper for us -
our policy is to compile all packages (yes, even gcc itself) using HP's
ANSI C and C++ compilers unless it's literally impossible to do so (the
only package exception so far is "pdftk" and that's only because HP don't
have a compiler equivalent to gcj).

> Are there any plans to release a 64bit GIT build for 11.11 and/or 11.23
> on the porting center's? And if not (yet), can I hereby please request
> to consider that?  

At this moment in time, we just build using the default HP ANSI C/C++
bitness flags (i.e. none are used, rather than explicitly stating +DD32 or
+DD64). This defaults to 32-bit builds (e.g. ELF-32) on the 5 platforms we
port on - we have discussed moving to 64-bit builds with HP, but they want
us to stay on 32-bit for the time being. In an ideal world, it would be
useful to offer both 32-bit and 64-bit builds, but technically it's too
difficult to automate (e.g. not just compiler flags, but also install
trees would have to be different between the two), so we can only easily
build one bitness and that's 32-bits for the moment.

HP-UX Archive Librarian,    E-mail queries: hpux@connect.org.uk
Connect Internet Solutions, Official HP-UX Archive WWW sites:
Liverpool,                  United Kingdom: http://hpux.connect.org.uk/
United Kingdom.             Netherlands:    http://hpux.its.tudelft.nl/
                            Canada:         http://hpux.ece.ualberta.ca/
                            United States:  http://hpux.cs.utah.edu/
-->8---

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
