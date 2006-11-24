X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/5] fetch-pack: Properly remove the shallow file when it becomes empty.
Date: Fri, 24 Nov 2006 15:58:04 +0100
Message-ID: <871wnsvqmb.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 14:58:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32220>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncVH-00083M-VA for gcvg-git@gmane.org; Fri, 24 Nov
 2006 15:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934635AbWKXO6I (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 09:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934636AbWKXO6I
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 09:58:08 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:37348 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S934635AbWKXO6H
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 09:58:07 -0500
Received: from adsl-84-226-49-216.adslplus.ch ([84.226.49.216]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GncVC-0005HO-Ly for
 git@vger.kernel.org; Fri, 24 Nov 2006 08:58:07 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 0D8DB10A155; Fri,
 24 Nov 2006 15:58:04 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The code was unlinking the lock file instead.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 fetch-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d00573d..bb310b6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -700,7 +700,7 @@ int main(int argc, char **argv)
 
 		fd = hold_lock_file_for_update(&lock, shallow, 1);
 		if (!write_shallow_commits(fd, 0)) {
-			unlink(lock.filename);
+			unlink(shallow);
 			rollback_lock_file(&lock);
 		} else {
 			close(fd);
-- 
1.4.4.1.ga335e

-- 
Alexandre Julliard
