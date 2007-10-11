From: Sam Vilain <sam@vilain.net>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Fri, 12 Oct 2007 10:51:17 +1300
Message-ID: <470E9AD5.2090002@vilain.net>
References: <20071010015545.GA17336@lapse.madduck.net> <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org> <20071010102528.GB20390@lapse.madduck.net> <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5wV-0001hZ-OT
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759231AbXJKVvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759218AbXJKVvY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:51:24 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39213 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759213AbXJKVvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:51:23 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 53E3227C0F9; Fri, 12 Oct 2007 10:51:21 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id BCF0921CFC1;
	Fri, 12 Oct 2007 10:51:17 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60644>

Linus Torvalds wrote:
> So git doesn't try to avoid conflicts per se: the merge strategies are 
> fundamentally pretty simple (rename detection and the whole "recursive 
> merge" thing may not be simple code, but the concepts are pretty 
> straightforward), and they handle all the really *obvious* cases, but at 
> the same time, I feel strongly that anything even half-way subtle should 
> not be left to the SCM - the SCM should show it and make it really easy 
> for the user to then fix it up.

This is true.  However I think there are some obvious places for
improvement that does look at the file history, when the regular
algorithm fails;

1. do a --cherry-pick rev-list on just the file being merged and see if
all the changes on one side disappear, in which case just take the result.

2. see if the files were identical at some point, in which case use a
new merge base for that file based on the changes since that revision.

I actually thought #2 was already the way recursive worked!

Sam.
