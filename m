From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/41] builtin/worktree.c: use error_errno()
Date: Tue,  3 May 2016 19:03:47 +0700
Message-ID: <1462277054-5943-15-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7M-0000Cn-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbcECMHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:42 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35804 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbcECMHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:40 -0400
Received: by mail-pf0-f180.google.com with SMTP id 77so9225703pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKLEVrD+0v5e5XIVY9tJEs+9ZFOYejn6v1Ggnnn7Lbg=;
        b=Hw5NISBIzqN0WEt+vgATrNFxUNHd8W9hyqn2MFcgRCNiwABbmNrs/eSdSmCDVCGCnt
         aPrMPrfOUoy6XEHIeAUBdPu+HfUTeP7FEYktBaPN5+qokgrppIhz6i5Ry1ivNlLKtMd6
         +muB7oMWFTK1Jav2wG+r2wa4yf6ydmaTGR5Qac8dyfbQ+xvIRAYNwG4izzRd/oX0Xm2y
         PyVVV6ebdFRBTbvJVvdGV9hCv/m4kl6RczEWZQXocInTaqK/gSORRFB6oZwJpLCCoLl3
         MR+g2xkqmA8i+R0ONjMiCZJwptN26G/acqscmri3HFYvnw1QNk+9b3oi42uZonY9DCpj
         /X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKLEVrD+0v5e5XIVY9tJEs+9ZFOYejn6v1Ggnnn7Lbg=;
        b=SXTtA8KZhmHrqtgFdTmvsOC5RlcZe380tXXoba9daFU/X8EXs4YjDCmSXXE+o4f/Sb
         XsTxJIqtIJydtmvd1JjLQjtBWsdiEbVs9Ejw+iCrIvPwQyHUqxH+WvsefSQ0id1pFZGG
         6PDb/RHDgPK4qMB57z7AkvT+eeK8SW92tRLHGRgZKB0aE+RYlh8OQSobRXDIHrLmHZwM
         oBUBTBECxPls51PGu+liDUWhiLTMizYATRzI4i8zucUvbkhBVHaNu2b6G3FJ5Q4QM1OR
         sUQ6JrsV9wvPw9CJy8Y8396CWf0BK7eAhqxP1bjHV3lYjV5VFsjbW5tIMefrpGxcchRP
         cUtQ==
X-Gm-Message-State: AOPr4FVLnjC+RYj6DbgcAuGYjAEfkobJuEIqEt7yPKLksWwp+k1H34ZfxNoBzfaHVtUPJw==
X-Received: by 10.98.64.4 with SMTP id n4mr2912382pfa.58.1462277259448;
        Tue, 03 May 2016 05:07:39 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id l14sm5518056pfi.23.2016.05.03.05.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:35 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293368>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d8e3795..331ecf6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -110,7 +110,7 @@ static void prune_worktrees(void)
 		if (ret < 0 && errno =3D=3D ENOTDIR)
 			ret =3D unlink(path.buf);
 		if (ret)
-			error(_("failed to remove: %s"), strerror(errno));
+			error_errno(_("failed to remove '%s'"), path.buf);
 	}
 	closedir(dir);
 	if (!show_only)
--=20
2.8.0.rc0.210.gd302cd2
