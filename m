From: David Turner <dturner@twopensource.com>
Subject: [PATCH 18/24] fsck_head_link(): remove unneeded flag variable
Date: Thu,  7 Apr 2016 15:03:05 -0400
Message-ID: <1460055791-23313-19-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEF-0007fu-4k
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbcDGTDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:42 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35110 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbcDGTDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:40 -0400
Received: by mail-qg0-f43.google.com with SMTP id f105so47947071qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yaiQeQZNFrvmquNW2uukfBV6hBCsDK+78+rLe3Q6RmI=;
        b=ElOO1k9T2c/pedD6nMqKHzA6WUNPLnDsy6Yb7cewri1djTDmQk/xswWPmf/XAcjM+u
         rrP5NPsIpIoLeBt/pwdrj9RMqEZa4vfYc/6fUkJusv23kXqCwAAef8MY+PipEfNR3ooY
         ClNZD82grwpZxQxqa9m0UE3JrisQSBu75sWrsQYjqXOS3vtzqpVsICZQEZljsKW0Yy/C
         5kmxgkATOKWySidPexukJKTuRdgVmQdbP3/uvcRm78A71kWtfG/VKdhan942poeOSlVB
         /R3XHXCbwgqoeHKCBEH/5+KTwPoclHE4ilY4va6lgxusLmPERLpxBpPBdu7ReR2YjkRD
         O1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yaiQeQZNFrvmquNW2uukfBV6hBCsDK+78+rLe3Q6RmI=;
        b=kGZAwgvnnsOefvEprsire++lVFwNvRhCuYQCFSbpjSsckK4Uq9shEG3pcZBby29XD1
         rA33BY0lQIVytxjRV6+7mXBIzF42R8/HaAw2nzlmRem3qDYKN+CR7N5v0dLKFq069H9O
         tG/DBtkASy0VvtoBtLF0j/0+zyseZb5sH0iMzd8CLvF6+slAbbYZKstLB5+qnTbJZOWd
         h6vydQET+XCvlQYjIYOylyceF88Cz0fWIxnVqBFhICaEaCDX7fHym8eRwtzSjkXjWNuY
         PAPOJOKpwto/8v1Kth4GLt5xNPVE4rIDwQmkg4+dDAsv4VOcfs4+NPhy47RgeiXqHFEa
         XJcA==
X-Gm-Message-State: AD7BkJKTxVgdLEMtiNHFEG+u2bC2obB4yMfBb/Rew2jA/ptG163WHCF6MCX6nzitR0D2oA==
X-Received: by 10.140.176.23 with SMTP id w23mr6408955qhw.76.1460055819729;
        Thu, 07 Apr 2016 12:03:39 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290967>

From: Michael Haggerty <mhagger@alum.mit.edu>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 55eac75..3f27456 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -493,13 +493,12 @@ static void fsck_object_dir(const char *path)
 
 static int fsck_head_link(void)
 {
-	int flag;
 	int null_is_error = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, &flag);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, NULL);
 	if (!head_points_at) {
 		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
-- 
2.4.2.767.g62658d5-twtrsrc
