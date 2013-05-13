From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] git-svn: multiple fetch/branches/tags keys are supported
Date: Mon, 13 May 2013 14:31:31 -0700
Message-ID: <20130513213131.GF3657@google.com>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
 <20111217100521.GA12610@elie.hsd1.il.comcast.net>
 <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
 <20111220012236.GB20979@elie.hsd1.il.comcast.net>
 <20130513213055.GE3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Gray <n8gray@n8gray.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 13 23:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0LM-0007Za-EY
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab3EMVbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:31:36 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:56636 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3EMVbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:31:35 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so1730948pbc.35
        for <git@vger.kernel.org>; Mon, 13 May 2013 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Dsu5Bcd2lhGwba4Qi/JkJN6jz1xDuyGfJDyuE8U81qQ=;
        b=Uvseog8gPqu4o9/7TzIvQHfQFx54lUFA+BOsw0886T0FIyJkVVfq+W+AXh7Qqilm59
         oxn8dbaxY8cST/7jM5fhidN9GkVZL5W6Z9vL0+AaKkn1W2gC8QzoIZkeV3Cmjb+Ni2ct
         4TVMShI1N0IvImj2hSx9h7+LxutDwkXORggM3NZ8MqmD7wBrYSSpe5Lfjrxfu/6J392V
         UwAnLSV+6+f4yiXjeDL3MkZ0ilYvGzfCZMslG2i6V3cvd56mkeRlxULrz6E1G+B0hd2e
         7VN4ILD38mdNhrCxOKAre1GNsV7pVjOIIU66tNJvAI4Hyds/Jex6GzhLlqc9N90Lilsx
         PN0A==
X-Received: by 10.66.118.79 with SMTP id kk15mr17075pab.193.1368480695427;
        Mon, 13 May 2013 14:31:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vu10sm15336574pbc.27.2013.05.13.14.31.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 14:31:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130513213055.GE3657@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224211>

From: Nathan Gray <n8gray@n8gray.org>
Date: Mon, 19 Dec 2011 19:23:50 -0600

"git svn" can be configured to use multiple fetch, branches, and tags
refspecs by passing multiple --branches or --tags options at init time
or editing the configuration file later, which can be handy when
working with messy Subversion repositories.  Add a note to the
configuration section documenting how this works.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 Documentation/git-svn.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 58b6d54..6c0988e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1032,6 +1032,18 @@ comma-separated list of names within braces. For example:
 	tags = tags/{1.0,2.0}/src:refs/remotes/tags/*
 ------------------------------------------------------------------------
 
+Multiple fetch, branches, and tags keys are supported:
+
+------------------------------------------------------------------------
+[svn-remote "messy-repo"]
+	url = http://server.org/svn
+	fetch = trunk/project-a:refs/remotes/project-a/trunk
+	fetch = branches/demos/june-project-a-demo:refs/remotes/project-a/demos/june-demo
+	branches = branches/server/*:refs/remotes/project-a/branches/*
+	branches = branches/demos/2011/*:refs/remotes/project-a/2011-demos/*
+	tags = tags/server/*:refs/remotes/project-a/tags/*
+------------------------------------------------------------------------
+
 Note that git-svn keeps track of the highest revision in which a branch
 or tag has appeared. If the subset of branches or tags is changed after
 fetching, then .git/svn/.metadata must be manually edited to remove (or
-- 
1.8.3.rc1
