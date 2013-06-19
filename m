From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Wed, 19 Jun 2013 10:00:04 +0200
Message-ID: <CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr> <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
 <vpqppvjpjz3.fsf@anie.imag.fr> <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
 <CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
 <vpqy5a7mmsg.fsf@anie.imag.fr> <CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
 <vpqsj0emzdu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDJy-0003m2-3J
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100Ab3FSIAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:00:46 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:62838 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756657Ab3FSIAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:00:45 -0400
Received: by mail-qc0-f172.google.com with SMTP id j10so2896086qcx.31
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yR76/nXl6iwyoBY1/YgS/wm4LFSw/3zCrt3CxTPvSog=;
        b=f2kO8RF1LVJl6YykFVKIfLowC8Q73Aw6xOBnO5M7vbPmgHhtvCdIDoehFsAjx1a5EE
         xnweaPQ0tg8UDIIGJs0uUYA4Gv1qpC7lMmTKfzIRNsmcMzPLT9uDEgk0ju2kEIzx/4tb
         rwYg/Wow/GlG1syaPMGd262POuuf8rP9b2AR28IiJlQhgQQOo/+EtKFZCayfuznULx29
         QvdOqXlzy0xHBjR18F9SDv/LkRYHRlENQS+jE0KS+TXD72HITkJNlfZ6pq1RShJrh/hI
         XziQRb4V/yAhUV14zAfZKG0S2Wkl+MQd5f9f4j5z97RRsesjefNFfsWbg33nA1a2e+AV
         zlPw==
X-Received: by 10.49.116.176 with SMTP id jx16mr1880972qeb.52.1371628844296;
 Wed, 19 Jun 2013 01:00:44 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Wed, 19 Jun 2013 01:00:04 -0700 (PDT)
In-Reply-To: <vpqsj0emzdu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228370>

Ok, this is how it looks. If everything is ok, I'm sending it to the ML

>From 262bdfb5cc84fec7c9b74dc92bb604f9d168ef9a Mon Sep 17 00:00:00 2001
From: Alexander Nestorov <alexandernst@gmail.com>
Date: Wed, 19 Jun 2013 09:55:42 +0200
Subject: [PATCH] Add example for reseting based on content changes instead of
 stat changes

---
 Documentation/git-reset.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index a404b47..da639e9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -289,6 +289,18 @@ $ git reset --keep start                    <3>
 <3> But you can use "reset --keep" to remove the unwanted commit after
     you switched to "branch2".

+Reset only files who's content changed (instead of stat information)::
++
+------------
+$ git update-index --refresh               <1>
+$ git reset --hard                         <2>
+------------
++
+<1> Make Git realize which files actually changed instead of
+checking out all files whether their content changed or only
+their mtime changed.
+<2> Now git reset --hard will checkout only the files that
+actually changed.

 DISCUSSION
 ----------
--
1.8.1.msysgit.1
