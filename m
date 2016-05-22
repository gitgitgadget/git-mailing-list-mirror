From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/6] completion: support git-worktree
Date: Sun, 22 May 2016 16:33:51 +0700
Message-ID: <20160522093356.22389-2-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:34:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4PmQ-0001I2-9B
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcEVJed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:33 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34500 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcEVJea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:30 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so15029555pac.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FN6L8UmLEA2SMzl7+IKw0uiONLFfaOgN0sRyZvoAA08=;
        b=SMQw9LGEZie+1b5kzagMMLLDG4r61n/TjO03lSbla9lE+Eq46HeiYmU60ZU3Xrkd0c
         P9LnrPinRViqrw7ExMpnF1fVVeOkPPHV7ShcpxpvITPIsAPahIgWuSnPxOgj6KC3zK0D
         QcdsdTDEfytAoNyxwN9ZhqgIjmNyLklYEGQwX8SBaQIrZ7UF77Je86SQkmOt3ISqdF2d
         MsnWwlyZ6dBBQAGc6hGdjq1nMvuNxwX25Ef/K8k6qmHxCAqE1AQs8+2jWqbKWAV3aJFS
         1rQ4g/fJZgbucHopjI3kdtybwNSSUGLx1CwgdUOAuWfhkUJpdlFIjS9dC+Q2mRki4gf5
         4wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FN6L8UmLEA2SMzl7+IKw0uiONLFfaOgN0sRyZvoAA08=;
        b=kaZcMh1Nv31QTEc60pvzbqIi9nE/zYX5zR2BHkbbDF7Cc6RjEHarh1D/7hvpcqJF0b
         ax35sms7AgsiTbNVc6MyBfX57qqJbbj0cv/yShRxsIa/hRfIrRLQ5Q5znZcatAlvcL8f
         dDUFHRHD+sstYDYnwYpIKw3jWItrKq4hX64caSZtNlZ5fa5z/NemlsaGlE6YWnJxoHTe
         YvFSkMokZwRTMBWiJTQl42habCb5iQIGxhLtOeb7DZpJ9XdqqgULfyRyu6p7fvAf/fCM
         gOUglOp33+DRflP7aICO9UgzCdR6daXNjcaORpzinTHjmOZad3XK4ok7TVUqZ3bz61bD
         bukg==
X-Gm-Message-State: ALyK8tLxCUaAIXwsZgBX/jbfYYgAxREmRGc0PnjNoRjQ4ne2OIjRWuwAUoLLDb2oWjXbzw==
X-Received: by 10.66.218.161 with SMTP id ph1mr7387508pac.127.1463909670100;
        Sun, 22 May 2016 02:34:30 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id r197sm14023088pfr.55.2016.05.22.02.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:25 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295261>

This adds bare-bone completion support for git-worktree. More advanced
completion (e.g. ref completion in git-worktree-add) can be added later=
=2E

--force completion in "worktree add" is left out because that option
should be handled with care.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 3402475..951a186 100644
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
+			__gitcomp "--detach"
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
