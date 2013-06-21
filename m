From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] t6003: add --date-order test
Date: Fri, 21 Jun 2013 11:49:37 -0700
Message-ID: <1371840579-20161-4-git-send-email-gitster@pobox.com>
References: <1371840579-20161-1-git-send-email-gitster@pobox.com>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 20:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6PG-0002QS-6h
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423709Ab3FUStt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:49:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUSts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:49:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC08A2A0C3;
	Fri, 21 Jun 2013 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WrFv
	gyqUAozObtvjAnwk+7uczd8=; b=Igj0efU64TyIuTaNsvKjxTpBNuh8wAqVm/k6
	C6nvN+E/Xo5GzmcFkhTopCkWfIg3Gm8rNlTt+YtFuYNvILeHNItPXZalKlOGnLtf
	YyCfzjx2L47ZDGG9ivh0rDvcyia90P9l5Iih+G92NnU82aW02kYCe71j0oyxHTgQ
	9RKJgWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	BC4u4kMXgqsj82rnt1WWfMQdBZRhFHWUCXgxhZ8RqcUt7jWj4F5BNdrnF04RaQ/K
	Mi1ukocEUzAgvUr/JhD1CN1vPSLaGd/5tRWQaM/B1EPBqrcz7OpV014C+VaRfjGq
	+bXbZj14fs5/0auKzblhmzxDQvqhMGN/dWIR5pXiBlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D01C22A0C2;
	Fri, 21 Jun 2013 18:49:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BFC62A0BF;
	Fri, 21 Jun 2013 18:49:47 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-691-gcbc83f4
In-Reply-To: <1371840579-20161-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 586C49F8-DAA3-11E2-AA7C-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228650>

The "--date-order" output is a slight twist of "--topo-order" in
that commits from parallel histories are shown in their committer
date order without an attempt to clump commits from a single line
of history together like --topo-order does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6003-rev-list-topo-order.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index bb66b8b..0e3b7e1 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -100,6 +100,28 @@ l0
 root
 EOF
 
+test_output_expect_success 'simple date order' 'git rev-list --date-order  HEAD' <<EOF
+l5
+l4
+l3
+a4
+b4
+a3
+a2
+c3
+c2
+b3
+b2
+c1
+b1
+a1
+a0
+l2
+l1
+l0
+root
+EOF
+
 test_output_expect_success 'two diamonds topo order (g6)' 'git rev-list --topo-order  g4' <<EOF
 g4
 h2
-- 
1.8.3.1-682-g924db96
