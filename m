From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv4 2/2] imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
Date: Thu, 28 Apr 2016 11:57:48 +0000
Message-ID: <20160428115748.37177-3-gitter.spiros@gmail.com>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 13:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avkaH-000284-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 13:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbcD1L6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 07:58:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35642 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbcD1L6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 07:58:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so22655941wme.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxeQGDsfditaBnnrsXpTeinMzBexmI4k/9DGOXg+tvM=;
        b=EIReSs6a6G137TKukVvskj+TdfM9Pb/+N3XrBhZshXRfry6JnBJsx1ibPOpVV+H7yN
         X9Zd4o0dBekpy9ZrgQLfAPzdnUA8z5Yq+fE4t3l0kRwDYmfmPfpbKsmMQM6gwzNSzYZA
         vERhbIThUuX6ZGEzC8nE51TWjACUt3TPjLVVVhfWvPazAVRqBke4kpUzDRl8sjhoWYu7
         QUJ/Jc9wpKdGaYDt/e+nsd2fMKON+L1Vz/3gUAFx28nZRgrTK7Tm+vILOV2M2HTMaliI
         tQ2XxJqMXtEx//BZeMoV+q3CsYj5ocfAUOQgWBzDvYEDuGh9fm5rnU9JNbhjTkPavyU3
         kxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxeQGDsfditaBnnrsXpTeinMzBexmI4k/9DGOXg+tvM=;
        b=iajpiZrlqcWbVSph3inZ+nV2VNBq8xYziG/HRoTAtAIg82mLoI5RPQzsJLeR6OE2QQ
         7GHDMu2AX6iXTgz1MdcBkdvdU4JqrkMeoLpCrBfk+6LzkI6c9ohEDXesALCGxeQnaXUx
         qConVcSwEQ5B1i8QbXGKRSiJ/EzuMxsKQTLQjY7seA0gLytojNaoCyNHLsav8WSik80X
         n+QQVjfR9jwJUb6Wh0n1YkVsRpT5purNT0Ne/7+hj+7/aivn9nYGz7iIscDw5T3HLuF3
         NV9hPY93aqKWAWGyNQtCndQU7CewpdzDOgEA4i9b96EmGELwcogGmEbwEQ6YmdoIZX9W
         RXeg==
X-Gm-Message-State: AOPr4FWrgOyh45EYo0ylxegJPRox/ds83VxB63y29Vh6LWkMR9Oeaw41orHjqAsTr7bWwQ==
X-Received: by 10.194.122.199 with SMTP id lu7mr16120867wjb.40.1461844683095;
        Thu, 28 Apr 2016 04:58:03 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id xt9sm9319278wjb.17.2016.04.28.04.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 04:58:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.487.gf8c3767.dirty
In-Reply-To: <20160428115748.37177-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292868>

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
2.8.1.487.gf8c3767.dirty
