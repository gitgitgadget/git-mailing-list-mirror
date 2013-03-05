From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 5 Mar 2013 13:22:55 -0500
Message-ID: <20130305182255.GB10928@sigill.intra.peff.net>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
 <5135DBE5.6080909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 05 19:23:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCwWJ-0002iU-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 19:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315Ab3CESW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 13:22:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35479 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756448Ab3CESW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 13:22:57 -0500
Received: (qmail 16762 invoked by uid 107); 5 Mar 2013 18:24:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 13:24:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 13:22:55 -0500
Content-Disposition: inline
In-Reply-To: <5135DBE5.6080909@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217472>

On Tue, Mar 05, 2013 at 12:49:57PM +0100, Michael Haggerty wrote:

> > One obvious alternative is only to push annotated tags with this
> > feature. That has the downside of not matching fetch's behavior, as well
> > as withholding the feature from people whose workflow uses only
> > unannotated tags.
> > 
> > Another alternative would be to change the inclusion rule from
> > "reachable" to "points at the tip of something being sent". But then we
> > lose the feature that it would backfill any old tags the remote happens
> > to be missing.
> 
> I have no opinion on this matter, but ISTM that another obvious
> alternative would be to push tags that point at *any* commits that are
> being sent (not just at the tip), but not those that point to older
> commits already known to the server.  This would reduce the potential
> for accidental pushes of "distant" tags.

Yeah, I think that is another sensible variant. It does not really
"backfill" in the way that Junio's patch does (e.g., if you forgot to
push out v1.6 to a remote 2 weeks ago and now you are pushing out v1.7,
Junio's patch will magically fill it in). But I do not see a huge value
in backfilling. It is anyone's guess whether you simply forgot to push
out v1.6 or whether you intended to hold it back. And I'd rather err on
the side of not-pushing because of the difficulty of retraction.

-Peff
