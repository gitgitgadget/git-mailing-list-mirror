From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/15] read-cache: Improve readability
Date: Fri, 20 Mar 2015 17:27:59 -0700
Message-ID: <1426897692-18322-3-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7H7-0001Z4-IV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbbCUA2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:22 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34871 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbCUA2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:20 -0400
Received: by igcau2 with SMTP id au2so1634008igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VYMYUzHx7jbLFM2sJjvwZdNFckbAVTa5BzaaLIuBq9E=;
        b=gjDdmKqdHs5HfiuNMCIqFtl+yxDxV0GNTZ/nzX8M4c1aCpqtE/RRvIbVjYmEvJAJZs
         zSS0x3DYDhRFkvkQBGEP4jlX0k9+ts/qObXbIG17iRKBy3eHlLZmYjd+ZOXjkZaOvMav
         vhhJhDpehAE5s718SDz8TMjy3IKbZF48Hh5q14yPQGHgA56JUsPk87GuJrlH3EZgxff3
         6Z5GrB0MyDXhin5QTcSI/pUnunwH5ogcxXrL78ZVkUfdmg4+XZMGA4x+LCGVZ6MAjagj
         8Ah9SKJbt7uzb2ihj2sgxBwBn1HsqSgiUYQPqMF4niJuQq/Q/Ka7M/tUDZe0s3LwT7QT
         1v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VYMYUzHx7jbLFM2sJjvwZdNFckbAVTa5BzaaLIuBq9E=;
        b=XqAzT4/vFohbOrTEo4R4rcX9izeCMcmXWgaC9c1w9F7OFIEBNAFOl9Hz08Q0vZLIhb
         CCb6r9/gX7iwO9VrbqlVjOX/QBmaBtrw990gC/ftn5UvcBgqn5sUsqYytLnJzBvGPqYf
         hF2tH8s5iv5JYOITaO3QhuvtOz+tEPu8jfYlzFTnsLMZLhzU1YtZ2UVrV3sWJbfw2Zf9
         Qro8RcHTysn0ZZ8UdrGr6moUbkXZYyDOnDLrM4IWyO1lycwG9J35HqMXHYaLTY5ylR56
         1sRtS6pRVGo3afxQUJYNO5sM94/qJxF1GRRPv4DxbpqCXArkTy7ZCyQAhfs+JGHxrgWB
         0rdQ==
X-Gm-Message-State: ALoCoQlnC8R4HdWYIeECxOet0uw8AkOglP8M/b/r4dozm1jRiZwizRBU5wv1ul9O/4NrNraE6MGo
X-Received: by 10.50.234.194 with SMTP id ug2mr417742igc.39.1426897699852;
        Fri, 20 Mar 2015 17:28:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id qr1sm164044igb.18.2015.03.20.17.28.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:19 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265981>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f72ea9f..769897e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -703,9 +703,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		    !hashcmp(alias->sha1, ce->sha1) &&
 		    ce->ce_mode == alias->ce_mode);
 
-	if (pretend)
-		;
-	else if (add_index_entry(istate, ce, add_option))
+	if (!pretend && add_index_entry(istate, ce, add_option))
 		return error("unable to add %s to index",path);
 	if (verbose && !was_same)
 		printf("add '%s'\n", path);
-- 
2.3.0.81.gc37f363
