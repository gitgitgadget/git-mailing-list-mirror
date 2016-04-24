From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t9824: fix broken &&-chain in a subshell
Date: Sun, 24 Apr 2016 13:50:21 +0200
Message-ID: <1461498621-25422-1-git-send-email-szeder@ira.uka.de>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 13:50:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auIYv-0003cR-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 13:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbcDXLuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 07:50:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41258 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770AbcDXLup (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 07:50:45 -0400
Received: from x4db27354.dyn.telefonica.de ([77.178.115.84] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1auIYc-0002sK-Gi; Sun, 24 Apr 2016 13:50:40 +0200
X-Mailer: git-send-email 2.8.1.99.g5d5236f
In-Reply-To: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461498640.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292318>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

As far as I can tell after eyeballing the test script, this was the
only case where the &&-chain was broken.

 t/t9824-git-p4-git-lfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 0b664a377c45..64f8d18216d4 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and stor=
e files in LFS based on compr
 		# We only import HEAD here ("@all" is missing!)
 		git p4 clone --destination=3D"$git" //depot &&
=20
-		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZZZ=
Z"
+		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZZZ=
Z" &&
 		test_file_count_in_dir ".git/lfs/objects" 1 &&
=20
 		cat >expect <<-\EOF &&
--=20
2.8.1.99.g5d5236f
