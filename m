From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] GIT-VERSION-GEN: do not fail if a 'HEAD' file exists in the working copy
Date: Sat, 28 Jun 2008 19:13:29 +0200
Message-ID: <1214673209-20498-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 19:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCe0M-0003bz-Nt
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 19:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYF1RNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 13:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYF1RNe
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 13:13:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:10775 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbYF1RNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 13:13:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so467066fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=t3pMYrf5Kx6ktpFRoUK3Roracw6+mhpIG17zJK8F8NA=;
        b=TOH6s2W3Qcxb8Mxche1XHWXuCczzw55Oy7XpsoOH8gzeyiklIKyGQP7R1XjoSQj572
         YsskkgQ1+VrjztBLJtz1Tcya0MF47lXUQSbMbrnn9IYpQslrmlnsmShtw7hFMhAZFQsb
         jNOoRBBfjRx9nqYnan9A4nQm3I4gn3dsqz94c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=g4g+qQbA/AKZvsPcI2ESAfAJbeh/EiTvL3p6jkBe77arvZ5gprrqjcbKDsGsE8zS4p
         +8tMsgJ05aAbEbwmcB2n1XVG5c65K5bm8ZNSrG8HmRFS1yQSdFv3orKunOHAUbaK5JZU
         D4cukhC1jFE3yKXIAUm9xRoZj4nWv9g3loTAY=
Received: by 10.86.26.11 with SMTP id 11mr3791781fgz.23.1214673212367;
        Sat, 28 Jun 2008 10:13:32 -0700 (PDT)
Received: from fly ( [91.33.232.159])
        by mx.google.com with ESMTPS id l19sm5726125fgb.7.2008.06.28.10.13.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 10:13:32 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KCdzN-0005L4-RX; Sat, 28 Jun 2008 19:13:29 +0200
X-Mailer: git-send-email 1.5.6.1.205.g55df3e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86731>

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
I had a created a "HEAD" file for test purposes (to see under what
conditions commands would fail).  This patch allows git to still be
built even if such a file exists.

 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index f221447..cb7cd4b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -16,7 +16,7 @@ elif test -d .git -o -f .git &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-		test -z "$(git diff-index --name-only HEAD)" ||
+		test -z "$(git diff-index --name-only HEAD --)" ||
 		VN="$VN-dirty" ;;
 	esac
 then
-- 
1.5.6.1.205.g55df3e
