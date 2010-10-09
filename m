From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 03/11] branch_empty: use pretty_tree and therefore respect -i/-w
Date: Sat,  9 Oct 2010 22:56:54 +0200
Message-ID: <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gUH-0008Is-39
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760585Ab0JIU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:57:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545Ab0JIU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:57:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=5jCU9SsHDDGOpMgZRj2uXCWbEW+ox6X/kFEFaviSgfc=;
        b=CBJo799jWUwrfMhIXtWnPSPl1BBmMnPQ8L+M+jfd0LNR7x2ElRMs2SitC7h/O253Pw
         FjWOhieHEJqqkCtPqb0yaL/7bCBZL8U85DSD1vwVG7tCkkw6tTZg4ssrMpV9C7VTaVFG
         wFu/hW7Ysoz/+Vg9b+d1KKiE353v81/lD+ZZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ThUA3Dq3luwvWscveKCO3E/y+CVZefpX+RaH26jEMDhAEbiN9ZvYwzBho/yYMImre5
         tgEAD4lyEZWy4Nyj3tS1pal9TOu+wPkRU56dxN2Ir0XnMiPDxUfugY4ZVXwsNYoWAhY9
         xntKfzLw8bG+xVOSBaIkF3vU1pyiV5I8Hu5wI=
Received: by 10.213.22.18 with SMTP id l18mr2453670ebb.85.1286657860618;
        Sat, 09 Oct 2010 13:57:40 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id q54sm3991123eeh.12.2010.10.09.13.57.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:57:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158613>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index 308ed28..a166a70 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -283,10 +283,10 @@ needs_update()
 	recurse_deps branch_needs_update "$@"
 }
 
-# branch_empty NAME
+# branch_empty NAME [-i | -w]
 branch_empty()
 {
-	[ -z "$(git diff-tree "refs/top-bases/$1" "$1" -- | fgrep -v "	.top")" ]
+	[ "$(pretty_tree "$1" -b)" = "$(pretty_tree "$1" ${2-})" ]
 }
 
 # list_deps
-- 
1.7.1.1067.g5aeb7
