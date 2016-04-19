From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 4/4] imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
Date: Tue, 19 Apr 2016 15:10:44 +0000
Message-ID: <20160419151044.27814-5-gitter.spiros@gmail.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:11:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXJ4-0007Jk-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbcDSPLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 11:11:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36435 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSPK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:10:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id j10so3085686lfg.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0OGSh1FU/ZIrzKJGdzTtWYsK8co9ckuseDBFKeoI8U=;
        b=QSC4zPAWAWRaGD3qHvNyCyDSl/xADwAyDkyEQHBKgY/BvXlmUufiCGEycGL3Xtzs63
         9MNxjV8UbnyrErPDsFiXiJgU/RW4jelKE/amP0jdxeFwV/7aKhhZNjjKki0bb2/+ubxy
         L0PZ4m0bAJXWAnEdHuBEeBuksOSMSDq2oKpjuLZgZp9sTmljcYR2jY0ikUuxLX4LgKqr
         Lvd/xnIFadBRNAATqu4JYtvy3JCq8W0nA+6jFgVCc1dkqu8XCPNBovSukf5EkeyExlVk
         jMI2XQw5NemsDgmTzU/QXaVi5akLhKTJKANMSYeUQtqjylafn3IpN4msk4oMvVbOWdx8
         zWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0OGSh1FU/ZIrzKJGdzTtWYsK8co9ckuseDBFKeoI8U=;
        b=cdcxlbF/ht5I5fgM/LSiqsILxgblt+cjtIddWfpwAq8pUQ233uaXA+I3Sm+stYf/Fv
         PSKJ2ot5A+mvUCsqdF7geEpLqg1VZ0QOYhyJIKjvFTRxDrzAl1y9b6l+3ICy3q7MA6FW
         zI9PG2p7+JwjlWV+EMX1TkFwkNEzH/zm/xBYHkdKinCuCvez1a41p/YyB6DgAuHU+979
         Z3PLneouF3k3ZvNd7cOlp5IbBOtvuxsyvGKl0L1UyBJnJK7ERs+qZ5t5rnzKoukqbcmP
         hG4Szqzz0p8AW3sU7pJ9QW/6EIKuoJRrqKa/M2rofSITIJraTJWUStrCJWxVQVKHL+NP
         QxqA==
X-Gm-Message-State: AOPr4FWGMGkIQZYAaDFnW1mbFYU7fBksKOOaRYwGjnVR2i9UHMBE/5hcYLOEJY7zv6YPHw==
X-Received: by 10.28.111.77 with SMTP id k74mr4078458wmc.37.1461078657785;
        Tue, 19 Apr 2016 08:10:57 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id u16sm4846168wmd.5.2016.04.19.08.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:10:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g0f2638b
In-Reply-To: <20160419151044.27814-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291872>

Permit the use of the GIT_TRACE_CURL environment variable calling
the curl_trace and curl_dump http.c helper routine


Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 imap-send.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 938c691..b371a78 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1444,6 +1444,12 @@ static CURL *setup_curl(struct imap_server_conf =
*srvc)
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
=20
+	if (trace_want(&trace_curl)) {
+		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+		curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
+		curl_easy_setopt(curl, CURLOPT_DEBUGDATA, NULL);
+	}
+
 	return curl;
 }
=20
--=20
2.5.0
