From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] merge-recursive: prepare merge_recursive() to be
	called from builtins
Date: Mon, 11 Aug 2008 17:13:03 +0200
Message-ID: <20080811151303.GA11208@leksak.fem-net>
References: <cover.1218374062.git.vmiklos@frugalware.org> <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZ62-0008W6-MZ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYHKPNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYHKPNH
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:13:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:44765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751005AbYHKPNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:13:06 -0400
Received: (qmail invoked by alias); 11 Aug 2008 15:13:04 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp049) with SMTP; 11 Aug 2008 17:13:04 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19F138M36pFO7xtu01tlzmX2QDy/omF29h/mtN7ao
	1gCFrq5FUUYsUI
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSZ4x-0003oy-Cz; Mon, 11 Aug 2008 17:13:03 +0200
Content-Disposition: inline
In-Reply-To: <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91945>

Hi,

Miklos Vajna wrote:
> When other builtins call merge_recursive(), they would have to handle
> the GIT_MERGE_VERBOSITY environment variable, causing a code
> duplication. Same story for the git_config() call. It's better to do it
> when merge_recursive() is called the first time.

Hmm, I have the long-run vision that we have a nice libgit some day,
with merge_recursive() being part of it.  And I'm a little unsure if
libified functions should rely on environment variables.
So I'm wondering if the verbosity should be set in the caller functions
of merge_recursive(), i.e. that cmd_merge_recursive() and cmd_merge()
(or another part of builtin-merge.c) does the
	getenv("GIT_MERGE_VERBOSITY")
stuff and a verbosity value could be a new argument to merge_recursive().
Then other merge_recursive() users don't need to
	setenv("GIT_MERGE_VERBOSITY", "3", 1)
or something, they just pass 3 as the verbosity value.

Just a thought,
  Stephan

PS: Your patch looks fine to me.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
