From: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] create subdirs for symlinks
Date: Fri, 6 May 2005 01:34:10 +0200
Message-ID: <20050505233410.GA1852@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 01:28:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTpkv-0004Gn-QZ
	for gcvg-git@gmane.org; Fri, 06 May 2005 01:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEEXeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEEXeQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 19:34:16 -0400
Received: from soundwarez.org ([217.160.171.123]:38629 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261917AbVEEXeN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 19:34:13 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id D190C2D00C; Fri,  6 May 2005 01:34:10 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We may need to create subdirectories, before we can create a
symlink.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -96,6 +96,7 @@ static int write_entry(struct cache_entr
 	case S_IFLNK:
 		memcpy(target, new, size);
 		target[size] = '\0';
+		create_directories(path);
 		if (symlink(target, path)) {
 			free(new);
 			return error("checkout-cache: unable to create symlink %s (%s)",

