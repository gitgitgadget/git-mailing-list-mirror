From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/10] t7406: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:05 -0800
Message-ID: <1357368788-28035-8-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdZ-0000vb-JH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268Ab3AEGx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab3AEGxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F8708CFD
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Oc23
	o8AIjWZWamdzVFm+IWbQAJc=; b=f7YZnkQdlX8CPVFkQrjh1m3QTIR3J+wbhXzO
	omYGdCqaOumz3A9+w+qdRqFi2Ik/EixUbOFm/NlvhPh9J83Ri3ALxP/T2nkOLeVF
	nPVwM8++2LDg1/06SdCeHXp/Ml46/kB4S+HV5YY/SLQqjnx2fpyWbhicjzLqMsEI
	+4SD2T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dRwbUV
	3tBztir43C80X8UhN0uV1fDHNmIReiticW+lhV+T9gJpUKAF4LmDplTxKpTK/SNL
	frkdic6RfmaF5taEUVKwqMLrNf6HOfv84+rjpvlqzuHgHcXVsJRnYOTfREJEb7EG
	cwGHbpsv6e08Ju5pQM4xj2UR+nv5ZTXhFC7so=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 001AE8CE8
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73C558CE6 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:23 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 991CA11E-5704-11E2-ADE2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212674>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7406-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index feaec6c..c675ce6 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -565,14 +565,14 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir recur
 	   git log > ../../../expected
 	  ) &&
 	  git commit -m "added subsubmodule" &&
-	  git push
+	  git push origin :
 	 ) &&
 	 (cd .git/modules/deeper/submodule/modules/subsubmodule &&
 	  git log > ../../../../../actual
 	 ) &&
 	 git add deeper/submodule &&
 	 git commit -m "update submodule" &&
-	 git push &&
+	 git push origin : &&
 	 test_cmp actual expected
 	)
 '
-- 
1.8.1.299.gc73b41f
