From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 17:44:44 +0200
Message-ID: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 17:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4D75-0000OF-GM
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 17:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab2HVPoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 11:44:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56275 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2HVPow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 11:44:52 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Me5Bm-1TIxTQ3C9O-00PKWg; Wed, 22 Aug 2012 17:44:51 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2AfPtWBGjedhMWTDmoJw8BPIswiw==
Content-Language: de
X-Provags-ID: V02:K0:MsETx9+A8JVrW86hfz49OtgTXKZZQ94qndIw1mvQhP9
 H7cDE+G7X12G1Qa6F3NDsHHRPzGVjGY5wVcGxySG8IWF3nLm5X
 yOLOiXan6CGLm/WBt8/Iv+GJ9VC2xTlkYrZm55VOJENVFx+Rk7
 7RyIZDSACtTlRBc1nHZ3vErqMf5zL0q77plk1EXF+b5W+ASngb
 qOYQp5DsGuq/jhpTVXApvIppO77JsdqE7BjIDkSYYGXUHAWJFG
 h3siDpgnvzZIegB4yOiBDO9+vGCmRK07iyCMpco9L4fks5058L
 f2Ooiz55shJ7mfrUTejoBkWbuVqT/fgb8EqnbBI4ihRPVP2RJZ
 Znl+FrrdKG7BNJ/tQ9hSDRlQy0Osc826i88bI49C24CXzVw9kL
 Bu5vZC8RHiSMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204022>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index b61ac85..18bc6bf 100644
--- a/http.c
+++ b/http.c
@@ -806,10 +806,12 @@ static int http_request(const char *url, void *result,
int target, int options)
                                ret = HTTP_REAUTH;
                        }
                } else {
+#if LIBCURL_VERSION_NUM >= 0x070c00
                        if (!curl_errorstr[0])
                                strlcpy(curl_errorstr,
 
curl_easy_strerror(results.curl_result),
                                        sizeof(curl_errorstr));
+#endif
                        ret = HTTP_ERROR;
                }
        } else {
--
1.7.12

Bye, Jojo
