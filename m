From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: auto-merge after push?
Date: Wed, 15 Jul 2009 17:54:30 +0300
Message-ID: <20090715145430.GB9075@redhat.com>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302> <20090511201705.GA21045@redhat.com> <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de> <20090611104020.GA12036@redhat.com> <20090711203831.GA10875@redhat.com> <alpine.DEB.1.00.0907120441440.3155@pacific.mpi-cbg.de> <7vocrplhbv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5tQ-0001iw-Mf
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022AbZGOOzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 10:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbZGOOzZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:55:25 -0400
Received: from mx2.redhat.com ([66.187.237.31]:39304 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784AbZGOOzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:55:24 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6FEtHo8010053;
	Wed, 15 Jul 2009 10:55:19 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6FEtG09022080;
	Wed, 15 Jul 2009 10:55:16 -0400
Received: from redhat.com (vpn-10-95.str.redhat.com [10.32.10.95])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6FEtD3m029032;
	Wed, 15 Jul 2009 10:55:14 -0400
Content-Disposition: inline
In-Reply-To: <7vocrplhbv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123319>

On Sun, Jul 12, 2009 at 02:30:44PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Well, I use it myself, what more can I say?
> 
> It's rather hard to justify a feature that is available to the general
> public with documentation that only says "we tell you what happens in
> terms of low-level commands when you use this feature, we warn you that
> this has its own set of possible complications, but we do not specify what
> they are, nor how to recover from them. You should know what you are doing
> if you choose to use it".
> 
> That is not very helpful.
> 
> If this _were_ implemented as a sample hook on the receiving end, with
> ample comments that the users can read to undersand the issues before
> deciding to install it on their repositories, it might have been an easier
> sell.
> 
> If Dscho is short on time, perhaps somebody else can improve upon the
> documentation part of the patch?  It's a long time ago that I took a look
> at the patch text itself but I had a recorrection that the code itself was
> reasonable (and it is a well known fact that I tend not to notice bugs in
> Dscho's code so it is not a very useful thing for me to go back to look at
> the code again now when I am short on brain cycles).
> 

So, let me summarize the issues:
- if the tree is pushed into while files are being actively read
  (e.g. built from), the build will get an inconsistent state
- even worse if one of the files is open for editing or is being written
  into: the file will get corrupted
- if there are uncommitted changes in the tree, the push is denied

Are there others?

-- 
MST
