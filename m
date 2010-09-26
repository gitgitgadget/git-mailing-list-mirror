From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 12/15] t7601 (merge-pull-config): add missing &&
Date: Sun, 26 Sep 2010 17:14:36 -0600
Message-ID: <1285542879-16381-13-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Py-0005ch-PS
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758377Ab0IZXNa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36429 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758272Ab0IZXN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:28 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1046760pzk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CLfVwqOpTqyboFS+H6ZD38nuFPTpJK2nq2WMFH6qOfk=;
        b=GeO0NAy6E9aTv9c8AEt7YzXZ05Ku1VbeXyz48WTpf9riz/SC0MXkTtXhGV1DuMccCV
         68JwRiZ+C7b4KlSy4mBIUtEctnAFnseEAFti4kXrSF11dhpkctazzQyEUmoZTJWR8m1M
         IsXWA3Z1lmGwmcsRWNA2Cb8nW9Q23Oxr0RgKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m8Ohve8qz+L4yWTpyuIIjDS/chB88Py9SyKB66iBBNvfOA+VatMrZa/imaAuqr17Id
         pLmsMY6dM5jSjLxV99Lih0UcWP+0KkjG92vH3DOji2wyTtQrLQbEpkah3CpBDibPzi3w
         xuw4kRvD8QXLsqqzg9Uc4Q3On5940HEus140E=
Received: by 10.114.113.14 with SMTP id l14mr7362808wac.9.1285542808454;
        Sun, 26 Sep 2010 16:13:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157278>

Also prefix several relevant git merge commands with 'test_must_fail' t=
o
keep the tests passing.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
index 7ba94ea..b44b293 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -114,13 +114,13 @@ test_expect_success 'setup conflicted merge' '
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
 	git reset --hard c5 &&
-	git merge -s resolve c6
+	test_must_fail git merge -s resolve c6 &&
 	resolve_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive c6
+	test_must_fail git merge -s recursive c6 &&
 	recursive_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive -s resolve c6
+	test_must_fail git merge -s recursive -s resolve c6 &&
 	auto_count=3D$(conflict_count) &&
 	test $auto_count =3D $recursive_count &&
 	test $auto_count !=3D $resolve_count
@@ -129,13 +129,13 @@ test_expect_success 'merge picks up the best resu=
lt' '
 test_expect_success 'merge picks up the best result (from config)' '
 	git config pull.twohead "recursive resolve" &&
 	git reset --hard c5 &&
-	git merge -s resolve c6
+	test_must_fail git merge -s resolve c6 &&
 	resolve_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive c6
+	test_must_fail git merge -s recursive c6 &&
 	recursive_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge c6
+	test_must_fail git merge c6 &&
 	auto_count=3D$(conflict_count) &&
 	test $auto_count =3D $recursive_count &&
 	test $auto_count !=3D $resolve_count
--=20
1.7.3.95.g14291
