From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 2/2] Loop index increases monotonically when reading unmerged entries
Date: Sun, 24 Aug 2014 19:57:27 +0200
Message-ID: <1408903047-8302-2-git-send-email-jsorianopastor@gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
 <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 19:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLc2t-0004u6-M1
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 19:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbaHXR5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 13:57:36 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:59533 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbaHXR5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 13:57:35 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so12404999wes.39
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jjf8HNBTFW17hTokNrSvJXSmpcqtJv7KeNt0LV7ETYU=;
        b=bhZOe9BmHChk15JgwPyHnm0BwB94AvGSL5X1SqG+pGUAfzlUazSHX5jWmQotH8V3Td
         amhkHK9OA6t0FnQ12+QAWqyKP8nB+YA7fFYTNwFNsmQQt2Y3me8/bb62aOfX6E/pCt45
         X1MrH95ibf7Q/jzuaeYpNh+QOeIm4Flv5yeZE5e5G0trjkyxO/fLpm7mBYE1D3AVcABd
         Dym5Bl2M6Gra111Z+d/1fH6ERn935lV3/jyIKo3NIIMI+rNpxYkYV4c+sQTL4B5xTfPz
         43Fdv0zw+9geQ30Ikm/IeI39rjNr2x7akdXXTFuTvlvfYGU4qKtBoI97QLBi938lqeJ0
         xumg==
X-Received: by 10.180.84.66 with SMTP id w2mr10126044wiy.27.1408903054819;
        Sun, 24 Aug 2014 10:57:34 -0700 (PDT)
Received: from localhost.localdomain (4.Red-88-3-38.dynamicIP.rima-tde.net. [88.3.38.4])
        by mx.google.com with ESMTPSA id fi1sm22712870wib.5.2014.08.24.10.57.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Aug 2014 10:57:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.1.g0b8a4f9.dirty
In-Reply-To: <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255808>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index c1a9619..3d70386 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1971,7 +1971,6 @@ int read_index_unmerged(struct index_state *istate)
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
 				     new_ce->name);
-		i = index_name_pos(istate, new_ce->name, len);
 	}
 	return unmerged;
 }
-- 
2.0.4.1.g0b8a4f9.dirty
