From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 2/2] log: "--no-show-signature" commmand-line option
Date: Sun,  5 Jun 2016 21:09:33 +0530
Message-ID: <20160605153933.15231-3-mehul.jain2029@gmail.com>
References: <20160605153933.15231-1-mehul.jain2029@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 17:40:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9aAW-00006n-T6
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 17:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbcFEPkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 11:40:49 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35885 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcFEPks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 11:40:48 -0400
Received: by mail-pa0-f67.google.com with SMTP id fg1so9904203pad.3
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TfDCI3RGxA23o0wDqwqDg8kliH8LeJ6u48HUqiv8/NA=;
        b=ghiltXtts6c9GFKLzfmuWAF6W4hQ6HSogCp+iAQOuV2X/5o6Kw+iJc1z3koHsu0fHh
         Yl1FvsdAyHzWOcgywO76GRj4Nc/1EMDOdQlB+crWYiro5YLR9R7q0tbF0J06aXAeqru4
         Vb+i2yvC1LbrzrUcfPGZ3ke+O9NEeI2LcDKiwK3Bvp8ZUEG2Qmh44K01QdoHBHBrKXk9
         0HswKfFhfmZ+1kKDU6S9BakKKzG2DdVR0Jz3/eHHyeCfD8B38qnt39RfzZ7NU2RzbZsT
         W3xuvUL5pc45ttWpw8SjSrrBPMbf8wZjInE3ZuHZwYj8pdC5IZq6/rPL6suPPblrhUG2
         9iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TfDCI3RGxA23o0wDqwqDg8kliH8LeJ6u48HUqiv8/NA=;
        b=IviEYyI3wdrUrc8Fuiwd/G1xvo9Z5rZA8EPAFsB8xwvy4SiVDRDkDGi7lQGc7NUgko
         U73REElIk+ZnibDl1dQiEyVkg+5FJ6qecK5WD+s47qVycP6r3R2M1CBI/tySSWUXs7a4
         2dHlmWqFmDvS5rZ2F147vB7+3omk5/bEXGbP1OYeAhKtjBQ8nP9rStoI4pOcBuYQb9rQ
         38YivqT1S+heUqBKkIn7Fsbu9tIGgWLSyHnEwS9DPTrXnxFVXUuJlp7a02pcMsD8vcQR
         hIJn7nTeq2VTX32T7/KZBdUcIciOntcZH6GRqjBJkJ2ZgbocD6CcU/fo92qQgU7nzmPq
         cnHg==
X-Gm-Message-State: ALyK8tKuFxqMGCwxi2Isy1PtHrAYjMoLTxg/ISVI3jKZCLw7j8xInj1qjH7fdGoJLupXcg==
X-Received: by 10.66.122.196 with SMTP id lu4mr18894964pab.52.1465141247191;
        Sun, 05 Jun 2016 08:40:47 -0700 (PDT)
Received: from localhost.localdomain ([182.67.205.35])
        by smtp.gmail.com with ESMTPSA id p1sm21307814pfb.73.2016.06.05.08.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jun 2016 08:40:46 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160605153933.15231-1-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296476>

If "log.showSignature=true", then there is no way to override it using
command line switch.

Teach git-log and related commands about "--no-showSignature" command
line option.

Note that introduction of "--no-show-signature" is meant to tackle
the above mentioned problem for the following commands: git-log,
git-show, git-whatchanged and git-reflog. It does not suggest that
we need "log.showSignature" config variable to affect other git
commands, as currently "log.showSignature" is only meant to affect
git-log, git-show, git-whatchanged and git-reflog.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 revision.c     | 2 ++
 t/t4202-log.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/revision.c b/revision.c
index d30d1c4..3546ff9 100644
--- a/revision.c
+++ b/revision.c
@@ -1871,6 +1871,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
+	} else if (!strcmp(arg, "--no-show-signature")) {
+		revs->show_signature = 0;
 	} else if (!strcmp(arg, "--show-linear-break") ||
 		   starts_with(arg, "--show-linear-break=")) {
 		if (starts_with(arg, "--show-linear-break="))
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 3e4a4ac..026808e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -901,6 +901,12 @@ test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
 	grep "gpg: Good signature" actual
 '
 
+test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
+	test_config log.showsignature true &&
+	git log -1 --no-show-signature signed >actual &&
+	! grep "^gpg:" actual
+'
+
 test_expect_success GPG '--show-signature overrides log.showsignature=false' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	test_config log.showsignature false &&
-- 
2.9.0.rc0.dirty
