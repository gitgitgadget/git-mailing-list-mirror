From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 05:12:57 +0100
Message-ID: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:13:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Cb-000564-G9
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab2J3ENI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:13:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62231 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2J3ENG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:13:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2265289bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7gD6WxmGRuPQagOchy682u9zzlNbL6exi0/dEJkufJQ=;
        b=DawZNfiYTi/5hPYGkjga225PermkyNO7n9dS795Ve9syZpWFpsv9NuxlUspxss5crm
         BnLNVfTxaFj97Lqxb8u4H5nndI4Sjj6rOqdlqNljjY3U17chxRTyA3AxPsxair0NHEmm
         tqyCTuSiCIxsTrrtp/5cUop0tnP7g8VC5v2L7jCVqHZjdRjad7RGEB4Vjq4OVzo8gfTl
         ODvDUgjUbK8v2aveTTGZR+vHSVuaT3dJePTRWiFmlE42P8dLBZbXt9rwtEUWayHeSQTQ
         4tmgzoD7jlk6fWqihsXfxXoB5otCeJQIvhrN7KQLS6J6zRd+Cref9+SgSYNGs0HV9s1k
         dlKA==
Received: by 10.204.147.153 with SMTP id l25mr9653602bkv.109.1351570385391;
        Mon, 29 Oct 2012 21:13:05 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id fm5sm5152598bkc.5.2012.10.29.21.13.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:13:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208661>

No reason to use the full path in case this is used externally.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 514282c..5a3d665 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -389,7 +389,8 @@ test_done () {
 	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
 		mkdir -p "$test_results_dir"
-		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
+		base=${0##*/}
+		test_results_path="$test_results_dir/${base%.sh}-$$.counts"
 
 		cat >>"$test_results_path" <<-EOF
 		total $test_count
-- 
1.8.0
