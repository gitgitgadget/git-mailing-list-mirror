From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/10] t9401: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:07 -0800
Message-ID: <1357368788-28035-10-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdu-0001Cn-7a
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab3AEGxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab3AEGx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB0F08D0F
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uKf8
	o8aWbtYv18erdmogqGvy4/E=; b=ec4lYxJn3Ak0GgSTkRAOxmhsfv4gl00H8DRZ
	QyvwSv27l+yLviGty1CG5Q/u93whERvDRJBroChTi3go41O/3tTcycBJoxf63nAA
	hCxMTAm/gawaZ4JTxTEB8JShRhb93SLjh7lp0nJP07bHWnIFlwT6OqSa35df8+qX
	HrG5uCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IpnkOy
	L8aXGG+KkqT7xkgTzbTJHBhAc9tYuSEp2bQh3t+zCbw7tmxukYBRpgXmlqxh9MLJ
	toyzBkSvtPvJhZbnJnXq0IPA9/AvX886gS/1owroXZHcbRYAlj2gd/XC5dbEe7gv
	Hl+bfchJ1lFp7D4dkZraMMqJaqOViQ4ys+VNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CABB8D0E
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E4988D0C for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:27 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9B5374D0-5704-11E2-8DA5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212675>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9401-git-cvsserver-crlf.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 1c5bc84..8c3db76 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -84,6 +84,7 @@ export CVSROOT CVS_SERVER
 
 rm -rf "$CVSWORK" "$SERVERDIR"
 test_expect_success 'setup' '
+    git config push.default matching &&
     echo "Simple text file" >textfile.c &&
     echo "File with embedded NUL: Q <- there" | q_to_nul > binfile.bin &&
     mkdir subdir &&
-- 
1.8.1.299.gc73b41f
