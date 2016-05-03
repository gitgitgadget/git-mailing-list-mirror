From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 34/41] sequencer.c: use error_errno()
Date: Tue,  3 May 2016 19:04:07 +0700
Message-ID: <1462277054-5943-35-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:09:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9G-0001Gu-U4
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbcECMJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:46 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34083 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id y69so9211401pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uk55ae8U70ffdUiKbZ1FIF6kwfb+cHM9JcPYuWAhqr8=;
        b=oZObJ3MYc37KhPc9GHzjW6A8EpXYiSQPgMjNbqTpixTWsbbFFzq8pcC2InvYbO6B28
         ErMWeUKPybyj80P0kCxumaYqgVfJQs7q8Iip/G1nOtymU1PblTtXNd6x0OHKHvSHEKqv
         ymHjlV35iz0Yu+082VfZs/yGj1aEe2FIy7LOdMVHABGat0GsKFhXuWQxBboNNp5v5wB8
         JXVPeGVuds/EyKUmsObL9soaTSJPYfc3WaeSHUJQxZtrNJcZqZmE1fmqp9y4K+FxC0I6
         4FdBMKxH4ntC1KFoDgbtffttmvlpQvuZlgtQkg53lxdOCh2SIu8wQ5y5ESbxDRfqgyyS
         y4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uk55ae8U70ffdUiKbZ1FIF6kwfb+cHM9JcPYuWAhqr8=;
        b=CDZW31XH2uxX9IDJUEHMu7YQCCDO+KFJjz7jjP4SRiKkwqS9rHA5L/QRShaQD36s2B
         o+gFyiRB1Nrz+7leFCEA9L1r7ZG2qqqgQAuABFieZ8MeE4uw2YFOQV+YTaONm6ZlGPFk
         oheoHLWZpbmCz31oZtzbJ/o6ygs/+1Lh0JQ/gmLVrXDZFci/ua0lBDLg0fcmPzwdasFr
         LJva4aHD0un2gv0ZGwXdMnE01ca4yEvpDXOI2kmT6IWgO8Xqjq6pJTv0aG/fel/rS6hG
         L23cXMnXm1ZFkavsC4CIGNyy7GBJZJPnaNFt9nK8DfAY+ShiZHhGO3BX8nTNlYl821Q0
         f1Aw==
X-Gm-Message-State: AOPr4FXl2mN0gwlfDaZnkoJbVBm4s45LtF4e3HdUyVjQMvuULMpEN0Rf36lyuUvTClrKWw==
X-Received: by 10.98.32.211 with SMTP id m80mr2898644pfj.3.1462277384557;
        Tue, 03 May 2016 05:09:44 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id n10sm5536725pfj.14.2016.05.03.05.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:40 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293387>

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
