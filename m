From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t3033: avoid 'ambiguous refs' warning
Date: Thu, 21 Apr 2016 12:24:57 -0700
Message-ID: <20160421192500.23563-2-gitster@pobox.com>
References: <20160421192500.23563-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:34:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKMQ-0001yk-Us
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbcDUTdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:33:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752685AbcDUTdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:33:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7EC513243;
	Thu, 21 Apr 2016 15:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=PWRh
	Gq7T2gO5QxQ/RvIKe7s/2po=; b=o1c24oB51U/KF2GFX+iTtSXs0rio60GtVtnF
	lShIbbJq9VHl6cj10V2xouZYPVkxY54xMSDtucAeCXtRH9FP8gV9oquO4REvscDw
	yPcYoWzLUS0PuQjRNNa4sc3Wo99m+tExgmx0SQYHf2yzl6NiOujviOS6Gw0r3T/p
	deMpiVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZfpPQF
	ZQnpBcTVnM8aPuhirg1ZrltYj+WTx/FgmMwoim2v6h3FMytoFp2rt7HxBtUl9bvk
	WpdyP3tU9e8ARmNSJi3iC84DxqlsP8EQAOgS7gHMRvhq7Gs5Vn6t0bkPneKwZ5sL
	/2omydqPz9GboJkzQJu6dMZuXEOxrVtNqxYsc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FB881323F;
	Thu, 21 Apr 2016 15:25:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2B441323C;
	Thu, 21 Apr 2016 15:25:02 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-422-g6d9b748
In-Reply-To: <20160421192500.23563-1-gitster@pobox.com>
X-Pobox-Relay-ID: BF0DBFA6-07F6-11E6-90DB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292147>

Because "test_commit five" creates a commit and point it with a tag
'five', doing so on a branch whose name is 'five' will later result
in an 'ambiguous refs' warning.  Even though it is harmless because
all the later references are for the tag, there is no reason for the
branch to be called 'five'.  Give it a name that describes its
purpose more clearly, i.e. "newroot".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3033-merge-toplevel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3033-merge-toplevel.sh b/t/t3033-merge-toplevel.sh
index c1379b0..d314599 100755
--- a/t/t3033-merge-toplevel.sh
+++ b/t/t3033-merge-toplevel.sh
@@ -19,7 +19,7 @@ test_expect_success setup '
 	test_commit three &&
 	git checkout right &&
 	test_commit four &&
-	git checkout --orphan five &&
+	git checkout --orphan newroot &&
 	test_commit five &&
 	git checkout master
 '
-- 
2.8.1-422-g6d9b748
