From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] builtin/merge.c: drop a parameter that is never used
Date: Tue, 28 Oct 2014 14:36:49 -0700
Message-ID: <1414532212-9016-2-git-send-email-gitster@pobox.com>
References: <1414532212-9016-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 22:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjEl7-0007K9-9w
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbaJ1V4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 17:56:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755257AbaJ1V4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 17:56:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F04C31AFC3;
	Tue, 28 Oct 2014 17:56:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fYFg
	xODM+FAyKfY+aVWhYib+xVA=; b=o9U5pUAIJAuD5dqI5BDMsHjBngVAG3ARJ5hg
	rTYn/KHAxnLsk60WJyd43we17Qmbjgk+1d3fsNTi8dNSkSTHqWOXNxc+26KgIJ9U
	RqN0GKUMi8xs9PDVeIMyXcpPYb0sYc3FAoxT8pYjDw9XJK73EWCRWIp0zduA8Es+
	P3Kf8J8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Cba3Oa
	Qri69KvJB4HfRGRMRQmkCtUfpWKSynQGsBiICb24g3oQpkzrF97ZuSipYwU5+vlP
	Ljn9OTky9ByVcENmaMVwAwjs97v5IOHB8JFlfUXonzHvFPRBU+kEo9HY7efjD/e5
	5MMezPc1gmXIgHn19PwqzqO7pz9VWr+YibDsM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E66F61AFC2;
	Tue, 28 Oct 2014 17:56:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 498DB1AAA5;
	Tue, 28 Oct 2014 17:36:58 -0400 (EDT)
X-Mailer: git-send-email 2.1.2-620-g33c52cb
In-Reply-To: <1414532212-9016-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8B780E46-5EEA-11E4-93A1-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the very beginning when we added the "renormalizing" parameter
to this function with 7610fa57 (merge-recursive --renormalize,
2010-08-05), nobody seems to have ever referenced it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 41fb66d..f6894c7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -884,7 +884,7 @@ static int finish_automerge(struct commit *head,
 	return 0;
 }
 
-static int suggest_conflicts(int renormalizing)
+static int suggest_conflicts(void)
 {
 	const char *filename;
 	FILE *fp;
@@ -1557,7 +1557,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, _("Automatic merge went well; "
 			"stopped before committing as requested\n"));
 	else
-		ret = suggest_conflicts(option_renormalize);
+		ret = suggest_conflicts();
 
 done:
 	free(branch_to_free);
-- 
2.1.2-620-g33c52cb
