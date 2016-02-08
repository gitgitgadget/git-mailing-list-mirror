From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Avoid interpreting too-long parameter as file name
Date: Mon,  8 Feb 2016 12:16:28 +0700
Message-ID: <1454908588-22475-1-git-send-email-pclouds@gmail.com>
References: <alpine.DEB.2.20.1602071317330.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ole@tange.dk, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 06:16:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSeBm-0004sz-Ik
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 06:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbcBHFQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 00:16:35 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33643 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcBHFQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 00:16:20 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so25954pfb.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 21:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m60N3emFlkrg6C7A3hcPd/2bPHipD+IHJ1ehUdyUJyU=;
        b=aGyEXnF7QCGbpa1A7q+twBYpTxrn5l9BRKKJXbs7y02Bt7JOAdESyHWEEh0gkgpvu0
         iEw3ojudJZuzGWahieSJX/FBFxzM2WiC6xtjDDUtSIewXQUeiy1SJUB/HO5P8wmBTeLR
         F8O6bq+zYgY01KUp2dD2Cwz8k+z0W5TqHkIL5urpw3pJU80WpZ85gOIs6iFUcS+TRg/Z
         bI4UpW8HikR4189ER1CvLmbIijcytljxADlqmgxe0eGHhJI8pMitQu1kuMWp9zLLu3IC
         j8l0Fr7EZyIv7A60vUv6Cm1R4W6coac+/eF5PUeSNBZOmgb/mWWH3/Z3Nfnq4AXo5LnX
         Imlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=m60N3emFlkrg6C7A3hcPd/2bPHipD+IHJ1ehUdyUJyU=;
        b=GNJkT8ZmUhNSprvnrKqG1wxz1Y7rvsHJz63GDMtyjA+VdjzUk38BbyISELoSDrhfIu
         I93YTxfFSxOL4u1c5P2tgMPRW/CxF6KNFl0J6NySu5US55Bl3lUBWjmyFQGez2wAn0iq
         Y0Y5yvsv6pq6dKI06kpKuPHG2FZCOQabZ5zkg5Fq6vRBkSKpERUkVsIkowlC89YduDfn
         B/aZfZIKcE+zJTMDdEM0NhEHhBtzdXcTsc+W1Hj8EXy2JYEW4TdrDdeVPQYl/8e/AYTm
         n9/uigjeHAftE6Ry3TamUd7mn6ymkfVHXlxHFuKkwnZvlX16NhG08lWYc8xcb/JgtqZX
         phTg==
X-Gm-Message-State: AG10YOSbXRXISOZYGwkphJdRVyt8fyAW4r+pJCwzB3dg2MLiQdBc8TxNwozkCIwMSGFApg==
X-Received: by 10.98.86.67 with SMTP id k64mr40244342pfb.50.1454908579616;
        Sun, 07 Feb 2016 21:16:19 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id l62sm39861072pfj.7.2016.02.07.21.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Feb 2016 21:16:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Feb 2016 12:16:35 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <alpine.DEB.2.20.1602071317330.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285748>

Even if it is easier to write HEAD~2000, it is legal to write
HEAD^^^... (repeats "^" 2000 times in total). However, such a string is
too long to be a legal filename (and on Windows, by default even much,
much shorter strings are still illegal because they exceed MAX_PATH).

Therefore, if the check_filename() function encounters too long a
command-line parameter, it should interpet the error code ENAMETOOLONG
as a strong hint that this is not a file name instead of dying with an
error message.

Noticed-by: Ole Tange <ole@tange.dk>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Note, git grep ENOENT.*ENOTDIR reveals a couple more matches, but I
 didn't check if they should receive the same treatment.

 Another option is just use file_exists() here instead, but I guess
 that's too relaxing.

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 2c4b22c..ab8f85d 100644
--- a/setup.c
+++ b/setup.c
@@ -147,7 +147,7 @@ int check_filename(const char *prefix, const char *=
arg)
 		name =3D arg;
 	if (!lstat(name, &st))
 		return 1; /* file exists */
-	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
+	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR || errno =3D=3D ENAME=
TOOLONG)
 		return 0; /* file does not exist */
 	die_errno("failed to stat '%s'", arg);
 }
--=20
2.7.0.377.g4cd97dd
