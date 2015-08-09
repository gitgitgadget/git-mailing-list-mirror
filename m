From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Sun,  9 Aug 2015 19:41:34 +0530
Message-ID: <1439129506-9989-2-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKZ-0006cq-Ms
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbbHIOME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:04 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35470 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbbHIOLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:11:47 -0400
Received: by pdrg1 with SMTP id g1so61909115pdr.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXK3cHURpZoO3xpGaG47z3EPB65xriddH/r6EObIJIM=;
        b=NXpGJ2Z/GHYqFmeCGW6eOM7xedRGwspt1gEsp6fpk8TCbM3mHNbKpivJWnvKQnhOAi
         EnoW+1ceDcX0h/nUI+7IfzRJvRUXtDAZ/vC+XLRVASDLjLI1daGxp9OyHJJG9K/SqE2d
         FrqasqPNDWhPk+/AyevSJD7FPQufJIOsyEbgNI7c82eV1G/eQegPip+cdkyz/vNCbImL
         d1FmwZOu/JHuKRPWz18jAf+DYKSSLqVZZ2fUKtvICYe7//Odhd3xvAZTWtJNibvMXT8+
         MGhcY+tfCKkuSlYW9OWE0GQCEE67jQmJg92Vx7wyLpSMLehyGvWEwIuykPolyZCF6Gu5
         8n1w==
X-Received: by 10.70.56.66 with SMTP id y2mr34755244pdp.168.1439129506876;
        Sun, 09 Aug 2015 07:11:46 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:46 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275536>

Since atom_value is only required for the internal working of
ref-filter it doesn't belong in the public header.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 5 +++++
 ref-filter.h | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 46963a5..07949f4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,11 @@ static struct {
 	{ "color" },
 };
 
+struct atom_value{
+	const char *s;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+};
+
 /*
  * An atom is a valid field atom listed above, possibly prefixed with
  * a "*" to denote deref_tag().
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..45026d0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,10 +16,7 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
+struct atom_value;
 
 struct ref_sorting {
 	struct ref_sorting *next;
-- 
2.5.0
