From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3 2/3] imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
Date: Wed, 20 Apr 2016 16:28:24 +0000
Message-ID: <20160420162825.62380-3-gitter.spiros@gmail.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuzW-0000N1-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbcDTQ2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 12:28:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36496 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcDTQ2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:28:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id l6so15195374wml.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfwaA+tG9+L3crWTywTP7G6/NBWCLFaJRdWaX14ke+Q=;
        b=lN/8F/bi5dryd7f8iUFfkkqQhBGDLfSchRrXEOET5WzcwX12ql0LvkWgG6SGhh/vBm
         BFttrIVPncfcdrZohz4n9hMj+0n2GAnJmYMT8YKHGbKBcyQnC5PFCvjOMCH1MEz5O/h+
         5yOHfcVB6kKvlDgy5pf24djrhguhQP423kxb+xJjW+ZMiFBx67/SPiaWNw0IwJTYtxp4
         /tLkAcaZuY9Z8D9hTErG/rwiZD8IwuQAsBu5z8NJ2iR5axqGmsAinjD4XWVfDJTE6XIy
         tF/sQObgyL187K5wuYFwqV0ts5ooJHA9zOTWi5803JrvHRYARyWWPYg9jsVmcfSGBpZC
         k0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfwaA+tG9+L3crWTywTP7G6/NBWCLFaJRdWaX14ke+Q=;
        b=QQbmlGnSuhV1W5nwXsqdcuPG7Aef/xKx6Ufysw8qh19xlU4lYV4Aw7a0OHAZT7DRiy
         3DLTSd/YdgGW0X3Lpk8ddY5uR26ViVOzkS2tQQT0KIw8JfCTjHS2M4cjubJvHBv8N1e2
         b3J9Y9qy1J4XsuWIITskqHY8M7Lbia5IMMbp2yecadydOFIlZflpwTP3TADPAiWTv/cH
         XFodZzyYJBGFrMLY7/qIOK5HYgJ2raMYyADPnGWtpRvJZaVUDEUHXGmByNQybUrrEiRf
         z3eVgFdxy0kjgG0H0wWN7gwinyx00jnlp29hke85FbR52/B9fsrH/kVAGsXkLxDwDeIi
         Q30A==
X-Gm-Message-State: AOPr4FUp0ifGMFug4nZB0wCwQJ1Q2DndS/V+jScJRfQfywPVxwG310ArwqYjpiyJiVz8qw==
X-Received: by 10.28.165.10 with SMTP id o10mr32104100wme.50.1461169711679;
        Wed, 20 Apr 2016 09:28:31 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id qt3sm6368445wjc.32.2016.04.20.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 09:28:31 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g31b84cc
In-Reply-To: <20160420162825.62380-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292039>

Permit the use of the GIT_TRACE_CURL environment variable calling
the curl_trace and curl_dump http.c helper routine.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 imap-send.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 938c691..61c6787 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1444,6 +1444,12 @@ static CURL *setup_curl(struct imap_server_conf =
*srvc)
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
=20
+	if (curl_trace_want()) {
+		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+		curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
+		curl_easy_setopt(curl, CURLOPT_DEBUGDATA, NULL);
+	}
+
 	return curl;
 }
=20
--=20
2.8.1.383.g31b84cc
