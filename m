From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Mon, 25 Aug 2014 15:44:30 -0400
Message-ID: <20140825194430.GI30953@peff.net>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
 <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
 <xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:44:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0Bw-0007Wd-5G
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbaHYToc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:44:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:58653 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751127AbaHYToc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:44:32 -0400
Received: (qmail 32500 invoked by uid 102); 25 Aug 2014 19:44:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 14:44:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 15:44:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255858>

On Mon, Aug 25, 2014 at 10:21:58AM -0700, Junio C Hamano wrote:

> > +		if (ce_stage(ce) >= ce_stage(next_ce))
> > +			die("Unordered stage entries for '%s'",
> > +				ce->name);
> 
> Not quite.  We do allow multiple higher stage entries; having two or
> more stage #1 entries is perfectly fine during a merge resolution,
> and both ce and next_ce may be pointing at the stage #1 entries of
> the same path.  Replacing the comparison with ">" is sufficient, I
> think.

For my own curiosity, how do you get into this situation, and what does
it mean to have multiple stage#1 entries for the same path? What would
"git cat-file :1:path" output?

-Peff
