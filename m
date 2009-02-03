From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http-push: wrap signature of get_remote_object_url
Date: Tue, 03 Feb 2009 20:39:00 +0800
Message-ID: <49883AE4.90709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 13:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUKaI-0001iV-7v
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 13:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbZBCMjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 07:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbZBCMjc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 07:39:32 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:60233 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZBCMjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 07:39:31 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1041914tic.23
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=E09o2X6YMlSrGiduJ887V5n1azz0iOtSn8Gi66h3GKM=;
        b=TdYhYiah8Bg4k16jbqgoQYdZm5NaUUeA8EmDgzy7FWIItiYm0X2AtZq81AsATzMyNW
         qkN5zovyS8K3Mvv3cc6UFTR9Bu1dXGPug9IT9BQbheym1Rxp0BEcUi/CQqWBs83sY5fo
         eYiWDV9jhYspEhqigomGgLYghi/Fz44AwhdJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=wkmQcXtRsxmXJzuQ1Oozjm3LWnjjKGl/xIfiBaLpB4ysFH2oiiivhwbK8xz5toSPh4
         GQI/3XLo9peawXpgzraXmFNuInCvi9CMbM/E0CWBbSvm4vzglaGC2gVjKMzfnKpaKoe7
         725qbG/Zx+39w3+rPOqYBHrxonndlVCjFMtsI=
Received: by 10.110.17.14 with SMTP id 14mr8270562tiq.19.1233664767523;
        Tue, 03 Feb 2009 04:39:27 -0800 (PST)
Received: from ?116.87.149.30? ([116.87.149.30])
        by mx.google.com with ESMTPS id a4sm439632tib.27.2009.02.03.04.39.24
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 04:39:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108181>

The signature of get_remote_object_url stands at 96 characters (as
pointed out by Dscho); this patch wraps it so that it conforms to the
80 characters guideline.

---

This patch applies on top of Junio's patch "http-push.c:
get_remote_object_url() is only used under USE_CURL_MULTI"

 http-push.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 3e75cf3..54c62d4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -232,7 +232,8 @@ static void process_response(void *callback_data)

 #ifdef USE_CURL_MULTI

-static char *get_remote_object_url(const char *url, const char *hex, int only_two_digit_prefix)
+static char *get_remote_object_url(const char *url, const char *hex,
+				   int only_two_digit_prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	append_remote_object_url(&buf, url, hex, only_two_digit_prefix);
-- 
1.6.1.2.278.g9a9e.dirty
