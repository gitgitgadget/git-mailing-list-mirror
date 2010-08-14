From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] log: test for regression introduced in v1.7.2-rc0~103^2~2
Date: Sat, 14 Aug 2010 01:10:47 +0000
Message-ID: <1281748247-8180-1-git-send-email-avarab@gmail.com>
References: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 03:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok5HG-0001uf-2Y
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 03:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697Ab0HNBK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 21:10:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33644 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625Ab0HNBKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 21:10:55 -0400
Received: by wwj40 with SMTP id 40so3689180wwj.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vuG3MVrm8/BS8wgjWuHfaH7mMx6OVdnfZcZw2RHQtFs=;
        b=ld+1bS9IvBSCXrnuqvpJSkSU0YlloITwkf6887GAyTQw1lF5MElTC/Wr63YJLkFtSw
         szvc9P4tykIhgQLKTtDnf0SD17rxB2PP+RHOb9YGivMGJdVMiKlSrH1RXoWHqfgEPg01
         fJc2EQH8UESfb2YNqTiv6Xzl2Ua67Www/WXLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G1xFdj4jPc/cggBQcA7UbzQY6mw9VgCdjzso+ph+ShYpISupc55KEkfgyILeTAbR5v
         +Lw7o8i394AOyHyVDD9YhcYdJt9B6veWjwQ9XVvElWw9TVdWkSfnRorFJzqEViNZTI+8
         oZxnbnaTD40SKVvldIkZaJWLzPm3ahFZ3Trpw=
Received: by 10.216.23.206 with SMTP id v56mr146188wev.67.1281748254539;
        Fri, 13 Aug 2010 18:10:54 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id n40sm1930469weq.5.2010.08.13.18.10.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 18:10:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.ge1a5e
In-Reply-To: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153539>

Add a regression test for the git log -M --follow --name-only bug
introduced in v1.7.2-rc0~103^2~2

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4202-log.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 95ac3f8..ff624f4 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -441,5 +441,14 @@ test_expect_success 'log.decorate configuration' '
=20
 '
=20
+test_expect_success 'Regression test for v1.7.2-rc0~103^2~2' '
+	# Needs an unrelated root commit
+	test_commit README &&
+	>Foo.bar &&
+	git add Foo.bar &&
+	git commit --allow-empty-message </dev/null &&
+	git log -M --follow --name-only Foo.bar
+'
+
 test_done
=20
--=20
1.7.2.1.338.ge1a5e
