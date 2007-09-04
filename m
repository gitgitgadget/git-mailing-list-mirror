From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Tue, 4 Sep 2007 16:44:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041642350.28586@racer.site>
References: <20070904115317.GA3381@artemis.corp> <11889144741644-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISaaP-0007tI-BC
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbXIDPo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbXIDPo7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:44:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:56376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753222AbXIDPo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:44:59 -0400
Received: (qmail invoked by alias); 04 Sep 2007 15:44:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 04 Sep 2007 17:44:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XBftRbLrXLZOHGhLakVTYCw5IKSqcX6So6fh+U2
	WGEhRYCLCPwkC5
X-X-Sender: gene099@racer.site
In-Reply-To: <11889144741644-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57601>

Hi,

On Tue, 4 Sep 2007, Pierre Habouzit wrote:

> +void strbuf_grow(struct strbuf *sb, size_t extra) {
> +	if (sb->len + extra + STRBUF_GROW_STEP < sb->len)
> +		die("you want to use way to much memory");
> +
> +	sb->alloc = ((sb->len + extra) + STRBUF_GROW_STEP) & ~(STRBUF_GROW_STEP - 1);
> +	sb->buf   = xrealloc(sb->buf, sb->alloc);
> +}

Why not use ALLOC_GROW()?  Seems to me more efficient than growing by 1kB 
blocks all the time, for big strings as for short strings.

Ciao,
Dscho
