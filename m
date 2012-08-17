From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 07/16] When debug==1, start fast-import with "--stats" instead of "--quiet".
Date: Fri, 17 Aug 2012 22:25:48 +0200
Message-ID: <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8e-00061V-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901Ab2HQU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:06 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34025 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888Ab2HQU04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:26:56 -0400
Received: by wibhr14 with SMTP id hr14so2001782wib.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CnLGCIvNTU6pH/mLPc/lE2BSpedwmHCv/N4VRRpGxLQ=;
        b=bzLIAmtnhYNbDn7ZVMQ9uwyIhKSqQn4zKkBMVZOzVeTdBjZlM16/tY/JdPzQu/mtJN
         zAGeE+OBa3mMGrHCZKWVGuvR7k572Dh3urNOSVWLvQ4aTjK/4ifD1uR/LUnBpUBG+xjD
         ytLAFnUu1jEKGRimqKCpnI+46PLeJhCbpEHfyoHDY7C6UcmE1yp5iH7LLqb+1caFzErK
         fn7E9UwixxBJBxArhDFWL3WHWsEMQUWTPPAuKNK0r3oAYCobnkqnOWrQshSCELQWq/W9
         6Ex2RGaMge/VyPi6L08g25Yom5XzbnAo01HWBBqHg6gMDgRCsQ3BnHh4sxex/kKdAEte
         xmGw==
Received: by 10.180.78.99 with SMTP id a3mr7645986wix.15.1345235214754;
        Fri, 17 Aug 2012 13:26:54 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.52
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203650>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3523f1f..4713b69 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -385,7 +385,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(&argv, "fast-import");
-	argv_array_push(&argv, "--quiet");
+	argv_array_push(&argv, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-- 
1.7.9.5
