From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/3] t1007-hash-object: add tests for verbose hash-object
Date: Mon,  2 Mar 2015 19:55:23 +0600
Message-ID: <1425304523-14425-1-git-send-email-kuleshovmail@gmail.com>
References: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 14:55:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSQoo-0005bZ-8M
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 14:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbbCBNza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 08:55:30 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:37036 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbCBNz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 08:55:29 -0500
Received: by lbvn10 with SMTP id n10so30088174lbv.4
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IalCycJ1rpkZGksbbexKpgyB7MnOkWET/bHd9RRrcLA=;
        b=Y7kRGXlY5ChF9erkPQzTQaR95ZOrddhEZQGt4rAwiSbeKv+/ev659ln2xp3b1orulx
         ewwObI9kMFfBckbUfwLeRIWDX3o1X0vIGlh34t3+bwakHD+JA9l/k2Bm/s39U7gsCN5a
         wFbb8z29CBjSejyhw3dwMrE2pzJ0Uxs5mUJKXIYWuqCVRvnOTcLai2AEOVjFE/llQoiu
         EmvSQEejvRkVe/CuxbIR1Z1S5iiP4wYFKPJL7Nylwo/pPpOtc7yN8VYRTKo8rxq/VRXz
         8YLDX82DNPMOhWEKVToWEwW7gPr9Voan+4xsZxYhsa1vLFeJWMxer27MN4IopVqKwggz
         ze/Q==
X-Received: by 10.112.219.196 with SMTP id pq4mr8576886lbc.104.1425304528292;
        Mon, 02 Mar 2015 05:55:28 -0800 (PST)
Received: from localhost.localdomain ([147.30.48.224])
        by mx.google.com with ESMTPSA id q7sm2554841lag.27.2015.03.02.05.55.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2015 05:55:27 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
In-Reply-To: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264596>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 t/t1007-hash-object.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f83df8e..fa957bf 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -201,4 +201,15 @@ test_expect_success 'corrupt tag' '
 	test_must_fail git hash-object -t tag --stdin </dev/null
 '
 
+filename="hello"
+hello_sha1_verbose="$hello_sha1\t$filename"
+
+test_expect_success 'hash-object verbose' '
+	test "$(echo $hello_sha1_verbose)" = "$(git hash-object -v $filename)"
+'
+
+test_expect_success "Can't use --verbose and --stdin together" '
+	echo example | test_must_fail git hash-object --verbose --stdin
+'
+
 test_done
-- 
2.3.1.167.g7f4ba4b.dirty
