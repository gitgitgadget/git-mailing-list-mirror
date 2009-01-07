From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 7 Jan 2009 18:01:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 18:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKboa-0002hA-Ji
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 18:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZAGRCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbZAGRB7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 12:01:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:47870 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752389AbZAGRB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 12:01:57 -0500
Received: (qmail invoked by alias); 07 Jan 2009 17:01:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 07 Jan 2009 18:01:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SBAl8SQHSAG7iJhnKxp5WFhjI772/Sd6Qkr62Cn
	dXjpMDnZuV4HNL
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090107143926.GB831@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104812>

Hi,

On Wed, 7 Jan 2009, Pierre Habouzit wrote:

> On Tue, Jan 06, 2009 at 07:40:02PM +0000, Johannes Schindelin wrote:
> 
> > Although I would like to see it in once it is fleshed out -- even if 
> > it does not meet our usefulness standard -- because people said Git is 
> > inferior for not providing a patience diff.  If we have --patience, we 
> > can say "but we have it, it's just not useful, check for yourself".
> 
> Well I believe it's useful, but maybe the standard algorithm could be 
> tweaked the way Linus proposes to make the "long" lines weight louder or 
> so.

I think this "weighting idea" is a bit too much of handwaving to start 
anything close to a design; as I pointed out, anything that has something 
different than a 1 for a deleted/added line affects performance 
negatively.

> WRT the leaks, you want to squash the attached patch on the proper
> patches of your series (maybe the xdl_free on map.entries could be put
> in a hasmap_destroy or similar btw, but valgrind reports no more leaks
> in xdiff now).

Thanks!

I also squashed in a patch that avoids calling xdl_cleanup_records() and 
then memset()ing the rchg array to 0 (which worked around the segmentation 
fault).

Patch 1/3 v3 follows,
Dscho
