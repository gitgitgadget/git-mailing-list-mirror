From: Jeff King <peff@peff.net>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Thu, 8 May 2014 17:26:47 -0400
Message-ID: <20140508212647.GA6992@sigill.intra.peff.net>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 23:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiVq9-0006Vh-Uj
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbaEHV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:26:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47720 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755323AbaEHV0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:26:49 -0400
Received: (qmail 32678 invoked by uid 102); 8 May 2014 21:26:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 16:26:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 17:26:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248449>

On Thu, May 08, 2014 at 01:52:38PM -0700, Junio C Hamano wrote:

>              (                                         103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>              (                                         105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>              (                                         107)         test...
> 
> which does away with the misleading information altogether.
> 
> I myself is leaning towards the latter between the two, and not
> overriding "-b" but introducing another "cleanse the output of
> useless bottom information even more" option.

Though I rarely use boundary commits, this one makes the most sense to
me (when I do use them, I just mentally assume that the information in
the boundary line is useless; this is just making that more apparent).

Coincidentally, I recently came across a malformed commit that had a
bogus empty committer name and email. The "git log" pretty-printer omits
the author and committer lines entirely. "blame" will show "(unknown)"
in the name field. I wonder if it should also switch to a formatted
blank as above (but _do_ print the commit).

-Peff
