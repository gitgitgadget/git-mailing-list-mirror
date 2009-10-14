From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/5] Introduce new pretty formats %g and %G for
 reflog information
Date: Wed, 14 Oct 2009 02:13:29 -0700
Message-ID: <7vd44qfidi.fsf@alter.siamese.dyndns.org>
References: <cover.1255380039.git.trast@student.ethz.ch>
 <e0321a8af8d702d24ace33510daff22d02f4e116.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jef Driesen <jefdriesen@hotmail.com>, Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:23:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxzwT-0004qZ-Nx
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757904AbZJNJO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbZJNJO1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:14:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbZJNJO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:14:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1408958DC6;
	Wed, 14 Oct 2009 05:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Q8aB23BqeWZDSkczaRJf9xT/bFg=; b=OeVkXDny64klkUe3ZItAMSz
	2TO0lnSNgHxBiqR61cfzRDp6Z8R/HuOp3M8ogzyHPoREgkGRF1nK8zaXnUMLG+Wq
	6+zAIm1jjXuTdli9SVl9xOTcMELqXu3kJ96LhTQ7bStRWJXQCnoyAsn+f9Xr2N1V
	0cFjVKI+Q/htQ0rusre8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TeAoaYoYyiaEVJQAtwcnDp97HKVxgMD3bUfwDro7S3pqyGrWb
	UwBtrrIe58VjJL+rM5pEcGDDCVluT//zSJKy9RQL20OJQmH1eCwX5UdV23bqvee7
	pQ5Tfv+i7tqBhmsmfTDynhiGSYyrl4BYWRaRGL+q1ozeoEocUwuVEqZ8QU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6E0B58DC5;
	Wed, 14 Oct 2009 05:13:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB88558DC4; Wed, 14 Oct
 2009 05:13:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DACE231C-B8A1-11DE-BA15-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130272>

Squash this patch on top, as

    cc1: warnings being treated as errors
    reflog-walk.c: In function 'get_reflog_message':
    reflog-walk.c:278: error: ISO C90 forbids mixed declarations and code

---

 reflog-walk.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 929f025..5cbcb1a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -270,12 +270,13 @@ void get_reflog_message(struct strbuf *sb,
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
 	struct reflog_info *info;
+	size_t len;
 
 	if (!commit_reflog)
 		return;
 
 	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
-	size_t len = strlen(info->message);
+	len = strlen(info->message);
 	if (len > 0)
 		len--;
 	strbuf_add(sb, info->message, len);
