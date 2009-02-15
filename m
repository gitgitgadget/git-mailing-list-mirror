From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/8] config: Don't allow extra arguments for -e or -l.
Date: Sun, 15 Feb 2009 11:00:58 +0200
Message-ID: <1234688460-9248-6-git-send-email-felipe.contreras@gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:03:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcuG-0000wm-G3
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZBOJB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbZBOJBZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:01:25 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:13610 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBOJBT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:01:19 -0500
Received: by fk-out-0910.google.com with SMTP id f33so869017fkf.5
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Sv6Xq9utYH24qsISrlTtQ6TYGvSppQJ52Af/oGobEfU=;
        b=D4Q0hkM/j7l9gXn3jewIsf5hGG9LJNJylJVXTVW6ca1ChvUXRF4wYzHPYPHPzAxnT7
         kO6MowwFbmvMEnSAg51evCMY/Yey6pxNijD5TvDYK5lEAbwY9Ek1+sA0r0Ymu+g1iNfM
         02EqxzwnBwBKanvnXqJrH/V7BfO/u0lzn8ov4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Imo3XpBMSt9pu4pjTzq7yxlFa9Tu9TB116ALjx2c4SQzoamWouD46eaZbJZ7vaoJx0
         xbY5OK07QCWuTNFJUixjB9FdX22/cZQcchHEW/xpMSjXQZsidGEOshEtvABYGybmSNk8
         c9bb/BflQEgq9Se+2wAJsb0yqcYdBzLtRfc7c=
Received: by 10.181.192.11 with SMTP id u11mr1476488bkp.50.1234688476842;
        Sun, 15 Feb 2009 01:01:16 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 28sm5582424fkx.37.2009.02.15.01.01.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:01:16 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234688460-9248-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109981>

As suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index e744ad8..3463b1c 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -375,10 +375,12 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		}
 
 	if (actions & ACTION_LIST) {
+		check_argc(argc, 0, 0);
 		if (git_config(show_all_config, NULL) < 0)
 			die("error processing config file(s)");
 	}
 	else if (actions & ACTION_EDIT) {
+		check_argc(argc, 0, 0);
 		const char *config_filename;
 		if (config_exclusive_filename)
 			config_filename = config_exclusive_filename;
-- 
1.6.1.3
