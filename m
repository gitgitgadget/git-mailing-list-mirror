From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-rebase--interactive: Handle commit messages that end in backslash
Date: Fri, 14 May 2010 12:15:55 +0200
Message-ID: <201005141215.55746.trast@student.ethz.ch>
References: <20100513133955.05493175@bobcat.office> <20100513135807.548594f9@bobcat.office> <20100513143350.GA2742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chris Lamb <lamby@debian.org>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 14 12:16:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrw6-0003lS-4n
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 12:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759023Ab0ENKP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 06:15:59 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4909 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759019Ab0ENKP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 06:15:58 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 14 May
 2010 12:15:55 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 14 May
 2010 12:15:56 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <20100513143350.GA2742@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147078>

Jeff King wrote:
> As I understand it[1], the subject line shown is for
> human consumption only, and the actual operations happen on the included
> sha1. So we could munge it in a non-reversible way without breaking
> anything.
> 
> -Peff
> 
> [1] I may be wrong. This is not code I'm too familiar with, and I do
> remember a proposal at some point for automagically handling subjects
> with "wip" or "squash" in them. Still, a light munging may work.

During the actual rebasing, only the 'cmd sha' portion of the line
matters, as evidenced by the code doing

  do_next () {
          rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
          read command sha1 rest < "$TODO"

and then not using $rest except in status messages.

The automatic handling you are referring to is --autosquash, which
happens in rearrange_squash() which is a preprocessing stage.  AFAICS
that function is still okay iff the munging maps prefixes to prefixes.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
