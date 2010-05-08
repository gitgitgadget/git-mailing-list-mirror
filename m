From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Sat, 8 May 2010 00:44:34 -0400
Message-ID: <20100508044434.GC14998@coredump.intra.peff.net>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
 <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
 <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 08 06:44:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAbuF-0001xb-Tl
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 06:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030Ab0EHEoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 00:44:38 -0400
Received: from peff.net ([208.65.91.99]:53200 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab0EHEoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 00:44:37 -0400
Received: (qmail 2613 invoked by uid 107); 8 May 2010 04:44:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 00:44:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 00:44:34 -0400
Content-Disposition: inline
In-Reply-To: <19428.24021.324557.517627@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146635>

On Fri, May 07, 2010 at 02:37:09PM -0400, Eli Barzilay wrote:

> BTW, I've had at least 4 people now who got confused by this.  Is
> there any use for -M/-C without --follow?  In any case, it will be
> very helpful if the -M/-C descriptions said "see also --follow".

Yes, it detects renames when doing diffs.

Documentation patch is below.

> Also, is there a way to set this as the default for `git log'?

If you mean --follow, then no. Nor would you probably want to, because
the --follow mechanism (as currently implemented) is pretty restricted.
It can only take a single path currently.

-- >8 --
Subject: [PATCH] docs: clarify meaning of -M for git-log

As an option to the "diff" family, it is fairly obvious what
"detect renames" means. However, for revision traversal, the
"-M" option is just included in the long list of options,
with no indication that it is about showing renames in diffs
versus following renames. Let's make it more explicit.

Signed-off-by: Jeff King <peff@peff.net>
---
The only other revision traversal manpage that includes diff-options
seems to be format-patch. Should it get the same treatment?

 Documentation/diff-options.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c9c6c2b..3070ddd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -177,7 +177,14 @@ endif::git-format-patch[]
 	Break complete rewrite changes into pairs of delete and create.
 
 -M::
+ifndef::git-log[]
 	Detect renames.
+endif::git-log[]
+ifdef::git-log[]
+	If generating diffs, detect and report renames for each commit.
+	For following files across renames while traversing history, see
+	`--follow`.
+endif::git-log[]
 
 -C::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
-- 
1.7.1.176.gcff095.dirty
