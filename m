From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/25] worktree: simplify prefixing paths
Date: Wed, 13 Apr 2016 20:15:41 +0700
Message-ID: <1460553346-12985-21-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKg0-0004jl-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760681AbcDMNRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:39 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35428 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760672AbcDMNRi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:38 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so3962081pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dl+vAGf/qAfhoW3Zks6rCwF+Wylnkj9OWx+VZfhF4q4=;
        b=FhGzSNaCyOAhtgqTQhaLPzI2fcjQZ9/T3Qqapq2yWQUWQwzge+9GQBI8ZjkV05wrXG
         IxYF5K6KIviXExP+Ww1VRXvjzbDFdvQA2CDLbsRf11J018lgLuSUe/qyZN6Fo062rXxi
         kNOdOgKu3WfMcvDTFXeiPUJsCELSQv9Y+0u7PXHu00W//5hngp4bay7/+MIOcJhtap7W
         BFWTr0Z+TTzozomAQjJKp0oNLQM3aKhCTXp72qav6L/7TK1RTlvwLdHMhhVV7C458R9Z
         1sGg2yh9R2VyfBTm9Lmy+8fcwkTLD0tOv5p+lvTuhmIkfDfUWCaVi2KWn8xiJRxbY4co
         n9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dl+vAGf/qAfhoW3Zks6rCwF+Wylnkj9OWx+VZfhF4q4=;
        b=as9C3LcBgB8iCdT6f7lzzVwmnvejPcXQNg6B3Ay6lfRsD+oLSCOF/dFF4AUgjAVl7v
         8GA4Ok6oOvdD7dj8WVb4r9tTLzyeeAMWan6p2Sq5r2Z8xz7mXO7lFsYJUOlQX+LyxJTg
         J3lsFpZN5SXgWzzgy7x9Szj82dA2P0RjjxiCA1YuTay5yncRvBiNK8ormEmYSSTnSmaU
         4w3iUGihZU7GSXl7vA9FnHIgvS1oZ6lkdg0s6RDTw4Pkz+SYVRMjyDsusGd/04RjcX4L
         JktWe1JMGtZU+qgCBqFP67wcB7NpTNn60yvLWjX+m3dwc/89bePMiOX5vtP7w7Q+ToGU
         LGpw==
X-Gm-Message-State: AOPr4FVXSCfmxsxOSRrsvzgcBWqx8b5xPofFAM4xNesbENt+M3QP09K+wp2SHPTcOCtLgA==
X-Received: by 10.66.218.161 with SMTP id ph1mr12633294pac.83.1460553457635;
        Wed, 13 Apr 2016 06:17:37 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id vv8sm51317783pab.22.2016.04.13.06.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:43 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291441>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e041d7f..a9e91ab 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -330,7 +330,7 @@ static int add(int ac, const char **av, const char =
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
@@ -460,6 +460,8 @@ int cmd_worktree(int ac, const char **av, const cha=
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
2.8.0.rc0.210.gd302cd2
