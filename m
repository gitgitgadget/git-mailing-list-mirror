From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] prepare_packed_git(): find more garbage
Date: Fri, 18 Dec 2015 21:02:47 -0500
Message-ID: <20151219020247.GA3098@sigill.intra.peff.net>
References: <20151215232534.GA30998@sigill.intra.peff.net>
 <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 03:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA6rG-0001ZI-LH
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 03:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbbLSCCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 21:02:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:44487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932284AbbLSCCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 21:02:50 -0500
Received: (qmail 20539 invoked by uid 102); 19 Dec 2015 02:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Dec 2015 20:02:50 -0600
Received: (qmail 2188 invoked by uid 107); 19 Dec 2015 02:02:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Dec 2015 21:02:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Dec 2015 21:02:47 -0500
Content-Disposition: inline
In-Reply-To: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282728>

On Fri, Dec 18, 2015 at 06:06:37PM -0600, Doug Kelly wrote:

> Corrects the issues found in review by Peff, including simplifying
> the logic in report_helper().  bits_to_msg() would've been an alternate
> solution to that change, however it'll get called by
> real_report_garbage(), so there's no need to call it twice, especially
> when the check we need within report_helper().

OK. The new logic in 1/3 looks fine to me.

> I think checking for seen_bits == 0 would be future-proofing should we
> arrive at a file bit not otherwise match it (i.e. file.foo and
> file.bar, but nothing else would cause seen_bits to be zero, but if
> that's the case, we wouldn't have PACKDIR_FILE_IDX or
> PACKDIR_FILE_PACK set, either, and the second half would also match.

Yeah, I think this is sound.

I left a few comments on 3/3. I don't think it's _wrong_, but I think we
can be a bit more thorough (and IMHO, a little more maintainable, but
others might disagree).

-Peff
