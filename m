From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 11/16] t6050 (replace): add missing &&
Date: Sat, 25 Sep 2010 13:07:02 -0600
Message-ID: <1285441627-28233-12-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4u-0005Xq-Al
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab0IYTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:52 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48425 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab0IYTFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:51 -0400
Received: by pxi10 with SMTP id 10so1062331pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sptoo8R7UpGiTQakAj4li9c9xgmbGIrAnasba/8eleg=;
        b=Ox1scDHQvGjjkp6zKuJpR4Hj4fP2PWdo/bjjXvIU51fBjwwfi/zSXbJbVskHpc7/UO
         mcEOcdNqI3k6p4YZh03nHwiwwQGhhJrxsS29bDQxIuR/etHgUYGx3ZL52PYvTrgySwah
         19CCxGK02PybAzyykICoi4720ui4/tk2YJjO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QiskjbupMDaund0FXVt3cSszk+QuL3UdOMUBVTcjDBvlVF9uLJpI6lHGiV6N5OZzl6
         O2L244X96k+CzOwEOtwPF7qwoq12RlZXC/bK7EqdCaLlPIEgyI0ePasjWGp4cpig8hEh
         Jhts2ZLG3YuT2zuSSadrScVz8A2eutrB9jtqU=
Received: by 10.114.36.6 with SMTP id j6mr5638007waj.120.1285441550183;
        Sat, 25 Sep 2010 12:05:50 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157181>

Also, mark the first grep in the 'fetch branch with replacement' test as
being expected to fail.

CC: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
The modified test below was first introduced in 4e65b53 (t6050: check
pushing something based on a replaced commit 2009-05-27), with the
lack of chaining.  It is not clear reading the original or current
version of the test (before my change) whether the grep is meant to
fail, and thus whether my change is correct.  Hopefully Christian can
answer.

 t/t6050-replace.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c907523..11a0680 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -205,8 +205,9 @@ test_expect_success 'fetch branch with replacement' '
      git branch tofetch $HASH6 &&
      (
 	  cd clone_dir &&
-	  git fetch origin refs/heads/tofetch:refs/heads/parallel3
-	  git log --pretty=oneline parallel3 | grep $PARA3
+	  git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
+	  git log --pretty=oneline parallel3 >output &&
+	  ! grep $PARA3 output &&
 	  git show $PARA3 | grep "A U Thor"
      )
 '
-- 
1.7.3.95.g14291
