From: Jeff King <peff@peff.net>
Subject: [PATCH] completion: recognize "--local" as a config file source
Date: Tue, 12 Feb 2013 00:49:22 -0500
Message-ID: <20130212054922.GA20129@sigill.intra.peff.net>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
 <20130211210455.GB32740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dasa Paddock <dpaddock@esri.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 06:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U58kX-0002Us-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 06:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab3BLFtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 00:49:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44931 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab3BLFtY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 00:49:24 -0500
Received: (qmail 31799 invoked by uid 107); 12 Feb 2013 05:50:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 00:50:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 00:49:22 -0500
Content-Disposition: inline
In-Reply-To: <20130211210455.GB32740@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216119>

When we are trying to show the list of config variables in a
file, we recognize "--system", "--global", and "--file" as
specifying a particular file. This list misses "--local",
which performs a similar function.

Without this patch, completing:

  git config --get --local

shows items from all config files, not just the local one.

Noticed-by: Dasa Paddock <dpaddock@esri.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c8452fb..0b7b659 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1779,7 +1779,7 @@ __git_config_get_set_variables ()
 	while [ $c -gt 1 ]; do
 		word="${words[c]}"
 		case "$word" in
-		--global|--system|--file=*)
+		--global|--system|--local|--file=*)
 			config_file="$word"
 			break
 			;;
-- 
1.8.1.2.11.g1a2f572
