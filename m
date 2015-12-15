From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 07/10] dir: free untracked cache when removing it
Date: Tue, 15 Dec 2015 17:28:24 +0100
Message-ID: <1450196907-17805-8-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTf-0004RO-1q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbbLOQ3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:18 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35674 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbbLOQ3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:13 -0500
Received: by mail-wm0-f47.google.com with SMTP id l126so1684403wml.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YK8PwEexQgt0uFtUXyhoh/DC/lbK2tWHpa9lW/m1WfE=;
        b=KWqgARRPThSq3O1cZ6Uw9HCMElifOBLUGRXbzpZHsiUabsuaXSvaRX1ttlpOTvkGPk
         ZVtJxZirQcmyUWntjpGztQ0MhUttMAWwctd35MyFcO7asGWhM+hhedpx3eqcp41ieLiq
         T35dtEUhVVpsbuDHzO801N7GNap4gJQt3Pdv/ecBwsLVwy3nVshd2UOg917kPyK2oOfe
         tMrI8GskdzI6YuC4v1LsQY5LEE3itlXZkgmi7JamnoKLv/EY+VO2iUc1vmBDLa5oVrnL
         ZHpJQtM+7eXFRBbI6AuOLmCw9KxHwKIuD/ElC88lGzVQu5bGvlxOCYbWoNuKknJbur60
         XtUg==
X-Received: by 10.194.172.2 with SMTP id ay2mr44718160wjc.137.1450196952637;
        Tue, 15 Dec 2015 08:29:12 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:11 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282487>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dir.c b/dir.c
index ffc0286..3b83cc0 100644
--- a/dir.c
+++ b/dir.c
@@ -1954,6 +1954,7 @@ void add_untracked_cache(void)
 
 void remove_untracked_cache(void)
 {
+	free_untracked_cache(the_index.untracked);
 	the_index.untracked = NULL;
 	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
-- 
2.6.3.479.g8eb29d4
