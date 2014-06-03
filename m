From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 34/41] refs.c: pass NULL as *flags to read_ref_full
Date: Tue,  3 Jun 2014 14:37:52 -0700
Message-ID: <1401831479-3388-35-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwQZ-00069u-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbaFCVjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:22 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:63390 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934293AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ig0-f202.google.com with SMTP id h18so28981igc.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X6dNAlt7DBcuDgsAvpgikyWx4ukNIB2EFWSC8zaSZnk=;
        b=fngeYDb8j3VbOuAya+FnFtJJi/z1csjpNvtwvZarti6IkGCTFnJkEJtcgw7ApTm7uv
         kfnOVdtcKqlKlmxLRdVTHnROSPdNmFIlsACLyiZ/Zvlw3+xPcYbGF7d6RuggOQYwX/Fl
         P/FSBzv+vHztuY/OVBPUxsjUT6ppkP2W2mLki06OHgv18o9dtA4RWmL1W4zHseZ78zNl
         MP9nzaofSbJtV3odIzNTRD00ih3hBjdm5vMhkoCSGe8pkGX4bagt50dEUgdAnbHqNlV1
         TzANlSMan6urGIYcKOHF2O8F6u1SrIpdhmy/l78iuTfCJ/8oupugg+8tbTgBfx76/y6V
         6rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X6dNAlt7DBcuDgsAvpgikyWx4ukNIB2EFWSC8zaSZnk=;
        b=LwDhWSvEiVrd7V/NgUWH83Gk9UGNHM9VQwK9ht809ptkniocBy8LOpMXmECOESglYm
         hZAvEF2TLEfIRa5MOhOoXtGPwVcEswrX2nQdJmsJieINyondRUXDe93JyiIVjOIoaYG4
         FimTpb6H+RizhJAlpEEp0YMqcvBYAOuy2no9hmJn5lCEpQsGxI4oJad6lJ/0/ltl5rhb
         tZStLR8y4U1Gdu0zoAwaReysX8ckHhO2KVrYIzp1TLg8i/Geii0xYDXdNv7vRek+HQQz
         DjNL3PekwR9PYQEyW4j4fy6pc1N+n6U+GX+/SAcFrJ+OrCBtAbDF1acjjhHsuJYv2Ojs
         9bNA==
X-Gm-Message-State: ALoCoQl6XaachA2IEDy5yqb2w8YXlZDnYDT14SCtMY1CCsIJVsjstO581avZmUaysbaNk9qYTydL
X-Received: by 10.50.239.196 with SMTP id vu4mr10837466igc.8.1401831488350;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si30042yhb.3.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 324FC5A43C6;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0EE7BE0887; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250659>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 88d9351..8848dbf 100644
--- a/refs.c
+++ b/refs.c
@@ -2657,7 +2657,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.567.g64a7adf
