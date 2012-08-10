From: Jeff King <peff@peff.net>
Subject: Re: git am and the wrong chunk of ---
Date: Fri, 10 Aug 2012 06:36:13 -0400
Message-ID: <20120810103612.GA21562@sigill.intra.peff.net>
References: <5024523F.3050208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 12:36:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szma2-0006GN-Du
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 12:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759375Ab2HJKg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 06:36:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33502 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab2HJKg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 06:36:28 -0400
Received: (qmail 28779 invoked by uid 107); 10 Aug 2012 10:36:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 06:36:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 06:36:13 -0400
Content-Disposition: inline
In-Reply-To: <5024523F.3050208@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203214>

On Thu, Aug 09, 2012 at 05:13:51PM -0700, H. Peter Anvin wrote:

> I have some contributors who consistently put their commentary
> *before* the "---" line rather than *after* it, presumably with the
> notion that it is some kind of "cover text".  This messes with "git
> am", and so I end up having to edit those posts manually.
> 
> I have tried git am --scissors and it doesn't seem to solve the problem.
> 
> Is there any other option which can be used to automatically process
> such a patch?

If I understand your issue, somebody is writing:


    From: them
    To: you
    Date: ...
    Subject: [PATCH] subject line

    commit message body
    ....

    some cover letter material that should go below the "---"
    ---
      [diffstat + diff]


How do you know when the commit message body ends, and the cover letter
begins? We already have two machine-readable formats for separating the
two ("---" after the commit message, and "-- >8 --" scissors before). Is
there some machine-readable hint? Is it always the paragraph before the
"---"? Chopping that off unconditionally seems like a dangerous
heuristic.

-Peff
