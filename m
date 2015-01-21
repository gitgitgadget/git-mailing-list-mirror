From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] .clang-format: introduce the use of clang-format
Date: Wed, 21 Jan 2015 12:01:27 -0500
Message-ID: <1421859687-27216-1-git-send-email-artagnon@gmail.com>
References: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDygC-0005i2-RS
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 18:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbbAURCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 12:02:52 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:42110 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbAURCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 12:02:51 -0500
Received: by mail-qg0-f48.google.com with SMTP id z60so3786255qgd.7
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Vn5ddWebpVMZ+r3lbIM6Px1TT6s6TlBr2L6lC3VX9ss=;
        b=KNRqq0NBQbiQTFIa84oOnWT/IIRAzPLaQHAYd+gdXGv+3TfM+7icMRQo8DiGteYWSX
         6ck3axGOkLCP9d/KZVA+z9uTxpG0zxm01m/sPTqqdBYyz7zLm063KuZG/dFoKJSLl5hF
         RoyMF/5f32Znnlk5Bez2l2t5ijK/fhSowZjH7x7DU2gPF38zcIrpjWb5MCgdki21KzZc
         UesfbCVxVVf+h6wcVegNIxvCTYfgdJfFuuiO4RVJMkIrK4XhImSn8nOlGl9xPsOnTZk3
         L/tOcFtb273kFcc/RfeUXwNL/O0OChXZ/+Tmg8lC2q2s4dM3Wwj0wRwl1scacg7mYmJB
         W0Uw==
X-Received: by 10.224.16.131 with SMTP id o3mr70335498qaa.31.1421859770811;
        Wed, 21 Jan 2015 09:02:50 -0800 (PST)
Received: from localhost.localdomain (ool-ad02b778.dyn.optonline.net. [173.2.183.120])
        by mx.google.com with ESMTPSA id o59sm687367qga.0.2015.01.21.09.02.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 09:02:50 -0800 (PST)
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262731>

Instead of manually eyeballing style in reviews, just ask all
contributors to run their patches through [git-]clang-format.

However, struct declarations that are combined with variable
declaration and initialization get mangled:

        struct a {
                int n;
                const char *s;
        } arr[] =3D {
                { 1, "one" },
                { 2, "two" }
        };

becomes:

        struct a {
                int n;
                const char *s;
        } arr[] =3D { { 1, "one" }, { 2, "two" } };

It gets formatted better if arr is declared separately.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 .clang-format | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 0000000..a336438
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,11 @@
+BasedOnStyle: LLVM
+IndentWidth: 8
+UseTab: Always
+BreakBeforeBraces: Linux
+AllowShortBlocksOnASingleLine: false
+AllowShortIfStatementsOnASingleLine: false
+IndentCaseLabels: false
+AllowShortFunctionsOnASingleLine: None
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+BreakBeforeBraces: Stroustrup
--=20
2.2.1
