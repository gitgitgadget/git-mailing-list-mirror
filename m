From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 17:03:42 -0400
Message-ID: <20160428210342.GB12268@sigill.intra.peff.net>
References: <20160428134953.GB25364@sigill.intra.peff.net>
 <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
 <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
 <20160428165031.GA31421@sigill.intra.peff.net>
 <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
 <20160428191038.GA10574@sigill.intra.peff.net>
 <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
 <xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:03:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avt6D-0006m3-DW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbcD1VDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:03:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:58763 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752388AbcD1VDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:03:45 -0400
Received: (qmail 15606 invoked by uid 102); 28 Apr 2016 21:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 17:03:44 -0400
Received: (qmail 14579 invoked by uid 107); 28 Apr 2016 21:03:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 17:03:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 17:03:42 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292952>

On Thu, Apr 28, 2016 at 12:52:03PM -0700, Junio C Hamano wrote:

> "git" is not always about submodules, so "-c-but-not-for-submodules"
> option does not belong to "git" wrapper.
> 
> Users use "git -c" and hope to affect what happens in submodules,
> only because "git submodule" support is still immature and does not
> have options to do that.  You certainly smell a linkage between
> "pass options to a selected subset of submodules" and your recent
> "give labels to submodules so that they can be named with *group
> syntax" topic, no?

Keep in mind that submodule interactions may be triggered from other
non-submodule commands. So "git fetch", for instance, may end up caring
about whether you pass "http.*" or "credential.*" down to the
submodules. I do not think "fetch" should grow submodule-specific
options, so that pretty much leaves "git" options as the only place
left.

-Peff
