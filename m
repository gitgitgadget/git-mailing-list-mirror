From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH resend 0/3] transport: catch non-fast-forwards
Date: Fri, 4 Dec 2009 02:05:39 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912040153090.14365@iabervon.org>
References: <20091204144822.a61355d2.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 08:05:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGSEb-0003g3-Oo
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 08:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZLDHFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 02:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZLDHFd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 02:05:33 -0500
Received: from iabervon.org ([66.92.72.58]:50192 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbZLDHFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 02:05:33 -0500
Received: (qmail 32246 invoked by uid 1000); 4 Dec 2009 07:05:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Dec 2009 07:05:39 -0000
In-Reply-To: <20091204144822.a61355d2.rctay89@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134499>

On Fri, 4 Dec 2009, Tay Ray Chuan wrote:

> This patch series applies on top of 'next', and deals with alerting
> the user to non-fast-forward pushes when using helpers (smart).
> 
> Previously, git silently exited. This situation involves the curl
> helper and the smart protocol. The fast-forward push is only detected
> when curl executes the rpc client (git-send-pack). Now, we detect it
> before telling the helper to push.
> 
> The first patch refactors ref status logic out of builtin-send-pack.c.
> 
> The second patch lets git know of non-fast-forwards before actually
> telling the helper to push anything.
> 
> The third patch changes the return code when ref status indicate an
> error (determined by push_had_errors()), so that the caller of
> transport_push() is alerted.

Seems to me like transport_push() ought to set this sort of status 
information before calling the push method, rather than requiring all of 
the implementations to remember to call the generic function, since 
there's not really anything else sane they can do, right?

(There's eventually going to be at least a third push implementation: 
export the data to a foreign system a la "git svn dcommit")

	-Daniel
*This .sig left intentionally blank*
