From: Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] t9824: fix wrong reference value
Date: Fri, 29 Apr 2016 15:57:02 +0000
Message-ID: <0102015462bcd1c3-4196e36b-515b-447f-beca-649922456098-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:57:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awAn3-0007Cp-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 17:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbcD2P5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 11:57:06 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:58542
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753317AbcD2P5F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 11:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1461945422;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=e7ugwIaI/NJcAJgcpuVt/tCt7aCkZhmGoegxzwirro8=;
	b=CheDsfY52fr9EtvKVjlc60HuUS3DLETuqoEqcgutI4BjXI8SAvNJGLmTI9qH8X3d
	pckalyQm9LbxO+02hPQMv087VMBmSjkJePHBcgEInMfoYEsqjIVmA0rmWYwxQihjbgH
	mde49f4psh/zG7isf2cu8xg2O2WdHPFcWpXytKOM=
X-SES-Outgoing: 2016.04.29-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293021>

0492eb4 fixed a broken &&-chain in this test which broke the test as it
checked for a wrong size. The expected size of the file under test is
39 bytes. The test checked that the size is 13 bytes. Fix the reference
value to make the test pass, again.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9824-git-p4-git-lfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 64f8d18..3fc6790 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
 		# We only import HEAD here ("@all" is missing!)
 		git p4 clone --destination="$git" //depot &&
 
-		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" &&
+		test_file_in_lfs file6.bin 39 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" &&
 		test_file_count_in_dir ".git/lfs/objects" 1 &&
 
 		cat >expect <<-\EOF &&

--
https://github.com/git/git/pull/235
