From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 10/11] t5544: add a test case for the new protocol
Date: Tue, 26 May 2015 15:01:14 -0700
Message-ID: <1432677675-5118-11-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMv6-00025s-HK
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbEZWBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:45 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35358 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbbEZWBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:42 -0400
Received: by iesa3 with SMTP id a3so31590ies.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQSDit0yZejZpC3NRaMc/EkzBneWHSQI3oCTQIX3LtE=;
        b=iQT1VQQEMltbzFQ3HTwvfEmnF+uOgGnmla8NJMMjPcBLhKSF4QWfmllXeJ/3NwirlY
         Wwzotkg4ZAMfScNEzDqHtFgcQaOqgY36Njbr1oypMA1XpuMszLgiIzC32np4g4r+D0JC
         G9NhnnNQlSssioPO2aEGFcheWIwbGX+CKP0ChyA8Ir6/r+T4zjluxDBjrDBBnrLvH6Uq
         aV1ldE28HakUtOpeOo5+BmVR8lyDOp9DUIbiR8jYvE9+vBFSSwMLV2v4RBGOv97yP8Gi
         n1asToh0DAmUjC84NDb+Qzyur7fs8LUs305CZ2dvt98uFtEfx71NnRXm/77uJ3muljXC
         CyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQSDit0yZejZpC3NRaMc/EkzBneWHSQI3oCTQIX3LtE=;
        b=C0dQ+2dOqkHnx+uoSpNBuFZaMWFxqP3Bj7BFWA58A5lKlZYOyK8m3D8dZv+ARqoNnK
         2Mf9DykU0pxyqxUOEV5KwroTsqREADor7Z2YmxDoeC4I0RLV4ijxOSO4HQbK91ma2PU7
         RLzNw0K8mVXjaAC3mwdj84Zq3J9gLG33qs7Bhbd4UT4Lh7HuRfYwklIIUWoUUZRj3x42
         OdVxdCOgMRZKsl5IwbcIcAkQ15AltekecO2shMGJLRz/HZQ/r8S/Vo1MomTPquICtfim
         m0xWXRGHnxf2xWfKhLyh7r01nj5mQijNUl6RRwrdFb+fL1UmDIsj92eXdV7FjrnH/zo6
         raqw==
X-Gm-Message-State: ALoCoQmdZVsQ31BijPSOIJx/uw1KdKr7AMn6iVbK5xDP8CdYJCMCgdHQiB0d2f1BAMaRmKjObdJr
X-Received: by 10.50.132.71 with SMTP id os7mr32195059igb.24.1432677702349;
        Tue, 26 May 2015 15:01:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id x4sm11997161iod.26.2015.05.26.15.01.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269995>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5544-fetch-2.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/t5544-fetch-2.sh

diff --git a/t/t5544-fetch-2.sh b/t/t5544-fetch-2.sh
new file mode 100755
index 0000000..beee46c
--- /dev/null
+++ b/t/t5544-fetch-2.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Stefan Beller
+#
+
+test_description='Testing version 2 of the fetch protocol'
+
+. ./test-lib.sh
+
+mk_repo_pair () {
+	rm -rf client server &&
+	test_create_repo client &&
+	test_create_repo server &&
+	(
+		cd server &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	(
+		cd client &&
+		git remote add origin ../server
+		git config remote.origin.transportversion 2
+	)
+}
+
+test_expect_success 'setup' '
+	mk_repo_pair &&
+	(
+		cd server &&
+		test_commit one
+	) &&
+	(
+		cd client &&
+		git fetch origin master
+	)
+'
+
+# More to come here, similar to t5515 having a sub directory full of expected
+# data going over the wire.
+
+test_done
-- 
2.4.1.345.gab207b6.dirty
