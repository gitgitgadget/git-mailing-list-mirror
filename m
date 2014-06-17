From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v6 1/4] commit test: Use test_config instead of git-config
Date: Tue, 17 Jun 2014 14:38:57 -0500
Message-ID: <a7aa2efcb6a2beba973c389f5c7afbce79ec9747.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:39:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwzE9-0007ID-SW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933643AbaFQTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:39:23 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33500 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756486AbaFQTjV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 15:39:21 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C926868E
	for <git@vger.kernel.org>; Tue, 17 Jun 2014 15:39:20 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 17 Jun 2014 15:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references; s=mesmtp; bh=0YYwmEzs2Vi1PsNCnlPptIfUDo
	g=; b=oF3lQnvqFoKYbr8y5Z9qpdEYI03bgM1VAlcKl4sN5NfBsWobyab9ee2+nj
	qDew8VuYzeu3iiD1ACm4jw9tIavyqZFyiKKDb/pLbk0pQ8Bgm9qI9j7Ia/KqmqQ4
	f90vLdTbFDNh8NBNLdleYjBlQBc8zEHDz5tltK7XMXYLnHvP0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=0Y
	YwmEzs2Vi1PsNCnlPptIfUDog=; b=IbgX47j5DQM7RMJcuMZBEyIco9kq5knDew
	9bu8MgNI9Perl0r31AxGmm4IellWJ48D1zxiO5muW3qsO9D6somA7Yks7WWPbE7C
	96Zsz2pXp2fLpfFjwPkuHv7DrEuTnMV9Ix3JBYz7cexBKQquU+zvUBwKRDqkGDmE
	bdMeZb8+c=
X-Sasl-enc: rpVT6o8KaioYWkmDi81egJLUQWqK7XfLxfbbI+gtjcuu 1403033951
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2587AC007B4;
	Tue, 17 Jun 2014 15:39:11 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
In-Reply-To: <cover.1403033723.git.caleb@calebthompson.io>
References: <cover.1403033723.git.caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251941>

Some of the tests in t/t7507-commit-verbose.sh were still using
git-config to set configuration. Change them to use the test_config
helper.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>
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
