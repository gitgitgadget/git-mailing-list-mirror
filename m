From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] git config: report when trying to modify a non-existing
 repo config
Date: Wed, 24 Feb 2016 13:48:11 +0100 (CET)
Message-ID: <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:48:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYYrp-0001l3-1y
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 13:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbcBXMsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 07:48:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:58674 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbcBXMsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 07:48:23 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M92ZJ-1adkzw10sX-00CRF0; Wed, 24 Feb 2016 13:48:13
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Ws4NeY/l8NYoIbd2qSMb+xqQluidhj+cgPt1fT0fxRFf177uJrc
 xKHfXeklkQDAgijjSh7UzGBiNTP1zNZnUJq46rri2KsZ+hLE9tptZz4Lrl6H0haPo2aZ5kt
 +9o+w3Db73YBKL/XF9hjVtJSIowURkmXjg/5DLwffE5IZhisAUdz4PDiVjS8Rr9Zgys0CrK
 v26a6LQRla0G7de4hbiXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OjSRVslA0LA=:JW1Tz43EYcnkoSBqiwrKyl
 s2KtIZbdcv0DPIO/eH4Hjx34b/KtPB2yeqEZFak5LEIucsZ5TEGjwpNy62keKPUvQ7WjPIzXZ
 fhALo8s035lyobuB2/XZdmb4RqeiYMJ0Ub9wAUEItG64ME3shwzaAyYUOI0L4YuFYADWAKnsE
 p7BMpvbcF/dEerFht15uZ6j30I1w3OvHu0mXpMqTW3hgvMtSlyMhU980NL/XCO4DB8I+G5PXs
 34lpA2FEjXhuJxvNeGJbmBWyI50A4Y/0C6Hv2raiPo/RJKZZhKdO9spvXcQ/rWWbiKDd622Nf
 QQrcD0ySLcyl9IhkLqGceoK06sI7ZYUEhmyq4lqSdwTNV5sStiRtEcv8XI0hlPDay2AUaRwvh
 oSd5qUHj1Nrnoc05ZJTDHNbYAWCLOGb7UaNGkvw9Yg3ZXrCWiBcO946Rtj7CqoIlVfK9hcS+I
 2hN3cESwS3XdSd22iL4R36ICc+2HthRAnqNme3yoVHGJ+2MSFXQOYLPtm5ZVf4ffI47KqSFIQ
 Sy4oQEwqGDeiEj7Vz2ilR5wbTn3jvjQUvQk4pWvCsLNra4XzFxM2IWoHMUPBU83M5jDi7M4SK
 2/47LQMSiWy14yuHu1lYQSAQqgDCCb14hOCxLQkg9HjvID1ViiSRXuEhfI4HtRwIomIU6bHdq
 E8Iqn9C/c7RUzuhh7/hrOL+cfGikGut1eI5it7qx+q/dbRVnqqLC2OheKa78fB5UcUGOeCoIt
 dh4LS5TzTpGJFVgkQVG6J2co0BigQ9nMMp1w5egzzex2+xJfoX0loZ3Vbz47AgRzB/uLyksQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287204>

It is a pilot error to call `git config section.key value` outside of
any Git worktree. The message

	error: could not lock config file .git/config: No such file or
	directory

is not very helpful in that situation, though. Let's print a helpful
message instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/config.c      | 3 +++
 t/t1308-config-set.sh | 9 +++++++++
 2 files changed, 12 insertions(+)

The commit message was adjusted to reflect that this is not a bug fix
(except for Git for Windows), and a test was added.

Interdiff vs v1:

 diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
 index 91235b7..f62409e 100755
 --- a/t/t1308-config-set.sh
 +++ b/t/t1308-config-set.sh
 @@ -218,4 +218,13 @@ test_expect_success 'check line errors for malformed values' '
  	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
  '
  
 +test_expect_success 'error on modifying repo config without repo' '
 +	mkdir no-repo &&
 +	GIT_CEILING_DIRECTORIES=$(pwd) &&
 +	export GIT_CEILING_DIRECTORIES &&
 +	cd no-repo &&
 +	test_must_fail git config a.b c 2>err &&
 +	grep "not in a git directory" err
 +'
 +
  test_done


diff --git a/builtin/config.c b/builtin/config.c
index adc7727..78aab95 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -352,6 +352,9 @@ static int get_colorbool(const char *var, int print)
 
 static void check_write(void)
 {
+	if (!given_config_source.file && !startup_info->have_repository)
+		die("not in a git directory");
+
 	if (given_config_source.use_stdin)
 		die("writing to stdin is not supported");
 
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 91235b7..f62409e 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -218,4 +218,13 @@ test_expect_success 'check line errors for malformed values' '
 	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
 '
 
+test_expect_success 'error on modifying repo config without repo' '
+	mkdir no-repo &&
+	GIT_CEILING_DIRECTORIES=$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	cd no-repo &&
+	test_must_fail git config a.b c 2>err &&
+	grep "not in a git directory" err
+'
+
 test_done
-- 
2.7.2.windows.1.2.gbc859c8
