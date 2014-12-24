From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] refs: release strbuf after use in check_refname_component()
Date: Wed, 24 Dec 2014 01:18:45 +0100
Message-ID: <549A0665.6080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 01:19:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3ZfJ-00051c-RC
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 01:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbaLXAS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 19:18:56 -0500
Received: from mout.web.de ([212.227.15.3]:64398 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756647AbaLXASz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 19:18:55 -0500
Received: from [192.168.178.27] ([79.253.147.237]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0McneT-1YLW9d2ohV-00Huoc; Wed, 24 Dec 2014 01:18:52
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:mdqf1ml0KunjW3iqFMOrxitDmvN8+iqxVzqReUGmD3OJ8SD5SOn
 dHCeEGirWvtsA5T8UWX3QhNHnsh9clhtpr4O7mCqgx7aWBiYIXRCiVh8EtbZ7rSjbWNjG9p
 tl80rK7s/a16Gxx7/d1ISowpCMIvcGtNijlw5uWQAMhDfqU01fVav5VQZM251VX4EoomMAt
 xRBYPWZMsY6HUEs8SeQYw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261783>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 5fcacc6..ed3b2cb 100644
--- a/refs.c
+++ b/refs.c
@@ -2334,7 +2334,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			struct strbuf err = STRBUF_INIT;
 			unable_to_lock_message(ref_file, errno, &err);
 			error("%s", err.buf);
-			strbuf_reset(&err);
+			strbuf_release(&err);
 			goto error_return;
 		}
 	}
-- 
2.2.1
