From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 4/6] t7406: Just-cloned checkouts update to the gitlinked hash with 'reset'
Date: Wed, 15 Jan 2014 20:10:25 -0800
Message-ID: <09008c79ecc7d4fd92131b4049a25e65db92a30d.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eIy-0001c1-7R
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaAPELh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 23:11:37 -0500
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:49445
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520AbaAPELb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:11:31 -0500
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id EUAr1n00327AodY5BUBWLF; Thu, 16 Jan 2014 04:11:30 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id EUBV1n002152l3L3fUBV3p; Thu, 16 Jan 2014 04:11:30 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id D0B6CEFE48D;
	Wed, 15 Jan 2014 20:11:28 -0800 (PST)
Received: (nullmailer pid 18566 invoked by uid 1000);
	Thu, 16 Jan 2014 04:11:03 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
In-Reply-To: <cover.1389837412.git.wking@tremily.us>
References: <cover.1389837412.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845490;
	bh=TXN5q8V5tWv6lpeDWOvN5Uy9vkbjbBKvY1+uIOx/rH0=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=jTZudmmtb4Bihj/A5HLzn5GX/F0bS2D3hNODMKq1zihhK5t9cesC1dIjO/kKAqEkr
	 C61EUyG3s7Dx3b3L5+yVLtnyvMbudu9kkpgJ2ji6qeceYivg9P5CcpC4XF4Z08zcXV
	 vMBgGuIkn5XRdGlm2/J6MC+I+Pgh1RYXGrUx7bVwa249uXsNaICXG14TXTHz/1FuDi
	 9tJOv+hoVzLzR+sLQakFoEnpfBYJW9qN+uUDa+6IsFqfoV8+X+C/DjL9zgjrE2rJHG
	 UzoR3q9V0nQIqncZxuhBwuwBFTzYLoW0sOARdoJlbck/jgC14m1+lmo0RMosyU1kec
	 qwfcxYGmJ0FWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240502>

To preserve the local branch, for situations where we're not on a
detached HEAD.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0825a92..5aa9591 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -703,7 +703,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
 	 git submodule update --init --recursive >actual &&
-	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
+	 test_i18ngrep "Submodule path .submodule/subsubmodule.: .git reset --hard -q" actual &&
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
-- 
1.8.5.2.8.g0f6c0d1
