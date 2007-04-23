From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Fix tail option problem in test
Date: Mon, 23 Apr 2007 19:56:58 -0400
Message-ID: <462D47CA.7010806@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 01:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8P7-0004jD-26
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbXDWX5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030792AbXDWX5D
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:57:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:63872 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030342AbXDWX5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:57:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1984535wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 16:57:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=q8HJiqamscUmzkgxw9lrlSmHa8NGG7KRdMTkQIwa1oFQ2R7O5T3a6O0hSTBBRaRU4IugIlTW3nckuYiRaf0WXljv/XlNjPUzMJ2Rzh4iBhML+w1B7M9dP1yT8lyXwvnCk/dSqLZuF3k88pe3iE5jvhX65apzGOdiyJIg7au0e0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=EaSVZ0Aya2DXxFyXe5GNWwk0NeFdM1NSohdgaTS/Sbt5P0OQxY0Oq7A4subnMHUqf86t2LKJ9r/mVanMTHwAomKlLs5TRfDpxcePOpjd8bmLp6IYylGbxrAyKYAB7Zs64nLNubPYTbsVo8c4vKyAV4c/NIimb8G0BL2ZxdSGnP4=
Received: by 10.70.129.5 with SMTP id b5mr3333546wxd.1177372620243;
        Mon, 23 Apr 2007 16:57:00 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id 8sm7121782wrl.2007.04.23.16.56.59;
        Mon, 23 Apr 2007 16:56:59 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45385>

The tail command on my system complains:

	tail: cannot open `8192' for reading: No such file or directory

if there is any whitespace between the '-c' option and the byte count.

Signed-off-by: A Large Angry SCM <Gitzilla@gmail.com>
---

 t/t5302-pack-index.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 232e5f1..b7870a8 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -16,7 +16,7 @@ test_expect_success \
          test-genrandom "$i" 8192 >>file_$i &&
          git-update-index --add file_$i || return 1
      done &&
-     echo 101 >file_101 && tail -c 8192 file_100 >>file_101 &&
+     echo 101 >file_101 && tail -c8192 file_100 >>file_101 &&
      git-update-index --add file_101 &&
      tree=`git-write-tree` &&
      commit=`git-commit-tree $tree </dev/null` && {
