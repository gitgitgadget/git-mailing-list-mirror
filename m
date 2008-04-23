From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 08:11:49 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0804230806220.18401@ds9.cixit.se>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
  <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> 
 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> 
 <20080422023918.GA5402@sigill.intra.peff.net>
 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:12:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoZ9y-0000f9-Jy
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 09:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYDWHMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYDWHMG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 03:12:06 -0400
Received: from ds9.cixit.se ([193.15.169.228]:60106 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbYDWHMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 03:12:05 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3N7BnBs020820
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Apr 2008 09:11:50 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3N7BntB020815;
	Wed, 23 Apr 2008 09:11:49 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 23 Apr 2008 09:11:50 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80192>

Avery Pennarun:

> Do you think git would benefit from having a generalized version of
> this script?

Definitely. Also, something that would work with a) several branches
(i.e traverse all the branches; keeping the points at which they
diverge), and b) submodules (i.e apply the same changes to the
submodules and updating the submodule index accordingly).

I ended up doing CRLF conversion for most of the repositories I had
converted. Fortunately, most of them had a single branch, so after
having created a small script that did CRLF->LF for the text files, I
could do a

  git filter-branch --tree-filter 'c:/temp/crlf2lf.sh' \
                    --tag-name-filter 'cat' HEAD

on each repository and get everything converted during my lunch break.


What I couldn't figure out is why, after converting everything,
removing all references to the repositories I cloned from, and removing
references to the old objects in the reflogs, why

 git fsck --unreachable

did not report any unreachable objects? I would have guessed the entire
old history and its objects would now be invalidated and could be
killed off.

-- 
\\// Peter - http://www.softwolves.pp.se/
