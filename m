From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: use "spurious .sp" XSLT if
	DOCBOOK_SUPPRESS_SP is set
Date: Wed, 1 Apr 2009 06:14:00 -0400
Message-ID: <20090401101400.GA26181@coredump.intra.peff.net>
References: <7vljql4586.fsf@gitster.siamese.dyndns.org> <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 12:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoxV9-00070U-QS
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 12:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZDAKOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 06:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbZDAKOQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 06:14:16 -0400
Received: from peff.net ([208.65.91.99]:38642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756816AbZDAKON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 06:14:13 -0400
Received: (qmail 16189 invoked by uid 107); 1 Apr 2009 10:14:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 01 Apr 2009 06:14:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Apr 2009 06:14:00 -0400
Content-Disposition: inline
In-Reply-To: <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115365>

On Wed, Apr 01, 2009 at 03:50:34AM -0500, Chris Johnsen wrote:

> With this change, the "spurious .sp" suppression XSLT code is
> disabled by default. It can be enabled by defining
> DOCBOOK_SUPPRESS_SP.
> [...]
> Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

Acked-by: Jeff King <peff@peff.net>

This looks good to me. Thank you for being so thorough in both the
research and implementation, especially when I was being so lazy. :)

> I went with a "feature knob" instead of a "version knob" since my
> research in the docbook SVN repo indicates that multiple versions
> are affected. Maybe the name could be better. Also I am not at
> all sure that my research into past docbook-xsl releases is 100%
> accurate. Anyone motivated enough to install old versions of
> docbook-xsl and test with them?

I think the "feature knob" makes sense. I don't know that it is worth
extensive testing with old releases. You have a pretty good guess about
which versions are affected, and people who experience the problem can
turn the knob. Your Makefile comments make it easy for them find the
knob once they see the breakage.

It is probably worth mentioning in the release notes to give a heads-up,
though.

Something like:

-- >8 --
Subject: mention docbook knob in the release notes

People with ancient docbook-xsl will see the return of the "spurious
.sp" unless this knob is turned, so let's inform them.

---
diff --git a/Documentation/RelNotes-1.6.3.txt b/Documentation/RelNotes-1.6.3.txt
index f0a2e41..0c8a14e 100644
--- a/Documentation/RelNotes-1.6.3.txt
+++ b/Documentation/RelNotes-1.6.3.txt
@@ -107,6 +107,11 @@ Updates since v1.6.2
 * Makefile learned 'coverage' option to run the test suites with
   coverage tracking enabled.
 
+* Building the manpages with docbook-xsl between 1.69.1 and 1.71.1 now
+  requires setting DOCBOOK_SUPPRESS_SP to work around a docbook-xsl bug.
+  This workaround used to be enabled by default, but causes problems
+  with newer versions of docbook-xsl.
+
 Fixes since v1.6.2
 ------------------
 
