From: =?UTF-8?q?Mihai=20Capot=C4=83?= <mihai@mihaic.ro>
Subject: [PATCH] count-objects doc: document use of kibibytes
Date: Fri,  5 Apr 2013 11:39:23 +0200
Message-ID: <1365154763-9875-1-git-send-email-mihai@mihaic.ro>
References: <7vvc82jm77.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 06 18:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWEK-0002u6-R5
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab3DEJkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 05:40:20 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:38483 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161370Ab3DEJjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 05:39:31 -0400
Received: by mail-ea0-f182.google.com with SMTP id q15so1325077ead.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 02:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=A+HFdZ4wxBu1blMaQbQbBccJ0GYb1y9DHaq/j1+qLFo=;
        b=GxHMZP+f/SDXpIJkau1/2/wRuXXDnyufnW6ssuwQmTXlqGgBhMSQy0UhXDp+BaPOdw
         5VAJa6wMGq7JWwVlIDegRTYds2aJH/fHuCTDBYJwDjZgFTEzFXQsP1T7Zlx6qqqTpj3/
         kIc3NJEbl6wXFEe+XJHIf5CmqvJ/xbbzdcNlxZhEjkGOOp2bWziz/2eAmFmChgCFRUTt
         YTz8KMDc9lRe3/x9t9dngoPHin4gw+FhfKM9aPoPfeTcAOCEZYOZT3IHDd+by9FBp+Rn
         5JgbupJdqNL41IvsONTi9o2IKN9GwOfK+l7ZAAtFypjsr+3dseNwj7K1W4DTQmsAFXhK
         vrdA==
X-Received: by 10.14.182.137 with SMTP id o9mr18070367eem.13.1365154770451;
        Fri, 05 Apr 2013 02:39:30 -0700 (PDT)
Received: from dutier.st.ewi.tudelft.nl (dutier.st.ewi.tudelft.nl. [130.161.159.51])
        by mx.google.com with ESMTPS id n2sm14407198eeo.10.2013.04.05.02.39.28
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 02:39:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vvc82jm77.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQk0Im8YZ4h/3fkPj18XET0RuX0X9HpRsH2yzl2iQCcBIHDLMt53UPHQ6TEdjvW42FcOyUrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220160>

Document the use of kibibytes, not kilobytes, in the output of count-ob=
jects
and the reason for not correcting the output.

Also, make cvsimport comment and variable name reflect unit actually us=
ed.

Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
---
 Documentation/git-count-objects.txt |    7 +++++++
 git-cvsimport.perl                  |    6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index 23c80ce..d562dad 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -26,6 +26,13 @@ OPTIONS
 	and number of objects that can be removed by running
 	`git prune-packed`.
=20
+
+BUGS
+----
+Consumed space is actually expressed in kibibytes, not kilobytes as st=
ated in
+the output. The output is kept as it is for compatibility reasons.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 73d367c..6803f04 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1126,12 +1126,12 @@ unless ($opt_P) {
 }
=20
 # The heuristic of repacking every 1024 commits can leave a
-# lot of unpacked data.  If there is more than 1MB worth of
+# lot of unpacked data.  If there is more than 1MiB worth of
 # not-packed objects, repack once more.
 my $line =3D `git count-objects`;
 if ($line =3D~ /^(\d+) objects, (\d+) kilobytes$/) {
-  my ($n_objects, $kb) =3D ($1, $2);
-  1024 < $kb
+  my ($n_objects, $kib) =3D ($1, $2);
+  1024 < $kib
     and system(qw(git repack -a -d));
 }
=20
--=20
1.7.9.5
