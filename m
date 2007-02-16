From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] pager: use an environment variable for pager_in_use
Date: Fri, 16 Feb 2007 19:56:53 +0100
Message-ID: <20070216185653.GA10308@moooo.ath.cx>
References: <20070216151925.GA28974@moooo.ath.cx> <20070216155658.GB7183@coredump.intra.peff.net> <20070216182231.GA31676@moooo.ath.cx> <Pine.LNX.4.63.0702161934230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 19:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI8GR-000236-V1
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 19:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946217AbXBPS45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 13:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946210AbXBPS45
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 13:56:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:35491 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946217AbXBPS44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 13:56:56 -0500
Received: (qmail invoked by alias); 16 Feb 2007 18:56:54 -0000
X-Provags-ID: V01U2FsdGVkX1/NgZlOTbnNbe529cnYFkxF7tMC+lyiSh5wlmuqCO
	30ag==
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702161934230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39939>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> +int pager_in_use = getenv("GIT_PAGER_IN_USE");
test.c:3: error: initializer element is not constant

So you could only add this at another place where pager_in_use is not yet
used (e.g. start of main or some other initialization method).
I did not want to put it at the beginning of main or another function.
After adding GIT_PAGER_IN_USE I thought it would make sense to remove
pager_in_use because there were only two parts of code using
pager_in_use:
> pager_in_use = 1;
> setenv(..);
and
> pager_in_use || getenv(..)
