From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/12] refs.c: pass NULL as *flags to read_ref_full
Date: Wed, 16 Jul 2014 15:23:05 -0700
Message-ID: <1405549392-27306-6-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:23:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xbn-0004EI-EY
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbaGPWXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:24 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:41793 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbaGPWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:17 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so174289igi.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/DnFqQX9EXhVhZn8LWNryF2YsML3z4a2lxhq3fZmCU=;
        b=NilLlOAgLoXpR42WV7UOcDYaHHhxtqEFoEclTK21e/PU4fnhF3THnaRYCklr0XOuOq
         6ihszZz5MpbPOKA09Gq55Ax/8FrWdYkyvamVJaMxEmKX8pFhZaLervV4xT7GQrSjDIaB
         QzhIsv4G1U/OPdOLwTfcp/GMiPmaKjjXmlwhg1SYO2LzqN/9r1OO877iEMWCnK2xsnMD
         aRx9QjMUejYM5yF9WqxWkpZIHWglzZaDYNTdjbTSlmk6YsK69fgubr1pX3nkA3qWhUQN
         0OeF6/SpAP+VEziqKQT4qkh7Y4KHzVxqBRAzRIF+EAnNrzgub4fOF+p5DhHGgcrlKDym
         85GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B/DnFqQX9EXhVhZn8LWNryF2YsML3z4a2lxhq3fZmCU=;
        b=KPUFHCqqpoIFRosCUpQ6kpf5nEEMmg9DwfrwpQW1Yb1x4BQ+4ivRgqmdYCjNNAPwEm
         YmOBPtWcTYULj9LnTpCiF/YHsw8H1q4EK/F4SllyZpWhmLAhhZH9lwqKDKLv+NQtzGFB
         /cdp1h/C1tEydeKqDwrVMiD+Fi+liuXi0YumnRlhnRy5GTNc2owbTuREav2hwl7Vb3My
         ZxQGlxEzBf25CqogupVYH6IpICVhoWN9DF4AXXPJ05EfKnXzr36z5zI0vDlYjlnfwLB6
         jsAS4TPkaXx6nt2bMoqZ2NqXcTKqrdAGtBahbvX0LwLxYKafbtPIUC1mvktn0r/057oJ
         JCWQ==
X-Gm-Message-State: ALoCoQk/3KtJ9G9pxcQqLEBsgiQdSbAcNVnu3y2Jgt1FW7KtmFRkEZTFA8V2/3OZo6DglVUN+Y07
X-Received: by 10.182.68.17 with SMTP id r17mr11118040obt.26.1405549396111;
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si75573yhg.1.2014.07.16.15.23.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ED15331C04E;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8747FE0F40; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253705>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 7d65253..0df6894 100644
--- a/refs.c
+++ b/refs.c
@@ -2666,7 +2666,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.1.527.gc6b782e
