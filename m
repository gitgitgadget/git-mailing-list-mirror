From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/41] builtin/branch.c: use error_errno()
Date: Sun,  1 May 2016 18:14:21 +0700
Message-ID: <1462101297-8610-6-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLm-0006mi-T7
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbcEALPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:42 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33314 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcEALPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:41 -0400
Received: by mail-pa0-f65.google.com with SMTP id vv3so18834394pab.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSYZtZdQ1hMu3kH39epCcbIjTQHXgwQeOn7XFD/CKMI=;
        b=TvG8npGESPBjBaKlcVpaJa0YLEtG/+Y12DasM8aPr7cRoCRAfXzLmSsrqFIl3VlcQX
         aRaoEq966D/HHLbPNRIcDNdzCNMUJeN4qGap1CRQiEp0piYQso1mZmiIYNNxIIJMpD2N
         V0ogxVJ5FxxJl9u6hLwexC/WGdcnuQiDKxqC6zRh8qW6cxDxo/rZS6as9LMD5iMZGuqn
         le2F2TOij6kyBSlwi5ZQVslgCdJBIREXCtFnJcsXdog9dyu7OzzAOlIHWTFd7Ux0mJ2z
         bwHgHxKXi/O+tgP1XIWDZshu+Q9wRIscFa7JPX9ZaB/IzYMS6jACbDqZm/EIlboZ+C3A
         CNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSYZtZdQ1hMu3kH39epCcbIjTQHXgwQeOn7XFD/CKMI=;
        b=mickXNC97AMlOhJNxEI32oB87xe+RzU0VhUvUS4YyozUrE7C9DSbLMOZ22U8gtXxrH
         c4Wqa1/t95LutXxXDw4PZf09fK1DxeEcRIUkTrybuty7jjbaC4gvWLq7UXf1wzwYrQFb
         44VuD72jAVpzLl60KYm8t5fXjoYxQw6b9/EnwgFjjecHf7+rE7gahnmqQnH1ZF0mvUwH
         RQUOIosYJNIt2mgko57apgG9zsl01RYalcaTU12LkDeMYQIJrHMNEaBPBDk137IFmgPu
         d1XCneuypCTjaho9ZDqJxoLgurqW7DgjjPmsGDj+gyNXMR9l0CQ/g7Klg0xuEY3Z2wvS
         /fsQ==
X-Gm-Message-State: AOPr4FVBK9J5DuEdrxV2UNyeAUy3v9pfOApbkayKt8SMcJk0F3hgqFpWNwbp7J5vdT7mtg==
X-Received: by 10.66.222.202 with SMTP id qo10mr42203516pac.141.1462101340858;
        Sun, 01 May 2016 04:15:40 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id az6sm1238141pab.43.2016.05.01.04.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:36 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293155>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0adba62..6f1572d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -593,8 +593,7 @@ static int edit_branch_description(const char *bran=
ch_name)
 		    branch_name, comment_line_char);
 	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
 		strbuf_release(&buf);
-		return error(_("could not write branch description template: %s"),
-			     strerror(errno));
+		return error_errno(_("could not write branch description template"))=
;
 	}
 	strbuf_reset(&buf);
 	if (launch_editor(git_path(edit_description), &buf, NULL)) {
--=20
2.8.0.rc0.210.gd302cd2
