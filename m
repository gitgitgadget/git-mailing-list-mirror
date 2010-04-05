From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/43] var: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:41:02 +0200
Message-ID: <1270492888-26589-18-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH1-0000ps-Nc
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab0DESmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:39 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0DESma (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:30 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QWM7XDU+dErVWL08ykhrHTAEK0EZRnO1M+Tlzvxkp9E=;
        b=sqgZT8xaFZLEAPjsUly8OiUM0Go8dYN3+AHzc1DNbTOipnNf53yOlC89o5GhApNFmy
         jl0pL8mB973VPPy2KI+mOR7k3d3395E9lLwkX3pJEe/a4Qt3sMMIkephilqC79e8dGcM
         fr+hlC988ok/6eaAetkAZcbiV4JRsuSCNV82Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wxkFyII/6KPFvrdFHYb/nfRLuoYCAnvrHCm+Dq4RywnoMktj2m72FPAQSUWCbrRdq3
         2ywSdYUoBQEzU07uVsuydwiDZHPia8JaR9+/6a5rdaRHXPEs5n2nrRUN4GeEcHKoEJt6
         vkJai4R7k+bbSXWICCwwBMeM8bFWs5TCMfE1Q=
Received: by 10.223.65.77 with SMTP id h13mr6079891fai.91.1270492949366;
        Mon, 05 Apr 2010 11:42:29 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 35sm474318fkt.7.2010.04.05.11.42.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:28 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:26 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144016>

"git var" needs to read repository config, so setup gitdir first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/var.c |    2 --
 git.c         |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 70fdb4d..26324ef 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -75,12 +75,10 @@ static int show_config(const char *var, const char =
*value, void *cb)
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
 	const char *val;
-	int nongit;
 	if (argc !=3D 2) {
 		usage(var_usage);
 	}
=20
-	setup_git_directory_gently(&nongit);
 	val =3D NULL;
=20
 	if (strcmp(argv[1], "-l") =3D=3D 0) {
diff --git a/git.c b/git.c
index 257ddde..567d533 100644
--- a/git.c
+++ b/git.c
@@ -391,7 +391,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
-		{ "var", cmd_var },
+		{ "var", cmd_var, RUN_SETUP_GENTLY },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
--=20
1.7.0.rc1.541.g2da82.dirty
