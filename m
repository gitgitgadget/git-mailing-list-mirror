From: Vishvajit Singh <vishvajitsingh@gmail.com>
Subject: git diff --numstat notices empty file creation, while --stat does not
Date: Fri, 23 Apr 2010 00:17:13 -0400
Message-ID: <k2r520868e81004222117nedbd7a3flb94bf7bef65d9c68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 23 06:17:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5AKO-0000kS-F7
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 06:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab0DWERP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 00:17:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41125 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab0DWERO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 00:17:14 -0400
Received: by gwj19 with SMTP id 19so2524609gwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 21:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=v5isr0iV9cnzzNZQukFzWQgKY/P9xJQWhBHI8HzLYN4=;
        b=nWTEqWFjbWBYofSskm5KNppiyDBldOUz6kM66yc5I0UTT3rg0yRLnqP4RhMy7S3frP
         8cc3BdUr+aflZ4WSPVA/FB0kIgoFzL8GkyK3mZfn19ydygHfkroMRHd0GS5QjJqTjXZA
         8OZ5hsMr9SQ2j0ZA3EG6Ijjcuww4T9AWEuVCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=YH7MVAGfxoUveXCUI2gmwcPkvGxqbbpxbSg0obUwYaK/16UuxTK+7KZRuBMAZp1+KX
         AtU/mo44+mas+bdT+F+iiJaVxpqbVI7pj7oBXjHn/TBdUMb/lUnK/ExvEr8eiTkJAU4Q
         f2m5hEhYJJq1mTWl7dZctMmMfKpkQlPiY7/Go=
Received: by 10.150.143.5 with HTTP; Thu, 22 Apr 2010 21:17:13 -0700 (PDT)
Received: by 10.150.180.16 with SMTP id c16mr10464815ybf.4.1271996233561; Thu, 
	22 Apr 2010 21:17:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145586>

I noticed that, in the case of two trees that differ in the creation
or deletion of an empty file, git diff --numstat provides information
about the empty file, whereas git diff --stat does not.

$ git --version
git version 1.6.1.2
$ git status
# On branch master
nothing to commit (working directory clean)
$ touch x.txt
$ git add x.txt
$ git commit -m 'add x.txt'
[master]: created 62f3c25: "add x.txt"
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 x.txt
$ git diff --stat HEAD^ HEAD
 0 files changed, 0 insertions(+), 0 deletions(-)
$ git diff --numstat HEAD^ HEAD
0       0       x.txt

This behaviour surprised me as I had been using diff --stat to get an
overview of the current differences between my working branch and the
master, and I had created a temporary to-do-list file in that branch
which I had subsequently emptied. In closing that branch, I might have
inadvertently merged the empty file into the master if I had not
remembered it was there. (I will use --numstat instead now.)

Is this small difference in behaviour between the two intentional?

Thanks,
Vishvajit Singh
