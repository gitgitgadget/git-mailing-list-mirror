Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542B81FE4E
	for <e@80x24.org>; Sun, 26 Jun 2016 11:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbcFZLQp (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 07:16:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32942 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbcFZLQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 07:16:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id l188so26101739lfe.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 04:16:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MT3ovBgzgf9p9rFQ3RKeJuJO37IEtMt0hKKWoZMuRqk=;
        b=mbsY9UmVXTLXVnGzt/5nm9H4G1oq7sHqt2Zgwzdr0RvgalvqVVgMCdQj4NQFbTdAVN
         fQk3xWftyxORILxfTPxYXdCk+JrDyjmQjZ+c+OLPbCkTgFwYUkf6X0k3fGCTTAWplzs/
         UtkwdwoHhGK5iiAgTHX7owMt43e04PwkVYiEWS5KCI3OywfMRylWE/PQhETaIjCbSHmt
         gwfkdGlfjCvzx36N8x07hIxogWNXiDnIZjhLqo1zzgYxLEMIM91mIJ+Au761M29O9bN5
         jnn6R9we6MEuMscuBVBS6hKu9noP+D3TmPSVIty5t37W/uQ0Rabos/UkrrTYAfhLC/Qm
         +9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MT3ovBgzgf9p9rFQ3RKeJuJO37IEtMt0hKKWoZMuRqk=;
        b=VE59rVVQOUL0rAmSgH+WqOq56UP/7sDvdnY0Jr6BUXop/ZaghAX/16ADAM6J/7aIju
         w4gn6Xsx1z+FLgH0pvXGb0cYOhucmNIiTJQDaO2UKy96bNSNudOY3pnDNpisX8R/abuW
         LCeRm59pUZmXq1R5bZnNjc09nxcbxrnIM6RSGYdLkE4U8oBkdpTj1QDXVpUlVefFDJh1
         1VjvIBnYmE4eUg1iDAKaMRpWrWV/xskHRzBeivm6cvfoPz1+dEcvhYHTdg3Z39oU6Hhw
         YYl8DTPfSls10qBnSNO9kyjUp5MMfjKkxD8WSgu0l76GXjKhns5Bz4vGAPnp7CPxLhtL
         AVMA==
X-Gm-Message-State: ALyK8tL2KeqqmWZQQIICbLRIKrOxC0mxg/Fyufwfsvx4ZKdXIt55dmM526omnxFtWcyfgQ==
X-Received: by 10.46.9.215 with SMTP id 206mr3692510ljj.63.1466939802056;
        Sun, 26 Jun 2016 04:16:42 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 89sm2268979lja.35.2016.06.26.04.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 04:16:41 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] connect: read $GIT_SSH_COMMAND from config file
Date:	Sun, 26 Jun 2016 13:16:35 +0200
Message-Id: <20160626111635.6809-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.530.g66e63ce
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to $GIT_ASKPASS or $GIT_PROXY_COMMAND, we also read from
config file first then fall back to $GIT_SSH_COMMAND.

This is useful for selecting different private keys targetting the
same host (e.g. github)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 core.gitProxy can also be used for my purpose (I need pushing, not
 fetching though; the document says for fetching but I guess
 core.gitProxy always works for pushing), but then the key file
 is hidden behind the script. And writing a script for this seems a
 bit overkill.

 Documentation/config.txt |  7 +++++++
 connect.c                | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 58673cf..3bf070c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -443,6 +443,13 @@ specify that no proxy be used for a given domain pattern.
 This is useful for excluding servers inside a firewall from
 proxy use, while defaulting to a common proxy for external domains.
 
+core.sshCommand::
+	If this variable is set then 'git fetch' and 'git push' will
+	use the specified command instead of 'ssh' when they need to
+	connect to a remote system. The command is in the same form as
+	'GIT_SSH_COMMAND' environment variable and is overriden when
+	the environment variable is set.
+
 core.ignoreStat::
 	If true, Git will avoid using lstat() calls to detect if files have
 	changed by setting the "assume-unchanged" bit for those tracked files
diff --git a/connect.c b/connect.c
index c53f3f1..722dc3f 100644
--- a/connect.c
+++ b/connect.c
@@ -658,6 +658,19 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 
 static struct child_process no_fork = CHILD_PROCESS_INIT;
 
+static const char *get_ssh_command(void)
+{
+	const char *ssh;
+
+	if ((ssh = getenv("GIT_SSH_COMMAND")))
+		return ssh;
+
+	if (!git_config_get_string_const("core.sshcommand", &ssh))
+		return ssh;
+
+	return NULL;
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -758,7 +771,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				return NULL;
 			}
 
-			ssh = getenv("GIT_SSH_COMMAND");
+			ssh = get_ssh_command();
 			if (!ssh) {
 				const char *base;
 				char *ssh_dup;
-- 
2.8.2.530.g66e63ce

