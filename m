From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: Revisiting large binary files issue.
Date: Tue, 11 Jul 2006 08:55:27 -0600
Organization: Hewlett Packard
Message-ID: <20060711145527.GA32468@hpsvcnb.fc.hp.com>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 16:56:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Je8-00013x-L2
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 16:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWGKOz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 10:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWGKOz3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 10:55:29 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:39866 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750948AbWGKOz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 10:55:28 -0400
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 9B88B35709;
	Tue, 11 Jul 2006 10:55:27 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 5B09A3C8C3;
	Tue, 11 Jul 2006 14:55:27 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 38C5D2EBF6; Tue, 11 Jul 2006 08:55:27 -0600 (MDT)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23714>

I'd like to get my hands dirty and see for myself where the issue lies.
I hope to have some time next week to devote to this.  Is it reasonable
to hope for a solution that is at least a lot lighter weight than the
current status quo?

Carl

On Mon, Jul 10, 2006 at 04:28:24PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 10 Jul 2006, Carl Baldwin wrote:
> > 
> > When I set the window to 0 I one more issue.  Even though the blobs are
> > already compressed on disk I still seem to pay the penalty of inflating
> > them into memory and then deflating them into the pack.  When the window
> > size is 0 this is just wasted cycles.  With large binary files these
> > wasted cycles slow down the push/fetch operation considerably.  Couldn't
> > the compressed blobs be copied into the pack without first deflating
> > them in this 0 window case?
> 
> The problem is that the individual object disk format isn't actually the 
> same as the pack-file object format for one object. The header is 
> different: a pack-file uses a very dense bit packing, while the individual 
> object format is a bit less dense.
> 
> Sad, really, but it means that right now you can only re-use data that was 
> already packed (when the format matches).
> 
> 		Linus
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
