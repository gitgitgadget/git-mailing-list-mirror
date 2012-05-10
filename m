From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] apply: reformat comment
Date: Wed,  9 May 2012 23:02:18 -0700
Message-ID: <1336629745-22436-2-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:02:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSU-00025a-LK
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777Ab2EJGCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2EJGC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A5805FB8
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3h8h
	f1uVF/Auu5pa3+IYSIfJCao=; b=pHrJ8/D4pn/Tv6k2m8coW84KxknLU5ESlGvw
	Pe88FWOQhuX8S/JoxY68nXhHiNdgjb1iE3eZXjJNu3YMEYOYf78avOfAech4Z4DI
	k9bZSXuqqB84zrjjuphvPuYtxebk5q8BEnzKxe9Be8EA4bXb3mI7xJwMRQTRgQan
	oRdj0Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aB4cNt
	c/OgrU96WCDZE2ml4g9UN3Z4ubHHaFu6BfDfeLYV5xuTJrAbwQ4+r7gyZpqimA7P
	qnVp6wdYdFGkqZKgF8yKZl1YJ79JYsGw4TAqoGLVWTxaSqjbd426e15PMP32o1gU
	UQ0IfZSE4R9hwRcKyX+bjZL+N32CcUXwC5El8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 829665FB7
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 170775FAD for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B96B8B94-9A65-11E1-9881-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197536>

With the "--reject" option, apply_fragments() can return 0, while marking
the fragment that was rejected as such, and there was a comment for that,
but it was stated rather poorly.

Update the comment and enclose it in a block, as this part will be getting
new code in later patches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..fc7f07b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3066,8 +3066,10 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&image, img, len, !patch->is_binary);
 
-	if (apply_fragments(&image, patch) < 0)
-		return -1; /* note with --reject this succeeds. */
+	if (apply_fragments(&image, patch) < 0) {
+		/* Note: with --reject, the above call succeeds. */
+		return -1;
+	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
 	add_to_fn_table(patch);
-- 
1.7.10.1.562.gfc79b1c
