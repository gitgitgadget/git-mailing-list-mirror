From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] verify_signed_buffer: fix stale comment
Date: Wed,  4 Jan 2012 14:10:56 -0800
Message-ID: <1325715058-11984-2-git-send-email-gitster@pobox.com>
References: <1325715058-11984-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 23:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZ39-0000SF-5m
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119Ab2ADWLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:11:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55683 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086Ab2ADWLC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:11:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E45216795
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bMnH
	LTVswJqZsf+KarunnjUBKjk=; b=X95WL9/315rXC315MffHrFlHOOuf9lQy4bQc
	4GmrfE4Iu830C3d/IC0mtDonel2gdamebhA2GM4wuNgV77x6KdvgmT7RiQIHL8xl
	Lqk6SfRfiR+eVBqvAZw0mVsHWpL1Kfbd7thC1UYU95BQcIQSMeJQ17X3G4VbUvjo
	40ry5VM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EFq7o4
	aDKGYE9Opn1uLawWCWdDUqUZ44Q9Ez5GsmQhnHk+O4nUnio9B/+ILlrUCrpZ/sL7
	zKlaDGQeQ2w+wAGbeP85VaM41VYj0ejMjpYtdu10izL9ysoJ9Z/FhLjpCp1AcX9g
	OipBHbpVIkGjhojpMV0k/Nz9pbW99aHB7YwH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3A36794
	for <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72E9E6793 for
 <git@vger.kernel.org>; Wed,  4 Jan 2012 17:11:01 -0500 (EST)
X-Mailer: git-send-email 1.7.8.2.340.gd18f0f
In-Reply-To: <1325715058-11984-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FCA22EAC-3720-11E1-8CB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187945>

The function used to take an integer flag to specify where the output
should go, but these days we supply a strbuf to receive it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gpg-interface.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 18630ff..09ab64a 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -95,10 +95,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 
 /*
  * Run "gpg" to see if the payload matches the detached signature.
- * gpg_output_to tells where the output from "gpg" should go:
- *   < 0: /dev/null
- *   = 0: standard error of the calling process
- *   > 0: the specified file descriptor
+ * gpg_output, when set, receives the diagnostic output from GPG.
  */
 int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
-- 
1.7.8.2.340.gd18f0f
