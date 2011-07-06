From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: document --textconv diff option
Date: Wed, 6 Jul 2011 11:13:30 -0400
Message-ID: <20110706151330.GA13790@sigill.intra.peff.net>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
 <20110702104313.GA10245@sigill.intra.peff.net>
 <m3r5634ijc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Al Haraka <alharaka@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 17:13:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeTnJ-0002mF-LS
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 17:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab1GFPNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 11:13:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35337
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab1GFPNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 11:13:35 -0400
Received: (qmail 22111 invoked by uid 107); 6 Jul 2011 15:13:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 11:13:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 11:13:30 -0400
Content-Disposition: inline
In-Reply-To: <m3r5634ijc.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176709>

On Wed, Jul 06, 2011 at 06:59:53AM -0700, Jakub Narebski wrote:

> Actually I think neither git-format-patch (which is used by 'patch'
> and 'patches' views), not git-diff-tree (used by 'commitdiff' and
> 'blobdiff' views, and their *_plain versions) supports --textconv,
> and that it is supported only by git-diff.  But you better check that.

I did. It works for both.

> Nb documentation as of 1.7.5 is entirely unhelpful.  Only git-cat-file
> is documented as using --textconv... though this option is examined
> in diff.c, and there is test for git-blame supporting it.

Patch below.

> By the way, I don't know if git read .gitattributes file (which
> defines textconv... unless you use per repository instance
> .git/info/attributes) from tree for given commit, or only from working
> area.

It's not currently read from the tree; see earlier in the thread for
some discussion.

-Peff

-- >8 --
Subject: [PATCH] docs: document --textconv diff option

This has been there since textconv existed, but was never
documented. There is some overlap with what's in
gitattributes(5), but it's important to warn in both places
that textconv diffs probably can't be applied.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/diff-options.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4235302..b620b3a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -422,6 +422,17 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.
 
+--textconv::
+--no-textconv::
+	Allow (or disallow) external text conversion filters to be run
+	when comparing binary files. See linkgit:gitattributes[5] for
+	details. Because textconv filters are typically a one-way
+	conversion, the resulting diff is suitable for human
+	consumption, but cannot be applied. For this reason, textconv
+	filters are enabled by default only for linkgit:git-diff[1] and
+	linkgit:git-log[1], but not for linkgit:git-format-patch[1] or
+	diff plumbing commands.
+
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules in the diff generation. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default
-- 
1.7.6.20.g45f3f.dirty
