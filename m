From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 01/17] Makefile: A variable for options used by xgettext(1) calls
Date: Mon, 30 Aug 2010 21:28:07 +0000
Message-ID: <1283203703-26923-2-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:29:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBuT-0008Ah-9L
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0H3V2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:28:49 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:47033 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab0H3V2r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:28:47 -0400
Received: by wwi14 with SMTP id 14so307664wwi.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5/iOeorOdna9mYmcl8z07nkzcaF8TCfn6w6wjNhAqaU=;
        b=Q2nfvxvoAtIYsI2TeYiBSPKBQV6LYX1pMXfSuYA/nyP1yR3KiLVGptWnKEDCi5CaUR
         f9njDhm/H3NaXOl3NPh5zpSQMc0UUuB3JfhbMHcUkvGQO96sPio3Y/rUlc+WM+5LdYts
         k64Nl57NGZMoNV/VdnDlY+OsjXXxbFv2qVib0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dSNkQYfs4D1k/6sTDNO8iFYVXjgwTlPJPMAgkEjsvNy8Jaa9OR6j1ZborXamx4UUlP
         Zk6XA5Nykv23izG+FP+9+k70K5QNVm+R9HBi0M9xSptSDCEqHVit32233lsGme6TJudx
         UJN+K9bBvyg5TfMVBzK+c7PiRxUNYHLvv1Kag=
Received: by 10.227.153.211 with SMTP id l19mr5222100wbw.224.1283203716108;
        Mon, 30 Aug 2010 14:28:36 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154851>

Change the Makefile code to use a variable for the options that all
the xgettext(1) invocations are using. This makes it more readable,
and makes it easier to add more standard options.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 62d526a..6a5bcf5 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,10 +2008,11 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
+XGETTEXT_OPTIONS =3D --add-comments
 pot:
-	$(XGETTEXT) --add-comments --keyword=3D_ --keyword=3DN_ --output=3Dpo=
/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
-	$(XGETTEXT) --add-comments --join-existing --output=3Dpo/git.pot --la=
nguage=3DShell $(SCRIPT_SH) t/t0200/test.sh
-	$(XGETTEXT) --add-comments --join-existing --keyword=3D__ --output=3D=
po/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/test.perl
+	$(XGETTEXT) $(XGETTEXT_OPTIONS) --keyword=3D_ --keyword=3DN_ --output=
=3Dpo/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
+	$(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --output=3Dpo/git.pot=
 --language=3DShell $(SCRIPT_SH) t/t0200/test.sh
+	$(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --keyword=3D__ --outp=
ut=3Dpo/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/test.perl
=20
 POFILES :=3D $(wildcard po/*.po)
 MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
--=20
1.7.2.2.536.g3f548
