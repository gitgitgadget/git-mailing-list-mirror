From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/20] worktree: simplify prefixing paths
Date: Wed,  3 Feb 2016 16:35:46 +0700
Message-ID: <1454492150-10628-17-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsb-0006Xp-IT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbcBCJh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:26 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35192 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcBCJhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:23 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so10765395pac.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xLut2rW8CZ9aKetp083K674kvfBnuqjD7/9hYd8NvPY=;
        b=wvy4zsjwJf1UTAC6LRf4GjNffv+n7PIvNgaivWWFwLiHTi/BMaKfgipwxmtBrN0dEQ
         bJnV1BngdMsq+1aXzI0gVmNbTh/EYEUhfd9BrtKnDv2rDQ+oPyvTCPjJt2kJzBkeP6rR
         zX9GebxWuedfdpaZaqJSz5ap8Gdotl95r5t8EMrhor6j1su5z3Dj5TUJUE3/49Xh55W/
         OP1YH+Ri/u6OpHoVZjCvnBzvhpcMibXygX6CfAmm+Egdt1vb1q8m2zTLkEvNaItH6CjN
         kkpV31bFuxyxn5jUtMue0nMGvSktMapvnBbo5RtgblQFGqoEqoRM2bCbU3WaNe/xXxem
         eHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xLut2rW8CZ9aKetp083K674kvfBnuqjD7/9hYd8NvPY=;
        b=SgH8jqdYdXuQNFuN8G9pI7ToVJnjT+ANHXAkNBqgga0X+ETde55BfaNON0pyw/qpDu
         uXz8vksUqHMEBt/BivwMVziLUaiZxVLoX3ayn2XftFzPC19QISfEM9qLul4JX37uCdR8
         VaG/9JIhe8c6Icty0kJAlnlipAgQnj33AFTkzY/a9EGeDpgyOEmdz/gdhqd1lQjdWy5H
         +A6wvYSjTgxgffMwBCVc63fsHCUgKo+5m4+aiwZibTEi7qct0AisTDTJOhNPXy63y6pQ
         XD1DMstQd0PET2oqyH37M66lZrEZNRqHrSrXa8UOeDpu2bWJmDOEPdAXLgbFz1iXyOyv
         M77g==
X-Gm-Message-State: AG10YOSAuEhe/BYyT26Xg+Es0YXzQgNYbIq3ruIKj1tttzAGazG2wx0vfwYOL++UN60ZJA==
X-Received: by 10.66.156.195 with SMTP id wg3mr750700pab.54.1454492242672;
        Wed, 03 Feb 2016 01:37:22 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id o184sm8407537pfo.36.2016.02.03.01.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:34 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285360>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index f490ca3..36d942e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -332,7 +332,7 @@ static int add(int ac, const char **av, const char =
*prefix)
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
=20
-	path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av=
[0];
+	path =3D prefix_filename(prefix, strlen(prefix), av[0]);
 	branch =3D ac < 2 ? "HEAD" : av[1];
=20
 	opts.force_new_branch =3D !!new_branch_force;
@@ -453,6 +453,8 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
=20
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
+	if (!prefix)
+		prefix =3D "";
 	if (!strcmp(av[1], "add"))
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
--=20
2.7.0.377.g4cd97dd
