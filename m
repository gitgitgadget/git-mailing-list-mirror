From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 6/7] gettext: Basic sanity tests for Git's Gettext support
Date: Tue,  1 Jun 2010 23:39:56 +0000
Message-ID: <1275435597-4017-7-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 01:40:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJb4j-0006At-T4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 01:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505Ab0FAXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 19:40:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47167 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab0FAXkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 19:40:25 -0400
Received: by fxm8 with SMTP id 8so1461102fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lftW5bg4crhDd/OhXaBSOxrmjqXBrbc48lpIXVTsm6g=;
        b=IgZ+YC/wWzRlWIi1ZsWg380FYDpfoI2YWBMQdE+foEuWeDluKtcPEGU6Zj8cv91D89
         hk1jdrBkMz1bED1mvpa1QNdxDGp1jgaYGuVP7vgg0k9XXLFi3jLKNxC0lmLTTzP8BXbW
         9BvhEprUlSKjEuvn65gK2EdQUzQpvJ8V4JYUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Pf3cG0/IwBlofjF+jfZfPdAMz0LgJ/IgFtX7YJ3wqS9wU1KNtqQOSwGUmSUmm/M5FK
         o/Ap0EliXU1iSDomf3EZP2p0KDuumM6oY6dLUvlx5ZvYfYxHxjJwN/ZUiwGlRtOsA9JY
         eDAKDhiw2DApXJQQFDXrfkKYpOvSKWwGCA974=
Received: by 10.223.15.216 with SMTP id l24mr7795951faa.92.1275435624079;
        Tue, 01 Jun 2010 16:40:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id z12sm49391227fah.9.2010.06.01.16.40.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 16:40:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.248.gb7713.dirty
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148169>

---
 t/t0200-gettext.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100755 t/t0200-gettext.sh

diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
new file mode 100755
index 0000000..a8f9edd
--- /dev/null
+++ b/t/t0200-gettext.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Gettext support for Git'
+. ./test-lib.sh
+. ../../git-sh-setup
+
+test_expect_success 'sanity: $TEXTDOMAIN is git' '
+	test $TEXTDOMAIN = "git"
+'
+
+test_expect_success 'sanity: $TEXTDOMAINDIR exists' '
+	test -d $TEXTDOMAINDIR 
+'
+
+test_expect_success 'sanity: Icelandic locale was compiled' '
+    test -f $TEXTDOMAINDIR/is/LC_MESSAGES/git.mo
+'
+
+test_expect_success 'sanity: gettext(unknown) is passed through' '
+    gettext "" > expect &&
+    > actual &&
+    test_cmp expect actual &&
+    printf "This is not a translation string"  > expect
+	gettext "This is not a translation string" > actual &&
+    test_cmp expect actual
+'
+
+test_done
-- 
1.7.1.248.gb7713.dirty
