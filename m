From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 01/19] transport-helper: fix minor leak in push_refs_with_export
Date: Wed,  8 Jun 2011 20:48:32 +0200
Message-ID: <1307558930-16074-2-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:49:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNot-0007wm-O7
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab1FHStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57880 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab1FHSt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:29 -0400
Received: by eyx24 with SMTP id 24so279692eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=w7XqiSkvn0G94nSAeRywzQArABQMu9xsTqDvKl3S9q0=;
        b=xFKM2tLZD/1eWAdbb9HXsrLtwa5REQJ3lQZdy+dda0yw/+DjLtoBSufEy3Tz30A68C
         EM1QiLap43R/azBdhwzA6v1g/0zfnRDgCcJVxOUX1a4FdTbs/lEpS/EVzLz9KKs7Hfn/
         UyPCsaQ472d8i03Ubt+ZS5idbKXSS/XH4CXRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r4m1yR5UPA1BkYQSOGojhNp9EtAQvDnVQcZ9W8GdlkCC6dioEo5yq+d+j/78HrZc4C
         GrLQTb+ZloKsJGb6uccMODeCI96F7oOGs2kqDSd0OAwEMBrYglah7tpZCn9vkkRysWOn
         oSveiw8FruWHHnrJ94E5OSR4jkJ6iHNrzYlaE=
Received: by 10.14.96.199 with SMTP id r47mr3156186eef.109.1307558967632;
        Wed, 08 Jun 2011 11:49:27 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175423>

From: Jeff King <peff@peff.net>


Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from Peff's series.

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
