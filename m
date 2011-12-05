From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, v4] git-tag: introduce --cleanup option
Date: Mon, 5 Dec 2011 17:29:15 -0500
Message-ID: <20111205222915.GA7644@sigill.intra.peff.net>
References: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
 <20111205222724.GA7603@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXh2K-0000fd-NY
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 23:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572Ab1LEW3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 17:29:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1LEW3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 17:29:18 -0500
Received: (qmail 30285 invoked by uid 107); 5 Dec 2011 22:35:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Dec 2011 17:35:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2011 17:29:15 -0500
Content-Disposition: inline
In-Reply-To: <20111205222724.GA7603@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186294>

On Mon, Dec 05, 2011 at 05:27:24PM -0500, Jeff King wrote:

> I also looked at factoring out the "which cleanup mode to select" logic
> from builtin/commit.c, but it turned out to just make things harder to
> follow.

While I was doing that, I also noticed this minor fix:

-- >8 --
Subject: [PATCH] stripspace: fix outdated comment

The comment on top of stripspace() claims that the buffer
will no longer be NUL-terminated. However, this has not been
the case at least since the move to using strbuf in 2007.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/stripspace.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 4d3b93f..1288ffc 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -22,8 +22,6 @@ static size_t cleanup(char *line, size_t len)
  * Remove empty lines from the beginning and end
  * and also trailing spaces from every line.
  *
- * Note that the buffer will not be NUL-terminated.
- *
  * Turn multiple consecutive empty lines between paragraphs
  * into just one empty line.
  *
-- 
1.7.8.rc4.4.g884ec
