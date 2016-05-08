From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/41] entry.c: use error_errno()
Date: Sun,  8 May 2016 16:47:44 +0700
Message-ID: <1462700881-25108-25-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:52:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMe-0001lq-8A
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbcEHJvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:00 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34421 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbcEHJu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:59 -0400
Received: by mail-pa0-f67.google.com with SMTP id yl2so13705362pac.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+FQuRGc8rqkhVhmp5Ax5z+iMJbnz2uN3otK7AnJ6WQ=;
        b=jIjEtUD3vgY4pAvNf6V5TE0JKztrdpVK6njxYHFgSbOZm46fXLEqFGei4JhRHojAy4
         K0EnktBZUP2jTcgmuQjOJO5rhNOPcFNeUS+geZvh1lV6DDMLQSWkLxTXowQxl8/SQzWm
         UIQyUcMjtRxdqqUET0naDm+234RVEhlpm/jmHeo3h8fatFyul4bPaeKE6F0KgQIRmsao
         5xaETy1HtcWocyjDStzbzBkLPuFjx+wJxiOJh7QMZhGTmQpZdvFTHSzzVsTTK0v2Efym
         SrOMdZsAMqeGxH0tfEj7yYCsuVjoJGXLVrW6a79jLbr9ikuYxF7woURUkiXR07895jK9
         UGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+FQuRGc8rqkhVhmp5Ax5z+iMJbnz2uN3otK7AnJ6WQ=;
        b=G3hxaJ8qClooNa9rMat9ZtIwVJ7bXUHzCnkc/dT7BYHLadihru5H6zy1j+XWepAFp9
         F20hV+vDi+oLp1HtUeMRtMHuNXK/4dI6OrUe317V+dJbuZw2d1rfxXuavYXFl2RTIJfk
         dN9XAQq3Ev+iqlUihh5O2S0aW1ygEBVwW8aeRFOwr07LDEbLxYZGY6M3wHZtVIOWb4/V
         sZJLmjiayQR50oyTLsZeTV14SyJdxNlw9lHodXyXbFcKahFwx1AMAjpBS6LPz7liaGXa
         2hp8baqgQUS8rOOU1lvHFZOefYv9bfw9OqL4LqJdV7TfIDqc9sJ6sdpeN2I7YDWkHqPS
         evyA==
X-Gm-Message-State: AOPr4FUEDDG6L9dS8AprZCiyO8X/p3FdSgr3rq2nCPKBWk/weEWsnpen9eiHy6nRkSTdHA==
X-Received: by 10.66.6.98 with SMTP id z2mr41792653paz.95.1462701058554;
        Sun, 08 May 2016 02:50:58 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id fh14sm32861987pab.31.2016.05.08.02.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293940>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/entry.c b/entry.c
index a410957..519e042 100644
--- a/entry.c
+++ b/entry.c
@@ -168,8 +168,8 @@ static int write_entry(struct cache_entry *ce,
 			ret =3D symlink(new, path);
 			free(new);
 			if (ret)
-				return error("unable to create symlink %s (%s)",
-					     path, strerror(errno));
+				return error_errno("unable to create symlink %s",
+						   path);
 			break;
 		}
=20
@@ -186,8 +186,7 @@ static int write_entry(struct cache_entry *ce,
 		fd =3D open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
 			free(new);
-			return error("unable to create file %s (%s)",
-				path, strerror(errno));
+			return error_errno("unable to create file %s", path);
 		}
=20
 		wrote =3D write_in_full(fd, new, size);
@@ -284,8 +283,7 @@ int checkout_entry(struct cache_entry *ce,
 				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
 		} else if (unlink(path.buf))
-			return error("unable to unlink old '%s' (%s)",
-				     path.buf, strerror(errno));
+			return error_errno("unable to unlink old '%s'", path.buf);
 	} else if (state->not_new)
 		return 0;
=20
--=20
2.8.0.rc0.210.gd302cd2
