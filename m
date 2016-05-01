From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/41] run-command.c: use error_errno()
Date: Sun,  1 May 2016 18:14:49 +0700
Message-ID: <1462101297-8610-34-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOF-000862-HQ
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcEALSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:15 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33829 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcEALSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:14 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so16153400pac.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHO+kv4XdLapel/fDeP654YK4xCQ/QV/SKzmL4Zh9VY=;
        b=QZ/RJkxHIulQ8OF/nIwxY3kajay/iSQjwAmqA3vqFE2uCzz5KaryyAQZaxTZY6iWGz
         f2wPG6swoV1OCFiS6j0jcGso0Xy/FTxBjx/ovjeAqTB+KWaZmeUhwx3krfKWzn8+iuij
         Dr7mgBqySTT39ZwSNBBjNW8UhZXCprzQcG9wi/njGm0lZPKha20Ks5DFynfO0ndT5xOF
         Omdzkj0KitpwXS63Mv7xdzoXzAi+h0mG1TX+ep982GO5VwL9FgEVIU9VgZb8Dw6EmWfi
         62jh1aBaYCdxbHHQkZ/7HlHPkY+pPZg3TAuw8mcUuHCcBmKz0L0QBRok0P4S+oOMM3wC
         GCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHO+kv4XdLapel/fDeP654YK4xCQ/QV/SKzmL4Zh9VY=;
        b=kcoNLP90YTB7zZ/V2dwTmACUuyBWLR1L1iyO40Q98PLaatXQavS6tZiheWiTBuAL+f
         X/svVUWmSnyxyNe61AwMPQnjy/TMIJWWrAByoSijykFbPbQO+byl9x7qR7e881gCtFAN
         kpN0RrjI6RYqFEBSo1NlwdFt6AkpKKmYbX2TAoARZryttRqy76Vgs4ykkMNzqqE8jSWm
         UtBBOUzWGsCXFxnMfUDNB2p1zfHRE9BoANnoqkBhIIi8/vNCjDoFNxVB2TUkDIDh1Aqk
         YlM94DkK3OGXV9VlbkPDaTFEBtRE60/rQPjgaWeRttWc+oI70/W2KMcoPnw7UW0cTQWS
         2S3A==
X-Gm-Message-State: AOPr4FVet239h+BBQmkbwqbAPkEAWy8bJ+xJmeZeKCHuC1sZlwNC9OEYV2IzfjYnb43LDg==
X-Received: by 10.66.160.133 with SMTP id xk5mr35573488pab.71.1462101493764;
        Sun, 01 May 2016 04:18:13 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id dr4sm37376043pac.11.2016.05.01.04.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:09 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293183>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 run-command.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index e4593cd..842c8d1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -233,7 +233,7 @@ static int wait_or_whine(pid_t pid, const char *arg=
v0, int in_signal)
=20
 	if (waiting < 0) {
 		failed_errno =3D errno;
-		error("waitpid for %s failed: %s", argv0, strerror(errno));
+		error_errno("waitpid for %s failed", argv0);
 	} else if (waiting !=3D pid) {
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
@@ -420,8 +420,7 @@ fail_pipe:
 		}
 	}
 	if (cmd->pid < 0)
-		error("cannot fork() for %s: %s", cmd->argv[0],
-			strerror(errno));
+		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
 		mark_child_for_cleanup(cmd->pid);
=20
@@ -482,7 +481,7 @@ fail_pipe:
 			cmd->dir, fhin, fhout, fherr);
 	failed_errno =3D errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno !=3D ENOENT))
-		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
+		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >=3D 0)
 		mark_child_for_cleanup(cmd->pid);
=20
@@ -703,7 +702,7 @@ int start_async(struct async *async)
 		if (pipe(fdin) < 0) {
 			if (async->out > 0)
 				close(async->out);
-			return error("cannot create pipe: %s", strerror(errno));
+			return error_errno("cannot create pipe");
 		}
 		async->in =3D fdin[1];
 	}
@@ -715,7 +714,7 @@ int start_async(struct async *async)
 				close_pair(fdin);
 			else if (async->in)
 				close(async->in);
-			return error("cannot create pipe: %s", strerror(errno));
+			return error_errno("cannot create pipe");
 		}
 		async->out =3D fdout[0];
 	}
@@ -740,7 +739,7 @@ int start_async(struct async *async)
=20
 	async->pid =3D fork();
 	if (async->pid < 0) {
-		error("fork (async) failed: %s", strerror(errno));
+		error_errno("fork (async) failed");
 		goto error;
 	}
 	if (!async->pid) {
@@ -787,7 +786,7 @@ int start_async(struct async *async)
 	{
 		int err =3D pthread_create(&async->tid, NULL, run_thread, async);
 		if (err) {
-			error("cannot create thread: %s", strerror(err));
+			error_errno("cannot create thread");
 			goto error;
 		}
 	}
--=20
2.8.0.rc0.210.gd302cd2
