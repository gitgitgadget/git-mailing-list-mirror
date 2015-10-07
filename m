From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/2] quote: move comment before sq_quote_buf()
Date: Thu,  8 Oct 2015 00:05:50 +0200
Message-ID: <1444255550-27631-2-git-send-email-chriscool@tuxfamily.org>
References: <1444255550-27631-1-git-send-email-chriscool@tuxfamily.org>
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:06:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjwqx-0005gm-RA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 00:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbbJGWGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 18:06:23 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35803 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbbJGWGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 18:06:22 -0400
Received: by wicge5 with SMTP id ge5so197707wic.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihAkru1iBVuNRoKjlF66ivDwHLW15Nzvjmw2ZXHaFvc=;
        b=TJAuvspluDOK6CFLTQXFVUcAlKc3nrDE3MPI2xPgbQ/2ogYNYvQCa3EpYvoRGggZup
         3pb5n0XW1+vJGOIA6H/3Z1JBsUyf+EFKazbxTKENeg0psn6JQ+CTnaIJ5K5KZd8eyfaM
         iY2vpataWDL1PxGci+b4Q0CNqJD+9FVm6aaUHCj52ixdemxg2LYIz6/K9LDE85kboL33
         xgCQgKBaoakCmyzBDlnaPdPz4t4T+GTZmvLbc7z/rBdyTtFoslCkvf9fJT2P8BgJuBsR
         AYKzI4nvk8IqwNp/0aMZIxlHBqta2hCwfmGjcAiFyRknDoESXGA1LW96xap6RCL7F5wi
         loEw==
X-Received: by 10.194.6.161 with SMTP id c1mr4373805wja.152.1444255581556;
        Wed, 07 Oct 2015 15:06:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id hd1sm4385289wib.5.2015.10.07.15.06.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Oct 2015 15:06:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1444255550-27631-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279205>

A big comment at the beginning of quote.c is really
related to sq_quote_buf(), so let's move it in front
of this function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 quote.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/quote.c b/quote.c
index 890885a..fe884d2 100644
--- a/quote.c
+++ b/quote.c
@@ -4,6 +4,11 @@
 
 int quote_path_fully = 1;
 
+static inline int need_bs_quote(char c)
+{
+	return (c == '\'' || c == '!');
+}
+
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
@@ -16,11 +21,6 @@ int quote_path_fully = 1;
  *  a'b      ==> a'\''b    ==> 'a'\''b'
  *  a!b      ==> a'\!'b    ==> 'a'\!'b'
  */
-static inline int need_bs_quote(char c)
-{
-	return (c == '\'' || c == '!');
-}
-
 void sq_quote_buf(struct strbuf *dst, const char *src)
 {
 	char *to_free = NULL;
-- 
2.6.0
