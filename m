From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] t/Makefile: always test all lint targets when running
 tests
Date: Fri, 04 Jul 2014 00:21:33 +0200
Message-ID: <53B5D76D.1090509@web.de>
References: <53B5D6FE.2090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:21:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2pNz-0005yI-1E
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759599AbaGCWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 18:21:43 -0400
Received: from mout.web.de ([212.227.17.11]:54031 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbaGCWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 18:21:42 -0400
Received: from [192.168.178.41] ([84.132.191.233]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LcgZv-1WJtZh08V5-00kC7O; Fri, 04 Jul 2014 00:21:34
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B5D6FE.2090700@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:vqaSzoZcW+VI/vx1Td+5JIcNj06GCJso0l82eIMf0Uko9tsnkhl
 GblWmYo7eSLJw2zaABTNtbweIIPIv474iYDTSlc9DaWrrO0T4AaHRmQa/HVA9xcBWdrHhlk
 0RCPxQwpyT7fpIsIOK1aY3N5KT8LhwP3PbclYBPHOPdinzcCjNWF3fCjA7xSlIkaBoUNeUg
 zvHTubwwQD4DEN9kZMe5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252886>

Only the two targets "test-lint-duplicates" and "test-lint-executable" are
currently executed when running the test target. This was done on purpose
when the TEST_LINT variable was added in 81127d74. But as this does not
include the "test-lint-shell-syntax" target added the same day in commit
c7ce70ac, it is easy to accidentally add non portable shell constructs
without noticing that when running the test suite.

Fix that by always running all lint tests unless the TEST_LINT variable is
overridden. If we add less accurate or slow tests later we could still
fall back to exclude them like 81127d74 proposed. But for now it is better
to include all lint tests until proven otherwise.
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
2.0.1.474.g5b85b58
