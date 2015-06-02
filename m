From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] configure: add getdelim() check
Date: Tue,  2 Jun 2015 14:18:58 -0400
Message-ID: <1433269138-10890-3-git-send-email-sunshine@sunshineco.com>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 20:20:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzqnF-00063g-LV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbbFBSUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:20:00 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33850 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbbFBSTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:19:54 -0400
Received: by ieczm2 with SMTP id zm2so139593621iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zNgyFm6cYsSgotAHogG/46V4K/KTHEIwPXjgyBH+JG4=;
        b=qizk8gtUjiZCH6ZjmhMlUsnYGwxjnZoTvPj0q7b558dnF94fnGENa79dWO3uaymk+Z
         tznYrNH72sQRKz03/7W9lPlWvElsafyrOsd+PDemyL++UPCkPgBO4I0+fMCpk1DjtojE
         bGC6fLghn40MO0yV9AkYxUst12YdziIrqN9BckVC/wqdaV8v9MZp9e6CQw/cQ46cpEis
         FU5ycQ+daU9WpPXQz3EIJtLVLzgzACF4zd1Q/Rgn1kcHOaNz6shquuD0qsWL6pCB2Kub
         /OP/2TEBfqqdnhKy7FpUKbIeTcLW0mkwxt8jjnBKnxNfC4wQky76MQ2EhlUMVHHMA0s5
         yidQ==
X-Received: by 10.50.30.202 with SMTP id u10mr21937627igh.28.1433269194155;
        Tue, 02 Jun 2015 11:19:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id v14sm10451458igd.12.2015.06.02.11.19.53
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 11:19:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.674.gb037150
In-Reply-To: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270577>

As an optimization, strbuf will take advantage of getdelim() if
available, so add a configure check which defines HAVE_GETDELIM if
found.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Tested on:
* OS X 10.10.3 "Yosemite" with Xcode 6.3.2
* OS X 10.5.8 "Leopard" with Xcode 3.1
* Linux
* FreeBSD

 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index bbdde85..14012fa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1041,6 +1041,12 @@ GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=YesPlease])
 GIT_CONF_SUBST([NO_INITGROUPS])
 #
+# Define HAVE_GETDELIM if you have getdelim in the C library.
+GIT_CHECK_FUNC(getdelim,
+[HAVE_GETDELIM=YesPlease],
+[HAVE_GETDELIM=])
+GIT_CONF_SUBST([HAVE_GETDELIM])
+#
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
-- 
2.4.2.598.gb4379f4
