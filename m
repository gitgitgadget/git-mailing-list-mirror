From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv5 2/2] imap-send.c: introduce the GIT_TRACE_CURL environment variable
Date: Mon,  2 May 2016 14:28:13 +0000
Message-ID: <20160502142813.50868-3-gitter.spiros@gmail.com>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 16:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axEpn-0001VT-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 16:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbcEBO2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 10:28:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36329 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbcEBO2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 10:28:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so17298315wmw.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLINaArFgEi1a/LBeFhY5oZnNUeSWznJ5jJzbnZip2s=;
        b=FKsIw6mlWUQbJSfRRQJs/GI8I0V5HY8fh5glpQmyIp+NofoQEJGjXxNGcXwLhA8+Ya
         cPbarsWJO/RDlDuvRdGsgiMUCumb3Ph+Pq+8BnQZILUqzsKPJ1O71zN24U1AYF/gxNel
         vvlWuI53VpqawVJo9pY6GfR9pJC+Soin0x5fZGAZz9lafDZ5Kl+z3f+v8rwksrxJz90q
         tG79L4h2IZaIKuTgb5cGsMJmfAIhU6Iil4HTZunyutGZtx5ITRcMiTsiZo5+slqNjtQa
         9sHTJJPxoX10FtnjXEoFuDhsNskcfCtFCKbh3jCV4qTynQaEHwbYqkbrKGKrxXz3PBYw
         rYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLINaArFgEi1a/LBeFhY5oZnNUeSWznJ5jJzbnZip2s=;
        b=SJrPhOJMqyiSJgcVZYxQWY9Sux/dxsSgbwWMsu1DNzWMHJRWkzcfwnhg6+twI9q9hi
         7pP+vri8F7G/BMRrpsrgwpPcEcs3Qq2S1hcGzwEtAHGvOEAuucw7ol9hBViA4Q1MBW+B
         gGUmZBwT+q2V3x9/R2IFgGvgGxdIlc0alB7WSMMuGpZkD+1BP7msGKm20NSHZYCDOyLZ
         buQDDQii41APdD5o8pSvK/5KF4GajBWgjlBdn5TYF/zVA8u1yuQeKTOCi1FSCbt87ZS1
         EtUx2YatOHz2qUV3R/iej/Nj7V80yCNHvFUJSMO6jsJ5LGS6t1kIbOZhRHae5ph3ef2T
         fBUg==
X-Gm-Message-State: AOPr4FVepzQ7//sJIF6A6BQ70ThioD5r4njL5aR7R9pK+0zvoQNsMrHdKDcrbYAATKnZMA==
X-Received: by 10.194.14.6 with SMTP id l6mr41778514wjc.48.1462199298897;
        Mon, 02 May 2016 07:28:18 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id a200sm19197814wme.8.2016.05.02.07.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 May 2016 07:28:18 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.435.ga07a3e0
In-Reply-To: <20160502142813.50868-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293238>

Permit the use of the GIT_TRACE_CURL environment variable calling
the curl_trace and curl_dump http.c helper routine.

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
2.8.2.435.ga07a3e0
