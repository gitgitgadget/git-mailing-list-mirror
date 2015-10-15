From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 03/26] refs-be-files.c: rename refs to refs-be-files
Date: Thu, 15 Oct 2015 15:46:27 -0400
Message-ID: <1444938410-2345-4-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUf-0006eM-B2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbbJOTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:12 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35840 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbJOTrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:08 -0400
Received: by qgx61 with SMTP id 61so80917740qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKeoiUVFZcvuux8ACLtwndv2ZuDSW9mLRa9RF8ZUH6k=;
        b=EFMfme7+r8kYDcOxKYK7wkZ9PBcIgrdTobqu/qbNn8cm1Zcbz+Kb1sFMhndosNDd9k
         esi9UCBmKmLjd7nwlfw++/4ZW+1otEdTAgw375X4rLX++Y1flCY0jMXbgyBuIe80QjpL
         Z/aYrHd9LpTuu36TeEfo/tlt/TNTaFT7BVdv3VIVBXyz95GDl2+/zor5x5oFrrk6HsNz
         Q06zDRE6HI1GxldnR9YltRct8A86p4nm8kTmaVFyRu3QtlXm8A2DfS1HcvVBkoepwwZX
         0gbMPA5d43AhsDtvyIn7q/uC1iVK4WCblsDibW+zoCih6ltGGQOE34SHRMBXFuSwlOz+
         39xQ==
X-Gm-Message-State: ALoCoQm/kRCxVzGTf4cXLZWyTimGiJolO48FL1r2gxtSX4FOrrWRqc01YmeSXdu+aOFRSsuRW7R9
X-Received: by 10.140.239.82 with SMTP id k79mr15031525qhc.50.1444938428138;
        Thu, 15 Oct 2015 12:47:08 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279681>

From: Ronnie Sahlberg <sahlberg@google.com>

Rename refs.c to refs-be-files.c to indicate that this file now
holds the implementation for the files based refs backend.
A smaller portion of the code in this file is backend agnostic and will
be moved to a a new refs.c file that will hold all the common refs code
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
2.4.2.644.g97b850b-twtrsrc
