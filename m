From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 13:59:23 +0100
Message-ID: <1114865964.24014.77.camel@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	 <42730061.5010106@zytor.com>
	 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	 <20050430125333.2bd81b18.froese@gmx.de>
	 <1114859594.24014.60.camel@localhost.localdomain>
	 <20050430144936.6b05cc90.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 14:55:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRrVM-0005v0-Ic
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 14:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVD3NBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 09:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVD3NBV
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 09:01:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261214AbVD3NBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 09:01:20 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRral-0006mZ-77; Sat, 30 Apr 2005 14:01:09 +0100
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050430144936.6b05cc90.froese@gmx.de>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-30 at 14:49 +0200, Edgar Toernig wrote:
> +       if (tm.tm_sec > 59)
> +               return;

During a leap second, won't tm_sec be 60? And in fact you don't seem to
handle leap seconds at all, so isn't my_mktime going to be out by one
second for every leap second which has occurred since 1970?

There's a reason I'd rather just let glibc handle it :)

It's not as if tm_gmtoff is particularly esoteric -- we inherited it
from BSD. Let's just use it and let both remaining HPUX users worry
about it themselves if they ever want to use git on their systems.

-- 
dwmw2

