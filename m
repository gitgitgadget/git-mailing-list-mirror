From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Documentation: git gc packs refs by default now
Date: Sat, 9 Jan 2010 20:59:41 -0600
Message-ID: <20100110025941.GC1083@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <9516c897017ec420403bb7f687fb8962de42cb7c.1263081032.git.trast@student.ethz.ch>
 <20100110025641.GB1083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 03:59:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTo1l-00059s-35
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 03:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab0AJC7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692Ab0AJC7g
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 21:59:36 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:38712 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0AJC7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 21:59:35 -0500
Received: by iwn32 with SMTP id 32so3957506iwn.33
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 18:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h5IEW571lVsU86sRm7OGY3ytpZO05WmJTbJk6WX7Knw=;
        b=GJQVdgKEcaurOqkqOW3LTbUX/VuoZ05hbAK7HS6S9jVQtKc24kHyADqWu58jmP6/bk
         Z5CqbS7JtXyRlfT7Ie4nY7oZaCNRlJaCuCzWTYsInwFX18Vf3gc6G774cI/ZIZDZeGD1
         4VR6JJ9kPn+X+11U7yqOppGRUdAH3tPWZHf7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h1HP2+FLdswuUg9D5K8mY5/M7H80gu2iOJAS+YTo2iB8Q7uoDj5TExVTDZrVYWZxC7
         uz70k+bBHLgL9BKEXlnCNVaI16Ujcuztc/ve/8vJY3MjdF0kNzgeoz7Loem0SFyTCZan
         stX7FfnOf6WFovcALoCMJm84BYMRn+5a9+Vlo=
Received: by 10.231.81.148 with SMTP id x20mr4794423ibk.2.1263092374993;
        Sat, 09 Jan 2010 18:59:34 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2217241iwn.9.2010.01.09.18.59.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 18:59:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100110025641.GB1083@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136548>

In commit 56752391 (Make "git gc" pack all refs by default,
2007-05-24), 'git gc' was changed to run pack-refs by default 

Versions before v1.5.1.2 cannot clone repos with packed refs over
http, and versions before v1.4.4 cannot handled packed refs at
all, but more recent git should have no problems.  Try to make
this more clear in the git-config manual.

The analagous passage in git-gc.txt was updated already with
commit fe2128a (Change git-gc documentation to reflect
gc.packrefs implementation., 2008-01-09).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b5b27ba..bcfed1c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -875,15 +875,12 @@ gc.autopacklimit::
 	default	value is 50.  Setting this to 0 disables it.
 
 gc.packrefs::
-	'git-gc' does not run `git pack-refs` in a bare repository by
-	default so that older dumb-transport clients can still fetch
-	from the repository.  Setting this to `true` lets 'git-gc'
-	to run `git pack-refs`.  Setting this to `false` tells
-	'git-gc' never to run `git pack-refs`. The default setting is
-	`notbare`. Enable it only when you know you do not have to
-	support such clients.  The default setting will change to `true`
-	at some stage, and setting this to `false` will continue to
-	prevent `git pack-refs` from being run from 'git-gc'.
+	Running `git pack-refs` in a repository renders it
+	unclonable by Git versions prior to 1.5.1.2 over dumb
+	transports such as HTTP.  This variable determines whether
+	'git gc' runs `git pack-refs`. This can be set to "nobare"
+	to enable it within all non-bare repos or it can be set to a
+	boolean value.  The default is `true`.
 
 gc.pruneexpire::
 	When 'git-gc' is run, it will call 'prune --expire 2.weeks.ago'.
-- 
1.6.6
