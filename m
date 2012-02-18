From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH 0/1] Make libintl in libc detection more robust
Date: Sat, 18 Feb 2012 14:38:03 -0500
Message-ID: <1329593884-9999-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 20:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryq9D-0001r4-Tr
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 20:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab2BRTjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 14:39:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55393 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab2BRTjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 14:39:21 -0500
Received: by qadc10 with SMTP id c10so1955479qad.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 11:39:20 -0800 (PST)
Received-SPF: pass (google.com: domain of jszakmeister@gmail.com designates 10.229.102.88 as permitted sender) client-ip=10.229.102.88;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jszakmeister@gmail.com designates 10.229.102.88 as permitted sender) smtp.mail=jszakmeister@gmail.com; dkim=pass header.i=jszakmeister@gmail.com
Received: from mr.google.com ([10.229.102.88])
        by 10.229.102.88 with SMTP id f24mr9618898qco.117.1329593960956 (num_hops = 1);
        Sat, 18 Feb 2012 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=jYhaqI9YfmIOWhB3q11ubavssyTrG/Kv23rPrutD0cg=;
        b=nmMXUnr4MD13cy7T/8ZoGoAXqG7JupfNAX07Ql3HDF8rqqLx1yxUsqUas5M2pLExQo
         Wfs3dkAQWnXOszXsxFp5NbZg3aPpvzne6vWMVuTBRlWho3yx0ZBbhL4DEcoYbbGl6ZJh
         XhJ6BYIE5k32Td9ehiJkZmkztz1y9j3clfPCA=
Received: by 10.229.102.88 with SMTP id f24mr8176885qco.117.1329593960866;
        Sat, 18 Feb 2012 11:39:20 -0800 (PST)
Received: from localhost.localdomain (pool-71-179-190-236.bltmmd.fios.verizon.net. [71.179.190.236])
        by mx.google.com with ESMTPS id bf2sm8430903qab.20.2012.02.18.11.39.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 11:39:20 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191011>

When building the latest release, I noticed that pthreads support
was disabled.  It turns out that the libintl in libc support is
adding "-lintl" to LIBS, even though I don't have that library on my
Mac.  This patch fixes the issue by moving the check for libintl.h
closer to the checks for libintl in libc, and only adding "-lintl"
when NO_GETTEXT is empty.

This is my first time submitting a patch to git.  I hope I've done
things correctly!

John Szakmeister (1):
  Don't append -lintl when there is no gettext support

 configure.ac |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

-- 
1.7.9.1
