From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and 
 optimize it a bit
Date: Sun, 7 Oct 2007 17:11:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071710190.4174@racer.site>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
 <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home>
 <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:12:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYjV-0001GT-Nf
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbXJGQLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbXJGQLt
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:11:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:32856 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752431AbXJGQLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:11:48 -0400
Received: (qmail invoked by alias); 07 Oct 2007 16:11:45 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp046) with SMTP; 07 Oct 2007 18:11:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9aHN71Jr9kJvXIJwZ3zhYCgDn3vXMHhnfbDN/ql
	ZjRm+SrZTUWTsv
X-X-Sender: gene099@racer.site
In-Reply-To: <20071007143912.GB10024@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60191>

Hi,

On Sun, 7 Oct 2007, Pierre Habouzit wrote:

> On Sun, Oct 07, 2007 at 02:24:25PM +0000, Timo Hirvonen wrote:
>
> > strbuf->buf is always non-NULL and NUL-terminated so you could just do
> > 
> > static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> > {
> > 	int len = a->len < b->len ? a->len : b->len;
> > 	return memcmp(a->buf, b->buf, len + 1);
> > }
> 
>   doesn't work, because a buffer can have (in some very specific cases)
> an embeded NUL.

But it should work.  The function memcmp() could not care less if there is 
a NUL or not, it just compares until it finds a difference.

Ciao,
Dscho
