From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v7 2/2] imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
Date: Mon, 23 May 2016 13:44:03 +0000
Message-ID: <20160523134403.43880-3-gitter.spiros@gmail.com>
References: <20160523134403.43880-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
X-From: git-owner@vger.kernel.org Mon May 23 15:45:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4qAF-0004ny-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 15:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbcEWNos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 09:44:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33065 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcEWNor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 09:44:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id 67so15269627wmg.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgdrJYopLZXedC6R/gwObhOjti69x3UwRdRjcwXCHSE=;
        b=Oj/krEEzOagYu9vflgRHvJpvl7GIqgFbNNIU4jRqZ2c9oWZnkEe2UhP6uQnNslZk+8
         QvKiiphnczXOM1jp2cHICSWWN3Vy/q7LiWbM4O/KhVGSR8GKw2m+bKJpusw7jXF722zV
         VxpMtxs9eV/eIYlqoZZim9qabXbX/65/e7Bumuuz1RouIQ8qDHaKGjGK8CmTtf0g3EWW
         j7DMwTmk6wwH3Kjuhyqhl5a9OZvb+ReupXlibrj2o0q+pu1B6RI+4LTmIEXzYmhRCPVd
         lW9KGe3UVdo1Cs/SLZEcQQ0tuEldrylXI29fvgWMUseqNKDfY/e/BFSvogkKjN118O5n
         WrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgdrJYopLZXedC6R/gwObhOjti69x3UwRdRjcwXCHSE=;
        b=MedPPSv6yJ94F2YkTck/XToyzdgbU6VTvkxp1hI1tf5NKsV1vVhUOkjvR1eCxRhMSe
         8wXdIEUASg7tmcrShA+tdGu7WgLanPvRjbfUK0+mwtYEDqRQLocCbX6VbUM0IFnLeGLh
         TYXO9/UKWAY3YH4wdN5wGReLh2BJA7fc03N+3oG9d3thJYWiwtrgGUeWYMTrvx93gLqN
         9RicTMR98HR53PS3ogXsk7rXRaeVuNH++tf31ELByY81sDMs4UnjGXzWM/ic5Muz7ii/
         V10I00o4f/N+YxSWMEHh7kk5abpYTJWiZ4RNdXc9/v2ncSNIGRDmNrGl7j0hWCmWrmtE
         YMgA==
X-Gm-Message-State: AOPr4FVCEhGCPj2zr+TQAfCo3iNZORxGKS4kSXINGgN33tZBFjLPjDQ8pMtns3x6u9jmBw==
X-Received: by 10.28.217.79 with SMTP id q76mr17033932wmg.83.1464011086081;
        Mon, 23 May 2016 06:44:46 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id t3sm13764131wmf.20.2016.05.23.06.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 06:44:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.614.g2da74fb.dirty
In-Reply-To: <20160523134403.43880-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295324>

Permit the use of the GIT_TRACE_CURL environment variable calling
the setup_curl_trace http.c helper routine.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index 938c691..50377c5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1443,6 +1443,7 @@ static CURL *setup_curl(struct imap_server_conf *=
srvc)
=20
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+	setup_curl_trace(curl);
=20
 	return curl;
 }
--=20
2.8.3.614.g2da74fb.dirty
