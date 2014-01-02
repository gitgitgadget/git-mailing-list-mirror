From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 1/4] Consistently use the term "builtin" instead of "internal
 command"
Date: Thu, 02 Jan 2014 17:15:44 +0100
Message-ID: <52C590B0.1020702@gmail.com>
References: <52C58FD7.6010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 17:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vykw9-0005LE-1U
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 17:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbaABQPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 11:15:53 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:35526 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaABQPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 11:15:52 -0500
Received: by mail-bk0-f51.google.com with SMTP id 6so4537976bkj.24
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 08:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2MnfLzbGwcN10wW3lMC4RlqSmqia9QCrgwIKJBwVI54=;
        b=ojJziJ670rXZZMAk07t1/O2CNlYdDavR1tTfyp2ltt4+WM37/aHIszLuXFquVB0MPL
         zooPPQTerINUpqTzcGu1FabIMBxqbFdnRTQ/OdbnWVgoVpQwWmgJek2d2hWmSjpgQxAp
         U9+xcXWDxKx7SIpLk/uVsNMAnGbqZGKjKmauDcT/Gco6sI8FccQyxj1Bqk25gotbzJ7K
         X7Y9c1mUBoBgh99lMi9F9me/E3Jg82Boxh1A2EmIDB/IkPi5DaD6eYt7TTlgpKoTKubc
         mDHwGXbQcFrCICnWQfbXIs2ZLDhHnByHYHzF0+tr/hLBk0Az2cphk8hDIg8sllT+VUW+
         CI1Q==
X-Received: by 10.205.23.194 with SMTP id rb2mr62840bkb.112.1388679351656;
        Thu, 02 Jan 2014 08:15:51 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id bg1sm27221970bkc.4.2014.01.02.08.15.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 08:15:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <52C58FD7.6010608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239854>


Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/technical/api-builtin.txt |  2 +-
 git.c                                   | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index f3c1357..150a02a 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -14,7 +14,7 @@ Git:
 
 . Add the external declaration for the function to `builtin.h`.
 
-. Add the command to `commands[]` table in `handle_internal_command()`,
+. Add the command to `commands[]` table in `handle_builtin()`,
   defined in `git.c`.  The entry should look like:
 
 	{ "foo", cmd_foo, <options> },
diff --git a/git.c b/git.c
index 3799514..89ab5d7 100644
--- a/git.c
+++ b/git.c
@@ -332,7 +332,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
-static void handle_internal_command(int argc, const char **argv)
+static void handle_builtin(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
@@ -517,8 +517,8 @@ static int run_argv(int *argcp, const char ***argv)
 	int done_alias = 0;
 
 	while (1) {
-		/* See if it's an internal command */
-		handle_internal_command(*argcp, *argv);
+		/* See if it's a builtin */
+		handle_builtin(*argcp, *argv);
 
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
@@ -563,14 +563,14 @@ int main(int argc, char **av)
 	 *  - cannot execute it externally (since it would just do
 	 *    the same thing over again)
 	 *
-	 * So we just directly call the internal command handler, and
-	 * die if that one cannot handle it.
+	 * So we just directly call the builtin handler, and die if
+	 * that one cannot handle it.
 	 */
 	if (starts_with(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_internal_command(argc, argv);
-		die("cannot handle %s internally", cmd);
+		handle_builtin(argc, argv);
+		die("cannot handle %s as a builtin", cmd);
 	}
 
 	/* Look for flags.. */
-- 
1.8.3-mingw-1
