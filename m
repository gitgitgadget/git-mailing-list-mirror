From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v6 0/4] githooks.txt improvements + core.hooksDirectory
Date: Wed,  4 May 2016 22:58:08 +0000
Message-ID: <1462402692-24712-1-git-send-email-avarab@gmail.com>
References: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 00:58:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5kT-0002QJ-SN
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbcEDW60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:58:26 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37410 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbcEDW6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:58:25 -0400
Received: by mail-wm0-f45.google.com with SMTP id a17so599396wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltmLnyN/qGpYwxungk5ZD48k7yCVOPg8daKWjwNDL6I=;
        b=oNYq9UtXuGuHgA953RHp0cP67xczzTMejsija4m8tLwFIoB+yrrBIupCGGotG7pSbs
         xB/JvkIahJLl38kZ3ssIjIuivpwjUk6vwjSz2rME6nn6GuX2sv6mzeShu82h1w7Y6N9o
         Wyl8aDM9dt4FLvemb4eaboxtml8rL8e4Rx7OXD0P4CYbOOUCY/etsb8wosqHWHRGtitD
         5KE/KvT91VPk9eWi5AvrtzgOrbBVhBl7YYR2wjHW0c7xgUb8868/qBB3QQy9XDEA+r8j
         2Qk6/YpZisOUZPmNJLT65VPpx96vNcDJIRljVW7kWUBvOuGBL20+aeVSW7yzZ+IPmIQE
         rL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltmLnyN/qGpYwxungk5ZD48k7yCVOPg8daKWjwNDL6I=;
        b=H8PgbcycCM8WDSYvCobXj3Syy12TE4SQBlE/WmL8unjnvPvwlN/cDy9DBBN5L3VQlL
         vRyM8C9S9VEfXYdp3Wz4LGA2T4BfncQ0NxzcGmQTxQWor8Br5BJRwX41t7vJZIggzV9x
         JRU5m6SWjNW0OHvmqNAwLCwqn+5SHwyiosT2KUNINqIJERyK5f4Iv8fkcA2p4eZi800A
         Dvros8eTSMg1KwTFBwCFFQRpaeuTtXukuw1BGE+aWWfw/+BeyBiQthmTsCObkWkT6kPA
         jbR4BqUKAbhAJxagiuP23zIEUgX412FCDQ2WF9dl2U9WbjTT2IupirUGEtSF3ER41aw9
         HoVQ==
X-Gm-Message-State: AOPr4FWHFPIE8bAJbtaoMQNi+E8Xsn+w0J+9b2cHvuaIfcdanNCd6Th8orL/s9F9Qfwu3Q==
X-Received: by 10.194.62.99 with SMTP id x3mr187454wjr.128.1462402704326;
        Wed, 04 May 2016 15:58:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id us3sm6557967wjc.41.2016.05.04.15.58.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 15:58:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293614>

Changed to reflect Junio's latest comment, diff between the whole
series and the last one here at the end (made with -U0).

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  githooks.txt: Improve the intro section
  githooks.txt: Amend dangerous advice about 'update' hook ACL
  githooks.txt: Minor improvements to the grammar & phrasing
  hooks: Add ability to specify where the hook directory is

 Documentation/config.txt     | 17 +++++++++++
 Documentation/git-init.txt   |  7 ++++-
 Documentation/githooks.txt   | 73 ++++++++++++++++++++++++++----------=
--------
 cache.h                      |  1 +
 config.c                     |  3 ++
 environment.c                |  1 +
 run-command.c                |  5 ++-
 t/t1350-config-hooks-path.sh | 37 ++++++++++++++++++++++
 8 files changed, 112 insertions(+), 32 deletions(-)
 create mode 100755 t/t1350-config-hooks-path.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9a74acd..6cc069f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -635 +635 @@ per-repository basis, or as a more flexible and central=
ized
-alterantive to having an `init.templateDir` where you've changed
+alternative to having an `init.templateDir` where you've changed
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 6f562cd..d82e912 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -24,5 +24,3 @@ linkgit:git-config[1]).
-Hooks don't need to worry about the user's current working
-directory. Before Git invokes a hook it changes its working
-directory. The working directory will be the root of the working tree
-in a non-bare repository, or in the $GIT_DIR directory in a bare
-repository.
+Before Git invokes a hook, it changes its working directory to either
+the root of the working tree in a non-bare repository, or to the
+$GIT_DIR in a bare repository.
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.s=
h
index 6e4586a..5e3fb3a 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -11 +11 @@ test_expect_success 'set up a pre-commit hook in core.hoo=
ksPath' '
-EOF
+	EOF
@@ -14 +14 @@ EOF
-EOF
+	EOF
@@ -33 +33 @@ test_expect_success 'Check that various forms of specifyi=
ng core.hooksPath work'
-EOF
+	EOF


--=20
2.1.3
