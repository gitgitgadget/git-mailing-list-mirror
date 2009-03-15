From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
 current branch
Date: Sat, 14 Mar 2009 21:49:09 -0500
Message-ID: <1237085349-14824-1-git-send-email-chris_johnsen@pobox.com>
References: <20090314205628.GA17445@coredump.intra.peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 15 03:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LigRo-0005e1-Jj
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 03:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbZCOCte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 22:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZCOCte
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 22:49:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbZCOCte (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 22:49:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F4A46178;
	Sat, 14 Mar 2009 22:49:32 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.203.162.168]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 8337A6177; Sat, 14 Mar 2009 22:49:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <20090314205628.GA17445@coredump.intra.peff.net>
X-Pobox-Relay-ID: E929E1E6-110B-11DE-B1AB-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113273>

On 2009 Mar 14, at 15:56, Jeff King wrote:
> On Sat, Mar 14, 2009 at 04:34:34PM -0400, Jeff King wrote:
> > The question is how it _should_ be rendered. Monospace isn't really
> > useful for terminals. Maybe simply putting quotation marks around it
> > would cover all situations (I'm worried it will look funny for
> > single-word instances).
>
> And here's a patch that does that; skimming through the output it
> doesn't look too bad. What do you guys think?
>
> ---

The presentation seems OK to me. I thought of two issues:

1) literals that contain a double quote

	$ git grep '`[^`]*"[^`]`' | cat
	config.txt:You can have `[section]` if you have `[section "subsection"]`, but you

   There might be a better regexp to find these, I did not think
   about it too long. The above "hit" seems like a reasonable
   literal string. Maybe it is OK to live with this one
   ("[section "subsection"]").

2) manpage-1.72.xsl 

   I have been setting DOCBOOK_XSL_172 to avoid the ".ft" problem
   (<http://article.gmane.org/gmane.comp.version-control.git/112943>;
   my system is Mac OS X 10.4.11 with MacPorts asciidoc 8.3.1,
   xmlto version 0.0.21, and docbook-xsl 1.74.0). Since non-null
   DOCBOOK_XSL_172 replaces callouts.xsl with manpage-1.72.xsl, I
   added the line to manpage-1.72.xsl.

   Here is the patch if it is deemed appropriate (same line Peff
   added to callouts.xsl):

-- >8 -- 
Subject: [PATCH] manpage-1.72.xsl: wrap inline literal text with double quotes

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
---
 Documentation/manpage-1.72.xsl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
index 4065a3a..a39fd55 100644
--- a/Documentation/manpage-1.72.xsl
+++ b/Documentation/manpage-1.72.xsl
@@ -18,4 +18,6 @@
 	<xsl:text>&#x2302;br&#10;</xsl:text>
 </xsl:template>
 
+<xsl:template match="literal">"<xsl:apply-templates/>"</xsl:template>
+
 </xsl:stylesheet>
-- 
1.6.2
