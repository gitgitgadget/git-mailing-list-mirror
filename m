From: Jason Sewall <jasonsewall@gmail.com>
Subject: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Sun, 22 Jul 2007 20:59:11 -0700
Message-ID: <11851631511468-git-send-email-jasonsewall@gmail.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
Cc: gitster@pobox.com, raa.lkml@gmail.com,
	Jason Sewall <jasonsewall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 05:59:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICp4p-0008BA-IT
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 05:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXGWD7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 23:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbXGWD7Q
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 23:59:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:2055 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbXGWD7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 23:59:15 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1025384nze
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 20:59:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WILmohJhixR7DJhw8108NSXExjg6HU4DpMxY4NKvMRjRC3U09DUgZnIeuBmjXKqeK8ukxSHzfMcVENncDKL8VFbOTKV8y4Lo1AVYHwBqnQO9XueLaOtbY0qaTNkJlmrG5m083xo9mnv2G9MSfXVwhBHG7OufsYkx42dVELzp+00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ua2YAD6r7ofEgat7I6ugfTyBssKoYYFeKWKANgoI/5Z6IGEXr71Ds28Tu8Ay2tUXEdRp4gpkoHdHSNYWkmbTaTH4HbcnlSxsrnxvTH0s4KJJgsFXDC3mrWan/9isLuorl6Su56+KhEZyIjtdvsqA1yLZVSV783J6nuPjnuNIVU0=
Received: by 10.141.210.5 with SMTP id m5mr810048rvq.1185163154467;
        Sun, 22 Jul 2007 20:59:14 -0700 (PDT)
Received: from localhost ( [76.102.148.137])
        by mx.google.com with ESMTPS id c36sm6399407rvf.2007.07.22.20.59.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 20:59:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.29.gc4640f-dirty
In-Reply-To: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53385>

Test #7 of t9200 isn't likely to succeed because tests are executed too fast for cvs; add a delay to give it a chance to succeed.
---
 I think I didn't send this through the proper server, so here it is finally.
 t/t9200-git-cvsexportcommit.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 4efa0c9..2096e59 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -164,6 +164,7 @@ test_expect_success \
       git add "G g/with spaces.png" &&
       git commit -a -m "Update with spaces" &&
       id=$(git rev-list --max-count=1 HEAD) &&
+      sleep 1 &&
       (cd "$CVSWORK" &&
       git-cvsexportcommit -c $id
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" = "with spaces.png/1.2/-kb with spaces.txt/1.2/"
--
1.5.3.rc2.4.g726f9
