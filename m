From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/10] config: Cleanup editor action.
Date: Tue, 17 Feb 2009 15:52:48 +0200
Message-ID: <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPk-0001sQ-Sn
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbZBQNxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbZBQNxL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:11 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51922 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZBQNxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:09 -0500
Received: by bwz5 with SMTP id 5so4067593bwz.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=i9C/+5fDNE4tJa4wsUYN3fRYLPPA9l04TK9IjiDWLQw=;
        b=S3/gCDDk5ChuZz06cZ3YvD7SfdEbYDgxXNnHKxli6aeIls26jwsgc2cfNui6QKrVQz
         PryGIC4ekueXcB2eSKqHuE0gou97Uc4yhsU2Vxyt3V+OOl3iM+m6pjgEi76sUUI0no4c
         QpcsdXPB4UmfKgAPpqFOmD7w+4hcPiNL3ObJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oO4zFT7axAYFv+opmw7A7MJWMcSAbRGUNPzfvz6wecUmQL7yzWtYhehifGue6lqvrS
         d4fh1qWvqRLsm31nToF6Qe7ImBcwj3WIhNwpas9pWg2qTUZFHUBgGziB311UqOg2ERPn
         GS3MVJ5MDfTorfnoULQwzbbynzV6t0fQvlFvg=
Received: by 10.223.110.211 with SMTP id o19mr1851365fap.57.1234878785376;
        Tue, 17 Feb 2009 05:53:05 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id g11sm9592275gve.5.2009.02.17.05.53.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:04 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110377>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index afc4393..d52a057 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -363,15 +363,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		} else if (!strcmp(argv[1], "--get-colorbool")) {
 			return get_colorbool(argc-2, argv+2);
 		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
-			const char *config_filename;
 			if (argc != 2)
 				usage(git_config_set_usage);
-			if (config_exclusive_filename)
-				config_filename = config_exclusive_filename;
-			else
-				config_filename = git_path("config");
 			git_config(git_default_config, NULL);
-			launch_editor(config_filename, NULL, NULL);
+			launch_editor(config_exclusive_filename ?
+				      config_exclusive_filename : git_path("config"),
+				      NULL, NULL);
 			return 0;
 		} else
 			break;
-- 
1.6.1.3
