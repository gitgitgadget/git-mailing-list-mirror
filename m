From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH sd/format-patch-to] format-patch: add tests for format.to and --to=
Date: Fri,  5 Mar 2010 00:57:35 -0800
Message-ID: <1267779455-7811-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Drake <sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 09:57:52 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnTLt-0002lX-I4
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 09:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab0CEI5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 03:57:41 -0500
Received: from mail-yx0-f185.google.com ([209.85.210.185]:63832 "EHLO
	mail-yx0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab0CEI5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 03:57:40 -0500
Received: by yxe15 with SMTP id 15so1983663yxe.25
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 00:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FpVTLommQa5/6MF1C0mOqG7AyKLQpGNSyCAYM2il8Ww=;
        b=NL6MdpzbRlI9XMAZYGJqZfdXslYPJojNK3kt57J5799koL+4GmZxREQ0TObL/KZlBo
         qNHBEjleyiHiEQLSMq6QFnPDlpPuWubblGKznoIplS8NeHXq4B8EMsdEpjcNWyhN8vXY
         Q7RoVHSTmopU1Xegw9Sgo6fHrtI5RYH9Tr5jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GLhZ5PgflaaTlO/Bi4nTHYkpZ9mre8QXZjt8cudrB7VeywLJ6sNhZmhG29KXZPfW/q
         CHyPM33FRbjGhMeObRvCjcLn779Bovr5pQ95yGj7ZOoLB5XZXiXs1CCK/uCYH/233gra
         IGOsIi7SyWpwPTNZYH+cFRiJLYjXC3+ECFzFo=
Received: by 10.101.64.18 with SMTP id r18mr1054921ank.24.1267779458795;
        Fri, 05 Mar 2010 00:57:38 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm494504ywh.47.2010.03.05.00.57.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 00:57:37 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.164.gbe2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141565>

Cc: Steven Drake <sdrake@xnet.co.nz>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Squash away.

 t/t4014-format-patch.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f2a2aaa..830ddb0 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -143,6 +143,20 @@ test_expect_success 'configuration headers and command line headers' '
 	grep "^ *S. E. Cipient <scipient@example.com>\$" patch7
 '
 
+test_expect_success 'command line To: header' '
+
+	git config --unset-all format.headers &&
+	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>\$" patch8
+'
+
+test_expect_success 'configuration To: header' '
+
+	git config format.to "R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>\$" patch9
+'
+
 test_expect_success 'multiple files' '
 
 	rm -rf patches/ &&
-- 
1.7.0.1.164.gbe2f
