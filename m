From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/10] t5517: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:02 -0800
Message-ID: <1357368788-28035-5-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdX-0000vb-Eg
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab3AEGxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab3AEGxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 374DA8CDA
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=w7IQ
	qWWp4cLxPQzHriYHaUuP+bk=; b=ScHUDLPuKsUTpHwyYjVjn3O9pXKyx9uHrHhZ
	dOrLRGTWge/H2YbhM8ydyJGPIlXH7ub9IkKY7zqL6cwzxtLug/20Qgk1ZjUYo4dP
	d4dtUrDVj8AQ9w65Z0ZyvuP0k1ap2dEd6ZFMbgdHUKSLyozf2xZpzAZqMj7eQnAV
	58TCY0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xhLKYl
	l9cBdwUzgjemU7IJ5aBvaWY55D1x9N0x9vSPaKAKPKdmQCKSsvbVZ47RDqGvhLnn
	70TMwyCugPLqECXnZVH0TT7+PoQBP8LMfj0o9Z57YD4SxQk5RKcdnuGGtOpH48kQ
	YoRStmHzSf9EqD7krnjd7LML1Cxal+EmXWuck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A1CF8CD9
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0B548CD8 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:17 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 95AF1B38-5704-11E2-8DDE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212671>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5517-push-mirror.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index e2ad260..12a5dfb 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -256,7 +256,7 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
 		git branch keep master &&
 		git push --mirror up &&
 		git branch -D keep &&
-		git push up
+		git push up :
 	) &&
 	(
 		cd mirror &&
-- 
1.8.1.299.gc73b41f
