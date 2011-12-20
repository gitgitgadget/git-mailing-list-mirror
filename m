From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] git-svn: multiple fetch/branches/tags keys are supported
Date: Mon, 19 Dec 2011 19:23:50 -0600
Message-ID: <20111220012350.GC20979@elie.hsd1.il.comcast.net>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
 <20111217100521.GA12610@elie.hsd1.il.comcast.net>
 <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
 <20111220012236.GB20979@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcoR3-0004RT-W0
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab1LTBYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:24:01 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56676 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab1LTBYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:24:00 -0500
Received: by yhr47 with SMTP id 47so4420114yhr.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 17:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WI6l31lXJgNqb327pcilRhx4iFTyOMjXBsFvnvEaEXg=;
        b=RuqUjsltVyND3yM4CvIox/o62GxQ/j5pQ8bZ+xfjCDCpLcJMRZdrcZTyJNdXb5dX+1
         AWeJcnpQXBotI9QWv2+htWayFvawChO+v5sGqFDxgYrtjxd4yJhWVdbH3dhB1wsU9Ewe
         o/FuLGZOAbh0IpJFHqe4x8VSwjCr7QAZlTnFU=
Received: by 10.236.189.97 with SMTP id b61mr31726700yhn.116.1324344239778;
        Mon, 19 Dec 2011 17:23:59 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 7sm188524anz.18.2011.12.19.17.23.58
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 17:23:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111220012236.GB20979@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187490>

From: Nathan Gray <n8gray@n8gray.org>

"git svn" can be configured to use multiple fetch, branches, and tags
refspecs by passing multiple --branches or --tags options at init time
or editing the configuration file later, which can be handy when
working with messy Subversion repositories.  Add a note to the
configuration section documenting how this works.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-svn.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee7850..66fd60a4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -923,6 +923,18 @@ comma-separated list of names within braces. For example:
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
1.7.8
