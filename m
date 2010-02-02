From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct spelling of 'REUC' extension
Date: Tue, 2 Feb 2010 07:33:28 -0800
Message-ID: <20100202153328.GB9687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKmz-00054f-QZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405Ab0BBPfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:35:12 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:46070 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab0BBPfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:35:07 -0500
Received: by gxk24 with SMTP id 24so153534gxk.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:33:35 -0800 (PST)
Received: by 10.150.240.13 with SMTP id n13mr8635560ybh.333.1265124811081;
        Tue, 02 Feb 2010 07:33:31 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 7sm2175022ywf.10.2010.02.02.07.33.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 07:33:29 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138727>

The new dircache extension CACHE_EXT_RESOLVE_UNDO, whose value is
0x52455543, is actually the ASCII sequence 'REUC', not the ASCII
sequence 'REUN'.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I missed the patch that added this to C Git, so I got a bit
 surprised when an unresolved index started crashing inside of JGit.

 JGit is trying to do the right thing by ignoring the extension,
 since its name is all uppercase, but its still getting confused
 and barfing at the end of the file.  While trying to track it down
 I started scratching my head wondering what this 'REUC' extension
 was, and where it came from... only to find out its not actually
 documented in the sources, because the comment is wrong.

 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 309b77a..f1f789b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -26,7 +26,7 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
 
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
-#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUN" */
+#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 
 struct index_state the_index;
 
-- 
1.7.0.rc0.170.g7207c

-- 
Shawn.
