From: Sam Vilain <sam@vilain.net>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 10:20:52 +1300
Message-ID: <470E93B4.3080300@vilain.net>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:21:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5T7-00045z-8H
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493AbXJKVVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbXJKVVI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:21:08 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:40978 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757641AbXJKVVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:21:06 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 7895327C0F9; Fri, 12 Oct 2007 10:21:00 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D7CB021CFC1;
	Fri, 12 Oct 2007 10:20:55 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60638>

Peter Karlsson wrote:
> Randal L. Schwartz:
> 
>> That's not a job for a source code manager to do.  It's a job for your 
>> build/install tool.
> 
> Since there is no build step involved (my web site is just a CVS checkout at 
> the moment), it's a job for the checkout step. I'd really want to avoid 
> having a separate copy of the web site just so that I can do a "make 
> install". That would sort of negate the savings in disk space I hope seeing 
> by moving from CVS to Git.

The problem is that asking for the "last commit that changed a file" is
one of those features which comes out of the wash with proper merge
support.  There is often no clear answer to that question.

Here's an example.  Say two people apply a patch on their own branches,
which are subsequently merged.  The file was the same on both branches;
the commits may have exactly the same date, but different committers.

Now, consider what happens as you are switching branches.  Instead of
just being able to check the file identity in the tree, the system has
to somehow know that the (derived) ancestry of the file is different,
and now the content has to change.  That makes something that was
extremely fast, slow.

It's the sort of thing that's possible to arrange to work using hooks
(with whatever arbitrary decisions you choose to make for the areas
where it would be ambiguous), but no-one bothered because people
realised that it probably means you're trying to encapsulate the
information in the wrong place.

Sam.
