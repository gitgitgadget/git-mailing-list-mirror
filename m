From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 13/31] Check that "guilt header '.*'" fails.
Date: Fri, 16 May 2014 16:46:00 +0200
Message-ID: <1400251578-17221-14-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:52:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJUr-0001E3-If
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367AbaEPOwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:52:25 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44379 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154AbaEPOwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:52:25 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2032417lbi.29
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZJkqZEmaVLp0d/gegupPJ+/klqumM1eJr/BlC36vKg=;
        b=drgtu1DFma9UPW3lsoK7ZjrD8T0u42gaVOXR5XSayv9hc+2X9TQi1C+v9pro7Rai5D
         +foQnNzr2ExsFsYeqKyWqVvashd4O8bvEGZYSoiDbVrBYVE0lBf9p4OmDQq4c9Zq1cmd
         bZ5uirmHf4U7gJhcqxmIgjsYj/lkP7weVzVQOUvBvLClfB/9b6+FBwz2DTEJSnFMG4SU
         BbAtvfGtATkUvazE1kGfzolsYiCgQc8zi9uBqfvqpWAXNp0mrFE20EF93T3CWawwFVOG
         Y6BqrBfUPikCRNjTbb6bfyZa+OP0uUuuZ/oZBG120CwGQEsaVq9GZC8by6G3+HjQw+4Y
         VTPw==
X-Gm-Message-State: ALoCoQkyNieIBaYGmVbDVcQt9C3sjc6TIU8hn8txuUYXqvNasGdmOf8qVpHf3I0TfafH8+GfNPbg
X-Received: by 10.152.170.169 with SMTP id an9mr12525864lac.14.1400251943438;
        Fri, 16 May 2014 07:52:23 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.52.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:52:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249321>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/t-028.out | 7 +++++++
 regression/t-028.sh  | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/regression/t-028.out b/regression/t-028.out
index 1564c09..ea72a3a 100644
--- a/regression/t-028.out
+++ b/regression/t-028.out
@@ -49,3 +49,10 @@ Signed-off-by: Commiter Name <commiter@email>
 
 % guilt header non-existant
 Patch non-existant is not in the series
+% guilt header .*
+.* does not uniquely identify a patch. Did you mean any of these?
+  modify
+  add
+  remove
+  mode
+  patch-with-some-desc
diff --git a/regression/t-028.sh b/regression/t-028.sh
index 88e9adb..2ce0378 100755
--- a/regression/t-028.sh
+++ b/regression/t-028.sh
@@ -31,4 +31,8 @@ done
 
 shouldfail guilt header non-existant
 
+# This is an evil variant of a non-existant patch.  However, this
+# patch name is a regexp that just happens to match an existing patch.
+shouldfail guilt header '.*'
+
 # FIXME: how do we check that -e works?
-- 
1.8.3.1
