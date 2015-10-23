From: Francis Moreau <francis.moro@gmail.com>
Subject: Question about about a trivial merge conflict that git should resolve alone
Date: Fri, 23 Oct 2015 15:07:39 +0200
Message-ID: <CAC9WiBj7Vwfjzbik7+d9cxpS=m+_s-CViJ3b4fKAzYQ4ixXfiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 15:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpc4T-0005EY-BR
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 15:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbbJWNHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 09:07:40 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34778 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbJWNHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 09:07:39 -0400
Received: by iow1 with SMTP id 1so123239666iow.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=boyKmfj7Y5hC9D1iYCMmC4ktw1XJjzqqG1LCdG1axrE=;
        b=ZIqtD1jYJc4oY7wCDN342w0yBSZ1w8Y4t4jIsRuYmbnNWqG8ed1IjvRuC+4t3RPEli
         LztqSObOLsIB5lRS13t7FGZVIljt87iLRSeA5ITd3l2pmwWGKVf/XDV5j1iwx6sobRfB
         blYmysWJqX0crfQahUhsWAocEZOdzefwlCSpuMee3oW5Vjlm+MhdR7Cgyvw+QjupcG4Y
         eKhFM6Ajhe4XhOPthYETWv61+fw3fqHfSzxRwR0G+dDD1yP75sE+WxfqGEQoQQwgxsGs
         qW0GiSHHp5p+aBbF50vuelkli2AGZKPVWXwcIaKcaVq5buXOwgv80Z1uwtnWAbtbFESZ
         214g==
X-Received: by 10.107.136.140 with SMTP id s12mr21356040ioi.197.1445605659060;
 Fri, 23 Oct 2015 06:07:39 -0700 (PDT)
Received: by 10.79.77.1 with HTTP; Fri, 23 Oct 2015 06:07:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280094>

Hi,

I have a simple merge conflict use case:

$ mkdir foo
$ cd foo/
$ git init
$ echo line1 > a
$ git add .
$ git commit -q -m init
$ echo line2 >>a
$ git commit -a -q -m "add line2"
$ git checkout -b foo HEAD~1
$ git cherry-pick -x master
$ echo line3 >>a
$ git stage a
$ git commit -q -m "add line3"
$ git checkout master
$ git merge foo
$ git diff
diff --cc a
index c0d0fb4,83db48f..0000000
--- a/a
+++ b/a
@@@ -1,2 -1,3 +1,6 @@@
line1
line2
++<<<<<<< HEAD
++=======
+ line3
++>>>>>>> foo

Why does git think there's a conflict here since the "line2" string
was added in both branch by the same commit ?

Thanks.
-- 
Francis
