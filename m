From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: BUG (v1.5.6.1): ./configure missing check for zlib.h
Date: Fri, 27 Jun 2008 11:07:32 -0400
Message-ID: <20080627150732.D88F64B4002@artemis.sr.unh.edu>
References: <4864DD65.1080402@mircea.bardac.net>  <m3prq3hr6n.fsf@localhost.localdomain>
Reply-To: tfogal@alumni.unh.edu
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 17:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCG6J-0003K8-0a
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 17:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbYF0PmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 11:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYF0PmG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 11:42:06 -0400
Received: from artemis.sr.unh.edu ([132.177.249.69]:4346 "EHLO
	artemis.sr.unh.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYF0PmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 11:42:05 -0400
X-Greylist: delayed 2068 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jun 2008 11:42:05 EDT
Received: from localhost (localhost [127.0.0.1])
	by artemis.sr.unh.edu (Postfix) with ESMTP id B04504B4012;
	Fri, 27 Jun 2008 11:07:34 -0400 (EDT)
Received: from artemis.sr.unh.edu ([127.0.0.1])
 by localhost (artemis [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10215-03; Fri, 27 Jun 2008 11:07:33 -0400 (EDT)
Received: from artemis.sr.unh.edu (artemis.sr.unh.edu [132.177.249.69])
	by artemis.sr.unh.edu (Postfix) with ESMTP id D88F64B4002;
	Fri, 27 Jun 2008 11:07:32 -0400 (EDT)
In-Reply-To: Your message of "Fri, 27 Jun 2008 07:46:50 PDT."
             <m3prq3hr6n.fsf@localhost.localdomain> 
X-Virus-Scanned: amavisd-new at artemis.sr.unh.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86574>

Jakub Narebski <jnareb@gmail.com> writes:
> Mircea Bardac <dev@mircea.bardac.net> writes:
> 
> > $ ./configure
> [...]
> > configure: CHECKS for header files
> > In file included from daemon.c:1:
> > cache.h:9:18: error: zlib.h: No such file or directory
> > make: *** [daemon.o] Error 1
> > 
> > (installing zlib1g-dev on Ubuntu 7.10 fixed the problem)
> 
> What should ./configure do (what ./configure for other programs
> or packages do)?

If one can determine during configure time that a required library is
not found, it (IMHO) is nice to give an error message and bomb out (via
AC_MSG_ERROR).

The AC macro archive has a zlib macro which does this, as an example:

   http://autoconf-archive.cryp.to/check_zlib.html

I should note, however, that I disagree with that macro's logic in that
it `searches' for zlib if the user does not specify it.  IMO, if the
user does not give a --with option, and it doesn't work `out of the
box' (without hacking FLAGS), macros should die with an error rather
than retry with changed FLAGS.

-tom
