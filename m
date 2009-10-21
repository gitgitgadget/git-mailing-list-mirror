From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 4/8] imap-send: fix compilation-error on Windows
Date: Wed, 21 Oct 2009 19:04:47 +0200
Message-ID: <1256144691-2908-5-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-2-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-3-git-send-email-kusmabite@gmail.com>
 <1256144691-2908-4-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 19:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0edH-0007uR-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbZJURFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbZJURFY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:05:24 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:63374 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZJURFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:05:22 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so6261965ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kGuThS30/QVLJ/lmnp+/1u2FSlGkpv6c7oL8weZ7lfA=;
        b=M1X1SC+UWE0TupI0q97vLbYsco8HM1gwslg5f5+KNfKYxBoHCtLi1pDPVbhT4nRmK4
         7qyB9OFkkgIgS2ALfXnM973l8A0u/XC+KM/q/eJHE8LfmrK4GNfabDzPaDl+2tRz11Ev
         Qt6ErvdHWLvFAE1voAe2Bpsgn2glx7Jk/eucE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SZHShhAbubBGwKEOjMD1xfu6Y2NXdh+akl9yyejJ4o14MVLr/HAsFWAJJaX0HtdjF7
         5wR/J4Iq/61dUzLDMMCAaSfhqdm4zu7Yx/UDkxacdUzUyPlQJCRlPg8nhHYRAq1+rYTZ
         OnFyXXlws1WfjMJ2rSG4cnfZ3S96Iuu4Pj60M=
Received: by 10.211.146.5 with SMTP id y5mr9203830ebn.41.1256144726436;
        Wed, 21 Oct 2009 10:05:26 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 10sm1058969eyz.3.2009.10.21.10.05.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 10:05:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130938>

mmsystem.h (included from windows.h) defines DRV_OK to 1. To avoid
an error due to DRV_OK redefenition, this patch undefines the old
definition (i.e the one from mmsystem.h) before defining DRV_OK.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 72ed640..69e6142 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -94,6 +94,7 @@ struct msg_data {
 	unsigned int crlf:1;
 };
 
+#undef DRV_OK
 #define DRV_OK          0
 #define DRV_MSG_BAD     -1
 #define DRV_BOX_BAD     -2
-- 
1.6.4.msysgit.0
