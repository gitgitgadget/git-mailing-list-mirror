From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/17] send-pack: read list of refs with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:16 -0800
Message-ID: <1450303398-25900-16-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAr-0001KG-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967094AbbLPWDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967083AbbLPWDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C317B325ED;
	Wed, 16 Dec 2015 17:03:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+3Pi
	RoFToEtujOJFczeyIBBRTdU=; b=ZlBDW3H34HSMZJvrWopua11bnFLEApem0o9U
	pIKd4yAJaDeqtCSvcxDUQOioa+GwTrhepoUbCVB+TfEoI9QoQ36WibCun2LRw1D+
	B8rJjPMtbvwylpGYSco3sHWeZlshdj5kgPQf2PHxv7NTpL6EqOK6IzArScs1mI+X
	zCRPdxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Oqowef
	1iSkdisLmyciIwHQQDfYeklX+i56eF47EXbJWgFyHQh9TI2m4RU763kjY8TKNV8i
	FBJ1hHiEvZT//2J5Kh6uS3EaGdkbo/AZle8Drm/k7rjeygyAIRTx55thrxCHBVRP
	SwUNi0854JnQuWO+IV+F1L6jtxNKCf4EZAxFg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAE19325EC;
	Wed, 16 Dec 2015 17:03:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32E37325EA;
	Wed, 16 Dec 2015 17:03:44 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DFADC932-A440-11E5-B20F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282608>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f6e5d64..02e6e24 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -212,7 +212,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				argv_array_push(&all_refspecs, buf);
 		} else {
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_getline(&line, stdin, '\n') != EOF)
+			while (strbuf_getline_crlf(&line, stdin) != EOF)
 				argv_array_push(&all_refspecs, line.buf);
 			strbuf_release(&line);
 		}
-- 
2.7.0-rc1-83-ga8b6b9e
