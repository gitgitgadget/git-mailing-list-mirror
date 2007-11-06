From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Tue, 06 Nov 2007 22:44:54 +0100
Message-ID: <4730E056.7080809@gmail.com>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWEZ-0007PO-W2
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbXKFVpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbXKFVpF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:45:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:57825 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXKFVpB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:45:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so24742ugc
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=m5WX7/PLyal/BQVBhCDQ+n2oPc4fTomw/l5Mq5qn500=;
        b=nKdoMZtFoGEXGCaDmJ+8fYLF5KIB1zK6/7Dsc7GHb94KE6Bg0DWI76dhi4zI2iasFNzYpfEEz/sjrQloSQIjSspwBWLHOKYmZrBVU19nSjrQr/By0MCF6+Utr/OHiCRGwOpHuJ9jDax4XR1R9SYPJW+YzUfZ69m51eIcxOxqvlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bVQYWP9GRpF4ovJVwu5rm3FrlRahHwlEF25oA7F12AVJHO9fK7hVJ0oA7/XMSJgEQPFBIPk8uIt8CmD2SeiCCjuA2xJolXZptDMHvQ4m+KZSVBq1KDuOE07jB/d+04UgDLkohtZ3NZsvv5QwL8AfTq+VRX4RKw/K8j2vuHlSecw=
Received: by 10.67.20.3 with SMTP id x3mr129149ugi.1194385499579;
        Tue, 06 Nov 2007 13:44:59 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id i39sm229436ugd.2007.11.06.13.44.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Nov 2007 13:44:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63733>

Signed-off-by: Francesco Pretto <ceztkoml@gmail.com>
---
 More detailed instructions on how to set up shared repositories.
 Removed an old reference to the need of setting umask of ssh
 users of shared repositories.
 Added a reference to "git for CVS users" doc in git-init manual.

 Documentation/cvs-migration.txt |   61 +++++++++++++++++++++++++++++++++++----
 Documentation/git-init.txt      |    7 ++++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 3b6b494..849b403 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -71,7 +71,40 @@ Setting Up a Shared Repository
 We assume you have already created a git repository for your project,
 possibly created from scratch or from a tarball (see the
 link:tutorial.html[tutorial]), or imported from an already existing CVS
-repository (see the next section).
+repository (see the next section). Moreover, we assume you can write in a
+public accessible directory and give other users the permission to do so.
+You could need or not admin privileges to do so, depending on your
+system configuration and how you decide to export the repository.
+
+It's recommended, but not strictly necessary, to create a specific group for
+every project/repository you'll want to create, so it will be easier to give
+or prevent access of users to specific repositories. With admin privilege launch:
+
+------------------------------------------------
+$ groupadd $group
+------------------------------------------------
+
+If you want to add an user to this group, launch:
+
+------------------------------------------------
+$ usermod -a -G $group $username
+------------------------------------------------
+
+In our example, we will store the shared repository in the /pub dir, so the
+user creating it will need write permission there. There's no problems if you
+choose another directory, but you'll have to ensure it will be accessible by
+other users, on local or by remote (this could be not the case of home
+directories).
+
+If you just want to create a directory that is writable by every users that have
+a local account, launch with privileged credentials:
+
+------------------------------------------------
+$ mkdir /pub
+$ chmod a+w,+t /pub
+------------------------------------------------
+
+Now you can proceed with an unprivileged user.
 
 Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
 repository (a repository without a working tree) and fetch your project into
@@ -84,21 +117,37 @@ $ git --bare init --shared
 $ git --bare fetch /home/alice/myproject master:master
 ------------------------------------------------
 
+If you previously decided to create a specific group for the committers of the
+repository, assign its ownership to that group (you'll have to be a member of it
+or switch to privileged credentials):
+
+------------------------------------------------
+$ chgrp -R $group /pub/my-repo.git
+------------------------------------------------
+
 Next, give every team member read/write access to this repository.  One
 easy way to do this is to give all the team members ssh access to the
 machine where the repository is hosted.  If you don't want to give them a
 full shell on the machine, there is a restricted shell which only allows
 users to do git pushes and pulls; see gitlink:git-shell[1].
 
-Put all the committers in the same group, and make the repository
-writable by that group:
+The following two commands will require admin privileges; first, enable
+git-shell putting it on the trusted shells list of the system:
 
 ------------------------------------------------
-$ chgrp -R $group /pub/my-repo.git
+$ echo `which git-shell` >> /etc/shells
+------------------------------------------------
+
+Now, let's create the commit users:
+
+------------------------------------------------
+$ useradd -g $group -s `which git-shell` $username
 ------------------------------------------------
 
-Make sure committers have a umask of at most 027, so that the directories
-they create are writable and searchable by other group members.
+These users will be enabled to push on repositories owned by the group $group.
+Later, you can give access to other projects simply by adding them to
+other groups. Similarly, you can prevent access to repositories simply
+removing those users from related groups.
 
 Importing a CVS archive
 -----------------------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 07484a4..f5f363d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -101,6 +101,13 @@ $ git-add .     <2>
 <2> add all existing file to the index
 
 
+SHARED REPOSITORIES
+-------------------
+
+Please refer to link:cvs-migration.html[git for CVS users], section "Setting Up
+a Shared Repository", for details on how to set up shared repositories.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
