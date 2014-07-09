From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/2] t/Makefile: always test all lint targets when running
 tests
Date: Wed, 09 Jul 2014 21:34:42 +0200
Message-ID: <53BD9952.8060109@web.de>
References: <53B5D6FE.2090700@web.de> <53B5D76D.1090509@web.de> <xmqq38eddolk.fsf@gitster.dls.corp.google.com> <53BC4569.3020907@web.de> <CAPc5daUXZNB=2X8zsrhs9=Z-nV1o1v7KWGydAj6UmBk23UBEEw@mail.gmail.com> <53BD9908.1060807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 21:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4xdo-0000ow-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 21:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbaGITew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 15:34:52 -0400
Received: from mout.web.de ([212.227.15.14]:58877 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276AbaGITev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 15:34:51 -0400
Received: from [192.168.178.41] ([84.132.188.65]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LbwKy-1WLlX43Dpk-00jIcm; Wed, 09 Jul 2014 21:34:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BD9908.1060807@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:HH5f4+XXWyDrz/Tod8V6rBQWkWDGs35a43XL8dyr66cu8gTEsSZ
 uuJ+cb6POsgIcVpBZ4BcHep63u1P7HyRyX3gZeGYAsUhqE/I1ySPvKeZ936NfyQYRtJ+txz
 s2+8k8OtPgX/HJIe0odRQ9PhoYTwZQeoKW8xy4Og0c3fvIJlH6OvILT9hrFSnEb4yn9Aedg
 kCq20AMX6U5Fqx+hlalNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253143>

Only the two targets "test-lint-duplicates" and "test-lint-executable" are
currently executed when running the test target. This was done on purpose
when the TEST_LINT variable was added in 81127d74 to avoid twisted shell
scripting by developers only to avoid false positives that might result
from the rather simple minded tests, e.g. test-lint-shell-syntax. But it
looks like it might be better to include all lint tests to help developers
to detect non portable shell constructs before the patch is sent to the
list and reviewed there.

Change the TEST_LINT variable to run all lint test unless the TEST_LINT
variable is overridden. If we hit false positives more often than helping
developers to avoid non-portable code (or add less accurate or slow tests
later) we could still fall back to exclude them like 81127d74 proposed.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 7fa6692..43b15e3 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -13,7 +13,7 @@ TAR ?= $(TAR)
 RM ?= rm -f
 PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
-TEST_LINT ?= test-lint-duplicates test-lint-executable
+TEST_LINT ?= test-lint

 ifdef TEST_OUTPUT_DIRECTORY
 TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
-- 
2.0.1.476.gf051ede
