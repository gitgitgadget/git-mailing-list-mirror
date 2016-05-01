From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/41] diff-no-index.c: use error_errno()
Date: Sun,  1 May 2016 18:14:38 +0700
Message-ID: <1462101297-8610-23-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNI-0007YW-5J
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbcEALRP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:15 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36010 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:14 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so16178424pag.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ixKnY5jHiqlgjhRy4Dh1VQCzCIoB5KlROrcgSjkOfmc=;
        b=rpDLwP0/pdETdH39mG0+nuKLtIxs1tUNOqXlbW0uKFhgrztXpMaulTe2tOT5L01XN6
         TxoOKVXamfgHKHG0o4hov2yFAqw0J/yiQ5ZtdwdTClJZyDidV04iTRC2TUSwNBBwb2Td
         BPxQUwlsRLd2uhKoj5pn9mddSYLPYjbDmquGpfZUkQ6poUePl++FM//Gqsx+nqCPKQ8v
         2IThg6Bds+niQhb6llJBdXWAwdUDpJmYyxJ5BG9Gntp58Zk/fDxztleJMlZNpRrW+WvT
         439Gg1TBT2hCfqIOJHExk0yYZluEEFVZQsptQ450Hk3XKPpCZs2pP/hIbe03iLOMV2lJ
         VXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ixKnY5jHiqlgjhRy4Dh1VQCzCIoB5KlROrcgSjkOfmc=;
        b=UIA3kWb2xA4jsiRPeeC8b+eNffEiXk3LhPvxt9zzx3BM1CKutt4JKflAszTk/6eb8B
         YGpJJfy6DOXe22w+YnKi/ZBC8Gh35QClLCbdPIuqacBlDisMLTuwwjvhCN5795sqbpru
         mr2TQkqM+Pv7X9Mlm79H8abNd0W9dnqQAnNJbyhNODr1hPYc96aGLwkUduOULqrYOuPh
         sCGrH1nBe80LDIjn/h5iOWitJo1Dwi4Ofih5+q6gqeCDZmtLSwdNu/gzy8cxDEkO+pL/
         R9FoJJlQIuxMlulsKPK6uOaOPwDW5/T3HTU33L2I+gnacwHkVQNW9cKZPbR6m+uBw7Pq
         +UHA==
X-Gm-Message-State: AOPr4FUy0C55ogoSHQp5ji5q6QSMK3W0ePXBIzuBwbhC4ciml7h1RRTmlLzupqrnof0A8w==
X-Received: by 10.67.15.9 with SMTP id fk9mr42850681pad.77.1462101434027;
        Sun, 01 May 2016 04:17:14 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id uw2sm37393927pac.10.2016.05.01.04.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:09 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293172>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 03daadb..1f8999b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -65,8 +65,7 @@ static int populate_from_stdin(struct diff_filespec *=
s)
 	size_t size =3D 0;
=20
 	if (strbuf_read(&buf, 0, 0) < 0)
-		return error("error while reading from stdin %s",
-				     strerror(errno));
+		return error_errno("error while reading from stdin");
=20
 	s->should_munmap =3D 0;
 	s->data =3D strbuf_detach(&buf, &size);
--=20
2.8.0.rc0.210.gd302cd2
