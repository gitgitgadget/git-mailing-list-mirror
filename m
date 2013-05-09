From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 3/3] Makefile: avoid deprecation warnings on OS X 10.8
Date: Thu,  9 May 2013 02:13:30 -0700
Message-ID: <1368090810-40596-3-git-send-email-davvid@gmail.com>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
 <1368090810-40596-2-git-send-email-davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 11:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMvB-0003x3-BC
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 11:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab3EIJNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 05:13:44 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:37444 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab3EIJNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 05:13:42 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1862209pbc.17
        for <git@vger.kernel.org>; Thu, 09 May 2013 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=b9Je7T/uVx5fqa6zUJGuxQKSxLO2RbUK860Uy6lONtA=;
        b=n1rPACgYiTzE72L5jUhwyiNfUxVbGBDjIcUvszO2KqP8gXQvtlpm+/b5KF3Pdfc+nA
         IYfCe/IihWaXgia/UYnh9YOu21MkL6B03Ly4ZlfMSUHkuNWR/PCpxSQya+/96lI53zH2
         4PWsxU+2n6xSvthiV3KYTM6WtZDmM4s1fjoZtP4SoPxIFsL1RjeDMjyK69Pn3IAT98Gb
         83+CYZAAolTtc/zrlVgSfwu8H3HVKYwd25Dv5hCh4XzqE5h3d/YUCt7oGbdyh+hOHFxR
         hA7Bm5epCpq5KS3CQnhNkqQLusihz0VdMUQ8cpYiYvWCGKug7PvQNGvlDcGaeisrZrnt
         DJ7Q==
X-Received: by 10.66.220.104 with SMTP id pv8mr12073726pac.72.1368090822213;
        Thu, 09 May 2013 02:13:42 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id wi6sm2323180pbc.22.2013.05.09.02.13.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 02:13:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.38.gd586103
In-Reply-To: <1368090810-40596-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223722>

Mac OS X Mountain Lion prints warnings when building git:

	warning: 'SHA1_Init' is deprecated
	(declared at /usr/include/openssl/sha.h:121)

Silence the warnings by disabling OpenSSH in favor of BLK_SHA1.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I know I can create config.mak, but do we prefer to have the default
settings be warning-free?  I do not see any other platforms that tweak
NO_OPENSSL themselves, hence "RFC".  Is there a better way to do this?
Are there any Darwin/PPC users that would be harmed by this patch?

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 0f931a2..3bb9ac2 100644
--- a/Makefile
+++ b/Makefile
@@ -1055,6 +1055,7 @@ ifeq ($(uname_S),Darwin)
 		endif
 	endif
 	PTHREAD_LIBS =
+	NO_OPENSSL = YesPlease
 endif
 
 ifndef CC_LD_DYNPATH
-- 
1.8.3.rc1.38.g0f1704c
