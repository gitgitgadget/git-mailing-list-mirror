From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B v4 4/5] git config: don't allow extra arguments for -e or -l.
Date: Sat, 21 Feb 2009 02:49:28 +0200
Message-ID: <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag5Y-0007JC-TG
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbZBUAtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbZBUAto
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:44 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:40466 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbZBUAtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:41 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3160875bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0B3OcGeEi3qhZU8go6FjLhlhT5YFAdC8WoQrp0Diils=;
        b=pHnA7kC/4uEKDhUN7jx8Z4R9WOQmYPIzoUXtbLLRbTQ3UBmsbSfKXc036iYK5LiRzb
         2Ff7WkVwts4PlEzTPsFRT2TjX39kfSC6uS7u2WpS4BZbnBLcw/bjOd1HtoB2fDYWUPm6
         vm3iCL4d6Ja0g7xmqsihNdh+qratakns4QF/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y9XpUhwaEpWfNPfJM1TUwAbIbIv8yoJ+BlkvoynKKZC37twidd/iA7PLSDOmKQ6Ffc
         XapW96eY+ySNTCVkn0z7ULoSlhDJmQHJwPHpRk0waq3juZuH1Kfj2Ed66J7loMDdbNI2
         jopVXVtsJcwgK9ypNil9J9T3t9NpZZmxWksgc=
Received: by 10.181.239.8 with SMTP id q8mr477481bkr.109.1235177380897;
        Fri, 20 Feb 2009 16:49:40 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 21sm3347370fkx.19.2009.02.20.16.49.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:40 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110914>

As suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index c2a30f2..8045926 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -373,6 +373,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		}
 
 	if (actions == ACTION_LIST) {
+		check_argc(argc, 0, 0);
 		if (git_config(show_all_config, NULL) < 0) {
 			if (config_exclusive_filename)
 				die("unable to read config file %s: %s",
@@ -382,6 +383,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		}
 	}
 	else if (actions == ACTION_EDIT) {
+		check_argc(argc, 0, 0);
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
 			      config_exclusive_filename : git_path("config"),
-- 
1.6.1.3
