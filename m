From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
 after svn dcommit
Date: Fri, 05 Oct 2007 09:12:05 -0700
Message-ID: <47066255.6080500@midwinter.com>
References: <20071005001528.GA13029@midwinter.com> <20071005082110.GA4797@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idpmm-00081I-RL
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759852AbXJEQMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759892AbXJEQMJ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:12:09 -0400
Received: from tater.midwinter.com ([216.32.86.90]:48632 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756405AbXJEQMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:12:08 -0400
Received: (qmail 12288 invoked from network); 5 Oct 2007 16:12:07 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=bTY4KEbsQROMpg/fA8PdSqb9b4RtjD/7W4ZT/hw04bbfV2zZC4J7Ty8yS/3Rsz04  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 5 Oct 2007 16:12:07 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20071005082110.GA4797@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60101>

Peter Baumann wrote:
> I don't like the automatic prune. What if someone has other objects in
> there which shouldn't be pruned? Making git svn dcommit doing the prune
> would be at least suprising, because how is one supposed to know that
> doing a commit into svn will prune all your precious objects?
>   

"git commit" already does garbage collection, so we've already set a 
precedent for a commit operation also doing some cleanup at the end. 
However, you're correct that this cleanup behavior (and the way to turn 
it off) should be documented so that there's some way to know about it. 
Doc patch forthcoming.

> Sure, I can unterstand from where you are coming from, but I'd prefere
> if this could be specified on a case by case basis, e.g. from the
> cmdline or as a config option.
>   

This code (by virtue of only doing the prune if the "too many loose 
objects" test succeeds) will obey the existing gc.auto config option. So 
it's already possible to turn off as is. I'll note that in the doc patch.

-Steve
