From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/16] ls-files: apply --deleted on narrow area only
Date: Sun, 14 Sep 2008 20:07:58 +0700
Message-ID: <1221397685-27715-10-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerMy-0005vw-7g
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYINNJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbYINNJX
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbYINNJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:22 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R6CZnE124F8HpUcHKhY9mi7QDPykLzJVXbSO3GKWFbs=;
        b=m0utPFXh3zuR24yf723ZcRl9+x4tcDBLrlpQcccphMP/bXGUaTf+r+4q06BKCHir/6
         ZZ4mY2B4hsExUzcAdJVCT5AZjDCz07xID0qm5b5fSnP9ZXPA7YCuHTEr1eLhW9RFe4Jz
         nVEYxIwJ18r1KdxfLh+62r4XpDgdWZpJOmDTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CAJQOtVtv0KIl1F5JGe3l62h9blR78pgL7UUdfMkCZQtkFqhN+w9iNripXXN8bw/2v
         h+U8S6F+k3dSoM6EClu5E368gHk8SJi7kaTreIwFihi/L3JNNY++mflwlhDdtfq+9N2u
         wFOka1a8a59jloIlCGABdsGUf63G1NG3k22bs=
Received: by 10.142.82.6 with SMTP id f6mr2268577wfb.43.1221397761704;
        Sun, 14 Sep 2008 06:09:21 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 22sm20081109wfg.13.2008.09.14.06.09.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:14 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95836>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c             |    2 +-
 t/t2104-update-index-narrow.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 456d41c..02fa00b 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -260,7 +260,7 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 			if (excluded(dir, ce->name, &dtype) !=3D dir->show_ignored)
 				continue;
 			err =3D lstat(ce->name, &st);
-			if (show_deleted && err)
+			if (show_deleted && err && ce_checkout(ce))
 				show_ce_entry(tag_removed, ce);
 			if (show_modified && ce_modified(ce, &st, 0))
 				show_ce_entry(tag_modified, ce);
diff --git a/t/t2104-update-index-narrow.sh b/t/t2104-update-index-narr=
ow.sh
index 2683929..1a3acdd 100755
--- a/t/t2104-update-index-narrow.sh
+++ b/t/t2104-update-index-narrow.sh
@@ -25,6 +25,12 @@ test_expect_success 'index is at version 3 after hav=
ing some no-checkout entries
 	test "$(test-index-version < .git/index)" =3D 3
 '
=20
+test_expect_success 'ls-files --deleted ignores no-checkout entries' '
+	rm 1 &&
+	test -z "$(git ls-files --deleted)" &&
+	touch 1
+'
+
 test_expect_success 'update-index --checkout' '
 	git update-index --checkout 1 sub/1 &&
 	test "$(git ls-files)" =3D "$(git ls-files --narrow-checkout)"'
--=20
1.6.0.96.g2fad1.dirty
