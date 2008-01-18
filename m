From: David Brown <git@davidb.org>
Subject: Re: git and binary files
Date: Thu, 17 Jan 2008 22:52:01 -0800
Message-ID: <20080118065201.GA4478@old.davidb.org>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net> <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com> <20080116141836.GA22639@coredump.intra.peff.net> <alpine.DEB.1.00.0801161622030.5260@bender.nucleusys.com> <20080116143219.GA22744@coredump.intra.peff.net> <alpine.DEB.1.00.0801161634080.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 07:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFl5j-0001Sg-16
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 07:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYARGwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 01:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYARGwJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 01:52:09 -0500
Received: from mail.davidb.org ([66.93.32.219]:40916 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbYARGwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 01:52:08 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1JFl57-0001Dy-Lf; Thu, 17 Jan 2008 22:52:01 -0800
Mail-Followup-To: Petko Manolov <petkan@nucleusys.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0801161634080.5260@bender.nucleusys.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70967>

On Wed, Jan 16, 2008 at 04:39:19PM +0200, Petko Manolov wrote:

>> As an experiment, it might be worth trying to store the uncompressed
>> versions instead (git will delta _and_ compress them for you).
>
> I don't have them uncompressed.
>
> I can try to convert those files into ascii format and then save them in 
> the repository.  Since most changes are incremental git should be able to 
> generate relatively small delta, which should compress well enough.

This won't help, only make things slightly worse.

The problem is when you compress the files, as soon as there is a
difference between the two files, the output of the compressor will be
entirely different for the remainder of the file.  Unless you changes
always are at the end of the file, you will end up pretty much entire
versions in the repo.

I'm using some repos that get regular 50MB tarballs checked into them.  I
convinced them to not compress the tarballs, and git does a fairly decent
job of doing delta compression between them (although it needs quite a bit
of RAM to do so).

Dave
