From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 01/20] transport-helper: fix minor leak in push_refs_with_export
Date: Sun, 19 Jun 2011 17:18:26 +0200
Message-ID: <1308496725-22329-2-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJmj-0003bU-1x
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab1FSPTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1FSPTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:30 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=c0iaFJRL/poKgpJyoARsMqEE7ydldMrEQWyrHi+iyLM=;
        b=I+ZxGlRXYdyScniHXX6q/UHVlQRq9f2mEjuhRx/i3BW9y8VlP6KWPw7DUau4vWpLEF
         jEEzeo2IF6ITiqh8YfdWrSXz1Y6Wvl2rO59cTRcwDM/NIRcc5uFQMvX/RXWrn6SUVJoi
         xw6ouZ6CHeRRFjZXEFNZSbj23itjUE9VQ6hrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fdEI7BX9Usn7bnXc/b87AuIhYxSxqi8JttLJqSLhd+YEzAayiwmli7v8w8VFu1GGC8
         Y4CEi2a0/4vljhmsRzcXDu/PNmxJn8r9G98MBKmgSuqyGlvgMGhrU+QpS6Cn9zFv7ei8
         uD53vkSyePIOj/vBI6fyt2Oer9SVZ6vjN56M4=
Received: by 10.14.17.97 with SMTP id i73mr1502023eei.124.1308496770083;
        Sun, 19 Jun 2011 08:19:30 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176003>

From: Jeff King <peff@peff.net>


Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 transport-helper.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 660147f..b560b64 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -728,6 +728,7 @@ static int push_refs_with_export(struct transport *transport,
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
 		}
+		free(private);
 
 		string_list_append(&revlist_args, ref->name);
 
-- 
1.7.5.1.292.g728120
