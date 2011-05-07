From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 01/02] git-instaweb: Simplify build dependency on gitweb
Date: Sat,  7 May 2011 14:45:20 +0200
Message-ID: <1304772321-22687-2-git-send-email-jnareb@gmail.com>
References: <1304772321-22687-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 14:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIgwk-0001Qa-Bg
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 14:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab1EGMtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 08:49:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1EGMtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 08:49:17 -0400
Received: by fxm17 with SMTP id 17so2841785fxm.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=IyTpOYW3xlFjr+rVASlsbjINGVg7DB7UZcbiNiuFr2M=;
        b=kRfByrhMO2W3OkUYvqCWd5EKlDh185F50RnxTo5HbEtEr/3/xGz/vrpLEKXYUXoFmf
         CHuIfAlNKjxbi/qjOscPW4+WzKp4XI73auOczqnTd5eRSd3oN4/XeX3U17Pb2tWWLTp4
         FFypuEV76FyHRrcK+aZFAe5jDrlrFcDStA9hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hag/wcHsyAfMjbJrVlWoq8OTmJ6TDOcNuAUjH+3oAm+QJ6bCES4j9agfjnfYHzsROU
         yckxOpBffi/ZWsNBsXLGjEEqC768ZR9NAw6s2m0iA8Ft93cPFAGbmykC0qRKvw5t/hIQ
         Gn9wftyQiABEQca8LWBUMsOwYiPBfVwN0EmLY=
Received: by 10.223.14.137 with SMTP id g9mr2520974faa.8.1304772554669;
        Sat, 07 May 2011 05:49:14 -0700 (PDT)
Received: from localhost.localdomain (abwd142.neoplus.adsl.tpnet.pl [83.8.227.142])
        by mx.google.com with ESMTPS id j11sm1375094faa.20.2011.05.07.05.49.12
        (version=SSLv3 cipher=OTHER);
        Sat, 07 May 2011 05:49:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
In-Reply-To: <1304772321-22687-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173049>

Since c0cb4ed (git-instaweb: Configure it to work with new gitweb
structure, 2010-05-28) git-instaweb does not re-create gitweb.cgi
etc., but makes use of installed gitweb.  Therefore simplify
git-instaweb dependency on gitweb subsystem in main Makefile from
'gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js'
to simply 'gitweb'.

This is preparation for splitting gitweb.perl script, and for
splitting gitweb.js (to be reassembled / combined on build).  This way
we don't have to duplicate parts of gitweb/Makefile in main
Makefile... it is also more correct description of git-instaweb
dependency.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is part of 'jn/gitweb-js' (a76424e) in 'pu', and was sent
to git mailing list as part of the following series:

  [PATCHv3 00/13] gitweb: Change timezone in dates using JavaScript
  http://thread.gmane.org/gmane.comp.version-control.git/172384

I think this simplification of git-instaweb dependencies is worth on
its own, even if gitweb.js won't be generated file.

P.S. Now that it is standalone, Reported-by makes little sense, though...

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index cbc3fce..8960cee 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
 endif # CSSMIN
 
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
+git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
1.7.3
