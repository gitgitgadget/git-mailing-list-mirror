Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5CB209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdINOw4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:52:56 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdINOwz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:52:55 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lzkkl-1dNNYM3BWV-0153tb; Thu, 14
 Sep 2017 16:52:37 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] test-lib: ulimit does not limit on CYGWIN and MINGW
Date:   Thu, 14 Sep 2017 16:52:34 +0200
Message-Id: <00b6d2a5508520635956da1d2db656bca126cd1a.1505400392.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.712.gda4591c8a2
In-Reply-To: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
In-Reply-To: <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
References: <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
X-Provags-ID: V03:K0:5GvWkaTMRe9nmQF8fSdcRdlE1IP1g3N5XhvHBVOzNf9rn6xqjWL
 Fx2bv4CtCJE47i38LLH922HBoG3Eyx0DKBAXT5ouBXX6nTy4WZ/4az/pMxwHxm8ZtOijPuc
 W6HBtgODnQE8W1Fg0a7nGuyR0gRhhbENqxSu/v+XgJjiDGwx2D6St3W4IJBWy941vRBE7/X
 zNLNN2CScrsIPySezPlZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H23Exl6kDt8=:RuqK1FlcfHJjBVCCu/sepR
 CmwfBh9H/JUIZK+0CjXr3JEJC7huc717hw8n4LuQRbRS3Tnj0HE3njYyiPL7U7xZ3Nir8h2i/
 I3eCwgZkwIETWFciaW29Avk+Luwkug3bDhkQJLWnaJ9rc0BuymnYEDyt+e+ro7Vum6I2Ka53/
 GEFr5/xcYWzknV1FxDKOLoE5kB3GorffDEo9dd3N7lQ6+wRhaftua1FlqcLkPMRJRgusGzdSS
 kXr+haoQHhPyYLMJgvPszhCoIbH9llTs1WLImwkrlyKFL98Um0J3HJ4SLa3j8MIQttjZhm7YY
 dHR1pzfP4F7sJfyLjLAWbNuATbOyclmcZEhc3kyschWNlt5jJQI73QWM2gLtr4Y/fGQw6Ahd+
 FGjcFYIaqbEnzmynGkPJ+qT9hFPvy/br9a1DKE/AQ/z0pdj7H1oYRNoLDtV3x2hYFj3TBBb9V
 VEORHnm8T54ypFbnIM+SqLWwNGxbaIfA5+ePhHOSMz4NA9cl+s4oo6314pmpOVz4VU5w6Yqvd
 4rTSfiPBqpRcQIc3qyettaPugWqptHIyRJ38c3/KAbZRUoHPMtCW6m5LHihnmf93cZMBRLW3d
 LjTbYrjLDvhkEKSrGkKGiM/pKYIfSl4wnDy/u9eEomwW9LhDay91qLSAqRCN0dYK71Gtod+Nb
 o9r2CzudUJOfM9F370Wsok2wt5weK2+SnElV8uVp3I7G+ajF8Nm7JoQvISAJJPeyh52k7hoZI
 O0HE9AWzgYXtZy7g+TvaOXaxFjlZ3JWw9Xxk8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ulimit succeeds (by return value) but does not limit on some systems.

Set ulimit() to false on these systems so that we do not rely on its
output nor effect. As an intended side-effect, ulimit based
prerequisites are set correctly (to "not-have") on these systems.

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
This is independent of my series, but should best go before so that no
ulimit based test is run on CYGWIN and MINGW.

It follows the basic assumption that a tool like ulimit is either
present and functional or not present; and that we work around by
defines or such when that assumption is broken.
(Alternatively, we could set ULIMT_LIMITS or so and depend on that.)

 t/test-lib.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b8a0b05102..f6ac60d487 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -998,6 +998,10 @@ case $uname_s in
 	mkfifo () {
 		false
 	}
+	# ulimit succeeds but does not limit
+	ulimit () {
+		false
+	}
 	# no POSIX permissions
 	# backslashes in pathspec are converted to '/'
 	# exec does not inherit the PID
@@ -1012,6 +1016,10 @@ case $uname_s in
 	mkfifo () {
 		false
 	}
+	# ulimit succeeds but does not limit
+	ulimit () {
+		false
+	}
 	test_set_prereq POSIXPERM
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq CYGWIN
-- 
2.14.1.712.gda4591c8a2

