From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Fri,  7 Aug 2015 21:30:28 +0100
Message-ID: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
Cc: Adam Dinwoodie <adam@dinwoodie.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 22:31:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNoI7-0006yT-Pz
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 22:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946089AbbHGUay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 16:30:54 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34177 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbbHGUax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 16:30:53 -0400
Received: by wicne3 with SMTP id ne3so72795762wic.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uz4Hqt98Y9r1THkmeKoleDR7iYfUPzBGHTGFdpvR3Bk=;
        b=tWPvxdMfaf4WZ4T1TOYtTq04EJR99fGs44jLB7dY7BFZVG5cLROHpGX9QLvm+ceKgd
         gnN1tWW14gOnniJKx4HwXHv69S0oebe8MCmRtHcCCG0bNohsFSarZhAkkI3bTlkxis5W
         tQYcGxeTiCacWffKSqgHyNAC7AXU7qpHFJ5B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uz4Hqt98Y9r1THkmeKoleDR7iYfUPzBGHTGFdpvR3Bk=;
        b=H5IS4cAXVRmy19ph5yTVhZZi6W53OwWypN3iquJ8Fg1OVM+gsUIVs1I9Grc5SeL91v
         Yv8CHVziQL/Ymn3ebnXbGGLqr7LL/55xa9rfVge/TFW3amQNWUbQfms/EUGKlHx+MZCA
         /oKHOkDDw7JTzt9LZjWOaItm+XKHSL7lTBaFv9euQyQyNhEbaKn0FqQLXwxVI4ur+YvL
         co78ukjhmPDhSZZFBtxp4hBgAjeFiqcHzuH4qOk17iJX9IB4BSQkER0ss/+U9L7LJOg6
         GjHQO0jl2Do/sYChAfRNprPp37L48DqIZ3HAK2jk5qUr+emRhe6+6X5hpKmjmdGg8n2m
         8aIg==
X-Gm-Message-State: ALoCoQl4Bn9wtZCvJl7TqzJrHoRO2MbN/L98dCTrcznimdsPHIg8YlZXqhIqJXpaQ9EP1fcGoLlE
X-Received: by 10.194.79.225 with SMTP id m1mr18776194wjx.8.1438979452185;
        Fri, 07 Aug 2015 13:30:52 -0700 (PDT)
Received: from localhost.localdomain ([95.147.88.49])
        by smtp.gmail.com with ESMTPSA id s1sm511305wix.13.2015.08.07.13.30.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Aug 2015 13:30:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275485>

When generating build options for Cygwin, enable
OBJECT_CREATION_USES_RENAMES.  This is necessary to use Git on Windows
shared directories, and is already enabled for the MinGW and plain
Windows builds.

This problem was reported on the Cygwin mailing list at
https://cygwin.com/ml/cygwin/2015-08/msg00102.html (amongst others) and
is being applied as a manual patch to the Cygwin builds until the patch
is taken here.

Reported-by: Peter Rosin <peda@lysator.liu.se>
Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 943c439..be5cbec 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -187,6 +187,7 @@ ifeq ($(uname_O),Cygwin)
 	X = .exe
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
+	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-- 
2.4.5
