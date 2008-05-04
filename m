From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] add merge.renamelimit config option
Date: Sun, 4 May 2008 15:31:06 -0400
Message-ID: <20080504193106.GC13029@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net> <20080430172354.GA23747@sigill.intra.peff.net> <7viqxvta9h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 21:31:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsjwD-0002NQ-3C
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 21:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbYEDTbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 15:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbYEDTbI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 15:31:08 -0400
Received: from peff.net ([208.65.91.99]:1394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444AbYEDTbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 15:31:07 -0400
Received: (qmail 27332 invoked by uid 111); 4 May 2008 19:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 15:31:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 May 2008 15:31:06 -0400
Content-Disposition: inline
In-Reply-To: <7viqxvta9h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81194>

On Sat, May 03, 2008 at 01:15:06PM -0700, Junio C Hamano wrote:

> >  	opts.detect_rename = DIFF_DETECT_RENAME;
> > -	opts.rename_limit = rename_limit;
> > +	opts.rename_limit = merge_rename_limit >= 0 ? merge_rename_limit :
> > +			    diff_rename_limit >= 0 ? diff_rename_limit :
> > +			    100;
> >  	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> >  	if (diff_setup_done(&opts) < 0)
> >  		die("diff setup failed");
> 
> Makes one wonder where the magic 100 comes from.  Wouldn't this
> 
> 	opts.rename_limit = (merge_rename_limit >= 0)
>         		  ? merge_rename_limit
>                           : diff_rename_limit;
> 
> be easier to maintain, with the same semantics?

Yes, though I was being a little sneaky in perparation for 2/3, which
changes the defaults differently for diff versus merge. I could maybe
have put that particular change into 2/3, but it looks like you have
applied this to next as-is already.

-Peff
