From: David Turner <dturner@twopensource.com>
Subject: [PATCH 11/24] resolve_ref_1(): eliminate local variable
Date: Thu,  7 Apr 2016 15:02:58 -0400
Message-ID: <1460055791-23313-12-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDj-0007MT-RL
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbcDGTDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:46 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35000 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbcDGTDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:33 -0400
Received: by mail-qg0-f54.google.com with SMTP id f105so47943913qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=qDPosh6z3wNmy3HFBnKUmprEM3X6sH1goaHUjI2rLuM=;
        b=xVZqfCAwMFTlfrvz3yfmrT73i9UKvRb6rt1xEkIckslK3UBg/QokNzdciZ/U6KxVYT
         DXQHRclmIm3eg+J7gALkT4XE96pEC5rHicpr+/DQuh4DxOEsvImTZ69T92g/gYElWxUb
         uMN4yw9sP7EfDZMQG3j18n5uisCu9jFuV+WOY7N7J14VHPCG7P4MUX5Y+4M3w0WKQZS2
         +nE84f4QMKHEOcz/4wm8j13MGDJi/tVRNfJmvb6jP/ovGi7M7nALiG1smotKoSEgjrsV
         bHvHck+2Ea3zvsn/PO+7phejxOyfsLZ7YjfBX+uILnHERUYMu2ZCTsFEwDCSdQzI9WU/
         3eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=qDPosh6z3wNmy3HFBnKUmprEM3X6sH1goaHUjI2rLuM=;
        b=Yf7xkbUEFX3z3BWdUktUg1S1/WFRYjHiz7n/OuXlj/6hVxmRgf3FDCJvaI8ianB28t
         3efW8/X0t6/DR4pGP2jTtHWtahvhsmmdO5KCseB7TlUpMNbW42B1og0lBptTXv29I2zJ
         zpAvQPLn04QLbRpqj6Icub4NZ74o82uXqpzZ2FB1OOxaaYRAOJi7E5AQCgCHpQJaWc3N
         BqiXc8ZXKpvWxHCjj+NlpcNQvcM9y/C88klpIMfs0GTUKib+j1JD9K6ce+RfJLoIaGyC
         o+dwpOWfcjPKgEp5gxPGcdFOTcxI2/szmFpo0G1IDwUxdX8udQiGFYwOx9gRoin++NA2
         v3cw==
X-Gm-Message-State: AD7BkJL1qgGgnGqajdJ8sftLwzxeDhT3W1EJo6S2uoUaVo2WYNW6cWaiy9h9I1VmAh+ZPg==
X-Received: by 10.140.253.197 with SMTP id y188mr6106521qhc.67.1460055812572;
        Thu, 07 Apr 2016 12:03:32 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290962>

From: Michael Haggerty <mhagger@alum.mit.edu>

In place of `buf`, use `refname`, which is anyway a better description
of what is being pointed at.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 067ce1c..69ec903 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1426,7 +1426,6 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		const char *path;
 		struct stat st;
-		char *buf;
 		int fd;
 
 		strbuf_reset(sb_path);
@@ -1532,21 +1531,21 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 		*flags |= REF_ISSYMREF;
-		buf = sb_contents->buf + 4;
-		while (isspace(*buf))
-			buf++;
+		refname = sb_contents->buf + 4;
+		while (isspace(*refname))
+			refname++;
 		strbuf_reset(sb_refname);
-		strbuf_addstr(sb_refname, buf);
+		strbuf_addstr(sb_refname, refname);
 		refname = sb_refname->buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
 		}
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			*flags |= REF_ISBROKEN;
 
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(buf)) {
+			    !refname_is_safe(refname)) {
 				errno = EINVAL;
 				return NULL;
 			}
-- 
2.4.2.767.g62658d5-twtrsrc
