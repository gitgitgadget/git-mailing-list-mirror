From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v2] tg-push: add bash completion
Date: Wed, 27 May 2009 01:31:34 +0200
Message-ID: <1243380694-7744-1-git-send-email-bert.wesarg@googlemail.com>
References: <1243377428-27546-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 27 01:31:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M967Z-0000ea-KO
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 01:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbZEZXbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 19:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbZEZXbj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 19:31:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:3682 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZEZXbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 19:31:38 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1062331fga.17
        for <git@vger.kernel.org>; Tue, 26 May 2009 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yLkcub1aiFZ5iwXq4Y+/iyb7+nXI4URk1I+gg/yQE8g=;
        b=iMCmnCaiBcWoG9QPQF7CZ8Ml63hUhRKh2d/dqi7aDrCNMLwqKAeOZwO6Wd2GnZ6YnB
         5MpDVnqugvvAcRuTtRo8+d0o99sMHA6ewduU/avhaZC3SgwZxT93wVoNt+LUu0Z1DzFz
         q6+88Y3XUwjot+7e9zu3tI4sTyxu1PM0RUR4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cgc62tK3dHseMrEtYw4mQYoktCqIBy+T//TbtSVkkwNikHpis6ZsNzv/X20P2ZV7Vm
         ChTroRZt3kcaIvL8qcpDbVMeUoWYfebEulorIoJkzhHkgAgODTW8ogJeZr/ryaQt4+go
         2UollQ2Dfoi09uwQ3TmTldbnrZD7Ift4AgcFE=
Received: by 10.86.70.20 with SMTP id s20mr7641725fga.1.1243380698288;
        Tue, 26 May 2009 16:31:38 -0700 (PDT)
Received: from localhost (drsd-4db3d3cf.pool.einsundeins.de [77.179.211.207])
        by mx.google.com with ESMTPS id 3sm825687fge.19.2009.05.26.16.31.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 16:31:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
In-Reply-To: <1243377428-27546-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120017>

Include all options.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 contrib/tg-completion.bash |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index de8a7b5..0ee233c 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -370,6 +370,29 @@ _tg_patch ()
 	esac
 }
 
+_tg_push ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	__tg_complete_arg "-r" && {
+		__tgcomp "$(__tg_remotes)"
+		return
+	}
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			--no-deps
+			--dry-run
+			--tgish-only
+			-r
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
 _tg_remote ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -449,6 +472,7 @@ _tg ()
 	info)        _tg_info ;;
 	mail)        _tg_mail ;;
 	patch)       _tg_patch ;;
+	push)        _tg_push ;;
 	remote)      _tg_remote ;;
 	summary)     _tg_summary ;;
 	update)      _tg_update ;;
-- 
tg: (b725fc9..) bw/push-completion (depends on: master)
