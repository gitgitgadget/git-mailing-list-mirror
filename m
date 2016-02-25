From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] run-command: fix an 'different modifiers' sparse warning
Date: Thu, 25 Feb 2016 19:35:07 +0000
Message-ID: <56CF576B.4020401@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:35:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1h4-0001iu-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933656AbcBYTfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:35:18 -0500
Received: from avasout04.plus.net ([212.159.14.19]:49741 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933377AbcBYTfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:35:17 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id NjbC1s00A4mu3xa01jbDXc; Thu, 25 Feb 2016 19:35:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=cHrC_p4BxEfK6BwOxesA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287424>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jk/epipe-in-async' branch, could you
please squash this into the relevant patch. (ie. "write_or_die:
handle EPIPE in async threads", 24-02-2016).

Thanks!

ATB,
Ramsay Jones

 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index cd861bc..5dec18b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -625,7 +625,7 @@ int in_async(void)
 	return !pthread_equal(main_thread, pthread_self());
 }
 
-void async_exit(int code)
+void NORETURN async_exit(int code)
 {
 	pthread_exit((void *)(intptr_t)code);
 }
@@ -675,7 +675,7 @@ int in_async(void)
 	return process_is_async;
 }
 
-int async_exit(int code)
+int NORETURN async_exit(int code)
 {
 	exit(code);
 }
-- 
2.7.0
