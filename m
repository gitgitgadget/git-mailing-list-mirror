From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/10] t5519: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:03 -0800
Message-ID: <1357368788-28035-6-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdX-0000vb-W2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab3AEGxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3AEGxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321D38CDE
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+T9G
	uNJctlshfHvq4IJvl4DDIAU=; b=TJ93pvSyZmc0y/QWQMqUK5TostJ8IjOrbozN
	vNnS9hn3YMkd0wRo4zXV2B3r2aT2GC1kf+iuk+matcD3RB1K6DoryapFwj7M2gOf
	g4qSoUIdCO7qc6dryaWRX3ipbOLx+Qq9AyXzhd8EwzXsepcWFt9nMbdJNu0sQZKM
	UvqPBxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GbzEqM
	fwFxb+8D8SZV83eXB0P8KMHhaT6rIsOEzelOUJp+dWTtyUTxtGU2dnv2t9mbQAT2
	OxV/D8PkL30pRzALveuqrASJOKcwPHC1WnFkJ04BjHMkyXT693XE2YVPmXSOlnXn
	i1gnw9xLZnLSYogWxFCxDzCCpIl/wZ2uCRkPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 251278CDD
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C918CDB for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:19 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 96D01E90-5704-11E2-8C58-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212669>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5519-push-alternates.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index c00c9b0..11fcd37 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -40,7 +40,7 @@ test_expect_success 'alice works and pushes' '
 		cd alice-work &&
 		echo more >file &&
 		git commit -a -m second &&
-		git push ../alice-pub
+		git push ../alice-pub :
 	)
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'bob fetches from alice, works and pushes' '
 		git pull ../alice-pub master &&
 		echo more bob >file &&
 		git commit -a -m third &&
-		git push ../bob-pub
+		git push ../bob-pub :
 	) &&
 
 	# Check that the second commit by Alice is not sent
@@ -86,7 +86,7 @@ test_expect_success 'alice works and pushes again' '
 		cd alice-work &&
 		echo more alice >file &&
 		git commit -a -m fourth &&
-		git push ../alice-pub
+		git push ../alice-pub :
 	)
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'bob works and pushes' '
 		cd bob-work &&
 		echo yet more bob >file &&
 		git commit -a -m fifth &&
-		git push ../bob-pub
+		git push ../bob-pub :
 	)
 '
 
@@ -115,7 +115,7 @@ test_expect_success 'alice works and pushes yet again' '
 		git commit -a -m sixth.2 &&
 		echo more and more alice >>file &&
 		git commit -a -m sixth.3 &&
-		git push ../alice-pub
+		git push ../alice-pub :
 	)
 '
 
@@ -136,7 +136,7 @@ test_expect_success 'bob works and pushes again' '
 		git hash-object -t commit -w commit &&
 		echo even more bob >file &&
 		git commit -a -m seventh &&
-		git push ../bob-pub
+		git push ../bob-pub :
 	)
 '
 
-- 
1.8.1.299.gc73b41f
