From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/41] sequencer.c: use error_errno()
Date: Sun,  1 May 2016 18:14:50 +0700
Message-ID: <1462101297-8610-35-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOK-00088y-0a
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbcEALSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36845 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcEALST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id p185so18817354pfb.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk55ae8U70ffdUiKbZ1FIF6kwfb+cHM9JcPYuWAhqr8=;
        b=THFYeAoHlgKe73kHlOmp50yKbpNpJPg2YtmPf6vNHWsmHJ7pUvyJ1lU04c81WqxbHa
         ueuwo0rbaR0N/B1Wxizhq9X21YtGyvq5Ue7JQrYaLIF+K54TrmXTFHrmLLWaBYTbU9rH
         2tm7y1ns1qfNlRny96scVsw7NlfwO9Mona5ULsF/Jh0SJ08IFEazIGz5u3ep52U1BQIx
         5GOjGJEzWRGwzDWq/y3k7XzkYBM1rBpwI8NgBxXc1HgY/YNUwaGR5iBefSp60DFPwpUK
         QD2/sneTDHOxkeLrWIRGLIyjfgo4yXhMO33y08md+uOzcDNRS0nc2HkkiX0J342WmgNg
         Wy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk55ae8U70ffdUiKbZ1FIF6kwfb+cHM9JcPYuWAhqr8=;
        b=cNiej1fT7rGjrU0M/FemVc4K6cMAx2fb7YqVU11VMH+S0zStzjSULZPPzRxg5u2CND
         6p3FEsrD+e4e1Ph9I50B99jl6VPBYleB5AD6lrcZ5DzcoD9DD28cIrrIg2Jh2RzGe+1v
         LyDYonHu8YTidIm5HqlRl+cjuDke8qkx9JEAENLASFGBKSBByHvBUi32GD014n84+T/d
         YAwqTdA3HzUNojiIf+OD93nnZLtmkr2ZDnTQ4VGoNgau5rSMeAimTIpegWviS4EreI5s
         KG1zxbAQ4Bo2Y67EzuxhcDDBr6uzb2amP7DebY7q0U1LIw2S6BeJ4qJ9aX1uTtsNa5xv
         yoeQ==
X-Gm-Message-State: AOPr4FU0dMJCuwMuNlKDYbtEdEwJ23hcnVR+Z6U89wt9s009R7oPuljvsjc+ih0l8MaQIQ==
X-Received: by 10.98.86.141 with SMTP id h13mr43135647pfj.99.1462101498958;
        Sun, 01 May 2016 04:18:18 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id w15sm37059304pfa.34.2016.05.01.04.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:14 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293184>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sequencer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e66f2fe..4687ad4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -875,8 +875,7 @@ static int sequencer_rollback(struct replay_opts *o=
pts)
 		return rollback_single_pick();
 	}
 	if (!f)
-		return error(_("cannot open %s: %s"), git_path_head_file(),
-						strerror(errno));
+		return error_errno(_("cannot open %s"), git_path_head_file());
 	if (strbuf_getline_lf(&buf, f)) {
 		error(_("cannot read %s: %s"), git_path_head_file(),
 		      ferror(f) ?  strerror(errno) : _("unexpected end of file"));
--=20
2.8.0.rc0.210.gd302cd2
