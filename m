From: Jeff King <peff@peff.net>
Subject: [PATCH] subtree: initialize "prefix" variable
Date: Mon, 17 Mar 2014 15:59:47 -0400
Message-ID: <20140317195946.GA29839@sigill.intra.peff.net>
References: <5326F158.4050402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gilles Filippini <gilles.filippini@free.fr>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:00:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdhR-00052y-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbaCQT7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:59:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:41332 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750728AbaCQT7t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:59:49 -0400
Received: (qmail 25858 invoked by uid 102); 17 Mar 2014 19:59:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 14:59:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Mar 2014 15:59:47 -0400
Content-Disposition: inline
In-Reply-To: <5326F158.4050402@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244277>

On Mon, Mar 17, 2014 at 01:58:00PM +0100, Gilles Filippini wrote:

> Test 21 from contrib/subtree/t/t7900-subtree.sh fails when an
> environment variable 'prefix' is set. For instance here is what happens
> when prefix=/usr:

I think it just needs the patch below.

-- >8 --
We parse the "--prefix" command-line option into the
"$prefix" shell variable. However, if we do not see such an
option, the variable is left with whatever value it had in
the environment. We should initialize it to a known value,
like we do for other variables.

Signed-off-by: Jeff King <peff@peff.net>
---
I checked, and this looks like the only variable in this situation.

 contrib/subtree/git-subtree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dc59a91..db925ca 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -46,6 +46,7 @@ ignore_joins=
 annotate=
 squash=
 message=
+prefix=
 
 debug()
 {
-- 
1.9.0.532.gc4c322d
