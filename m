From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: setup git repository
Date: Tue, 26 Aug 2008 21:32:42 +0700
Message-ID: <1219761162-5942-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 16:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXzcQ-0004Nl-PJ
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 16:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075AbYHZOc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbYHZOc6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 10:32:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:19917 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbYHZOc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 10:32:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2338241wfd.4
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=i6EwzJtCOWxlADYnwL6ZCwcCR3QgBdz6olz+4Dop9fA=;
        b=tPuIjMdkCHBcY3sLp/84tRaf90kiGzNoGUiN+m1gHoWb1/fZCN21vSnYJMfREyMDOc
         WZM31PdAWRR1BeY0YLzyxIKOsDcTFj8vd5Bpy3ORlv5Arj/xsIcdJW+6vJv9vDu569sh
         Fe1hReQ7dqT5AweLcXMEm1b9dkNk+iVIMH52o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jvRRhEi/WZK4dJdLuL7KqzQzdfx7h+1y9KeYq5NbT+AAIL/i8B2nfbcu21/d1zcgLy
         kcmzdsEA6f76dvtR8jjjDKOvMvJUGg6LUshpViepzaUGl/+wUTT9SDYNJjEncCHADcfL
         coIWiU/ZgytQLqsOZUJapZJC8+XIUlM+drPxM=
Received: by 10.142.223.4 with SMTP id v4mr2022541wfg.172.1219761177405;
        Tue, 26 Aug 2008 07:32:57 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.134.57])
        by mx.google.com with ESMTPS id 20sm3893320wfi.11.2008.08.26.07.32.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 07:32:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 26 Aug 2008 21:32:42 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93747>

"git index-pack" is an independent command and does not setup git
repository while still need pack.indexversion. It may miss the
info if it is in a subdirectory of the repository.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 index-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 52064be..728af7d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -876,7 +876,9 @@ int main(int argc, char **argv)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
+	int nongit =3D 0;
=20
+	setup_git_directory_gently(&nongit);
 	git_config(git_index_pack_config, NULL);
=20
 	for (i =3D 1; i < argc; i++) {
--=20
1.6.0.96.g2fad1.dirty
