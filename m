From: santiago@nyu.edu
Subject: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple tags
Date: Tue,  5 Apr 2016 12:07:25 -0400
Message-ID: <1459872449-7537-3-git-send-email-santiago@nyu.edu>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:07:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTWF-0000aC-E5
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457AbcDEQHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:07:44 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33794 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcDEQHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:43 -0400
Received: by mail-qg0-f67.google.com with SMTP id j35so1618524qge.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iGJLkb08EOCXIYpObJoXgLuQegeK+HDw479eBpgyyHg=;
        b=M4dvJROQx6NPQ/lJjSOi11GM5Dqbd4CZ7b33IE9U2ZsD7rD14+6CHP+4Hgd7q8p0Yq
         t/MkOIngtkVVySs0vQ17yLOBMQq0YtZvBh3cZZzD5KUbZpe3X9eEPfcy7HTTLfn02dkx
         +f1Qt+NCry4YsXHFuECNC0AR1qqqSSgSq7JTO3Fr19FaUWVfSPACRy2yPNz/qR8deOH6
         YdTwVHXHcx6SnRR3k/MPHyuSSol7ISa6zAMR0Y81rNipOs9N8CG49s1bALaPK15ltom6
         Lo5FAnl/Wo5GlL7h8gbi/nZOQxuLUrNilKSu9B5ErIomoIcs7cQXvS3rPzuQPuyRje7+
         Tpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iGJLkb08EOCXIYpObJoXgLuQegeK+HDw479eBpgyyHg=;
        b=nLPHTEyM3YbPDUjuK7tRlazHEWbXR6vcJzC0FVA3Oo+50LeIf2XoY2PmfFBkKWY2y/
         A9rUnDplCLv981SMNjkLl3dJ1p0i3yLbKH2FoDwOt4I7tbGOxWt+3t3REmjBUuhJ658z
         b9u351sgA2pL9oBbz7wMz06pdmztZnUbXktdZxN7U5tynv5JzQ1keGVOYsVPd6iXB66e
         3cwVWEUTlxxpnseRine+yS+28lV6bDrVqGrY4MOmfjsicft7LaC8JDdC/b+5YWtrjqa2
         NJxOagdMEPPHg1zwa1VlvKojF1ROHKH/AJYjZdRk3MVHHy7AP7LF1gvNRJnhaZOsSJGV
         orrg==
X-Gm-Message-State: AD7BkJIqRcpqV46tRaDEW5cRfqgcJIFKpgryUCbNmTxQhLPt4a89LqIpulWzm0/nKhpUBxse
X-Received: by 10.140.81.51 with SMTP id e48mr18784442qgd.27.1459872457000;
        Tue, 05 Apr 2016 09:07:37 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290794>

From: Santiago Torres <santiago@nyu.edu>

The verify-tag command supports multiple tag names as an argument.
However, existing tests only test for invocation with a single tag, so
we add a test invoking with multiple tags.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7030-verify-tag.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 4608e71..c01621a 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -112,4 +112,16 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
+test_expect_success GPG 'verify multiple tags' '
+	tags="fourth-signed sixth-signed seventh-signed" &&
+	for i in $tags; do
+		git verify-tag -v --raw $i || return 1
+	done >expect.stdout 2>expect.stderr.1 &&
+	grep "^.GNUPG" <expect.stderr.1 >expect.stderr &&
+	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+	grep "^.GNUPG" <actual.stderr.1 >actual.stderr &&
+	test_cmp expect.stdout actual.stdout &&
+	test_cmp expect.stderr actual.stderr
+'
+
 test_done
-- 
2.8.0
