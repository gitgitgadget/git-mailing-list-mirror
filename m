From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Typo in RelNotes.
Date: Thu, 12 Jun 2008 02:14:28 -0400
Message-ID: <20080612061428.GA28696@sigill.intra.peff.net>
References: <alpine.LNX.1.00.0806120434290.5838@localhost> <905315640806112059r713bf807l20a1bc1e14ce4e27@mail.gmail.com> <20080612045330.GB25992@sigill.intra.peff.net> <905315640806112206g4df6ce11h2a98412223e13fdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:15:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6g61-0006n8-To
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYFLGOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbYFLGOb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:14:31 -0400
Received: from peff.net ([208.65.91.99]:3595 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbYFLGOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:14:30 -0400
Received: (qmail 9503 invoked by uid 111); 12 Jun 2008 06:14:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 02:14:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 02:14:28 -0400
Content-Disposition: inline
In-Reply-To: <905315640806112206g4df6ce11h2a98412223e13fdd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84719>

On Wed, Jun 11, 2008 at 10:06:13PM -0700, Tarmigan wrote:

> > Maybe I am blind, but I don't see a typo. Are you referring to tformat,
> > which looks like a typo, but is actually correct?
> 
> Oops you're right.  That's what I was thinking of.  Junio's commit
> message explains it well.  Should something be added to the man page
> about it?

How about this? I worry that the perl in the example is unnecessarily
complex, but I couldn't think of a simpler way to show "in this one, the
trailing newline is missing". So I am open to suggestions.

-- >8 --
document --pretty=tformat: option

This was introduced in 4da45bef, but never documented
anywhere.
---
 Documentation/pretty-formats.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e8bea3e..14a2665 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -124,3 +124,24 @@ The placeholders are:
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%x00': print a byte from a hex code
+
+* 'tformat:'
++
+The 'tformat:' format works exactly like 'format:', except that it
+provides "terminator" semantics instead of "separator" semantics. In
+other words, each commit has the message separator (usually a newline)
+appended, rather than placed between entries. This means that the final
+entry of a single-line format will be properly terminated with a new
+line, just as the "oneline" format does. For example:
++
+---------------------
+$ git log -2 --pretty=format:%h 4da45bef \
+  | perl -pe '$_ .= " -- NO NEWLINE\n" unless /\n/'
+4da45be
+7134973 -- NO NEWLINE
+
+$ git log -2 --pretty=tformat:%h 4da45bef \
+  | perl -pe '$_ .= " -- NO NEWLINE\n" unless /\n/'
+4da45be
+7134973
+---------------------
-- 
1.5.6.rc2.168.g23af0b.dirty
