From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is specified
Date: Wed, 4 Jul 2007 11:29:15 +0200
Message-ID: <20070704092915.GA18597@moooo.ath.cx>
References: <20070703224919.GA22578@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 11:29:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I61Aq-00018S-Ks
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 11:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432AbXGDJ3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 05:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756326AbXGDJ3W
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 05:29:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:35597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756052AbXGDJ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 05:29:21 -0400
Received: (qmail invoked by alias); 04 Jul 2007 09:29:19 -0000
Received: from pD9EBB592.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.146]
  by mail.gmx.net (mp017) with SMTP; 04 Jul 2007 11:29:19 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX195anAAWoJ5ZsYNUI6FgqzcGD4IIwRTcBk7L3lOoS
	xhDoZeXgLHRds6
Content-Disposition: inline
In-Reply-To: <20070703224919.GA22578@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51584>

> +	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
> +		die("Unable to read current working directory");

Dscho just pointed out that this causes problems on windows.  The same
is also in setup_git_directory_gently and was there before I touched
it, introduced by Linus in d288a700.  What was the original reason to
do this?  Are there implementations of getcwd which return a relative
path?

Additionally there are other places which need to check if some user
supplied path is absolute.  Should we have a macro/function for that
which depends on the os and checks for path[0] = '/' on unix and
perhaps path[1] = ':' on windows?
