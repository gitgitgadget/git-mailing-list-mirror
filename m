From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/10] config: Don't allow extra arguments for -e or -l.
Date: Tue, 17 Feb 2009 15:52:56 +0200
Message-ID: <1234878776-13250-10-git-send-email-felipe.contreras@gmail.com>
References: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-2-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-3-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-4-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-5-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-6-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-7-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-8-git-send-email-felipe.contreras@gmail.com>
 <1234878776-13250-9-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPq-0001sQ-Nj
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbZBQNxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZBQNxj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:38357 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbZBQNxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:38 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1318953fkf.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TMFU723XnadktrH3YH8uIgNpOMZpYAT1zRwC5f+SlcY=;
        b=o+utM+q6ftHy0TlupKZcicwthMyQdh+jF9x2QCvCFJNvtaQHjSFG4X8AOSy6dQRaJz
         wu+FkSGpSajaN/Toyhpy3dWdm0Bc0wrsnBqiKXGuwSjEFfhbKEgUeT+7rmAQcqq5XCAP
         aHes4BN8FN8btUh29ZhiAyR42QuMvmWo+FZZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lxSCNY0Po4OGdTBACN/0T12hMs49GI/Joly10QbRxtMYvz3YNBxu7DFyoD/GRA9vkb
         b2yj/Ixd10Bawi/8uO25l29GHXoKo038h76yNYf4saV0Js2eWkO62x9bz4DaXyeFdM0s
         IxRWmrZESiRng9rAW6JC6EmgNxH6DSJkBVFiA=
Received: by 10.223.113.195 with SMTP id b3mr4632895faq.79.1234878815943;
        Tue, 17 Feb 2009 05:53:35 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id u14sm6720037gvf.31.2009.02.17.05.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:53:35 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234878776-13250-9-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110374>

As suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 060191c..ec7b613 100644
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
