From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/29] commit_ref_update(): write error message to *err, not stderr
Date: Wed, 27 Apr 2016 18:57:23 +0200
Message-ID: <88629e7803570ef31459656184d01c73d3dc8b73.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnD-0003f6-GQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbcD0Q6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:19 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53601 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbcD0Q6R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:17 -0400
X-AuditID: 12074414-63fff700000008e6-e5-5720efa43551
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 38.62.02278.4AFE0275; Wed, 27 Apr 2016 12:58:12 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6J022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:11 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvkvUK4wbUea4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8b57j1MBetYKs6e28PSwHiSuYuRk0NCwETiSdNV
	li5GLg4hga2MEl3T7zFBOMeZJJZfus8IUsUmoCuxqKeZCcQWEXCQWL7yFztIEbNAE5PE9+VN
	QO0cHMICwRJTPtaD1LAIqEqsvbiGDcTmFYiS2HngGzvENjmJy9MfgMU5BSwkvrS+BZsvJGAu
	seTBavYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoSEmMgOxiMn
	5Q4xCnAwKvHwnpBSCBdiTSwrrsw9xCjJwaQkyrvkLFCILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO/0N0A53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ3vJ3QI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoBiILwZGAUiKB2hvKUg7b3FBYi5QFKL1FKMu
	x4Ift9cyCbHk5eelSonzLgApEgApyijNg1sBSyivGMWBPhbmDQKp4gEmI7hJr4CWMAEtuXxI
	FmRJSSJCSqqBUWnu+/oodsGNXD4i0tz/VaOOXFlsrs8xO3Cq/1aPlVMqCoXuX7u35pfcbn71
	iW9DrV7cSS3f97f0rcyHibabO2/v368Y+Uv+W/2Jj6UruNcEJR356Z4uO3f/UyWl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292746>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f38076..de38517 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2686,7 +2686,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		}
 	}
 	if (commit_ref(lock)) {
-		error("Couldn't set %s", lock->ref_name);
+		strbuf_addf(err, "Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
-- 
2.8.1
