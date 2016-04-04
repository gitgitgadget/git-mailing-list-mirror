From: santiago@nyu.edu
Subject: [PATCH v4 2/6] t/t7030-verify-tag.sh: Adds validation for multiple tags
Date: Mon,  4 Apr 2016 18:22:11 -0400
Message-ID: <1459808535-8895-3-git-send-email-santiago@nyu.edu>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtG-0007cZ-C3
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461AbcDDWW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:28 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33011 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbcDDWW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:27 -0400
Received: by mail-qg0-f47.google.com with SMTP id j35so165058636qge.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5L5DYomSG0tep6yTEoSh45Cl13NkDgxlOu6Wu+EBW/M=;
        b=h/pttWYyunkM/N/dIMpB4jyjfTkV0OMmZhpJZVYVWqQEpS5iayq+bzXTr8nL9Q5Y9E
         kCSbznURJP5n6Kdozs8lAtO5Y/jxJ7vVlrE17ylzzUqBvUHIPvGu8+zDmymAmPor3/SY
         yQsIzz7GuSIIrHW58r9qDtkhWWZbMIsgd1BBFAJMJlDdMlIbD0KFyz6VXlxFb8pNFrf+
         qu440cnR7r066fLIQDPikBS121Fe5x5QKgube8LhThG0J4U6LQBqmX1EVm9VfNwH20Mo
         yu3eHjYfN5jh4oiUAUOY70GS2KvQnGN4brxa1fgtnANXjwgfh1GZB54oqsoYNbLeM8az
         hJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5L5DYomSG0tep6yTEoSh45Cl13NkDgxlOu6Wu+EBW/M=;
        b=SYwSAM9MGq/AWQI0uI2G6Y/GrWOJ6Cce4HP2Eytj5tfhfVfHcAUMI/8TNEAtPDSyRP
         ATq2NM0ANyzW/vmEgsKF+KY0s6ZRHP6SYFPUvG12658OuvX+cGsjEIaf7/34PTJD3zuC
         ydeOJCmPxTj3ypVrg3Z7WYifXvCmp05NDRsV/9fNT7IZmBaM+W6yrw9qui13yW+gco+C
         iqJWie3QXpRfJA/zE52Ojz+kvWR625uCVM2wHnALZZmfefKbVNU3K32anRNkWelbbGIz
         V8OnymqKNiAB2k591xl75wU36TnU6HsFrX+oBMFtjmXHbi37Z2IHAuDLbjvYYCR5xHll
         GB1Q==
X-Gm-Message-State: AD7BkJK6x1U/7MfrutupI8Ioni0oBt4u2SwvqQ7HQDBq1npIlpmf/AX861JJ8PKXkJBO7gJo
X-Received: by 10.140.20.197 with SMTP id 63mr42422125qgj.18.1459808545876;
        Mon, 04 Apr 2016 15:22:25 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:25 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290730>

From: Santiago Torres <santiago@nyu.edu>

The verify-tag command supports mutliple tag names as an argument.
However, no previous tests try to verify multiple tags at once. This
test runs the verify-tag command against three tags separately and then
compares the result against the invocation with the same three tags as
an argument. The results shouldn't differ.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
	Note: In this version we don't check or uniq for the verify output, but
instead compare against an invocation for each of the three tags indivdually.

 t/t7030-verify-tag.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 4608e71..f9161332 100755
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
+	grep GOODSIG <expect.stderr.1 >expect.stderr &&
+	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+	grep GOODSIG <actual.stderr.1 >actual.stderr &&
+	test_cmp expect.stdout actual.stdout &&
+	test_cmp expect.stderr actual.stderr
+'
+
 test_done
-- 
2.8.0
