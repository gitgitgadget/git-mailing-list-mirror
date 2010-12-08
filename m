From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git format-patch should honor notes
Date: Wed, 8 Dec 2010 12:15:40 +0100
Message-ID: <201012081215.40809.trast@student.ethz.ch>
References: <4CFEACC5.70005@redhat.com> <20101207221151.GC1036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 12:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQHzw-0003zq-8U
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 12:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab0LHLPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 06:15:43 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:3329 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960Ab0LHLPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 06:15:42 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 8 Dec
 2010 12:15:18 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 8 Dec
 2010 12:15:41 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc4-13-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101207221151.GC1036@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163188>

Jeff King wrote:
> > My workflow is that I post patch series for upstream review via 'git
> > send-email'.  Often, that results in feedback that requires me to
> > amend/rebase my series, and post a v2 or v3 of the series.  By adding
> > 'git config notes.rewriteRef refs/notes/commits', I can add notes that
> > will carry across my rebase, and remind me what I changed in v2 (for
> > example, git notes add -m 'v2: fix foo, per mail xyz@example.com').
> 
> Yeah, that is a workflow that some others have mentioned using here,

Incidentally it's what I wrote the rewriteRef support for :-)

> too. And I think there is general agreement that notes should go after
> the "---" in format-patch. We just need a working patch.
> 
> Thomas posted one in February:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/140819
> 
> But there were some issues and it never got polished.

I got pretty frustrated with gfp being rather brittle.  It is very
hard to insert anything anywhere in the output stream in such a way
that the output is not affected in any *other* scenario where this
option is disabled.

So I think a good angle of attack if you want to hack around on this
would be to clean up gfp so that it becomes easier to work on, and/or
come up with a better/cleaner place to insert the notes support than I
had.

That being said, the version I still use just shifts around a linefeed
after the ---, IIRC, and so far nobody complained about that in
practice ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
