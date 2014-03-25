From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH 3/4] checkout: call the new submodule update test framework
Date: Tue, 25 Mar 2014 18:05:39 +0100
Message-ID: <5331B763.10808@web.de>
References: <5331B6F6.60501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:06:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUnX-0001z9-71
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbaCYRFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:05:54 -0400
Received: from mout.web.de ([212.227.15.4]:53721 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbaCYRFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:05:50 -0400
Received: from [192.168.178.41] ([84.132.146.250]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MKJ7S-1WU8gd1EaU-001gl8; Tue, 25 Mar 2014 18:05:41
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5331B6F6.60501@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:2F+KYGuPULAhYRholmuvMYsRcVFzSx4x0xsuJINba/ePrrgKz2b
 ryIm0tcPcu+OviDgBvoDi1p1ZO2l3e4qe30Gom3noUACIbB+K8CPEN/VhSh4swVeSm/w0k4
 Sg7N9VJcXoZ63mht7RxA+09CBCWfc3vBoNCSWAPT6IzZtEQpfdEyDBLkk69uJlf8noaV5OM
 dP0PwyJRZOylm27xTX4qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245047>

Test that the checkout command updates the work tree as expected with or
without the '-f' flag.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I think this should explain how to use the framework with a single command
and some options.

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
1.9.1.327.g3d8d896
