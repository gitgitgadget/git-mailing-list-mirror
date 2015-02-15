From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] t9300: correct expected object names
Date: Sun, 15 Feb 2015 15:43:40 -0800
Message-ID: <1424043824-25242-3-git-send-email-gitster@pobox.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8qw-0006CL-30
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbbBOXnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:43:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbbBOXnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:43:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75CEB39CE8;
	Sun, 15 Feb 2015 18:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ev+e
	GUBaXXVfdjm3vwsWj7oHopI=; b=ZtVT7wHHIVoxLzXxie9IbQzdwyrvzrT1Inbd
	AtYBRbfZzgcIRCR9WE1Pajb1ZO0nbe/jI+Ce9clO3l8kP4UAP123ZJNDB8x+1BrA
	9gVFB2t3eqcn3SFBx47PBKlQgNskZ34EElNcMdW2/clSsyUEVkr7FovyErcQLkkQ
	q7Vzor0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Vv8XPG
	an+jkbi3iUZh4zldaz9ibFBHVzsiTO7eSGP3PgxBOxpz+JHgwWJda8/eVe4wio1F
	nV6V2b1YhtaKPm+M0V/85ba/B6dnyL3qqrW0ZkYP9oZpbg5rCsRe+573NJxoBzoi
	Zc4OvNuoEzzcO7EfozpC/m0UczeDbqXG2wM14=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C86339CE7;
	Sun, 15 Feb 2015 18:43:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E57F439CE6;
	Sun, 15 Feb 2015 18:43:48 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7D325A0C-B56C-11E4-984B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263855>

The output the test #36 expects is bogus.  There are no blob objects
whose names are 36a590... or 046d037... when this test was run.

It was left unnoticed only because compare_diff_raw, which only
cares about the add/delete/rename/copy was used to check the result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9300-fast-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 27263df..e53def2 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -582,8 +582,8 @@ test_expect_success 'D: verify pack' '
 '
 
 cat >expect <<EOF
-:000000 100755 0000000000000000000000000000000000000000 35a59026a33beac1569b1c7f66f3090ce9c09afc A	newdir/exec.sh
-:000000 100644 0000000000000000000000000000000000000000 046d0371e9220107917db0d0e030628de8a1de9b A	newdir/interesting
+:000000 100755 0000000000000000000000000000000000000000 e74b7d465e52746be2b4bae983670711e6e66657 A	newdir/exec.sh
+:000000 100644 0000000000000000000000000000000000000000 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 A	newdir/interesting
 EOF
 git diff-tree -M -r branch^ branch >actual
 test_expect_success \
-- 
2.3.0-266-g5b48884
