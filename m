From: larsxschneider@gmail.com
Subject: [PATCH v7 2/2] fixup: config: add '--show-origin' option to print the origin of a config value
Date: Mon, 22 Feb 2016 10:23:46 +0100
Message-ID: <1456133026-15355-3-git-send-email-larsxschneider@gmail.com>
References: <xmqqd1rsd0ac.fsf@gitster.mtv.corp.google.com>
 <1456133026-15355-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 10:24:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXmiy-0004gH-6V
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 10:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbcBVJYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 04:24:05 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38031 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbcBVJXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 04:23:52 -0500
Received: by mail-wm0-f46.google.com with SMTP id a4so153089934wme.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mm6Cba36Ao/s/cthDKSbl3tx5VRJDD7tV5aa5Qc+rWw=;
        b=POxFSq/KD1h2EMg1XMlvANJt/lwpoEFgUsTmK0RWasZi4dFGbmh8ng370EqByn780R
         QjY4jtTEh6LODLvUi6nKuBjZITDQ2qt3gPHA0hQdpDJuiQWl3vutrSRQt68wZRFGWrzP
         9CQpC1IhU2bACjWvr+3qkQIdiP5jbaqfWvPYe6TZyblwDLhy/uV+Gi2ywyZjCuRQ3Etp
         W8DQ166aNi5kRm70K/DNGsNZnBN/jM0LFncsRfLp/6dcNEuZVuG2gTVWec2H6G4odOK+
         +w89uSkQ9bi8x93XPdW9c3Il04yZpDeIWQjEVhte5vEiJ2HHfXHCwze0SbYL9kwXc+Ue
         fsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mm6Cba36Ao/s/cthDKSbl3tx5VRJDD7tV5aa5Qc+rWw=;
        b=ZIS4g/2BRawiIvbhIkAlBgTo4WSqdwTRioseTiAwXqWoykUQv89H0FHuFgFZgoCMkd
         kguwHmbPwcTF2vSzN6N1qE1o9ZzCGjc10/+ZRIZxAePq1+wKc4HEJePXORTOKODgMCZ8
         +/WdzxMXQYc8hVmhVnnopgVzArT6f4s10g+97vDMbK5YOdyrpBO1duplGJ9lhW7HwAS6
         zN7xJ0FZnC/EJD7mA1gQVxTcCl6GQqe4bhOXN9UwWeYVhh00Fsv7DZYxcfRAeorJudpS
         7Lj+v8ou8BHl6pPcXRJEKaRLJIz7AbO5+ZdjdFhGWT1W1Sd+UjKSYrEw8h4gX8WHjehI
         aNDg==
X-Gm-Message-State: AG10YOTX78A0giATrjJpqL/N3P/f53X0fi4vJeDQSmjHhNREX+eaQ/5FDYXyvjtTTxzjaw==
X-Received: by 10.194.184.50 with SMTP id er18mr29934973wjc.160.1456133031235;
        Mon, 22 Feb 2016 01:23:51 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB49D4.dip0.t-ipconnect.de. [93.219.73.212])
        by smtp.gmail.com with ESMTPSA id g126sm20054279wmf.16.2016.02.22.01.23.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 01:23:50 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1456133026-15355-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286898>

From: Lars Schneider <larsxschneider@gmail.com>

---
 Documentation/git-config.txt | 5 +++--
 builtin/config.c             | 2 +-
 t/t1300-repo-config.sh       | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 6374997..499fc0f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -196,8 +196,9 @@ See also <<FILES>>.
 
 --show-origin::
 	Augment the output of all queried config options with the
-	origin type (file, stdin, blob, cmdline) and the actual origin
-	(config file path, ref, or blob id if applicable).
+	origin type (file, standard input, blob, command line) and
+	the actual origin (config file path, ref, or blob id if
+	applicable).
 
 --get-colorbool name [stdout-is-tty]::
 
diff --git a/builtin/config.c b/builtin/config.c
index a1a9b9a..0f14220 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -83,7 +83,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
-	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, stdin, blob, cmdline)")),
+	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
 	OPT_END(),
 };
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 254643a..8867ce1 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1246,7 +1246,7 @@ test_expect_success '--show-origin with --list' '
 		file:.git/config	user.override=local
 		file:.git/config	include.path=../include/relative.include
 		file:.git/../include/relative.include	user.relative=include
-		cmdline:	user.cmdline=true
+		command line:	user.cmdline=true
 	EOF
 	git -c user.cmdline=true config --list --show-origin >output &&
 	test_cmp expect output
@@ -1262,7 +1262,7 @@ test_expect_success '--show-origin with --list --null' '
 		trueQfile:.git/configQuser.override
 		localQfile:.git/configQinclude.path
 		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
-		includeQcmdline:Quser.cmdline
+		includeQcommand line:Quser.cmdline
 		trueQ
 	EOF
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
@@ -1318,7 +1318,7 @@ test_expect_success '--show-origin escape special file name characters' '
 
 test_expect_success '--show-origin stdin' '
 	cat >expect <<-\EOF &&
-		stdin:	user.custom=true
+		standard input:	user.custom=true
 	EOF
 	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" >output &&
 	test_cmp expect output
-- 
2.5.1
