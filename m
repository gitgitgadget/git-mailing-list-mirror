From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v4 2/2] merge-recursive: more consistent interface
Date: Wed, 17 Feb 2016 01:15:26 -0200
Message-ID: <1455678926-15105-3-git-send-email-felipegassis@gmail.com>
References: <1455678926-15105-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 04:18:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVscs-00040J-I8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 04:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933761AbcBQDR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 22:17:58 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33347 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933757AbcBQDRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 22:17:52 -0500
Received: by mail-qg0-f43.google.com with SMTP id b35so3077704qge.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 19:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=g383pQGJHwLmHJ16tGThUnllcb4a5lL9B2+xlC6TU9w=;
        b=XTGgCbWk5bT8VXROOwNzjBSuAHTQVQSqbCELYIYCPi6DgRPcyLhdzPBljf+/wzxnGD
         9DPjW6wzYh75bPE6UP0v73Kj/nls61ykC9lt4Nu/GAKba6nkrp0436mcP+S4yhSGfgvv
         Hs+DVhnM8npvhIrgktqOIUebIhjMKvJH2C26ye9d8h0KyV53Eq1EJuV7kJO7vks6ZZgM
         ieV/QcxNWQk6r0fqk5wM0PPqdopjVe9hESndJa5haji8vUwtqJRWvcta8tK5n6NycWfy
         icT9neW0K0qfPnsQKJCj1DU/42qwH99yOIdJQ90e0nSL5r/JUn4itzyFY42PCjc6EC18
         kujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=g383pQGJHwLmHJ16tGThUnllcb4a5lL9B2+xlC6TU9w=;
        b=d1CLgVEZGiOwuFFmnXiHHE2Ysbh/bMuFjpa//KbSymPryLDQYBktGIYgfshRWB28tQ
         uz0h0GEfYDMd1FQaCQ2RDzVWYVwPCS+aPWCyb9eIftINtvupasfN/ERFbfPY2iNQgVHU
         6/tm+7hjXp7kJRHgJjb3J0J8cJAraN/J+6n7y+tiaqpAqDzIDOVMkiZjLbKNb2QF/TlC
         5hivPB7HRkRkBJNA9sUTRTP9ANv7fKzPbJgKl+8JUuiRkO8kMrzK6MMxbEuMWbUe8c99
         aSx8dDPgJBWLaL7XCKzWN6BPOHoODRnNUUMcuClbTrb6gPeNRf3DGWQCM01zpY6lYi+P
         wG2A==
X-Gm-Message-State: AG10YOT4f6UIOCR3mKN4DyEcm1d3n/HcWsV00LuOBGvm8rVMImbpVafKfAR7PpNJ/GATww==
X-Received: by 10.140.97.227 with SMTP id m90mr31837070qge.60.1455679071686;
        Tue, 16 Feb 2016 19:17:51 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id b111sm14501148qge.47.2016.02.16.19.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 19:17:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.289.ga0c045c
In-Reply-To: <1455678926-15105-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286479>

Add strategy option find-renames, following git-diff interface. This
makes the option rename-threshold redundant.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 Documentation/merge-strategies.txt | 10 ++++++----
 merge-recursive.c                  |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index 1a5e197..ff359b6 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -85,11 +85,13 @@ no-renames;;
 	Turn off rename detection.
 	See also linkgit:git-diff[1] `--no-renames`.
=20
+find-renames[=3D<n>];;
+	Turn on rename detection, optionally setting the the similarity
+	threshold. This is the default.
+	See also linkgit:git-diff[1] `--find-renames`.
+
 rename-threshold=3D<n>;;
-	Controls the similarity threshold used for rename detection.
-	Re-enables rename detection if disabled by a preceding
-	`no-renames`.
-	See also linkgit:git-diff[1] `-M`.
+	Deprecated synonym for `find-renames=3D<n>`.
=20
 subtree[=3D<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
diff --git a/merge-recursive.c b/merge-recursive.c
index 6dd0a11..700febd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2094,7 +2094,10 @@ int parse_merge_opt(struct merge_options *o, con=
st char *s)
 		o->renormalize =3D 0;
 	else if (!strcmp(s, "no-renames"))
 		o->detect_rename =3D 0;
-	else if (skip_prefix(s, "rename-threshold=3D", &arg)) {
+	else if (!strcmp(s, "find-renames"))
+		o->detect_rename =3D 1;
+	else if (skip_prefix(s, "find-renames=3D", &arg) ||
+	         skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg=
 !=3D 0)
 			return -1;
 		o->detect_rename =3D 1;
--=20
2.7.1.289.ga0c045c
