From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] t0008: avoid brace expansion
Date: Thu, 10 Jan 2013 00:49:12 +0100
Message-ID: <50EE01F8.1070109@lsrfire.ath.cx>
References: <50EC8025.8000707@lsrfire.ath.cx> <7vr4lvcstt.fsf@alter.siamese.dyndns.org> <50EC8BE7.2010508@lsrfire.ath.cx> <7vboczcq5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 00:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt5Ou-0003e0-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 00:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180Ab3AIXtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 18:49:15 -0500
Received: from india601.server4you.de ([85.25.151.105]:37277 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab3AIXtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 18:49:14 -0500
Received: from [192.168.2.105] (p4FFD9E2F.dip.t-dialin.net [79.253.158.47])
	by india601.server4you.de (Postfix) with ESMTPSA id CBBFEB4;
	Thu, 10 Jan 2013 00:49:12 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vboczcq5a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213111>

Brace expansion is not required by POSIX and not supported by dash nor
NetBSD's sh.  Explicitly list all combinations instead.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t0008-ignores.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 9b0fcd6..0273680 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -129,8 +129,9 @@ test_expect_success 'setup' '
 		one
 		ignored-*
 	EOF
-	touch {,a/}{not-ignored,ignored-{and-untracked,but-in-index}} &&
-	git add -f {,a/}ignored-but-in-index
+	touch not-ignored ignored-and-untracked ignored-but-in-index &&
+	touch a/not-ignored a/ignored-and-untracked a/ignored-but-in-index &&
+	git add -f ignored-but-in-index a/ignored-but-in-index &&
 	cat <<-\EOF >a/.gitignore &&
 		two*
 		*three
-- 
1.8.0
