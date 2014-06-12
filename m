From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v5 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 14:38:59 -0500
Message-ID: <1402601942-45553-2-git-send-email-caleb@calebthompson.io>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:39:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAqR-0006wg-D5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbaFLTjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:39:21 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41344 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751875AbaFLTjT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 15:39:19 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2D6C7640;
	Thu, 12 Jun 2014 15:39:19 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 12 Jun 2014 15:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=GgKSyYislWjKl9ghjr/6uOVQho4=; b=ddryG0BYuxnQ5E1lxZkC1
	KydxZ/rZKAXOwQ315SLaW3bGuaZA3frVVlyrSg8w3KZ2F/WADFoDCVAt/mwGkHT1
	VEu6p53+EXsnrBK3iqg6ZNHJdMXPXPgw2GYokoFxfi5ZTQndltN6TP0fXeWPqXG0
	IlGJqkvqYUj4PqpwUpS/as=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=GgKSyYislWjKl9ghjr/6uOVQh
	o4=; b=aNC2rykTitAtXqbxAKWLsQEqS8gRecjV+eZmuIQDfmAkdRKOhrJjLea57
	dWDrQPLW9kM25AUd9NbwHTbtwzL8GMIZoTs9WSCV2XKJnmc6GbW2wxkvO727Lw8B
	MbyP2hO5gUC/D2j/c0+TlvLDvOFfv38GmOEz5Wx7PHF6bR3hA0=
X-Sasl-enc: mw9Nn5Po2jtGyyAoOz1kS9+BMpo9TRPQZmlim8mr8rUc 1402601958
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8230068011C;
	Thu, 12 Jun 2014 15:39:17 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251489>

Some of the tests in t/t7507-commit-verbose.sh were still using
git-config to set configuration. Change them to use the test_config
helper.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..6d778ed 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -43,7 +43,7 @@ test_expect_success 'verbose diff is stripped out' '
 '
 
 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
-	git config diff.mnemonicprefix true &&
+	test_config diff.mnemonicprefix true &&
 	git commit --amend -v &&
 	check_message message
 '
@@ -71,7 +71,7 @@ test_expect_success 'diff in message is retained with -v' '
 '
 
 test_expect_success 'submodule log is stripped out too with -v' '
-	git config diff.submodule log &&
+	test_config diff.submodule log &&
 	git submodule add ./. sub &&
 	git commit -m "sub added" &&
 	(
-- 
2.0.0
