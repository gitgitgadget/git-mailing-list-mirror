From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v5 4/6] Makefile: update to new command-list.txt format
Date: Sat,  9 May 2015 19:17:34 +0200
Message-ID: <1431191856-10949-5-git-send-email-sebastien.guimmara@gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 19:18:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr8Ok-0000dq-CN
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 19:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbbEIRSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2015 13:18:42 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35188 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbEIRSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 13:18:41 -0400
Received: by wgyo15 with SMTP id o15so96431726wgy.2
        for <git@vger.kernel.org>; Sat, 09 May 2015 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1vDc05aneaIqqVMK/Vsimp6uJQV51sRWPkPVKT8EpHM=;
        b=U9K1uX5zQRaJ/GE1IA+u2Nh+ereOmiOfNXzVe0ZnnhtTq5W9YSGAoz201mguY3cgMJ
         zyS7Q84HE3SgsClmzSY5n/VKVR8Ls4mWCR3NVBubidG17axmw99PA5bWERcahfe+OTQi
         TLjctpi//dhiWmPRpMAk5HyuD6f8F9ICFIboF49CsjmjwePkmRafHGR4/mKKAuufAh+r
         XIZVPsbN4d7A0X7Xis+KEEU6g79JoL6TfxhJ6zlH1+8riXJGoieTWKMR9WT+xeCMq/S6
         cOD+tdPMAwor25yBFKy6eKR9/xHtHX8XVonmg/78wlijANRN0dTsOKq14sJ++RgXTAIo
         mlSA==
X-Received: by 10.194.134.40 with SMTP id ph8mr6314377wjb.147.1431191920232;
        Sat, 09 May 2015 10:18:40 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fo7sm4710675wic.1.2015.05.09.10.18.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 10:18:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268705>

* In target common-cmds.h:
  The AWK script 'generate-cmdlist.awk' replaces 'generate-cmdlist.sh'

* In target check-docs:
  command-list.txt now contains common commands group in
  the header [common]. sed ignore all lines in command-list.txt
  until the [commands] list to correctly checks for missing
  documentation on Git commands.

=46or the target common-cmds.h part:
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

=46or the target check-docs part:
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 5f3987f..9f333e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1687,10 +1687,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
=20
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: generate-cmdlist.awk command-list.txt
=20
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)awk -f generate-cmdlist.awk command-list.txt > $@+ && mv =
$@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)=
:\
@@ -2447,7 +2447,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '/^#/d' command-list.txt | \
+		sed -e '1,/^\[commands\]/d' <command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -2455,7 +2455,7 @@ check-docs::
 		esac ; \
 	done; \
 	( \
-		sed -e '/^#/d' \
+		sed -e '1,/^\[commands\]/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
--=20
2.4.0
