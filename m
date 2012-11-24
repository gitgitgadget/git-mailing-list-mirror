From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 3/9] transport-helper: trivial code shuffle
Date: Sat, 24 Nov 2012 04:25:14 +0100
Message-ID: <1353727520-26039-4-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nf-0006y1-D9
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594Ab2KXDZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:46 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab2KXDZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:44 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TMynwEUn9heb/HdqEImu9xEcxm5AdWfTPvJvuqQyIDw=;
        b=RfL5yhOp8Zfdr9NqTuxPawR092cPfL28BwsjfSpziNWPnA32wcmsNwObW7UOTK32Ha
         dxyQeyig3i6RkOAR1cAtnJ9RMqItctZ1sHv382zktWpMIMhD+kWaVDoCbOg2WAFvohdI
         b3OKJjk1/bKwiZaTlfQe4CuXCvIxHzyG6D6AYtYXRYi3TpcnwlBodtfOQYq6HxVwAbKL
         wIr7llmUuIn22HCkTNFPnZtMWTk7fDXc+eMy/IXDtYPshQyU6+iR/Dgdn3YMtqy2EsoO
         z6kYZgPqPKZ3hd6b4aPJnYalW/Ti6tiYW9uiPk1cv424QnOiOkmN/KdM+rJ9PL1skAVa
         EygQ==
Received: by 10.204.6.20 with SMTP id 20mr1765271bkx.33.1353727543576;
        Fri, 23 Nov 2012 19:25:43 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id d16sm5471386bkw.2.2012.11.23.19.25.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:42 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210302>

Just shuffle the die() part to make it more explicit, and cleanup the
code-style.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 32ad877..0c95101 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -775,6 +775,9 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
+		if (ref->deletion)
+			die("remote-helpers do not support ref deletion");
+
 		if (!data->refspecs)
 			continue;
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
@@ -784,10 +787,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion) {
-			die("remote-helpers do not support ref deletion");
-		}
-
 		if (ref->peer_ref)
 			string_list_append(&revlist_args, ref->peer_ref->name);
 
-- 
1.8.0
