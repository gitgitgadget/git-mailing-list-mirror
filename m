From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/41] connected.c: use error_errno()
Date: Tue,  3 May 2016 19:03:52 +0700
Message-ID: <1462277054-5943-20-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7y-0000dk-3C
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbcECMIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:16 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34897 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbcECMIK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id 77so9231477pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cy8w2To31+I1tcXrcelmFf06S0W6OU/b4PxmzLEBa8w=;
        b=hwGodYEo1SBU43Mntd/7AaDg0WZQfgD/FFBUY8MEbYuYwxdFNVZcWzGAkGNqWspEIb
         HgYSLovdAK7fHcmWCf2OdxONzXzPc0wFd9qcQXQyDWQphvXYx8gqxryRlFqYIT0gunk3
         2Pqc3hcXuEoytZXUhC+2my4+vYHkHWiIEmOFieTyQ87JuCOpwRwjovj3IGApTfgyRzv1
         5fSn4qZHpbQT1iv7L//pRBf1NR9gfKCyfpFhRhvcxRBqkJWi1DRnovMSvRod62hSC3HT
         T/onuG9ufyxCtxQMocVVbC8bHMEpXgrfjsJmHrWr3e8XzKkj7YQhAnGD0l6yodVWj/Bp
         fttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cy8w2To31+I1tcXrcelmFf06S0W6OU/b4PxmzLEBa8w=;
        b=lrz565mIPCDe39LIvRQsPi+C6B47DeWwob7eKS4IRllyW28UEU4bQZspQVWXy1DhUD
         /ESxS1etkzdVyXVKnaYfx4Cj5IobWismcO1ngfB0lUvT2vmXx1XsB0YrpTJ8D23dqwyR
         89TX7OpwtMG/Z8zmjoxIX8nk7/IFIoUPNIYr7EO+2CNhv9zzuVP0MjsjB6lqgHMLR5mR
         qjy9Hebvsj4VJDzbj3ekb8lizOZy2ALXBi/muOkztR7Z9VS9Vfwx+cemhCJG0jH0or++
         u3AEoQqoGXyArx5i4SqKRgus3RbJWrX3SC9uUemcvfV9L12sqid/LF/AhFfHqkEA79J3
         +cLg==
X-Gm-Message-State: AOPr4FVdp447ztxf0DPJFSNw1fRvPeB5iVYtk9TPg0L+9tkfkPJeLnfLBZXmwj1yGcG80w==
X-Received: by 10.98.68.208 with SMTP id m77mr2888113pfi.25.1462277289636;
        Tue, 03 May 2016 05:08:09 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id c190sm5519066pfb.33.2016.05.03.05.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:05 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293373>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 connected.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/connected.c b/connected.c
index 299c560..bf1b12e 100644
--- a/connected.c
+++ b/connected.c
@@ -86,17 +86,14 @@ static int check_everything_connected_real(sha1_ite=
rate_fn fn,
 		memcpy(commit, sha1_to_hex(sha1), 40);
 		if (write_in_full(rev_list.in, commit, 41) < 0) {
 			if (errno !=3D EPIPE && errno !=3D EINVAL)
-				error(_("failed write to rev-list: %s"),
-				      strerror(errno));
+				error_errno(_("failed write to rev-list"));
 			err =3D -1;
 			break;
 		}
 	} while (!fn(cb_data, sha1));
=20
-	if (close(rev_list.in)) {
-		error(_("failed to close rev-list's stdin: %s"), strerror(errno));
-		err =3D -1;
-	}
+	if (close(rev_list.in))
+		err =3D error_errno(_("failed to close rev-list's stdin"));
=20
 	sigchain_pop(SIGPIPE);
 	return finish_command(&rev_list) || err;
--=20
2.8.0.rc0.210.gd302cd2
