From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/20] Makefile: MSGFMT="msgfmt --check" under GNU_GETTEXT
Date: Tue,  7 Sep 2010 16:47:41 +0000
Message-ID: <1283878065-19349-2-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:48:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1LA-0002l0-Po
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000Ab0IGQsF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55698 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757994Ab0IGQr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:47:59 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so4441328wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LlDo9SjFZASleBmC9cF3NlhzvBBDnY1GY557qZsKIAc=;
        b=V409MgzMVcMxzkBp4ImNUooxCEy2EL+zm2n+gUb6gfX0qO56N5Q/eB2Ntr/Jk6RC6x
         riow4qNECJ0uHluGoiBnRzrJHTXQsZkvOc6ESOXuWHvZNiwBYz2aAJrWRprR+kW75MGp
         1DyFvWZz0vNpy3vvFimbjWbMUlzscRDmUktwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wd8uxQzgIbqZLxvkkjI9LcmpsmCc254rcPt2kKoPL7fl/wb+Q0SrU/hMhrOf+pUreE
         Tmq9s3Iby7FcrdThzOmT9tpoYfHR7OH2GH4gLFxrvBlge4OaogUZ8pnLjMIripLWDU5S
         bDMJcsdIw1DtLK//nvKVhRMc1WeCCBC3rghLk=
Received: by 10.227.72.213 with SMTP id n21mr103512wbj.66.1283878078915;
        Tue, 07 Sep 2010 09:47:58 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5895402wbe.23.2010.09.07.09.47.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:47:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155714>

GNU msgfmt(1) supports the --check parameter which does various sanity
checks on the translated strings we're processing, including checks
that the printf(3) format of "c-format" translations matches the
original. I.e. that a "%s" isn't missing, or that there aren't
spurious or missing newlines in the translation.

Since Solaris msgfmt(1) doesn't support --check we have to wrap this
in `ifdef GNU_GETTEXT'.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3fe2e47..38ae13f 100644
--- a/Makefile
+++ b/Makefile
@@ -1523,6 +1523,10 @@ ifdef NEEDS_LIBINTL
 	EXTLIBS +=3D -lintl
 endif
=20
+ifdef GNU_GETTEXT
+	MSGFMT +=3D --check
+endif
+
 ifdef GETTEXT_POISON
 	COMPAT_CFLAGS +=3D -DGETTEXT_POISON
 endif
--=20
1.7.2.3.313.gcd15
