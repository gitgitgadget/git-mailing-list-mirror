From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Fri, 8 Apr 2016 14:43:06 +0300
Message-ID: <20160408144231-mutt-send-email-mst@redhat.com>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604071720160.2967@virtualbox>
 <20160407184026-mutt-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604081309150.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:43:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUok-0001i2-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240AbcDHLnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757922AbcDHLnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:43:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25FC97AEAC;
	Fri,  8 Apr 2016 11:43:08 +0000 (UTC)
Received: from redhat.com (vpn1-6-229.ams2.redhat.com [10.36.6.229])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u38Bh6ii010881;
	Fri, 8 Apr 2016 07:43:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604081309150.2967@virtualbox>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291027>

On Fri, Apr 08, 2016 at 01:13:51PM +0200, Johannes Schindelin wrote:
> Hi Michael,
> 
> On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:
> 
> > On Thu, Apr 07, 2016 at 05:23:09PM +0200, Johannes Schindelin wrote:
> > > 
> > > On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:
> > > 
> > > > Reverts can typically be treated like squash.  Eliminating both the
> > > > original commit and the revert would be even nicer, but this seems a bit
> > > > harder to implement.
> > > 
> > > Whoa. This rings a lot of alarm bells, very loudly.
> > 
> > Whoa don't be alarmed. It's just a patch :).
> 
> It's just a patch. Like every major breakage would be. So: no, there is
> reason to be alarmed if it is likely to disrupt normal usage.
> 
> > > It seems you intend to introduce a *major* change in behavior,
> > 
> > Doing this automatically for all users might be a bit too drastic for
> > the upstream git.
> 
> That is a pretty safe thing to say, even without the subjunctive.
> 
> > If there's a commit later followed by a revert, history can be
> > simplified by squashing them, and if the result is empty, removing both.
> 
> True. But that is not what the user told Git to do. If the user's
> intention was to squash the reverting patch, she could have easily done
> this:
> 
> 	git revert -n deadbeef
> 	git commit --squash deadbeef
> 
> where "deadbeef" is the placeholder for the actual commit to revert.
> 
> And indeed, I use exactly this song and dance quite frequently, *iff* my
> intention is to drop a patch.
> 
> A much better idea than co-opting the "Revert" commit message would be to
> introduce a sibling to --fixup and --squash that you could call --drop.
> 
> Ciao,
> Johannes

Sounds rather cool. Or alternatively

git revert --squash deadbeef
