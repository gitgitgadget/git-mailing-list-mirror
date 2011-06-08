From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 18/19] transport-helper: Use capname for gitdir capability too
Date: Wed,  8 Jun 2011 20:48:49 +0200
Message-ID: <1307558930-16074-19-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpP-00087c-31
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab1FHSuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:50:02 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46131 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab1FHSty (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:54 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so282597ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ir3zCj25r0Zn9aqA2jgOvWN1lv+zOh6riED6TCYqAyo=;
        b=IbDY7Jj3PCYDEAiqR8L4cxbVhsw+Oi5i+mqymmA2kYtWbYX2Sdk/T2qC6J9cEurctF
         u+Uzuo/y3xjTqDjlbbymC9HiK6wUHIfhkmHWOd5S59B1jHsrYbPld/b6VIdorBDoJvOF
         qtOh8UKNKWmQJhf9pPqrBvdVJF+xFwZTXOCyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VpuvNu+j9JuSoZFJ2LJmUU/pDhKmfvBW7PgqBptb5qQpFBQSRLnz27u7Fj5pHJAU3r
         8YwdBZ/L4Ofd8ewWfVCmSrsJqBwe2TrqCFaxEx2F4xy5K8m6HKaydV5PArnByCHAyque
         r1GsVhMboEF5AVQC0wuI6J5dpegBCjVlb2yR0=
Received: by 10.14.96.199 with SMTP id r47mr3156375eef.109.1307558994063;
        Wed, 08 Jun 2011 11:49:54 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175434>

Also properly use capname in the refspec capability.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from my original series.

 transport-helper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f78b670..ddf0ffa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -171,10 +171,10 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
-		} else if (!strcmp(buf.buf, "gitdir")) {
+		} else if (!strcmp(capname, "gitdir")) {
 			struct strbuf gitdir = STRBUF_INIT;
 			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
 			sendline(data, &gitdir);
-- 
1.7.5.1.292.g728120
