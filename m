From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] Makefile: provide a --msgid-bugs-address to xgettext(1)
Date: Sat, 28 Aug 2010 17:54:22 +0000
Message-ID: <1283018063-4256-3-git-send-email-avarab@gmail.com>
References: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 28 19:54:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpPcE-0001Lz-OT
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 19:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0H1Rys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 13:54:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39604 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0H1Ryf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 13:54:35 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so5021859wyb.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qyqa7RtWlDXmDW8TPBkVqn/CR5RTyLRgf9c+37oILiA=;
        b=bYxgmHtAVgtdapScntItt6ptvHug4uRHmHxnXRH6WaJSRbr9cZPssSeG8iClf8uhxl
         rVClHYVKZIeQws0dQbTaIHt040agRx2lpSeQL7lr2+kkX0H7PP9HLDUexYdbNYgyenmb
         GrDhWEqAd7dSAi9+8QrifD/mqJof+vH2u23FM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=om7JI4Tv86rNh6Y7RwOBtBenHDO780lVCEDg/g/iFFBc4h0i70znJfKVUp9bsfkFED
         PLLYffRYw77bFMkiq06+5bmnxAWACKQGMrUSkWJo99UkZExSzCYfwbimyD+i5Q0pcEfw
         4q7gGG5Y2v+e90uMkRqNitBdW+km2C2K/NQYI=
Received: by 10.216.188.1 with SMTP id z1mr2631106wem.57.1283018074815;
        Sat, 28 Aug 2010 10:54:34 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id o15sm78280wer.39.2010.08.28.10.54.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 10:54:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.g82b8
In-Reply-To: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154650>

Change the invocations of xgettext to use the --msgid-bugs-address
option. This has the effect of adding a Report-Msgid-Bugs-To header to
the git.pot and the derived *.po files. Doing so is recommended by the
gettext manual.

If this isn't added the Report-Msgid-Bugs-To already in po/is.po will
be removed by msgmerge(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 62d526a..155b69b 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,10 +2008,11 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
+POT_BUGS =3D Git Mailing List <git@vger.kernel.org>
 pot:
-	$(XGETTEXT) --add-comments --keyword=3D_ --keyword=3DN_ --output=3Dpo=
/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
-	$(XGETTEXT) --add-comments --join-existing --output=3Dpo/git.pot --la=
nguage=3DShell $(SCRIPT_SH) t/t0200/test.sh
-	$(XGETTEXT) --add-comments --join-existing --keyword=3D__ --output=3D=
po/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/test.perl
+	$(XGETTEXT) --msgid-bugs-address=3D"$(POT_BUGS)" --add-comments --key=
word=3D_ --keyword=3DN_ --output=3Dpo/git.pot --language=3DC $(C_OBJ:o=3D=
c) t/t0200/test.c
+	$(XGETTEXT) --msgid-bugs-address=3D"$(POT_BUGS)" --add-comments --joi=
n-existing --output=3Dpo/git.pot --language=3DShell $(SCRIPT_SH) t/t020=
0/test.sh
+	$(XGETTEXT) --msgid-bugs-address=3D"$(POT_BUGS)" --add-comments --joi=
n-existing --keyword=3D__ --output=3Dpo/git.pot --language=3DPerl $(SCR=
IPT_PERL) t/t0200/test.perl
=20
 POFILES :=3D $(wildcard po/*.po)
 MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
--=20
1.7.2.2.513.g82b8
