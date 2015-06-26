From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.5.0-rc0
Date: Fri, 26 Jun 2015 07:20:41 -0400
Message-ID: <20150626112040.GA4315@peff.net>
References: <xmqqr3ozy1zt.fsf@gitster.dls.corp.google.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197CF80F@C111KJZHMBX55.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, junio@pobox.com, git@vger.kernel.org
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Fri Jun 26 13:20:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Rgf-0004j3-MU
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 13:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbbFZLUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 07:20:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:52189 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751814AbbFZLUo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 07:20:44 -0400
Received: (qmail 1064 invoked by uid 102); 26 Jun 2015 11:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 06:20:44 -0500
Received: (qmail 15293 invoked by uid 107); 26 Jun 2015 11:20:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 07:20:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 07:20:41 -0400
Content-Disposition: inline
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C55197CF80F@C111KJZHMBX55.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272771>

On Fri, Jun 26, 2015 at 09:36:04AM +0000, steve.norman@thomsonreuters.com wrote:

> Jeff / Duy,
> 
> > Fixes since v2.4
> >  * Access to objects in repositories that borrow from another one on a
> >    slow NFS server unnecessarily got more expensive due to recent code
> >    becoming more cautious in a naive way not to lose objects to pruning.
> >    (merge ee1c6c3 jk/prune-mtime later to maint).
> > 
> >  * "Have we lost a race with competing repack?" check was too
> >    expensive, especially while receiving a huge object transfer
> >    that runs index-pack (e.g. "clone" or "fetch").
> >    (merge 0eeb077 jk/index-pack-reduce-recheck later to maint).
> 
> I was reading through the 2.5 release notes and spotted the above two
> entries and I think they are probably fixes related to the NFS
> slowness I reported last month.

Yep, especially the latter one.

> Did some tests this morning and things are much improved:
> 
> Version 2.4.5
>   - Local clone of https://github.com/git/git - 8s
>   - Clone to NFS - 1m 3s
> 
> Version 2.5.0.rc0
>   - Local - 7s
>   - NFS - 13s
> 
> Thanks for the effort in addressing this and sorry I missed the patch to check it out earlier.

No problem, and thanks for the original report. It gave me plenty to
replicate the problem locally, so I felt pretty good about the changes
even without a final test from you. :)

-Peff
