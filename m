From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 03/26] refs-be-files.c: rename refs to refs-be-files
Date: Tue, 27 Oct 2015 22:14:04 -0400
Message-ID: <1445998467-11511-4-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGM-0000pm-L6
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbbJ1COr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:47 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37653 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbbJ1COo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:44 -0400
Received: by igbhv6 with SMTP id hv6so92964229igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QeTk9s/Zuol8J72UHA1cDyrunha4owTc6fHgQ0GYx8s=;
        b=McLO4xnf6XumR5uKyLNYmZxKdVU+yLYnnKCNCgyX9w41C+nP+gCIUkxKDp8jW/pC9C
         56CvBo4MzEiXZz3IaD1Oi9bCYekCNiZ5IQMp3/NgY2L5tqYDMhk7Y4ly1QzniFL4HAhh
         4NF+8zpcaSyr4n8ohSjQI80r845jSY0UYYbQfoolh4SxXtVKoN8P98exX6slS+urvtuV
         QliUaH3f5FnX+eYV19jMN8qoNyrKiguTmBwLwnwHJ5eKMzu1u+lvVR6+vjl0m/dS+2z9
         cRoRwwUnTlR+wRbh+PmK8aONfICZSFvzzKRWiM1GAbbOTNPzgsK4/QlNrVkoSdCvd7PY
         UbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QeTk9s/Zuol8J72UHA1cDyrunha4owTc6fHgQ0GYx8s=;
        b=l2QFda59G1Pxh65CKw1z13eJyUn02ASF9kYFmcdyb+nEXfqjrIJEdxK//asj58F0Nu
         nBOWJcUYF8axIASLqWPW1/RqpiCo49FQbZzhuja/8bvEWYDLQzenc9B2UoFLnfzqtVuu
         Dp3i7JFVe2F3UIBFYiBoEMDqVgKG8jzMUWYRZI4mSFT33KWoOO1CtUsNeX147X1eo6eb
         Oiq/YssyZk0BOWrrQn1FrCcpHpiuyoqX+DPqSDGDCzi4BVWYVPIG8FWn96ARoSsv+IU7
         L0TeiFrfcWKBCddfn2P2w0MzefIxamF+4QeRpY2AQDGiqcWe10dfr/kU3DHsZz91rZP7
         YTyA==
X-Gm-Message-State: ALoCoQkFkIVVVE5AomrfkoV0tm+4ypKLAgdMPjdrqau2s9vi+LvDI2ENTTZjLVGk+Os2ybWBFvL9
X-Received: by 10.50.142.8 with SMTP id rs8mr336969igb.77.1445998484259;
        Tue, 27 Oct 2015 19:14:44 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280328>

From: Ronnie Sahlberg <sahlberg@google.com>

Rename refs.c to refs-be-files.c to indicate that this file now
holds the implementation for the files based refs backend.
A smaller portion of the code in this file is backend agnostic and will
be moved to a new refs.c file that will hold all the common refs code
that is shared across all backends.

A second reason for first moving all the code to the new file and then
move the backend agnostic code back to refs.c instead of the other way
around is because the code that will eventually remain in this new
refs-be-files.c file is so entangled that it would then be very
difficult to break the split up into small independent patches/chunks.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                  | 2 +-
 refs.c => refs-be-files.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename refs.c => refs-be-files.c (100%)

diff --git a/Makefile b/Makefile
index 0d9f5dd..173b9d4 100644
--- a/Makefile
+++ b/Makefile
@@ -762,7 +762,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
+LIB_OBJS += refs-be-files.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
diff --git a/refs.c b/refs-be-files.c
similarity index 100%
rename from refs.c
rename to refs-be-files.c
-- 
2.4.2.658.g6d8523e-twtrsrc
