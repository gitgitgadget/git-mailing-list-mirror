From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/41] builtin/branch.c: use error_errno()
Date: Tue,  3 May 2016 19:03:38 +0700
Message-ID: <1462277054-5943-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:06:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6M-0008Cq-6K
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbcECMGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:06:44 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33665 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbcECMGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:43 -0400
Received: by mail-pf0-f179.google.com with SMTP id 206so9339048pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSYZtZdQ1hMu3kH39epCcbIjTQHXgwQeOn7XFD/CKMI=;
        b=y9v+31+8I6pZNvfQFd5NBJ5VsHr2zl7dt1cFZ/I1Myx9pYVPaTfXYmicFS+TU4sjvG
         h0SL7P7vS7Zsy4Lh13Uj5FQVFp6OMiFyULpB9zClC9QWvuKCKD/cTRCeKOo97GNSYq52
         haaASqJzOqalHVUiV9sV+YKmYh3AKrX6chciTKMhKxP1xUzjr6bfrVUp4xM4QlHBVxMR
         WwFFRUDmlwFgnzheH6HbEx1GQtznWGDQ2TWehE+uzl0WC7ZjUNj7/t7BvQOeYwSAYQPH
         CmroxW1djUK5qLgGTZMCOzKVNRLH3Ica2RgoI0IFLbWtDs3xX6Xxizrse8eiYKpItBKu
         H5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSYZtZdQ1hMu3kH39epCcbIjTQHXgwQeOn7XFD/CKMI=;
        b=FtRBaF3Y5VKwT/h0BUX2ChBsAyKV/F4Dd0CHDYKaKXu1mcfIqfKdyv4msq0fiuJoxR
         KSJGrCHabHaBLB0qVOcIVTEfuxGfDUYJN7lEZGOqeKFr2YBVEvfoeXk/5bUWM39hTUAS
         YkqVIxpmPDmO4VmDbMtDfLomXhwNZos4my6VQ9tPa/Wbu+Z2WjixGamZlqlNwCISfw/Q
         liJBbjAbBh3Byf0a93guUxOYMUSS77C8Wei1y9yAorAEeQH1V6p3qgCGKHl/jqen2LiB
         2mT63qy8UcD15v8ZGXV91x8QLzMueiodCT5bYlCQDLy09v0t3UvWroxukr3/2grbHqnq
         M+2Q==
X-Gm-Message-State: AOPr4FX43c0IGvNkuIt+GgQkoxeJ9/ZqtxBpHutrYUptjMPIosMWybFAz+komeyDTpsxCQ==
X-Received: by 10.98.76.22 with SMTP id z22mr2914915pfa.78.1462277203173;
        Tue, 03 May 2016 05:06:43 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id y66sm5487063pfy.66.2016.05.03.05.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:39 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293359>

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
