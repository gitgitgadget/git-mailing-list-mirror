From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 3/5] git p4: Ignore P4EDITOR if it is empty
Date: Tue, 24 Apr 2012 09:08:15 +0100
Message-ID: <1335254897-15242-4-git-send-email-luke@diamand.org>
References: <1335254897-15242-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SManc-0007pH-55
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab2DXIIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:08:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51558 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab2DXII2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:08:28 -0400
Received: by wgbdr13 with SMTP id dr13so404881wgb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=cIm4gvO39801nixKzSZbWc0OcsWDU1LmyfuhYfo9x+4=;
        b=dbVNSl1OVkXUBOu+qbK6ekdj7eC5TUWFPmTBRSh93J/QTzRu0imR7tZjUtdhqDuY8p
         KFzhuc7GR6OZOllqW6u3yMrGaJKdd0cETfxr5KMcMHCy1b1RSko+7Jvj6JjkDipmdvbX
         hjzwI06ZWMus6GvgVLtlu6xlXEE1pW1vXcsqzLgQORH40QveCEPes4SKKxoHkiVCHmUF
         B7JVgnWc75/gxbeKJbffkawZp/hqI6TEFaUJkAORtHACr9czrDD+iA7Wbv44EsqIHF+H
         lopdqq8mSdaBZjgL5xjgwZllTHNWGLm85n5+HAku3xTL0iu8jrt/kTwvCJ8qagRudwgN
         nrwQ==
Received: by 10.180.24.7 with SMTP id q7mr13884192wif.11.1335254907477;
        Tue, 24 Apr 2012 01:08:27 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fl2sm44448146wib.2.2012.04.24.01.08.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:08:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.381.gb484f
In-Reply-To: <1335254897-15242-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQlwffNnCkKWOunJq03axuzcW3jbXsLg+GrIq/REUg/EB2Kk4QuCClFRwr5QQ5O/6439GJO2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196203>

p4 itself treats an empty value for P4EDITOR as the same as
having P4EDITOR unset. Do the same for "git p4".

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index f910d5a..ead0c44 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -970,7 +970,7 @@ class P4Submit(Command, P4UserMap):
         mtime = os.stat(template_file).st_mtime
 
         # invoke the editor
-        if os.environ.has_key("P4EDITOR"):
+        if os.environ.has_key("P4EDITOR") and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
-- 
1.7.10.381.gb484f
