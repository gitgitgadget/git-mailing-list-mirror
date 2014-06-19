From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 0/16] =?utf-8?b?c2tpcF9wcmVmaXg=?= refactoring and cleanups
Date: Thu, 19 Jun 2014 05:22:46 +0000 (UTC)
Message-ID: <loom.20140619T065448-710@post.gmane.org>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 07:23:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxUoX-00044R-1a
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 07:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbaFSFXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 01:23:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:52308 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaFSFXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 01:23:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WxUoM-0003uS-Ng
	for git@vger.kernel.org; Thu, 19 Jun 2014 07:22:58 +0200
Received: from 117.254.223.153 ([117.254.223.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 07:22:58 +0200
Received: from tanayabh by 117.254.223.153 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 07:22:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 117.254.223.153 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252096>

Hi,

I was about to send a patch like this series today, I am attaching it below.

-- >8 --
Subject: [PATCH] imap-send: use skip_prefix instead of using magic numbers

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 imap-send.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 83a6ed2..524fbab 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1328,13 +1328,9 @@ static char *imap_folder;
 
 static int git_imap_config(const char *key, const char *val, void *cb)
 {
-	char imap_key[] = "imap.";
-
-	if (strncmp(key, imap_key, sizeof imap_key - 1))
+	if (!skip_prefix(key, "imap.", &key))
 		return 0;
 
-	key += sizeof imap_key - 1;
-
 	/* check booleans first, and barf on others */
 	if (!strcmp("sslverify", key))
 		server.ssl_verify = git_config_bool(key, val);
-- 
1.9.0.GIT
