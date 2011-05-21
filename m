From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/12] convert: CRLF_INPUT is a no-op in the output
 codepath
Date: Fri, 20 May 2011 23:56:31 -0700
Message-ID: <1305960995-25738-9-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg8E-0006ID-T3
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab1EUG5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab1EUG5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACAC05DCA
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SdB6
	ibvRbOK2DZQJvs7P7Q93+dk=; b=e2owpQ0nNObWAsIBclfQojH5n2UILOXi7Z/A
	UYiyWPkFKj3d6x4VylgPjVqc9kBbeulImm2oYSh8MPA9kGv+TlxUMuUIQizaheXK
	C2Tj148qVSNM+eUGX+990IJLTo9zCGudYc1D1IF5G6zuwZpW6XTY+pnd4MdFgvkS
	dL3MSZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AnnNXP
	HTaIOqeTZ/y1m7lxEETcM5uKzYLRQP3Me0LKpWrT2IQgfCVkjOJbVGRfe3jx7Eyx
	nL9IZkXJ4pn+hBoGQbNSrFT6bUg9JNaDhqEbfvPNjFsv7h1EPh1wRmymjpnQArgD
	9pAEZT6wY/WTT5B/tkO7KvAnBoJhREPlhZj/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A96785DC9
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D49C35DC8 for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ECABD514-8377-11E0-A3A1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174103>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/convert.c b/convert.c
index d3c0041..264af1d 100644
--- a/convert.c
+++ b/convert.c
@@ -831,7 +831,7 @@ int can_bypass_conversion(const char *path)
 		return 0;
 
 	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
-	if ((crlf_action == CRLF_BINARY) ||
+	if ((crlf_action == CRLF_BINARY) || (crlf_action == CRLF_INPUT) ||
 	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
 		return 1;
 	return 0;
-- 
1.7.5.2.369.g8fc017
