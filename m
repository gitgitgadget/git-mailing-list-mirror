From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Unexpected behavior in git-rev-list
Date: Sun, 18 Sep 2005 16:49:31 +0200
Message-ID: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 18 17:15:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH0ri-0003AL-4p
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 17:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVIRPNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 11:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVIRPNz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 11:13:55 -0400
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:35013 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S932100AbVIRPNz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 11:13:55 -0400
Received: (qmail 9629 invoked by uid 5842); 18 Sep 2005 14:49:31 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8784>

Hello people,

There's something I don't quite understand about git-rev-list.
After adding two files only one shows up with the --objects option.

I'm looking at commit e621a691e9bdbbe263ce34dd20458d9fbbf1a126 at

http://www.student.dtu.dk/~s022018/git/gitweb.cgi?p=recipes.git;a=summary

I can find the difference between the latest commit and it's parent:

> git diff HEAD^ HEAD
diff --git a/HS-Plugins/20050403/Recipe b/HS-Plugins/20050403/Recipe
new file mode 100644
--- /dev/null
+++ b/HS-Plugins/20050403/Recipe
@@ -0,0 +1,16 @@
 [snip]
diff --git a/HS-Plugins/20050403/Resources/Dependencies
b/HS-Plugins/20050403/Resources/Dependencies
new file mode 100644
--- /dev/null
+++ b/HS-Plugins/20050403/Resources/Dependencies
@@ -0,0 +1,5 @@
 [snip] 

Notice that it creates exactly two files.  Now I expect the folllowing
objects:

tree HS-Plugins
tree 20050403
blob Recipe
tree Resources
blob Dependencies

Now what I understand so far is that we can list all objects reachable
from the HEAD commit but not reachable from its parent commit by: 

> git-rev-list --objects ^HEAD^ HEAD
e621a691e9bdbbe263ce34dd20458d9fbbf1a126
609c26436053564e8df145b175d75df339b2318b
fe47bcfb8f47b55e3f6fabd2b2d188030fb57e1f HS-Plugins
6c8582e49c9f792f4f550fcf510432c84d24d868 20050403
808a68c33f87693c873f8f9c5f66c050a5ddc81e Recipe

My question is now: Why doesn't "git-rev-list --objects ^HEAD^ HEAD"
list the Dependencies blob?  I'm a bit confused.

Regards,

Peter
