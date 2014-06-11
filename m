From: "" <caleb@calebthompson.io>
Subject: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Wed, 11 Jun 2014 13:24:36 -0500
Message-ID: <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 20:32:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WunKL-0003Zp-5U
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 20:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbaFKScf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 14:32:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35385 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752436AbaFKSce (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 14:32:34 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jun 2014 14:32:34 EDT
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 471CA636;
	Wed, 11 Jun 2014 14:25:10 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 11 Jun 2014 14:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=GgKSyYislWjKl9ghjr/6uOVQho4=; b=suGAQtnnokQsFoxrJFhR/
	4IHebW4qVvfQnVuC1wQUCoqugJkEFIJ0Se/sWag7lf8IMEz5rDNSLzJV4GwRCNf/
	olGm0f0P0ctnUKuJe48AWsdOIsK1uEJkJ3cys/wn0eRgX3npogpjfKtMKOcD9sHY
	SCR0mM7tLlvSXBI9/CxuuM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=GgKSyYislWjKl9ghjr/6uOVQh
	o4=; b=UGZCvd/E8aiwcyBtyVakIXCrrcLmCrNIxL2b1PVoVMvxgPXHg2RXxqvub
	tViLkO7c45EiwIiyGAHi0GIPmctzGN/chTWd1k7qfBCnzSgpyrbcOFdcn2Cp62Mv
	1tzAiSyU7PqlmL1FA8Yq8gER8UnUIE1a+OfwkDMApSxh1+Le0E=
X-Sasl-enc: 390/BzloThRpYEEAoIfh1aCGqPEvIKQ37rDrH0bV+/Tv 1402511109
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5C39268025D;
	Wed, 11 Jun 2014 14:25:09 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251377>

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
