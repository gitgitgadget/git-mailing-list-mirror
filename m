From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 03/14] checkout: call the new submodule update test framework
Date: Sun, 15 Jun 2014 18:58:44 +0200
Message-ID: <539DD0C4.4000609@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 18:59:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDle-0000tw-TZ
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 18:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbaFOQ6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 12:58:51 -0400
Received: from mout.web.de ([212.227.17.12]:63258 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbaFOQ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 12:58:50 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MUWFj-1XMrZO3DkZ-00RIgD; Sun, 15 Jun 2014 18:58:45
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:30nhtueZQYQRZrlPLMbhnPxArSqV4kECLUGp3ainHTP+QR06whH
 YIsLFXnKRlth0fN8r/gmA+5Kr5tDySIZA0pIFSgLS1pHrqZNKDRFCG+anw0nNuJTyAMROOL
 hkT/XFDjWTgFMJjluJmDyp6MQ7RSr1YhD8IwvDdigq5tEvRxcZhojwBGPyTeFr8a5Si3rSf
 Zq0mh3Vy9KoM/iszmZ0Uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251685>

Test that the checkout command updates the work tree as expected with
and without the '-f' flag.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t2013-checkout-submodule.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 06b18f8..6847f75 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -3,6 +3,7 @@
 test_description='checkout can handle submodules'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh

 test_expect_success 'setup' '
 	mkdir submodule &&
@@ -62,4 +63,8 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '

+test_submodule_switch "git checkout"
+
+test_submodule_forced_switch "git checkout -f"
+
 test_done
-- 
2.0.0.275.gc479268
