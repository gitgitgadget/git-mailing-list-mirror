From: Marc Singer <elf@synapse.com>
Subject: Re: Let me ask again: How do we import patches from non-git
	sources?
Date: Wed, 13 Jun 2007 18:45:04 -0700
Message-ID: <1181785504.4102.7.camel@zealous.synapsedev.com>
References: <1180017010.21181.2.camel@zealous.synapsedev.com>
	 <1181151454.6086.23.camel@zealous.synapsedev.com>
	 <20070606175458.GH12774@fieldses.org>
	 <1181665653.4194.24.camel@zealous.synapsedev.com>
	 <20070612181313.GB26767@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 03:45:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyeOb-0001xe-T1
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 03:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547AbXFNBpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 21:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757514AbXFNBpI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 21:45:08 -0400
Received: from henry.synapsedev.com ([66.147.194.230]:56325 "EHLO
	henry.synapse.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbXFNBpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 21:45:07 -0400
Received: from sanjuan.synapsedev.com (localhost.localdomain [127.0.0.1])
	by henry.synapse.com (Postfix) with ESMTP id 5616CD2C186
	for <git@vger.kernel.org>; Wed, 13 Jun 2007 18:45:06 -0700 (PDT)
Received: from sanjuan.synapsedev.com ([192.168.1.2] helo=sanjuan.synapsedev.com)
	by ASSP.nospam; 13 Jun 2007 18:45:06 -0700
Received: from zealous.local ([10.75.4.170]) by sanjuan.synapsedev.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Jun 2007 18:45:05 -0700
In-Reply-To: <20070612181313.GB26767@fieldses.org>
X-Mailer: Evolution 2.6.3 
X-OriginalArrivalTime: 14 Jun 2007 01:45:06.0046 (UTC) FILETIME=[A22141E0:01C7AE25]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50156>

On Tue, 2007-06-12 at 14:13 -0400, J. Bruce Fields wrote:
> On Tue, Jun 12, 2007 at 09:27:33AM -0700, Marc Singer wrote:
> > git-am complains that it cannot find an email address, but raw patches
> > seldom have these.  So, either we could use another command, or it would
> > be handy if we could supply the email address to git-am (or some other
> > data it needs so that it can split the patch.)  I suppose the mistaken
> > assumption is that the patch source in an email instead of already being
> > a nice clean patch.
> 
> I think it's intentional.  You need some standard format git-am can use
> to split out the patches and find the comments and the authorship
> information (for the Author: field on the commit), so why not just use
> something like mbox?
> 
> And it could provide some fallback for the "Author:" information in the
> case where it didn't find that, but we wouldn't want that to be the
> default if it meant risking silently losing authorship information.  I
> suppose an "--author" option to git-am might be convenient sometimes.
> 
> But personally I always just add those headers by hand (or with a
> script).  It's not that hard; I the minimum required is just three
> lines, I think:
> 
> 	From git-owner@vger.kernel.org Tue jun 12 11:43:40 2007
> 	From: someone <someone@example.com>
> 	Subject: [PATCH] do something
> 	
> 	Do something complicated.
> 	
> 	---
> 	
> 	diff a/foo b/foo
> 	...
> 
> And often I need different authors on different patches anyway, so
> git-am --author wouldn't help.
> 
> Of course if you've just got one patch to import, you can git-apply and
> then commit.

Thanks for the response.

I found that a deeper look into git-apply gives me a way to import
foreign patches.  I still have to do some index management by hand, but
it is much better than the alternative.

Your suggestion, while clearly effective, seems cumbersome.  I suppose
it may be worthwhile including a command that converts a foreign patch
into something that git better understands.  That would leave out this
sort of complexity from the git-am program.  In fact, I can imaging a
tool that lets the user fill in any pieces that aren't already present.

Honestly, it may just be that I'm still below the knee on the learning
curve for git.

Cheers.
