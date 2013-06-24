From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 04/16] bash prompt: add a test for symbolic link symbolic
 refs
Date: Mon, 24 Jun 2013 18:39:14 +0200
Message-ID: <1372091966-19315-5-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:43:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9rS-0002tJ-K4
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab3FXQnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:43:23 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:50301 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3FXQnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:43:22 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M8X4h-1U5dRt0FN5-00wF8S; Mon, 24 Jun 2013 18:43:18 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:APDeVZR2rn3O0WxTe+0+PS0VJggkzZpx3GsAvhty0Il
 J+e8ytoH3nLB92ZiTB/Jxo31rVkujL79SzdQuekXIDOCXDnrZF
 2GzsrlldF8lYR8tFcvN3XugF0Pccf3a1eqmQUhBB7QmdGwMTNo
 b5HYQboWdRsgNtk1Sy2dLUDnlZyeapfo+9eZqD5zvcuWf9tRCD
 JKSHXeunwl9enHWHAJ1rBquUZFFiMYzQb8X4ZO61OfZlBzGJp2
 9Dv+M+A6ArkHoxyYbuz2u9OHA3/Z95oMZqUScMfJ3J3PVpi1n0
 ewdGqe6zn2c/0HFOWi9ICZeBts3PGmWxjE94zBlEuefw3y4E0E
 fKyPLUrPczLSBoOxqBVYqmSnmcmrPnU1KvSPxoVsDugAmhXpSh
 N5iT99rwmTo9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228855>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index df36239a..416e6219 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -40,6 +40,15 @@ test_expect_success 'prompt - branch name' '
 	test_cmp expected "$actual"
 '
=20
+test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
+	printf " (master)" >expected &&
+	test_when_finished "git checkout master" &&
+	test_config core.preferSymlinkRefs true &&
+	git checkout master &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - detached head' '
 	printf " ((%s...))" $(git log -1 --format=3D"%h" b1^) >expected &&
 	git checkout b1^ &&
--=20
1.8.3.1.599.g4459181
