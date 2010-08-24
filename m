From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/32] daemon: support upload-narrow-base
Date: Wed, 25 Aug 2010 08:20:22 +1000
Message-ID: <1282688422-7738-33-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:25:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1vg-0004Dg-1m
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab0HXWYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:24:37 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60997 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab0HXWYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:24:36 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2825579pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WwCiXZowEBr36jkycqZcMWDCra5EbL253DOE+qOgYaM=;
        b=YJkq2ghIIPsMAFc7tFy/mVRTnizsytK0CkCz7g+YaMtc9JRn4ow+usiIm6exgOrucr
         XAsMpmOFYaxjp76MwZwCWlNhVTG8iCyysqTswnz6ym0XTUMX6PWNpqTEQsleh4g36Eh+
         XdqQkmfy3EkeLTQnjXEazO+PB01MhURks/d0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nRgCI43rtWuPO3UfdRnrfJ9vmAb75huTeXtQimwreihb7Cu9Lv1ynsgJJnP7f7HvFx
         Xu9XBIpCeWBiGTJ7gZTdemX8PQgnP2YXFovtnZJPDRDqxnCc/6Z060fWKag0oWQyh8Jj
         iP76u1ep1fm57Z3R/m1xJJ4kNuQae023eDZpE=
Received: by 10.114.12.14 with SMTP id 14mr8537408wal.23.1282688675932;
        Tue, 24 Aug 2010 15:24:35 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q6sm951790waj.10.2010.08.24.15.24.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:24:34 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:24:28 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154376>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 daemon.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index e22a2b7..58794b7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -356,6 +356,12 @@ static int upload_archive(void)
 	return run_service_command(argv);
 }
=20
+static int upload_narrow_base(void)
+{
+	static const char *argv[] =3D { "upload-narrow-base", ".", NULL };
+	return run_service_command(argv);
+}
+
 static int receive_pack(void)
 {
 	static const char *argv[] =3D { "receive-pack", ".", NULL };
@@ -364,6 +370,7 @@ static int receive_pack(void)
=20
 static struct daemon_service daemon_service[] =3D {
 	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
+	{ "upload-narrow-base", "narrowbase", upload_narrow_base, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
 };
--=20
1.7.1.rc1.69.g24c2f7
