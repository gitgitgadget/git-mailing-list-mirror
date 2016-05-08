From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/41] builtin/branch.c: use error_errno()
Date: Sun,  8 May 2016 16:47:25 +0700
Message-ID: <1462700881-25108-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:49:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKm-0008MM-5p
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbcEHJtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:04 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33346 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbcEHJtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:01 -0400
Received: by mail-pa0-f68.google.com with SMTP id gh9so13694046pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSYZtZdQ1hMu3kH39epCcbIjTQHXgwQeOn7XFD/CKMI=;
        b=mmJLby01PN6Udn5dNamMccQEuolJvBn0CIRvxev5wUQBorZZt3YwCwM47W7a3hnVfC
         9cW306gvFzdDwCqhvkV9upFzYRmSC7UZK6xwp0kaEyG1O453Nvtu2/YA27cBslvNjRCG
         btd92I1XvWizhge0dpVNYbh9+gRmkgi6zovYLLf7Xh7EQnjObWnmKpgVClxJQ/lcUvzn
         cibOvmbQitPr55icl3nXjf3EAy203YNZQkUEoOkneUzo+yGg5o7kUnfabA/jlEtrgj+r
         6dwimLmJQ5ZBjiVxXYonfeT6BYesJ2rIn/9Ub3p/PXUiJRatySPW5Uvm9EuSG1HKhxrQ
         /1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSYZtZdQ1hMu3kH39epCcbIjTQHXgwQeOn7XFD/CKMI=;
        b=MZ5naUktemmaG6+2YQuI/uCO19iDhXYnESktsExuZzwL2K3GEHBRuus+N0k+BXguvC
         hFj4dtN4ei4fkQhCgBzjMRr3kksiWU/o6jr0aUgNBi+giJEyPr11fA+zWinv3Xwt9dBJ
         Wfn/0viR9k4e24PAsMy+tXqDfp/zucMSz/aFiJIu4hsAMLpzN+7jQv1VNnmnnuh1MxnY
         H6lpYHHjah2h29xvILJBhw2gGMy5BC50ZLFW0CiDZd9O4vWxS4mi31HyM3O5KNjYT3aT
         27C8B+asy8cShpi0s+g/19T9/XGNB62XYbSRVPOjdc21k2k1Q8QJS/vXJgtTC/9QD81s
         zFJw==
X-Gm-Message-State: AOPr4FUjeohAgOEmx6Dc2K7pO05wB6Yut8K6FGKLKkAlWyM3IJsVsluYgGq1gVFBd4U0DQ==
X-Received: by 10.66.156.232 with SMTP id wh8mr41896416pab.153.1462700941055;
        Sun, 08 May 2016 02:49:01 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id ba9sm32838701pab.24.2016.05.08.02.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:48:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:00 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293916>

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
