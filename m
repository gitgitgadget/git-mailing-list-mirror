From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] fixup! notes remove: --ignore-missing
Date: Thu, 19 May 2011 20:47:02 +0200
Message-ID: <bdd14b3138e4d90de58945f25dcf33da027d9f07.1305830419.git.git@drmicha.warpmail.net>
References: <4DD4C73C.7020600@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8Fh-0007NO-R3
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933921Ab1ESSrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:47:08 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54401 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933895Ab1ESSrG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 14:47:06 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6952A2078C;
	Thu, 19 May 2011 14:47:06 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 19 May 2011 14:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=aMcr9Bd3PHcWnNPBeoHP2q8ywu4=; b=bFQJEE10flebeyta28X3PKeARO5qruwDcGFOEmfyX28sTU8RwzIDy6335rHm5zcJwnH1dyS7regN45CZNKCVb8CCPgUSxTikCof4QC5c7fmSie9UKr9w2HkmNiIvwLq8KnI9fscwPUbNPXu9yPPviw+JwzQraOuVoTLk71+IKKc=
X-Sasl-enc: cKv2WWc0dHvbFMfzz8y88OL7+g03toBimp9D+FaKXIk8 1305830825
Received: from localhost (p54858F0A.dip0.t-ipconnect.de [84.133.143.10])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC980447C56;
	Thu, 19 May 2011 14:47:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.558.gc8bec
In-Reply-To: <4DD4C73C.7020600@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173989>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3301-notes.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 09cf6b2..1edb7bf 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -438,12 +438,13 @@ test_expect_success 'removing non-existing note should not create new commit' '
 test_expect_success 'removing more than one' '
 	before=$(git rev-parse --verify refs/notes/commits) &&
 	test_when_finished "git update-ref refs/notes/commits $before" &&
+	MSG=4 git notes add HEAD^ &&
 	git notes remove HEAD^^ HEAD^^^ &&
 	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
 	test 2 = $(wc -l <actual) &&
 	git ls-tree -r --name-only refs/notes/commits >actual &&
-	>empty &&
-	test_cmp empty actual
+	git rev-parse HEAD^ >expect1 &&
+	test_cmp expect1 actual
 '
 
 test_expect_success 'removing is atomic' '
-- 
1.7.5.1.558.gc8bec
