From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/23] checkout: prepare_linked_checkout: drop now-unused 'new' argument
Date: Fri,  3 Jul 2015 20:17:19 -0400
Message-ID: <1435969052-540-11-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAe-0000G5-7s
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046AbbGDATB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:01 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33352 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbbGDASg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:36 -0400
Received: by igcur8 with SMTP id ur8so153710720igc.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPWG8qNHh5HkUg7A0PELTk/9G6BkWbqDwwD0EDNqCBg=;
        b=c99l6h7z6YneNtwR0MPE8VgqYoJ3OnTkltfACWab23+MjZc7IFYVh08WqBoxhB10SL
         HKzdoNS+eq2pVsWiuPIsXUhQ0940cr4WS/eDbxUPlMEHXMvJWc+GHc/1pl8toraLUzt0
         dxPzQqQd2yuayY3sVaVfUFIagz0WjI99yHGKmU8QwP5WQXscKIDASy8jHf3S/shKOFz+
         f7jK0mpRE7Rj5FOTt6H6gAHu6FYpf3IxeXRSIVSSdavYod2aZzcOKiYpX8r9KFZ/nVGM
         fPcdjpVUjKvtHcpkmWz2W8QWEWVDRSFKgU8pExUBMR5/icx1Bl+yywswtXO6whrnoCn1
         WxBA==
X-Received: by 10.50.114.40 with SMTP id jd8mr28153162igb.47.1435969115598;
        Fri, 03 Jul 2015 17:18:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273323>

The only references to 'new' were folded out by the last two patches.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0cb81ee..0dcdde2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -854,8 +854,7 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static int prepare_linked_checkout(const struct checkout_opts *opts,
-				   struct branch_info *new)
+static int prepare_linked_checkout(const struct checkout_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -1299,7 +1298,7 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->new_worktree) {
 		if (!new->commit)
 			die(_("no branch specified"));
-		return prepare_linked_checkout(opts, new);
+		return prepare_linked_checkout(opts);
 	}
 
 	if (!new->commit && opts->new_branch) {
-- 
2.5.0.rc1.197.g417e668
