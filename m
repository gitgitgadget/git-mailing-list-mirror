From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Fri, 2 Nov 2012 09:12:55 -0400
Message-ID: <20121102131255.GB2598@sigill.intra.peff.net>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUH3f-0000Q8-KV
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab2KBNM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:12:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab2KBNM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:12:57 -0400
Received: (qmail 3966 invoked by uid 107); 2 Nov 2012 13:13:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 09:13:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 09:12:55 -0400
Content-Disposition: inline
In-Reply-To: <20121031003721.GV15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208926>

On Tue, Oct 30, 2012 at 05:37:21PM -0700, Jonathan Nieder wrote:

> If the commit does not have the SHOWN or UNINTERESTING flag set but it
> is going to get the UNINTERESTING flag set during the walk because of
> a negative commit listed on the command line, this patch won't help.

Right, so my understanding of the situation is that doing this:

  $ git branch foo master~1
  $ git fast-export foo master~1..master

won't show "foo", which seems wrong to me. _But_ we currently get that
wrong already, so Felipe's patches are not making anything worse, but
are fixing some situations (namely when master~1 is not mentioned on the
command-line, but rather in a marks file).

Is that correct?

If so, then this series isn't regressing behavior; the only downside is
that it's an incomplete fix. In theory this could get in the way of the
full fix later on, but given the commit messages and the archive of this
discussion, it would be simple enough to revert it later in favor of a
more full fix. Is that accurate?

Sorry if I am belaboring the discussion. I just want to make sure I
understand the situation before deciding what to do with the topic. It
sounds like the consensus at this point is "not perfect, but good enough
to make forward progress".

-Peff
