From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do we import patches from non-git sources?
Date: Thu, 24 May 2007 14:45:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705241439220.26602@woody.linux-foundation.org>
References: <1180017010.21181.2.camel@zealous.synapsedev.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Marc Singer <elf@synapse.com>
X-From: git-owner@vger.kernel.org Thu May 24 23:46:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrL8a-0001fu-Sj
	for gcvg-git@gmane.org; Thu, 24 May 2007 23:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXEXVqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbXEXVqV
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 17:46:21 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:38102 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007AbXEXVqV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2007 17:46:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4OLjmmI020247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2007 14:45:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4OLjl7O003997;
	Thu, 24 May 2007 14:45:48 -0700
In-Reply-To: <1180017010.21181.2.camel@zealous.synapsedev.com>
X-Spam-Status: No, hits=-2.222 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48310>



On Thu, 24 May 2007, Marc Singer wrote:
> 
> Is there a way to import patches that did not come from git?  Remember
> that we'd like to include the functionality of git-am that adds new
> files to the index.

The normal thing to do is

	git apply --index <patchfile>

which will apply a patch _and_ update the index, so that you can then just 
do a simple

	git commit -m "my message goes here" --author "the author goes here"

to create the commit, new (or deleted) files and all.

Of course, the reason the "normal" patch format is an email, and not 
just a bare patch, is that an email contains so much more: it contains not 
just the patch, but the authorship information and the commit message.

So basically:
 - no, you _cannot_ just "commit" a patch, since a patch on its own 
   doesn't contain the required information to be a real commit.

 - but yes, you can obviously _apply_ a patch, and then commit it once you 
   add the proper information, but that does require more information than 
   just the patch itself includes.

So hopefully that clarified things.

		Linus
