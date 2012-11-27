From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] diff --stat: status of unmodified pair in diff-q is not
 zero
Date: Tue, 27 Nov 2012 13:21:47 -0800
Message-ID: <1354051310-29093-3-git-send-email-gitster@pobox.com>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSbj-00027f-EN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab2K0VV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:21:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab2K0VV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:21:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F75393D2;
	Tue, 27 Nov 2012 16:21:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=n439
	nkDz71ERhJtCnkKyHVk4UEc=; b=ljB9H6K5rLq/RDSZ5cjqQjbdSIulXoCAsgFS
	lVKLiZHYsnsRWKveguYlTtbTuPYfjYNKaiZ6goCXBCY1Zoa3nhIpaFMjlISi1Sfn
	R7O43z441cXtS7cIiqw8Dk+c/kTurj7ip1erw1k/KKGNWNjuZ/I52IX9KdtplQwl
	7FPi+zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	dV/RC+3CiaI+psPBs/JKiwnqxShy4M9xnUigXMe6/27jv3gKYI53DWBT2JL3VrHY
	JAeR9H9ABuKQwdE7m3mw6/bpnBJKC78PHfSSenW61ZL7gfEYVLhYBuMN2412WnKa
	no6KuqUF72G2Vs1wn4H7uWdAEGXbILQmsZ9/tGEJFE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E28093D1;
	Tue, 27 Nov 2012 16:21:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFC6593CF; Tue, 27 Nov 2012
 16:21:55 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1.331.g808d2af
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7865FE92-38D8-11E2-BE2D-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210601>

It is spelled DIFF_STATUS_UNKNOWN these days, and is different from zero.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 95bbad6..ce6baa4 100644
--- a/diff.c
+++ b/diff.c
@@ -2411,7 +2411,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	}
 
 	data = diffstat_add(diffstat, name_a, name_b);
-	data->is_interesting = p->status != 0;
+	data->is_interesting = p->status != DIFF_STATUS_UNKNOWN;
 
 	if (!one || !two) {
 		data->is_unmerged = 1;
-- 
1.8.0.1.331.g808d2af
