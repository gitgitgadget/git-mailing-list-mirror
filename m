From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v2 2/2] CodingGuidelines: Add note forbidding use of 'which' in shell scripts
Date: Fri, 24 Feb 2012 18:12:58 -0500
Message-ID: <1330125178-9194-2-git-send-email-tim.henigan@gmail.com>
References: <1330125178-9194-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 20:43:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26UI-00014v-7C
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026Ab2B0Tnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:43:49 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50913 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab2B0Tns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:43:48 -0500
Received: by vbbff1 with SMTP id ff1so1184417vbb.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 11:43:47 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.220.116.10 as permitted sender) client-ip=10.220.116.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.220.116.10 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.220.116.10])
        by 10.220.116.10 with SMTP id k10mr9780107vcq.25.1330371827470 (num_hops = 1);
        Mon, 27 Feb 2012 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=s3yaan1mv5VJOGRKoWnzSIgcH4L3e/SFdCewZuUPz/I=;
        b=m23tyrmJPt8oTXkEUC1dgkRTTqWYJdu0OrpQKnUj6QYp4W/NkOEyb850qX6Xg7qJ/7
         o17inS3uPNTEJZQJsv5MZ415fInIcQ3qPspi2lGH909ARoctrP3tUIc0gkDX49KLF0kg
         M4INfXrXcDTeM6uLGQQg0yzlp+oXXFQTh1HD4=
Received: by 10.220.116.10 with SMTP id k10mr7905811vcq.25.1330371827329;
        Mon, 27 Feb 2012 11:43:47 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id gz4sm12030839vdb.19.2012.02.27.11.43.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 11:43:46 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1330125178-9194-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191660>

During the code review of a recent patch, it was noted that shell scripts
must not use 'which'.  The output of the command is not machine parseable
and its exit code is not reliable across platforms.

It is better to use 'type' to accomplish this task.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Updated to the documentation pattern recommended by Junio Hamano:
"If you want to do Z, use X not Y, because Y is broken ..."

I grepped through the code and found the 'type <command' is indeed used
in place of 'which' to test for the presence of commands on $PATH.


 Documentation/CodingGuidelines |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 5a190b9..816c5ad 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -49,6 +49,11 @@ For shell scripts specifically (not exhaustive):
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
 
+ - If you want to find out if a command is available on the user's
+   $PATH, you should use 'type <command>', instead of 'which'.
+   The output of 'which' is not machine parseable and its exit code
+   is not reliable across platforms.
+
  - We use POSIX compliant parameter substitutions and avoid bashisms;
    namely:
 
-- 
1.7.9.1
