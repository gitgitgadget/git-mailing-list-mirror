From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 9/9] remote-bzr: strip extra newline
Date: Thu, 25 Apr 2013 06:20:49 -0500
Message-ID: <1366888849-19607-10-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:23:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKGZ-0004yr-32
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159Ab3DYLXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:23:02 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:33957 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067Ab3DYLXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:23:00 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so2714094oah.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9hVLAqURTKRM0CiT1p7Y9Wpwv/gJSh6mciNLDlpv47o=;
        b=nMj+dsba28n9tzdJOg7UiC8qwHNzr2m/1JlqpvsaZsflv/cZaVm2bpMHQlgUQc82mV
         Y56JzA991azXVMPcFLcmv6kOboCZUFuXmKdB7c54JaFDQE+jcG3D6HPJNTXThvuFN3LW
         wyPyBuRYLmZt+qVgjae/XIIuPV59gUAmVp/WiTZoCOUkxAD4aC6HP2UYdtUXS3tt/rTA
         rHK+uOTVgQFBm0U3x5hFN9VP6jXRdPSSEASwlBxe72ZI88ANkuj7ASlBdW5MVPEk+RJW
         VCTxzNgRv7700IMVTLWoByx5A4E6lVhp0sGOaIJOvFnHM4NgYqajO/CR6iaMmn4Thlrc
         Ky7A==
X-Received: by 10.60.146.227 with SMTP id tf3mr7416329oeb.50.1366888980121;
        Thu, 25 Apr 2013 04:23:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm3015695oby.5.2013.04.25.04.22.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222377>

It's added by fast-export, the user didn't type it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 19668a9..8c316fe 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -549,6 +549,10 @@ def parse_commit(parser):
         parents.append(parser.get_mark())
         parser.next()
 
+    # fast-export adds an extra newline
+    if data[-1] == '\n':
+        data = data[:-1]
+
     files = {}
 
     for line in parser:
-- 
1.8.2.1
