From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] streaming: allow to call close_istream(NULL);
Date: Wed, 16 May 2012 19:02:08 +0700
Message-ID: <1337169731-23416-1-git-send-email-pclouds@gmail.com>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUczf-0000EZ-AF
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab2EPMGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:06:05 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38428 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2EPMGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:06:04 -0400
Received: by dady13 with SMTP id y13so898350dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MHyN30sf9Lt9ypDgjpJVZaygM8EciTK0+t8BjHOeHIY=;
        b=SGLMXglperjd1fpwKF7ySr5GGREAgDXDq5fAj0PTSav40w6k12W5A1om2CDlDMfvgj
         ec9jbbUJwc/qow4JGf+/2xsrH0hr/xQ+I8weGyarMgWjXYeay++9n+bCNC2vsTcYajkJ
         VG+zK5UuRHcPFtfcH1X+EXXMueycAH1cNz3HaA22RRN7ZGb2IYDil0LVcHnI1ipSnHhn
         qDjocuOrR6uV+xPnEjVhLTodI/TMOwhELIWqkPnWO47aLZJb9P/pDybS36pCdmiZ1sFd
         iQulnzxxlCusAHAIPx+vHWqmISvbwdEJ1G037UGGeSSHFsq7zlk7vn2nqgFGKkg8wjHe
         73vw==
Received: by 10.68.138.196 with SMTP id qs4mr8551755pbb.149.1337169963656;
        Wed, 16 May 2012 05:06:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id tx9sm5280756pbc.10.2012.05.16.05.05.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:06:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:02:12 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197869>

This makes it more convenient in cleanup code, like free(NULL).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 streaming.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/streaming.c b/streaming.c
index 3a3cd12..38b39cd 100644
--- a/streaming.c
+++ b/streaming.c
@@ -94,7 +94,7 @@ struct git_istream {
=20
 int close_istream(struct git_istream *st)
 {
-	int r =3D st->vtbl->close(st);
+	int r =3D st ? st->vtbl->close(st) : 0;
 	free(st);
 	return r;
 }
--=20
1.7.8.36.g69ee2
