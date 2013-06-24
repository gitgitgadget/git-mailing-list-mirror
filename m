From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] t/t5528-push-default: remove redundant test_config lines
Date: Sun, 23 Jun 2013 21:33:03 -0700
Message-ID: <1372048388-16742-2-git-send-email-gitster@pobox.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyT5-00045x-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab3FXEdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3FXEdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76550265A3
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Pta0
	agxL0zM07Upyctu40Ek+ruk=; b=MXsSVFLLJ7LMej8ZEM5fXQN/Iq2goJ9iLnn2
	fl7Rf/HIYsvZVIx5pcBVb57UaqIodMzIVGKOHMopEXw/UvKTsBr7Clj704LIRW0a
	TOOrliuEhoim2NPbS522TEk9JTv2BfLVpK9rjXzA7+ujwlVVrQOhM30nizIM+5Tf
	1MMkAC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=M8Qic5
	dmFAZtwcX6D1bgjamoEg4Cviu9oLsGWK/0e7DXO4nxzpeGv8a6cVzzTENfIdBL8x
	nSyFV3QGh5gohFtx3MSqxzUPTei9ONM9SHBLkxk9WbNX01EZM+P6polXJl2qn06f
	6wp/3KXa7MOX4ajEHwK0tLiM6WfE4oE4MmYKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7A02659F
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC7432659D
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:11 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2DB05912-DC87-11E2-9947-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228769>

From: Ramkumar Ramachandra <artagnon@gmail.com>

The line

  test_config push.default upstream

appears unnecessarily in two tests, as the final test_push_failure sets
push.default before pushing anyway.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5528-push-default.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4736da8..69ce6bf 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -48,7 +48,6 @@ test_expect_success '"upstream" pushes to configured upstream' '
 test_expect_success '"upstream" does not push on unconfigured remote' '
 	git checkout master &&
 	test_unconfig branch.master.remote &&
-	test_config push.default upstream &&
 	test_commit three &&
 	test_push_failure upstream
 '
@@ -57,7 +56,6 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
 	test_unconfig branch.master.merge &&
-	test_config push.default upstream
 	test_commit four &&
 	test_push_failure upstream
 '
-- 
1.8.3.1-721-g0a353d3
