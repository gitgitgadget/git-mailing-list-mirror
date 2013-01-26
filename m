From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v2 1/2] t9901-git-web--browse.sh: Use "write_script" helper
Date: Sat, 26 Jan 2013 04:40:32 +0400
Message-ID: <c4cde7280a34d1a636c2eb93cfec6ce2f4ac222f.1359160531.git.Alex.Crezoff@gmail.com>
References: <cover.1359160531.git.Alex.Crezoff@gmail.com>
Cc: Jeff King <peff@peff.net>, Alexey Shumkin <Alex.Crezoff@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tytpk-00013E-RP
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab3AZAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:40:59 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:51183 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3AZAk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 19:40:57 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so1645240lba.37
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 16:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Pi4kdKTnzzK2hRW2ahBgNf+IXiLOs14/pBaWLh5IT5Y=;
        b=wjLcHl8EBN4pWLEO5556yCKaLAVSUrjhg28wrBAIq/HrCOoCRiQeN/3HpXN6LRvU1n
         fATbX5+spPASgRFazaWMkJsbbY+027tjTnd6ZFGbVc2LHZfSt3N3Y5cGJm9EyQzDBLq6
         wsoIauoRx8kxb+uGWUk73c9GPv7vxSWS9BA2NOeSyCKmxbob5ueqD0B1ILl7Fpu7DKO7
         qPPMPn0THaB2w6vM4Sim13aO9lP/D59rgIDUW0AIpSH9q2wzhmfSozw/FrU0yQekNZ5g
         Nofy8Jaze7M5Q6+gDmTMDH3AxaPPNjW8cdmC9SEvlrvYbQCQnx9A8ZoKJe7aEOcg0k2j
         NVvA==
X-Received: by 10.152.148.4 with SMTP id to4mr6622032lab.39.1359160855869;
        Fri, 25 Jan 2013 16:40:55 -0800 (PST)
Received: from ds212plus (ppp91-77-32-144.pppoe.mtu-net.ru. [91.77.32.144])
        by mx.google.com with ESMTPS id pz15sm1029924lab.3.2013.01.25.16.40.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 16:40:54 -0800 (PST)
Received: from localhost.localdomain (unknown [192.168.1.5])
	by ds212plus (Postfix) with ESMTPS id 94A3B6006E;
	Sat, 26 Jan 2013 04:41:38 +0400 (MSK)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.5/8.14.5) with ESMTP id r0Q0ef9v009999;
	Sat, 26 Jan 2013 04:40:41 +0400
Received: (from alex@localhost)
	by localhost.localdomain (8.14.5/8.14.5/Submit) id r0Q0efXW009998;
	Sat, 26 Jan 2013 04:40:41 +0400
X-Mailer: git-send-email 1.8.1.1.10.g71fa0b7
In-Reply-To: <cover.1359160531.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359160531.git.Alex.Crezoff@gmail.com>
References: <7v1ud93uw8.fsf@alter.siamese.dyndns.org> <cover.1359160531.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214603>

Use "write_script" helper as suggested by Junio C Hamano.
Also, replace `pwd` with $(pwd) call convention.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t9901-git-web--browse.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index b0a6bad..b0dabf7 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -38,12 +38,10 @@ test_expect_success \
 test_expect_success \
 	'browser paths are properly quoted' '
 	echo fake: http://example.com/foo >expect &&
-	cat >"fake browser" <<-\EOF &&
-	#!/bin/sh
+	write_script "fake browser" <<-\EOF &&
 	echo fake: "$@"
 	EOF
-	chmod +x "fake browser" &&
-	git config browser.w3m.path "`pwd`/fake browser" &&
+	git config browser.w3m.path "$(pwd)/fake browser" &&
 	test_web_browse w3m http://example.com/foo
 '
 
-- 
1.8.1.1.10.g71fa0b7
