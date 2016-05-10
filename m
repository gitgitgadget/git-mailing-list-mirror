From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] completion: support git-worktree
Date: Tue, 10 May 2016 21:15:47 +0700
Message-ID: <20160510141553.22967-1-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:16:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08SX-0007Uh-DM
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbcEJOQU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:16:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36326 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbcEJOQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:16:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id g132so1063446pfb.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N66qpkgcJa093zynAHNGttx84cqYjabXsYdx45IMUXg=;
        b=yiy20EIyHaGLlECAzv8FQ3zUkQW7vR1SIEfYvQW5Edj8kv0vddmrNpa7TXOXN/bB8U
         Zq+WFengQ7kZIzWWId4SMT1NTGwl2tRDjEXtOpYozCQjPxIjkTyVKXAte0Aqsp9m1R+f
         /dH9ZUKtTyJjLkaVncUPngOy1bHk5VGjW23aDC6ezpJYfzMhzw5918+OcTJkQCiRvyTG
         6r5YYMOC727VYYbxrEgX8dBwMpd8bKb+0+0WSpfne6HkIgadLSkDUnuPIHExwFWN+6HG
         Q3eO5Yal8uU4GeRdxnMrkDxkhgYQO+9QxtVdI7nMqLula4v1NmldjiEcYmon8vDZzTnS
         ZvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N66qpkgcJa093zynAHNGttx84cqYjabXsYdx45IMUXg=;
        b=M8W9yUWT5qjJV1uaYvR5CJaSInCH5fy8wmlsVzRcREQRn2Wpn3KuALqLJ56uoP1NfV
         zlKfYBf2B3NPRIk592JW2Y1EZIolf1pMWiwClkFZ1xPN0d4RUWHzFRg0VqliMcSp9HGf
         F4c1fkfvv7/C98LWW2O1A3//4YYsggs6tbcsNrPDCUxjaQfGwmKmgdPxspUH/TN2hc23
         gQY4u9cipE7rpk7iwG8V2SlIzOo9rt2sdsxTRUI64KHl2NiksRLV8fJ6dniTYNYV+oPy
         KVjYMHMPhWNyqGCY3mtbxYQvnhk+8mAgfm8Hn0Ncc0b3Fo99hZ3mXJTbEZo1Bkz7UELS
         DBIw==
X-Gm-Message-State: AOPr4FUYuqtPvcEfY5Wj4fehPswm2hV3DZkKW0Lpi7ofBjCo4n0W8v8tRb3IzX+Mnm2ufg==
X-Received: by 10.98.46.71 with SMTP id u68mr59426335pfu.136.1462889778444;
        Tue, 10 May 2016 07:16:18 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id ve11sm4977298pab.21.2016.05.10.07.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:16:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:20 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141416.GA22672@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294136>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 3402475..d3ac391 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2595,6 +2595,29 @@ _git_whatchanged ()
 	_git_log
 }
=20
+_git_worktree ()
+{
+	local subcommands=3D"add list prune"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		case "$subcommand,$cur" in
+		add,--*)
+			__gitcomp "--detach --force"
+			;;
+		list,--*)
+			__gitcomp "--porcelain"
+			;;
+		prune,--*)
+			__gitcomp "--dry-run --expire --verbose"
+			;;
+		*)
+			;;
+		esac
+	fi
+}
+
 __git_main ()
 {
 	local i c=3D1 command __git_dir
--=20
2.8.2.524.g6ff3d78
