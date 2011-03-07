From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 9/9] t6007: test rev-list --cherry
Date: Mon,  7 Mar 2011 13:31:43 +0100
Message-ID: <cb4f7705217f252ca1156babd8bcbea67ba38f13.1299499429.git.git@drmicha.warpmail.net>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZf6-0003Ub-NB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab1CGMfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:34 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52376 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752592Ab1CGMf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:28 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 54BDA20654;
	Mon,  7 Mar 2011 07:35:28 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 07 Mar 2011 07:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=BqxFtSv6e6rTnjKksgvPGq9qf7k=; b=G5ZpjX49Olf2NNJT17xCeXL7XeOd12KChZZiuN3Q6+kUWUgyY8PwT1DDYhNT/bRulNlTXFDHAipvEmyMNNUQo12EDzTPZ7jrox4Vq+dYdCwKg9/u0PDrJnq9H5/hVeboB3BpFsytLBePbpeEzi2MAtT+e0jwsdg/RD6Z+SkYGy4=
X-Sasl-enc: CmGpNmEZH+h2rChA22VfWGsmfxaSqbczujSCxs5dchP0 1299501327
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D12BF440F07;
	Mon,  7 Mar 2011 07:35:27 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168589>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6007-rev-list-cherry-pick-file.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 37bd25e..cacf3de 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -145,6 +145,18 @@ test_expect_success '--cherry-pick --left-only' '
 	test_cmp actual.named expect
 '
 
+cat >expect <<EOF
++tags/E
+=tags/C
+EOF
+
+test_expect_success '--cherry' '
+	git rev-list --cherry F...E -- bar > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
 test_expect_success '--cherry-pick with independent, but identical branches' '
 	git symbolic-ref HEAD refs/heads/independent &&
 	rm .git/index &&
-- 
1.7.4.1.299.g567d7.dirty
