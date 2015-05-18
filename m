From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] subdirectory tests: code cleanup, uncomment test
Date: Mon, 18 May 2015 14:10:26 -0700
Message-ID: <1431983426-4346-1-git-send-email-sbeller@google.com>
References: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
Cc: Johannes.Schindelin@gmx.de, Jens.Lehmann@web.de,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 18 23:10:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuSJ7-0004oi-No
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbbERVKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 17:10:36 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:32820 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbERVKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:10:34 -0400
Received: by igbpi8 with SMTP id pi8so90844420igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBE+cT5QRrhOMSXe+gVubA/lj/IOJcPd0qr4AlM6kSw=;
        b=nijjvUe+Q5grPNqxMcfTD+sD6AVQs5BHVISvR1BhJpuX3k6exYUH45ft7GBB8HF9Q+
         EX0FBsLYzgF77vZhBpN9SK1163Q2zvT9iAvv6VPpgHoeOwh7tL6T3UZdzCJx+WLNheS0
         Bne04MWSN+1yBINx+lxjDh092vAuThScdhpe8I+yqpNizGbOypRby8nDgQ4+3P34dncl
         ljOEGlTO994ob4xlXBsz4TMxI2qV3B7eBQGYE8JrmnrMnwYiJkm5ZAUEJfeaArbKklVa
         63vOHzPzg6npGl6KATnzBSRHVCsWTu6N9mjWYi1l0y7RgyC7Wf+ncodKzekEhgiMARhv
         7uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gBE+cT5QRrhOMSXe+gVubA/lj/IOJcPd0qr4AlM6kSw=;
        b=FCer7M6AAexS+aUXGdA2SJMd5eIr5i0g+eOxXAYJkCgzcc7j9DAipCK6eqoJplgd5t
         edJ/njSwtl87U6e7jtlp8vi3golz/GzEuzTUM6hPIieI6s8KhrGOOjVT/9+IyKS6agzh
         eqkiDVu1//vpaSqqdE7c7hl4LjDNNFqaGRXdfvwkDxtBKJFGtoQjHnNVuqwgrPPCvATZ
         6bBPrTLeSSUR1xwaiBGlm9DBswUNyXO39RqlCQsbPKQYZPCKmmyXaN85vVMmrS9Y2gY2
         IsSJwUg5cfqYYVaKCCzxRHP+IqtSben9YEhXwhQ4ysO2DwG4qNlQA+no9GbA8V9Z84me
         2LcQ==
X-Gm-Message-State: ALoCoQn6b+ijgKtj7zM6ykhRN0mIRuxYfVD5QxI0S+PXXDCE3AJ/Ms1Q/i4HITqfb3YNtRabdCx2
X-Received: by 10.42.185.12 with SMTP id cm12mr32369431icb.0.1431983434045;
        Mon, 18 May 2015 14:10:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8c3b:902d:86de:4470])
        by mx.google.com with ESMTPSA id c20sm8468482ioc.40.2015.05.18.14.10.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 14:10:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.194.gc518059
In-Reply-To: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269320>

Originally the test in t1020 was meant to not include setting the GIT_DIR
when testing inside a bare repository as it did not work without setting
GIT_DIR explicitly.

Nowadays the test as originally intended works, so add it to the test
suite. We'll keep the test, which has been run through all years as another
test for finding regressions.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio, thanks for providing the context!

I tried tracking down when this changes via bisect, though I messed up.
By looking through the code I find these commits most promising to have
fixed the underlying issue (I am no expert on subdirectory treatment)
337e51c (Use git_config_early() instead of git_config() during repo setup, 2010-11-26)
72183cb (Fix gitdir detection when in subdir of gitdir, 2009-01-16)
9951d3b (setup: clean up setup_discovered_git_dir(), 2010-11-26)


 t/t1020-subdirectory.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 2edb4f2..022641d 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -162,16 +162,20 @@ test_expect_success 'no file/rev ambiguity check inside .git' '
 	)
 '
 
-test_expect_success 'no file/rev ambiguity check inside a bare repo' '
+test_expect_success '(historic) no file/rev ambiguity check inside a bare repo' '
+	test_when_finished "rm -fr foo.git" &&
 	git clone -s --bare .git foo.git &&
 	(
 		cd foo.git &&
+		# older Git needed help by exporting GIT_DIR=.
+		# to realize that it is inside a bare repository.
+		# We keep this test around for regression testing.
 		GIT_DIR=. git show -s HEAD
 	)
 '
 
-# This still does not work as it should...
-: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
+test_expect_success 'no file/rev ambiguity check inside a bare repo' '
+	test_when_finished "rm -fr foo.git" &&
 	git clone -s --bare .git foo.git &&
 	(
 		cd foo.git &&
@@ -180,7 +184,6 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 '
 
 test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
-	rm -fr foo.git &&
 	git clone -s .git another &&
 	ln -s another yetanother &&
 	(
-- 
2.4.0.194.gc518059
