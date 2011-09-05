From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] http: remove extra newline in error message
Date: Mon, 5 Sep 2011 17:29:34 -0500
Message-ID: <20110905222934.GA20084@elie>
References: <20110905222202.GA32071@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 00:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0hgB-0008T5-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 00:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab1IEW36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 18:29:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56355 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1IEW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 18:29:57 -0400
Received: by iabu26 with SMTP id u26so6801525iab.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nO4Do7MZ47GOOV7P+UdfeMO4ZaqtcWhrmMroupAujaI=;
        b=EtQFasjkhnc9pVGutoouSt/l82kROnXEO0vTw6BHwKQ0KG7+v+nM2SNQldugj1W7bk
         PS11xBy7U0q3NBMcMrVHy38Z7YV0kcefalj8L/0kDR5G+QL9aR5KqK70Jx8hQOvy9FMA
         gGLDqgn6bi6hrpRDbDchIUdGAVJZgSK4Du/H0=
Received: by 10.231.21.201 with SMTP id k9mr8247292ibb.76.1315261793749;
        Mon, 05 Sep 2011 15:29:53 -0700 (PDT)
Received: from elie (c-24-1-57-115.hsd1.il.comcast.net [24.1.57.115])
        by mx.google.com with ESMTPS id v16sm15895172ibe.0.2011.09.05.15.29.50
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Sep 2011 15:29:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110905222202.GA32071@elie>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180765>

There is no need for a blank line between the detailed error message
and the later "fatal: HTTP request failed" notice.  Keep the newline
written by error() itself and eliminate the extra one.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
> I ran into this error today

Here's a patch for a simpler buglet noticed at the same time.

 http.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index dec3c60a..fb3465f5 100644
--- a/http.c
+++ b/http.c
@@ -913,7 +913,7 @@ int http_error(const char *url, int ret)
 {
 	/* http_request has already handled HTTP_START_FAILED. */
 	if (ret != HTTP_START_FAILED)
-		error("%s while accessing %s\n", curl_errorstr, url);
+		error("%s while accessing %s", curl_errorstr, url);
 
 	return ret;
 }
-- 
1.7.6
