From: Edgar Toernig <froese@gmx.de>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 23:31:04 +0200
Message-ID: <20050428233104.3e606ba9.froese@gmx.de>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:25:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGVs-0004OQ-Mr
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVD1VbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVD1VbK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:31:10 -0400
Received: from pop.gmx.net ([213.165.64.20]:60546 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262220AbVD1VbI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 17:31:08 -0400
Received: (qmail invoked by alias); 28 Apr 2005 21:31:07 -0000
Received: from p5090517F.dip.t-dialin.net (EHLO dialup) [80.144.81.127]
  by mail.gmx.net (mp013) with SMTP; 28 Apr 2005 23:31:07 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>
> Damn bash. What's the magic incantation that says SHUT UP!?

Try this:

+	{ set -e; trap 'exit 1' SIGPIPE
	$revls | $revsort | while read time commit parents; do
		[ "$revfmt" = "rev-list" ] && commit="$time"
		...
-	done | ${PAGER:-less} ${PAGER_FLAGS:--R}
+	done; } | ${PAGER:-less} ${PAGER_FLAGS:--R}

Ciao, ET.
