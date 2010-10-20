From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit RFC/PATCH v3 11/12] tg-patch: use ui diff when pager is active
Date: Wed, 20 Oct 2010 22:17:56 +0200
Message-ID: <cb28181bc3cc0cfbf19926aa9dabf3d1d1f643b0.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
 <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
 <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
 <3d4e3b72d48a5227fc7a22c0e55581114a75f1b0.1287605587.git.bert.wesarg@googlemail.com>
 <1bf3b3656a23c2de123c749524fcd6df09d9bf87.1287605587.git.bert.wesarg@googlemail.com>
 <8bd4da13a1c992ece87b4c742d75dad3b6776acf.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7r-0005GB-5X
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab0JTUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab0JTUSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:32 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3063004fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=b8An8Nnt/Cfwurvvk/n+9vXGjxyKYtUizDYnKNPh7Bg=;
        b=BcjQqYictuayzYCGKC1sIWU72hZSXIrTx64Kmor/8EAMClBohlgIUtMQIDcap29aeJ
         C+Tb7xGEEXI2LIlCjKzNDv0WHo9pGOtpfobRsqWGUDB+cQw8edWqC8RYWBUa41JRvRwr
         MbgGuwSL/W0/pJa9HkeFCMnUeaFdR6QyaanEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dU0YVxZLxnK2UC0N9rbdJp3haoJwrXbTiE9HapuvbK5BRQX2MOMhNiPVhvLZaZVtaU
         H47eBquMSv1tJr5yTZ0uyaLQ/fy5UwjejNIBFzyT+Y76TWxyHEcSzdA3gOkt4GctDDwC
         kZF202LoaBWrajKsFiUaC5vZ1dSDk6wPWCJ2k=
Received: by 10.103.108.5 with SMTP id k5mr6526053mum.94.1287605911714;
        Wed, 20 Oct 2010 13:18:31 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id p2sm405860fak.22.2010.10.20.13.18.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <8bd4da13a1c992ece87b4c742d75dad3b6776acf.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159436>

diff-tree should be used to generate patches meant for submission
(or non-human consumption). But for pure human inspection some 'eye-candy'
effects could take considerations. Like color, renames, mnemonicprefix,
or noprefix. External diff driver or word-diff. All these are in effect
by using the diff command, when configured in your git config file.
diff-tree does not honor these configure options but its possible to give
them as command line options too. Selecting the plumbing or ui diff driver
is best done automatically, in my opinion. And an active pager is my best
bet that a human will consume the output.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

I will probably add an overwrite command switch (to enable ui mode even
without an active pager shortly. Because I sometimes pipe the output for
inspection into my editor.

 tg-patch.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 9def6e5..dcce672 100644
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
1.7.3.1.1069.g89486
