From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/10] t9400: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:06 -0800
Message-ID: <1357368788-28035-9-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdu-0001Cn-OR
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab3AEGxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3AEGx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF9E58D00
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UYXh
	yo7MhTpzuJ48YKsY5vpsAAk=; b=lDffgANIVt/ubwFH5Ckjh4FJkVa3YzR5GBRK
	Eqce+SvZNmg521xCz+GMHPOolLT8Kdb903nO/YgcBzFlGxU2qJvgP4ZmMq9ba+Cd
	huSFwjcQE3cvqDlw91PLeuV1hMphSt6YH03JEvm5ZfOkbRKzv7SidZS7Cy/Qk2zn
	FqiaX7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=toNdlQ
	3/M/cnhkVRvRhB7xPz9q3wKUH8Z1KtvUMoIgIRQmn+uUu36m3NpIM1KD0IOHUicp
	V/eRnLrmFQ5C47z6Nyq0t9sOT1vM5wEOHKKYXaMvhuFLe1Z47gXRFC5uqi8hhzlJ
	rU0jwqO+5soWMc54yr2dlz5I9/3LlmXhRRUMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1A818CFF
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56DAC8CFE for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:25 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9A3BB206-5704-11E2-B745-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212677>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9400-git-cvsserver-server.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9502f24..0431386 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -36,6 +36,7 @@ export CVSROOT CVS_SERVER
 
 rm -rf "$CVSWORK" "$SERVERDIR"
 test_expect_success 'setup' '
+  git config push.default matching &&
   echo >empty &&
   git add empty &&
   git commit -q -m "First Commit" &&
-- 
1.8.1.299.gc73b41f
