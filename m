From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 10/11] [RFC] tg-patch: use ui diff when pager is active
Date: Sat,  9 Oct 2010 22:57:01 +0200
Message-ID: <58dbd71af776b1fb088080129a65c623b1dea926.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
 <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
 <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
 <65565f00635372ad3677c0187c33da4d3ceb4b73.1286657607.git.bert.wesarg@googlemail.com>
 <3f39e999ea8aeca5c7125e8981aeffb8cd92d472.1286657607.git.bert.wesarg@googlemail.com>
 <320cfcab44939419b5700daa6c356648becc2004.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:59:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gWI-0000ZT-FT
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760631Ab0JIU7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:59:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760619Ab0JIU7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:59:48 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=RoZ8p7SH0q0s5WOKNBF+Au+DJ0xCdQXasrYEKHD6fJ4=;
        b=xdChJyC37yd2lIBZ+Ak/i5DqtcQoYr2N0iZlI1Q303v9r+1OYWO+frGiTZfatPHxnD
         xuuwkz2xLd8sA4pAf6irMVKq+byvVSLL3sxVrsSai65NdYQ6bJEeCgYVLhcXK8JJMggy
         rMvOkFTo2to0busO309KdEkxEEygg/mRqm3rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=areMZ519VxusLMGqg91UtItlX+FfWecf4pgk1+oQDo7g12u6TJ5j0ZuwoTFlrURLuz
         APBxv8pfEnkPckvPidE5m3ZgGObSY+WhvaQLwWfhYsktrrnzcQVjLelxpadYB9vR4AR5
         YM3e2TdsesCqzaF0rXKQqtz4XiTxi/PdAnCtk=
Received: by 10.213.29.208 with SMTP id r16mr861451ebc.58.1286657988267;
        Sat, 09 Oct 2010 13:59:48 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id v8sm7835886eeh.20.2010.10.09.13.59.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:59:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <320cfcab44939419b5700daa6c356648becc2004.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158620>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-patch.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 9def6e5..dcce672 100644 tg-patch.sh
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -70,7 +70,12 @@ t_tree=$(pretty_tree "$name" $head_from)
 if [ $b_tree = $t_tree ]; then
 	echo "No changes."
 else
-	git diff-tree -p --stat $b_tree $t_tree
+	# use the ui diff command when the pager is active
+	diff_command=diff
+	[ "x$GIT_PAGER_IN_USE" = "x1" ] ||
+		diff_command=diff-tree
+
+	git $diff_command -p --stat $b_tree $t_tree
 fi
 
 echo '-- '
-- 
1.7.1.1067.g5aeb7
