From: Jeff King <peff@peff.net>
Subject: Re: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment
 variables
Date: Fri, 4 Sep 2015 17:44:54 -0400
Message-ID: <20150904214454.GA18320@sigill.intra.peff.net>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net>
 <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 23:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyn6-0004xe-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933725AbbIDVo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:44:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:55223 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933633AbbIDVo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:44:57 -0400
Received: (qmail 29000 invoked by uid 102); 4 Sep 2015 21:44:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 16:44:57 -0500
Received: (qmail 29383 invoked by uid 107); 4 Sep 2015 21:45:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 17:45:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 17:44:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277339>

On Fri, Sep 04, 2015 at 11:18:01AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It shouldn't be necessary for $GIT_DIR, but it makes sense for other git
> > variables. E.g., with "AcceptEnv GIT_*", "git -c" config is propagated.
> > E.g.:
> > ...
> 
> Just to make sure I got you correctly, you are saying that "we
> propagate, but that is not correct. We should stop doing so", right?

Exactly. We do not propagate config over git:// or http:// (because we
do not share our environment). Nor do we do so over same-machine
connections (because we explicitly clean the environment). So ssh:// is
the odd duck.

-Peff
