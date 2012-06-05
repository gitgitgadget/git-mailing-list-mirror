From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 5 Jun 2012 11:50:07 -0400
Message-ID: <20120605155007.GA20494@sigill.intra.peff.net>
References: <20120605085604.GA27298@sigill.intra.peff.net>
 <7vwr3lpxyh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbw1m-00010t-EH
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab2FEPuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:50:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43878
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab2FEPuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:50:10 -0400
Received: (qmail 20719 invoked by uid 107); 5 Jun 2012 15:50:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 11:50:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 11:50:07 -0400
Content-Disposition: inline
In-Reply-To: <7vwr3lpxyh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199253>

On Tue, Jun 05, 2012 at 08:42:14AM -0700, Junio C Hamano wrote:

> > I'm really tempted to do this:
> 
> Why (I am slower than my usual slow self today, so pardon me)?

Purely to clean up the nasty preexec thing, which is a hack, and should
never be used for new code due to portability issues.

> Aren't these already protected with "ifndef WIN32"?

Yes, but it means anything that uses it will not work on Windows.

> > I checked, and even RHEL5 is on less 436. So besides people on antique
> > "I installed less from source more than 5 years ago" systems, my only
> > concern would be that some other pager depends on this hack in a weird
> > way. But I have never heard of such a thing, so...
> 
> Hrm...

Yeah. This is purely a cleanup thing. It's a cleanup I've wanted to do
for a long time (ever since adding it), but it is not hurting anyone
as-is. We can always just reject new uses of preexec_cb in review (which
is more or less what I'm doing here).

-Peff
