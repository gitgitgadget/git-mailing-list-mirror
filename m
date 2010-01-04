From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] t7002: add tests for skip-worktree fixes in commit a67e281
Date: Mon,  4 Jan 2010 19:34:15 +0700
Message-ID: <1262608455-4045-2-git-send-email-pclouds@gmail.com>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 13:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRm9f-0005kq-Jc
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 13:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab0ADMfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 07:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833Ab0ADMfT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 07:35:19 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:49727 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab0ADMfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 07:35:17 -0500
Received: by mail-yx0-f188.google.com with SMTP id 26so14477660yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ayUFlb3J4uDZIJrMB/ODNhasFho3GMmQO5mpBHwG5PM=;
        b=NVWsu35ALQCcSanKeO1i0T0tRPqpy0kohc/sJD+UHSJV/Qqscq8vnXk1nVFSwz0wor
         94TIuajh0/Zy02uzykLW7ZlvC7Jfk1NzlFB75hJJkKoDldCav0b2n1Y+aQRZV5smJHUk
         wjl8S6qI4Eu+mrLg+gK2obvxZmyrJI3c4SFYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Z8Qcl1sLhhXw95G5KRQvR8CSC3o4A+pQx3GTXak93f1nMIBw6Wtb0FEWe5qGeKkO7j
         cMW52vS92YisahBpGcq6HNqCAArdKn0uwAvOtjoDUH/2GVgUnyxZfDjJk3RZ1Kmt4P4v
         FBjrnXb9h45f8dxWuusGDl49WvxgKAcbya+RA=
Received: by 10.90.201.9 with SMTP id y9mr2917582agf.33.1262608513965;
        Mon, 04 Jan 2010 04:35:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 16sm9015131gxk.15.2010.01.04.04.35.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 04:35:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  4 Jan 2010 19:34:25 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
In-Reply-To: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136110>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c  |    1 +
 t/t7002-grep.sh |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index f093b60..59c4b12 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -222,6 +222,7 @@ static int exec_grep(int argc, const char **argv)
 	int status;
=20
 	argv[argc] =3D NULL;
+	trace_argv_printf(argv, "trace: grep:");
 	pid =3D fork();
 	if (pid < 0)
 		return pid;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index ffda0df..ac0a658 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -438,4 +438,16 @@ test_expect_success 'grep -Fi' '
 	test_cmp expected actual
 '
=20
+test_expect_success external-grep 'external grep is called' '
+	GIT_TRACE=3D2 git grep foo >/dev/null 2>actual &&
+	grep "trace: grep:.*foo" actual >/dev/null
+'
+
+test_expect_success external-grep 'no external grep when skip-worktree=
 entries exist' '
+	git update-index --skip-worktree file &&
+	GIT_TRACE=3D2 git grep foo >/dev/null 2>actual &&
+	! grep "trace: grep:" actual >/dev/null &&
+	git update-index --no-skip-worktree file
+'
+
 test_done
--=20
1.6.6.315.g1a406
