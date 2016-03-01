From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Tue,  1 Mar 2016 11:49:56 +0100
Message-ID: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, luke@diamand.org, tboegi@web.de,
	Lars Schneider <lars.schneider@autodesk.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 11:50:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aahsc-0007lM-C0
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 11:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbcCAKuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 05:50:03 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37933 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbcCAKuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 05:50:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id l68so27477836wml.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 02:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WC5LmNHCZsG+izoTOtwdtifNfrPNpoYurdUNpKJxlzc=;
        b=RNscT2MUuzfKS3z8CXE0iTFBYR+8JJNpWsImxf02Czo4vfluXFzQdDp/0zNg7DNpAW
         Nykg24eDSbPeHkYxyW9+GPwINUCVatZ7gDob/b8VM7BIUx6+vlSnKFF+Hko6bf/X3FFe
         WdT2B+Ui5RsQW+B+NTFMHKDO3WJgl9J9m0cAyc/EbQD3TYBp7voalD3VEOMY4ShHonFT
         3mp2VFGFSzbOkLUFRPBW1xtoHqyo2SXp3OtP7MYppRc89QmXDrBHDTQ/FcSfU9zycjWw
         wsJ0n0hjscoNJm6Fl/B7sx81GxTTx8cRbDO5Jr3/ywBnx8ZEQbDyGoQuegnhcRVAJfxL
         IBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WC5LmNHCZsG+izoTOtwdtifNfrPNpoYurdUNpKJxlzc=;
        b=K5ehsMsP2HjNeLWJbcjOgMFPtQiO0mwPhzk/eHCBKrHaxRpO72vFtIVOoH/4aN+a2t
         8fH9LX7R0Po1rQI6TRhTEVTU+QtTLRWQnNewELyim4mWtidk/KTrhWAlCgwlJh2vveIC
         Z6QuDS4wtytQXnfjDp/NrX4LSfk+01m8VVfoOPzF4MCUTh7uDh3RF1jXVz2qLQIb1C48
         rstaRTbKYN0SjyvZjDOFOWO7pcw1flABj0dr1FMoU10m++SRkHczXikX30oGSOmLDGFE
         ssWUNwkmYM4HO1/ZmdFeiDDEWe2tUvcbppDHKqRMzXGc+PMUk9L9CrLiXMmm4ds1Lss6
         BuNg==
X-Gm-Message-State: AD7BkJJBshm5oOhb0f2/7GppUFj8Rm0yC5PtE0X3jD3bC8SmTyEhUXSPyflww1JNYuT+dA==
X-Received: by 10.28.4.210 with SMTP id 201mr2774442wme.51.1456829399133;
        Tue, 01 Mar 2016 02:49:59 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB539F.dip0.t-ipconnect.de. [93.219.83.159])
        by smtp.gmail.com with ESMTPSA id i5sm30216287wjx.15.2016.03.01.02.49.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 02:49:58 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288006>

From: Lars Schneider <lars.schneider@autodesk.com>

Map a P4 user to a specific name and email address in Git with the
"git-p4.mapUser" config. The config value must be a string adhering
to the format "p4user = First Lastname <email@address.com>".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

diff to v1:

* use '=' instead of '->' to mimic SVN user mapping format (thanks Eric)
* fix ASCII doc formatting (thanks Eric)
* fix broken && chain in test (thanks Eric)
* use more innocuous names for test users (thanks Luke and Torsten)
* make regex accept more blank characters

Cheers,
Lars


 Documentation/git-p4.txt   | 11 +++++++++
 git-p4.py                  |  9 +++++++
 t/t9828-git-p4-map-user.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 t/t9828-git-p4-map-user.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 738cfde..9f077fd 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -553,6 +553,17 @@ git-p4.keepEmptyCommits::
 	A changelist that contains only excluded files will be imported
 	as an empty commit if this boolean option is set to true.

+git-p4.mapUser::
+	Map a P4 user to a name and email address in Git. Use a string
+	with the following format to create a mapping:
++
+-------------
+git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
+-------------
++
+A mapping will override any user information from P4. Mappings for
+multiple P4 user can be defined.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index c33dece..bac341d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1160,6 +1160,15 @@ class P4UserMap:
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
             self.emails[output["Email"]] = output["User"]

+        mapUserConfigRegex = re.compile(r"^\s*(\S+)\s*=\s*(.+)\s*<(\S+)>\s*$", re.VERBOSE)
+        for mapUserConfig in gitConfigList("git-p4.mapUser"):
+            mapUser = mapUserConfigRegex.findall(mapUserConfig)
+            if mapUser and len(mapUser[0]) == 3:
+                user = mapUser[0][0]
+                fullname = mapUser[0][1]
+                email = mapUser[0][2]
+                self.users[user] = fullname + " <" + email + ">"
+                self.emails[email] = user

         s = ''
         for (key, val) in self.users.items():
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
new file mode 100755
index 0000000..e20395c
--- /dev/null
+++ b/t/t9828-git-p4-map-user.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='Clone repositories and map users'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo with different users' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+
+		>author.txt &&
+		p4 add author.txt &&
+		p4 submit -d "Add file author\\n" &&
+
+		P4USER=mmax &&
+		>max.txt &&
+		p4 add max.txt &&
+		p4 submit -d "Add file max" &&
+
+		P4USER=eri &&
+		>moritz.txt &&
+		p4 add moritz.txt &&
+		p4 submit -d "Add file moritz" &&
+
+		P4USER=no &&
+		>nobody.txt &&
+		p4 add nobody.txt &&
+		p4 submit -d "Add file nobody"
+	)
+'
+
+test_expect_success 'Clone repo root path with all history' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config --add git-p4.mapUser "mmax = Max Musterman   <max@example.com> "  &&
+		git config --add git-p4.mapUser "  eri=Erika Musterman <erika@example.com>" &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+			no <no@client>
+			Erika Musterman <erika@example.com>
+			Max Musterman <max@example.com>
+			Dr. author <author@example.com>
+		EOF
+		git log --format="%an <%ae>" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
--
2.5.1
