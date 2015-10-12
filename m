From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 03/44] refs-be-files.c: rename refs to refs-be-files
Date: Mon, 12 Oct 2015 17:51:23 -0400
Message-ID: <1444686725-27660-4-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll37-0006DP-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbbJLVwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:21 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35296 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbJLVwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:17 -0400
Received: by qgt47 with SMTP id 47so129527592qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B7IAkExvSvfoKSrGL+3ErbpYyyFB7IFSquPZsCqStLI=;
        b=DCbmtDnsv3s1YKOHvJ8/eUR6d7E/Fb4l39iWnc/JJrwJkXR85+xV+dAon//V7IYggo
         7cMbCxxokw+XFBFU0jxNYGJtBEqdhWAlA9mTmoqbL0a1uWmtqQdb5jfUFyYFEQO3Ua3n
         f7F2DFv7EDcnIX2h8gdwPBozrYY29J8P2e3oCrqGqq2D2iZe1YoFm0i0XxRMBtHR5gQc
         dPF6F8k0WDwbw3QshJ6cAOPPfUWljR4Elilt1eIMJ2y5yCVMbDm0TyL3d9iF4v/cuFXk
         DqGYL3ZM8UV8RMFU0yPRmoNeKc9BNMs1ov8O+R/ARyhz5HlduQEczD07RO2LTvAKGeub
         dh1A==
X-Gm-Message-State: ALoCoQkey+4+gOjz3q7EohF2oZ3j8E1HFbYd38wjtFDSCL3oXg2R90S+HK1TBM/kGGpY1LUHigVD
X-Received: by 10.140.99.49 with SMTP id p46mr33844298qge.76.1444686736802;
        Mon, 12 Oct 2015 14:52:16 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279461>

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
---
 Makefile                  | 2 +-
 refs.c => refs-be-files.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename refs.c => refs-be-files.c (100%)

diff --git a/Makefile b/Makefile
index 46d0ca7..19036de 100644
--- a/Makefile
+++ b/Makefile
@@ -766,7 +766,7 @@ LIB_OBJS += quote.o
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
