From: Jeff King <peff@peff.net>
Subject: Re: 'git show' with multiple revisions
Date: Wed, 29 Apr 2015 11:53:10 -0400
Message-ID: <20150429155309.GB13518@peff.net>
References: <loom.20150428T120412-982@post.gmane.org>
 <20150429020452.GA873@peff.net>
 <loom.20150429T174544-7@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:53:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnUIZ-0004TB-4R
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966236AbbD2PxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 11:53:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:51652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966000AbbD2PxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 11:53:12 -0400
Received: (qmail 6626 invoked by uid 102); 29 Apr 2015 15:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 10:53:12 -0500
Received: (qmail 27372 invoked by uid 107); 29 Apr 2015 15:53:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 11:53:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 11:53:10 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150429T174544-7@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267978>

On Wed, Apr 29, 2015 at 03:47:33PM +0000, Ed Avis wrote:

> Jeff King <peff <at> peff.net> writes:
> 
> >I think you want `git cat-file`:
> >
> >  {
> >	echo REV1:FILE
> >	echo REV2:FILE
> >  } |
> >  git cat-file --batch
> >
> >This prints a header line for each output object which contains the size
> >of the object (so a parser reads a header line, then N bytes, then a
> >header line, N bytes, and so on).
> 
> This looks like what I want but the object ids printed appear to be the id
> of the file in a given revision - not the id of the revision itself.
> So the ids in the output are not the same as the ones in the input.

Correct. You are feeding a name which resolves to the blob sha1, so
that's what cat-file will output for the object id.

> That's fine, as long as I can assume that the output entries are in the same
> order as the input?

Yes, it will process and output them in order.

-Peff
