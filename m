From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 11:55:39 -0700
Message-ID: <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:56:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhR5S-0004rE-Dx
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab1GNS4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:56:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32924 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652Ab1GNS4d (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 14:56:33 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6EItxdi028843
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:56:00 -0700
Received: by wyg8 with SMTP id 8so352620wyg.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:55:59 -0700 (PDT)
Received: by 10.216.38.76 with SMTP id z54mr2396165wea.102.1310669759139; Thu,
 14 Jul 2011 11:55:59 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 11:55:39 -0700 (PDT)
In-Reply-To: <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
X-Spam-Status: No, hits=-102.895 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177156>

On Thu, Jul 14, 2011 at 11:47 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Also, I suspect that the cache could easily be done as a *small* and
> *incomplete* cache, ie you don't need to cache all commits, it would
> be sufficient to cache a few hundred spread-out commits, and just know
> that "from any commit, the cached commit will be quickly reachable".

Put another way: we could do the cache not as a real dynamic entity,
but as something that gets generated at "git clone" time or when
re-packing.

I'm actually much more nervous about a cache being inconsistent than I
would be about having generation numbers in the tree. The latter we
can (and should - but my patch didn't) add a fsck test for, and then
you would never get into some situation where there's some really
subtle issue with merge base calculation due to a corrupt cache.

                    Linus
