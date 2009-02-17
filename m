From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/8] config: Cleanup editor action.
Date: Tue, 17 Feb 2009 02:54:54 +0200
Message-ID: <1234832094-15541-8-git-send-email-felipe.contreras@gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-5-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-6-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-7-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGi-0008Gx-PS
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbZBQAzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZBQAzW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:22 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:43168 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZBQAzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:13 -0500
Received: by mail-fx0-f20.google.com with SMTP id 13so6405830fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KbixfIrdWijx91rpCZvRiVClfz9pnyY0Vu5hrN9lg0U=;
        b=SK3Zv0AhNvMaB5cg+fWpf+GuKUROJgEOCsZPehPJA/2XrVhatV0bRcykLoZA8bz3dV
         w7E9uvKUeP3kBieyovLveVNAbFIUnW41VmnYQztGYLpQQ+cS6WKH3iRAv3f7M1Ws4rDA
         LrVXirZQ3FCBZ8ywMCxtjMHrm9xBZqiU3Yip8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C27xAL2eNQfFWhj5ZQHHFteNCR8BHbmiH723gouhxdeu4ObGZ9B0NWjz60toe9YWPO
         iT+vsRlxcs137ODgT7DtVTIezInlyQXODg94c5pzYEAKllYceB6S8D43f1dEV7lh+ZHa
         ZtNi51t+JPbaXThxp7sVXi27JPYjaOZ4CQ00o=
Received: by 10.103.52.7 with SMTP id e7mr1854197muk.52.1234832112465;
        Mon, 16 Feb 2009 16:55:12 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y2sm6628105mug.15.2009.02.16.16.55.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:55:11 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234832094-15541-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110278>

Copy-paste from Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index ff9e029..bc97854 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -369,13 +369,10 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	}
 	else if (actions & ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		const char *config_filename;
-		if (config_exclusive_filename)
-			config_filename = config_exclusive_filename;
-		else
-			config_filename = git_path("config");
 		git_config(git_default_config, NULL);
-		launch_editor(config_filename, NULL, NULL);
+		launch_editor(config_exclusive_filename ?
+			      config_exclusive_filename : git_path("config"),
+			      NULL, NULL);
 	}
 	else if (actions & ACTION_ADD) {
 		check_argc(argc, 2, 2);
-- 
1.6.1.3
