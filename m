From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/9] transport-helper: a bunch of improvements
Date: Fri, 24 May 2013 21:47:31 -0500
Message-ID: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Xq-0004d1-OW
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab3EYCtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:49:18 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46243 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab3EYCtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:49:18 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so6953480oag.5
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7zNEzHYkHUiHFb0Nr15AabSa8eakOPSHc39vyN9Cc4A=;
        b=UfrvouSprJejwFpsAnOGs87EJMNfZleC538js4BeEGSM1csTJtwXFj7ybMnKaq9IUA
         uhV5yrNQZTiATPbFWJ/ERQgdP1ve8IL3oDYqVAtpZ6Q75VsO53vjLWKRbSnNUg/KpWYS
         RXvfKOrf8+cFu33blLI8PmQbcFV69AdBM7Od5U2XXdybYQBbJ2IQXNtgzssrmRnmrx9U
         NCCGg07AF5YbAKK2m9wlDU/8ASPIjrCzixLcEwCom6Z0OnPhwfA5PeWQmuRD1ZtOCP8V
         N/vWOXOnmSYkJpYCNg9xS5c6U8us+HjnuwzWjKRUafKfQs8sZ5SfPwEZRdg+fJfTflKJ
         X7PQ==
X-Received: by 10.60.56.107 with SMTP id z11mr13203064oep.99.1369450157850;
        Fri, 24 May 2013 19:49:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id hv3sm20127489obb.7.2013.05.24.19.49.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:49:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225475>

Hi,

After these remote helpers that use 'export' are able to do everything:

 1) push --dry-run
 2) push --force
 2.1) report which branches were forced
 3) push old:new
 4) push :to-delete

I know these won't be applied, which is too bad for the users, which could
enjoy these features, which are implemented properly, with documentation,
tests, and everything.

Sorry users, I don't have Jedi powers to convince Git developers of what's
actually good.

Felipe Contreras (9):
  transport-helper: check if the dry-run is supported
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches

 Documentation/git-fast-export.txt |  4 ++++
 Documentation/git-fast-import.txt |  3 +++
 builtin/fast-export.c             | 47 ++++++++++++++++++++++++++++++++++++++-
 fast-import.c                     | 13 ++++++++---
 t/t5801-remote-helpers.sh         | 10 ++++++++-
 t/t9300-fast-import.sh            | 18 +++++++++++++++
 t/t9350-fast-export.sh            | 18 +++++++++++++++
 transport-helper.c                | 39 ++++++++++++++++++++++++++------
 8 files changed, 140 insertions(+), 12 deletions(-)

-- 
1.8.3.rc3.312.g47657de
