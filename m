From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 12:23:31 -0700
Message-ID: <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRWT-0004uf-4A
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1GNTY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:24:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37187 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753265Ab1GNTY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 15:24:27 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6EJNrid030886
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:23:54 -0700
Received: by wyg8 with SMTP id 8so369612wyg.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:23:52 -0700 (PDT)
Received: by 10.216.81.5 with SMTP id l5mr3684wee.102.1310671432098; Thu, 14
 Jul 2011 12:23:52 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 12:23:31 -0700 (PDT)
In-Reply-To: <20110714190844.GA26918@sigill.intra.peff.net>
X-Spam-Status: No, hits=-102.895 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177164>

On Thu, Jul 14, 2011 at 12:08 PM, Jeff King <peff@peff.net> wrote:
>
> If we aren't going to go whole-hog on generation numbers, I'm much more
> tempted to simply keep using commit timestamps.

Sure. I think it's entirely reasonable to say that the issue basically
boils down to one git question: "can commit X be an ancestor of commit
Y" (as a way to basically limit certain algorithms from having to walk
all the way down). We've used commit dates for it, and realistically
it really has worked very well. But it was always a broken heuristic.

So yes, I personally see generation counters as a way to do the commit
date comparisons right. And it would be perfectly fine to just say "if
there are no generation numbers, we'll use the datestamps instead, and
know that they could be incorrect".

That "use the datestamps" fallback thing may well involve all the
heuristics we already do (ie check for the stamps looking sane, and
not trusting just one individual one).

                           Linus
