From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] Makefile: fix http-push.o dependencies
Date: Sat, 28 Nov 2009 05:31:15 -0600
Message-ID: <20091128113115.GB10059@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELKa-0000PX-62
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZK1LTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbZK1LTA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:19:00 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:42431 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbZK1LS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:18:59 -0500
Received: by yxe26 with SMTP id 26so1864252yxe.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ln+cVHhfa9q5AzXX1i3rf6TUH41xsUHNCYCyERRPvq8=;
        b=fdJFX7jtWCrbdIH/tmmIhaNsrqBZQ8mL5CQLwwxoZKhXgvAOzDUUGfiNTyBVBSKmdI
         LrYliKWUygF+9s5RE+RIrA8a7fbWh3FYPrjLr0vLeIXLm5Dq4zfE5HWQ0j2NiJ8XxkkV
         K8MDF8Wv3W0dgiij1V0v9ml/kVcYhSybRRVFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IBGzK8O9tQdmBW+yjh+uD3Gl3pl5tumS/RbXVzAVab6Yo0mPJojDKzOoUN6m/0ES7X
         O9UkJXWORA6tPWd8hVIK4swQiYk3aCE/5fHdfk0V6NIqKQ3hGgy5lopaUe3xnIn9RSs7
         FOT6vU3q4hDgUKuWeX7UfuNFBwnA3KHh9y/rI=
Received: by 10.150.127.17 with SMTP id z17mr3385898ybc.61.1259407145804;
        Sat, 28 Nov 2009 03:19:05 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm1111974gxk.4.2009.11.28.03.19.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:19:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091128112546.GA10059@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133951>

Since it is not in LIB_OBJS, http-push.o needs an explicit
$(GIT_H) dependency.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
http-push.c begins:

#include "cache.h"
#include "commit.h"

 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 856ba09..dc7c929 100644
--- a/Makefile
+++ b/Makefile
@@ -1557,9 +1557,7 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
-http.o http-walker.o http-push.o: http.h
-
-http.o http-walker.o: $(LIB_H)
+http.o http-walker.o http-push.o: http.h $(LIB_H)
 
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-- 
1.6.5.3
