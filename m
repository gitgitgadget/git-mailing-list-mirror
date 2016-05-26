From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [RFC/PATCH 2/2] log: add "--no-show-signature" command line option
Date: Thu, 26 May 2016 18:36:47 +0530
Message-ID: <20160526130647.27001-3-mehul.jain2029@gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Cc: Austin English <austinenglish@gmail.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 15:09:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5v2O-0006zN-6g
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbcEZNJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 09:09:16 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36688 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbcEZNJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:09:15 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so9007869pad.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kLtpiOvjCwwy6Ut52Rw7d/I2V91u7DA0KUxNWvb7dvw=;
        b=Xd7FxN+8ExwHIqXnw6vnnvi11GVjX49Zil+FmLA5A1KPCiuVQoeGiqvDaXtcHELX0X
         rrZkvrEqc6RKtLnjaZ/bfAJSR5DbsLH9qdr1Mf1Q6KZ36CEhEGzU9ZP17I4BHb6XqAzH
         wLGQ7K+PpE2CQIOYJdLyX4NQG8PGln2XLvLn6qH7BBMHNvncWC7WVCVkpFmND4gVsNVK
         e4p1xvX/DN0jTi9B0D6e0l/57hkxc/1pqcKWqe+wcHJODuRyyNqkBNHIbpPaBgYCKBuB
         es7wZnWfyCH7tpbImtDNR1KkU2n8x21NZwOoEj6PsYWvTjg+g+bVZ2Td05iO/O5rK/b0
         z1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kLtpiOvjCwwy6Ut52Rw7d/I2V91u7DA0KUxNWvb7dvw=;
        b=KouRh/A3Wqcvh/YCbrlF/xyg4NNIZ6yjf82U/20tsxMXwEb3QIjzJ534ZB2VRPHcwW
         q/yoOgWFpercLMRF7K90CvhijNQ1iY+XjDizju0u1B0iIfFIYZ8ThrQlJdexygLSlb39
         6nY96SU2FvtJYkUtB7e9iI3DEctxRau+OgMESFDOHJ70FJ+9IbVNeIhGxjt8NntIlK+j
         3LxfVZj6jm5LDJA15ZSPKBtGnU4nSIv5saaPMCS7QQy9PjIEazk7Ktcv5zzfHlgNedAd
         7O7PwJobaNe3P1ueBnFH/6E2ub/Zz4Jwp+XwMEs8eTMq1mD8XVXEfcvDlHmImMSY5SIQ
         +8vw==
X-Gm-Message-State: ALyK8tLYFRUevGrwanm8XArucLFmsAlNNhSJTAhuWvNMOSb0ckTzLZytaSN6q55vGpuHgQ==
X-Received: by 10.66.232.226 with SMTP id tr2mr14070723pac.44.1464268153737;
        Thu, 26 May 2016 06:09:13 -0700 (PDT)
Received: from localhost.localdomain ([223.176.135.41])
        by smtp.gmail.com with ESMTPSA id vi6sm20547504pab.21.2016.05.26.06.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 May 2016 06:09:13 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295650>

If "log.showsignature=true", then there is no way to override it using
command line switch.

Teach "git log" and "git show" about "--no-show-signature" command line
option.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 revision.c     | 2 ++
 t/t4202-log.sh | 7 +++++++
 2 files changed, 9 insertions(+)

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
index 36be9a1..ea24259 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -901,6 +901,13 @@ test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
 	test_i18ngrep "gpg: Good signature" actual
 '
 
+test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
+	git config log.showsignature true &&
+	git log -1 --no-show-signature signed >actual &&
+	test "$(test_i18ngrep "gpg: Signature made" actual)" = "" &&
+	test "$(test_i18ngrep "gpg: Good signature" actual)" = ""
+'
+
 test_expect_success GPG '--show-signature overrides log.showsignature=false' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git config log.showsignature false &&
-- 
2.9.0.rc0.dirty
