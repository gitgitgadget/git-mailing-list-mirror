From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 34/41] sequencer.c: use error_errno()
Date: Sun,  8 May 2016 16:47:54 +0700
Message-ID: <1462700881-25108-35-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:53:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNg-0002ub-BV
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbcEHJwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33421 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbcEHJwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so13785011pfb.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk55ae8U70ffdUiKbZ1FIF6kwfb+cHM9JcPYuWAhqr8=;
        b=Ek6KEZ1xEEQbkXNAImyPPcoJJcrV78FEd+LBPJJllViD15rUkkceDTm1l/t8q6Fcs2
         r1IOm9Ufls7gfV2lkTw/xpYmoq/IWELfukYs+X2iprVRKlWbbMCly6boEBEeEamO3wIl
         IoxdOFda8j87Tbog3E9Va8sjkifu4CEBMc/IRvSswtdy8kc8bzmbrxtmqA+YKqPz091Y
         Q+tNqrOjL4P3q84C8TIgDvZuba/s5h8Dl0oOcD5/U6cQ+na4gs/7GOnIiP1rJ5PwH4aR
         U5AalyP6DOleO+xHAVHgWSmWCwxuXMYgh0mQDeq5GhyEKeiSZDU+/3bl2Rfl+dYNOgn6
         Gc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk55ae8U70ffdUiKbZ1FIF6kwfb+cHM9JcPYuWAhqr8=;
        b=GYsXZGrTVZzgEW5r+Jix6QqD9DhCtQm299CzJawfYB5nhYkUFSoUYEb/ycI7+3Fpqt
         XeU+5Vpn3HYA3v7r9snNc9oi8f0kp7IqK+SXNpsj6t6wxamJC7Z8RDckZiMRG2FYvbRL
         chq8nCMi/VTw/rj8xHjUnebb8GXkqA1r07tiYB7KIaDX06G2TrhUfFNZsnPXdiYBq74S
         UirpKQ6PnchqVjm7iSZeVNHOugS+0GlCh192xqPXhsMjs8zNERWYTYAKFaWQeRj61Jks
         wdX1TOYVnVMrU4N27pv43pw6Vm6VwijMFC6E3n0VA1XQXQvw8GGgZczTJrnAMRFVhmUE
         FwVQ==
X-Gm-Message-State: AOPr4FXxJ8TooeVIrla3JZpi0OycE60C64AY08K9MyYN13zoTJBp1nu3u7rhFPAuzi7cNg==
X-Received: by 10.98.27.78 with SMTP id b75mr41949027pfb.49.1462701121642;
        Sun, 08 May 2016 02:52:01 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id az6sm32833329pab.43.2016.05.08.02.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:01 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293948>

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
