From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/12] vcs-svn: use mark from previous import for parent
 commit
Date: Sun, 6 Mar 2011 17:16:13 -0600
Message-ID: <20110306231613.GN24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwNBX-0002Z0-OB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab1CFXQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:16:19 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45197 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab1CFXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:16:18 -0500
Received: by yia27 with SMTP id 27so1421013yia.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s14Yhcg6p/qZQCKNZ3cG6yONd79DLYTLLDsua9IolKk=;
        b=lz0VDG321l2Ty43wbOW9cWcNU/3vJvpSdN3qQCKAGQONYNsDTw7Drs5wCfP9q2vwws
         JdqBQbEgmwYDNaJq1R8/4RlykLw+URprBN9HdYzLITC+OrxFQhLZx9K4Dk2WCF4/HgN6
         btfEVPVyAZ2oETS6g73pGegFFomMIdQLo54fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=izP5aQOi3sjS/BXqA+SzXlgUFjCsFex9FGJIHRw9eSAtB6L6lEqx4R2msAHauFREzY
         mAOM0WQpUKxk5VbdJSe+ADW+++SLr0NNAHX139d56/a4wLlKABQSJ2U+UxQO1grtH4qM
         Fv4DTeXz651qT757rE5R3DnWd+stPo+d9j/YM=
Received: by 10.150.144.20 with SMTP id r20mr3930940ybd.32.1299453377924;
        Sun, 06 Mar 2011 15:16:17 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.ameritech.net [69.209.66.207])
        by mx.google.com with ESMTPS id q4sm1252568ybe.12.2011.03.06.15.16.15
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:16:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168559>

From: David Barr <david.barr@cordelta.com>
Date: Sun, 12 Dec 2010 13:41:38 +1100

With this patch, overlapping incremental imports work.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.

Bug reports, suggestions, improvements, welcome, of course.  The
documentation in contrib/svn-fe/svn-fe.txt is probably out of date
now.

Have fun :)
Jonathan

 vcs-svn/fast_export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 9c03f3e..f19db9a 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -83,7 +83,7 @@ void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
 		   log, gitsvnline);
 	if (!first_commit_done) {
 		if (revision > 1)
-			printf("from refs/heads/master^0\n");
+			printf("from :%"PRIu32"\n", revision - 1);
 		first_commit_done = 1;
 	}
 }
-- 
1.7.4.1
