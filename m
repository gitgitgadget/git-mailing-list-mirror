From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 1/6] diff-lib.c: fix misleading comments on oneway_diff()
Date: Sat, 19 Sep 2009 22:06:10 -0700
Message-ID: <1253423175-6339-2-git-send-email-gitster@pobox.com>
References: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdH-00044A-9j
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbZITFGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbZITFGW
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZITFGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5AD391B8
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=o8U7
	J8SGfyKN0ZW8+/QeAP7JuaU=; b=CCcIerp4l5fS8E9i97aG+KKUHFIwbD7k6D4C
	pzeVFYB77YsofHS5V2iLWmBImIJ4ZAd5/uCDbH071pa1wUoYB46fVneZ9ZPEeznu
	p+wUJ1PKduHcF/OWCw52FNqu0kJMQCLWW+sgxQSIwgKt5n8f5Q7xD4J9AcDP/yUH
	tWnZWiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Wq37y0
	h7W1TPbQm+2ifAQIPgeLx/QNMzzIYk3qzC/fnKqpKY+/iMW6h5fluhcljdWl8ZOn
	ziYbsK8ghjmsVKxQfA+HDH+9cxSqVMLP/QlN1b2s8VptBC/8ceJO7GfZ+vMaNeNM
	XtY/lbauYlP9NHVx9yjaKT7QKPcngYsIm1rcM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D69C4391B7
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 730D0391B6 for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:21 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
In-Reply-To: <1253423175-6339-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5693D45E-A5A3-11DE-9F75-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128840>

20a16eb (unpack_trees(): fix diff-index regression., 2008-03-10) adjusted
diff-index to the new world order since 34110cd (Make 'unpack_trees()'
have a separate source and destination index, 2008-03-06).  Callbacks are
expected to return anything non-negative as "success", and instead of
reporting how many index entries they have processed, they are expected to
advance o->pos themselves.  The code did so, but a stale comment was left
behind.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 0c74ef5..adf1c5f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -383,7 +383,7 @@ static inline void skip_same_name(struct cache_entry *ce, struct unpack_trees_op
  * For diffing, the index is more important, and we only have a
  * single tree.
  *
- * We're supposed to return how many index entries we want to skip.
+ * We're supposed to advance o->pos to skip what we have already processed.
  *
  * This wrapper makes it all more readable, and takes care of all
  * the fairly complex unpack_trees() semantic requirements, including
-- 
1.6.5.rc1.90.ga3b1b
