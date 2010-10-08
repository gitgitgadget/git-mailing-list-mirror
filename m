From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 09/10] [RFC] tg-patch: use ui diff when pager is active
Date: Fri,  8 Oct 2010 09:58:07 +0200
Message-ID: <0fd777939e0ca49b6e0013ab667cadbfae55e879.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
 <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
 <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
 <66f0cf2d3c7d2778616fa51bd8d81eb04d0528f6.1286524446.git.bert.wesarg@googlemail.com>
 <009a8ed75bd5dcee636e049b11a1bf3ca8ee6fc7.1286524446.git.bert.wesarg@googlemail.com>
 <39cbbf4b56e79fe95d603d2f1aa6112c89150bff.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qr-00020q-PB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab0JHH6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0JHH6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:34 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=RoZ8p7SH0q0s5WOKNBF+Au+DJ0xCdQXasrYEKHD6fJ4=;
        b=M8MUbUpD00HzazMsma0h3ezt5vBQGRwI/SegrPNsyLrWORsqb7xWBlQFRXBDtz2d2l
         jeBZ9ozp5MdD2llSxYPrpzE3D+3EUxN4d4DrOoDwG7mUmO0DWhG+yCz0AoX+BvcDxNrd
         jRA8TspaVOll0ma/u/7K0laxit112qjD9GvrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PYeSPeVCxlfRYUOfv5gYtKvxTTNyjun8ra5t+6Ap+23//an6eN/UxTxpZNQ5w24Mh0
         6sc1Ez6C8aAjhQTUzSVoSXchkygjlg+Dsdl+QnQhinVRl5Oeh8xwP9Z+qVpD/XbI7B6O
         fdhGsQKTV3sUhtBXnmEEVDjzI88gT/n4EvV8k=
Received: by 10.204.126.92 with SMTP id b28mr1684679bks.47.1286524713823;
        Fri, 08 Oct 2010 00:58:33 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id s34sm2404095bkk.1.2010.10.08.00.58.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <39cbbf4b56e79fe95d603d2f1aa6112c89150bff.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158488>

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
