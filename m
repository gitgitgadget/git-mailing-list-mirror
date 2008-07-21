From: Tim Harper <timcharper@gmail.com>
Subject: Bizarre missing changes (git bug?)
Date: Mon, 21 Jul 2008 14:26:06 -0600
Message-ID: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 22:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL1yb-00086d-Po
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbYGUU0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbYGUU0O
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:26:14 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:19824 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbYGUU0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 16:26:12 -0400
Received: by yw-out-2324.google.com with SMTP id 9so602003ywe.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:subject:mime-version:date
         :x-mailer;
        bh=RilpWDjK2SlQWlt5+K7k0rMJpbG0iR0jLvXNsstRBJg=;
        b=wr3GnPMiLyLAOv7IEOT/hkw0FWED0IQ6BT+b50Ez5uDNWPDlwIn2xIIZE1+vEHSbnS
         FxEv8dyd2o1ajQLN+R5coQlwzshVS2bJl83kXjZW34lDwT4mkosu14nMVPrT5Qv8zlz2
         xvJxed/UkD+ov2Ntr0fj2y6C+ES24+vWRbbZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date:x-mailer;
        b=CGXFR56e9go0pVBgj/OtiDy+FKVc8txvFnjfRp6I0pPP+XBjFsu2CwACbVdSagl9cc
         k+bQBd8zMSXKqdE7/n6mz8s4H1dlgRhRFXlURR2MWDPyN8H3+7RE91cEk4fM8V7/4fXf
         IvdT0dSTSif0PYosF8Pd1nurUSq/6Ae8wdavg=
Received: by 10.114.56.4 with SMTP id e4mr3060313waa.0.1216671970907;
        Mon, 21 Jul 2008 13:26:10 -0700 (PDT)
Received: from ?10.1.1.135? ( [66.236.74.194])
        by mx.google.com with ESMTPS id l23sm9396836waf.57.2008.07.21.13.26.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 13:26:09 -0700 (PDT)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89400>

I ran into a strange issue that has left me scratching my head.

I have a commit in my history, that does indeed show up in my branch,  
named "sprint"

The following commands yield as follows (I've modified the output  
slightly to conceal any potentially proprietary information):

#########################
git log HEAD -p

commit 8f9effffb0dcdacd514085608e8923fbbe00ff29
Author: Name Concealed <email@email.com>
Date:   Mon Jul 14 16:19:18 2008 -0600

     commit message....

diff --git a/app/controllers/events_controller.rb b/app/controllers/ 
events_controller.rb
index 6905ba4..a0b7dfc 100644
--- a/app/controllers/events_controller.rb
+++ b/app/controllers/events_controller.rb
@@ -238,36 +238,37 @@ class EventsController < ApplicationController
    }.freeze

    RUBY_STUFF = {
-    changes...
-    changes...
-    changes...
+    changes...
+    changes...
+    changes...

diff --git a/spec/fixtures/factors.yml b/spec/fixtures/factors.yml
index 186ed73..3c76e86 100755
--- a/spec/fixtures/factors.yml
+++ b/spec/fixtures/factors.yml
@@ -2483,4 +2483,54 @@ some_branch:
    file:
    contents:
-  reliable_on:
\ No newline at end of file
+  data:
+fixture_name:
+  id: 115
+  file: Event
+  contents: behavior


#########################
git log spec/fixtures/factors.yml

... commit 8f9effff is not listed anywhere

#########################
git log app/controllers/events_controller.rb

... commit 8f9effff shows up

#########################
git branch --contains 8f9effff

   some-task-branch
* sprint


The changes in 8f9effff for app/controllers/events_controller.rb show  
up in the working copy, however the changes for spec/fixtures/ 
factors.yml are nowhere to be seen.  It's as if the history of that  
particular file diverged somehow, but I know that can't be true since  
git doesn't track files.

Anyone run into this before?  Any idea what might have caused it?   
We're a bit concerned about this because if we don't know how to avoid  
this, we no longer can feel certain that when something is committed,  
it will make it out in our release.

Any help or clues VERY much apperciated.  Thanks!

Tim
