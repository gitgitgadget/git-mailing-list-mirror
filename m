From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Sat, 27 Jun 2009 02:17:25 +0100
Message-ID: <3ace41890906261817y523c9321xd621fb3130941d91@mail.gmail.com>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
	 <4A445959.6090403@op5.se>
	 <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
	 <4A44A9A9.6030008@op5.se>
	 <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Jun 27 03:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKMXt-0004zZ-Q7
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 03:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZF0BRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 21:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZF0BRX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 21:17:23 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:39433 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbZF0BRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 21:17:23 -0400
Received: by ewy6 with SMTP id 6so3913899ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 18:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dutV7n6dpVhHiNx9vqavS/49NbZeXKrU5aMY2MFiO6Y=;
        b=T7mL/+7Wll3BGc6vg4/11LVBIqktjTKWbWOJiBzswzkXoLD+/SZzXDbKldyTLhnQ27
         +5ik3imJXN1miEqQ7M+8X2tyxpRCP2pXuJxEQMurC4PJf7PrV0FuIIbcO5UzRxMZz5Y8
         i6v43dY1vbPYDTa5qQCoscnwS52wh5cirt994=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DSDCncnqq4CYuQwhsYRjJJI9zrPngNpgozT3BB7vpT7HZOHzh41TGGkeVAFIKCa0KR
         Uc+2i87D8dgi1zrwBoskE+wuxWDVCw6ZGx7XHpFVyk0WB0XGOaO2R4YpQHbziA9hMWwv
         rxf+i0tePgc1OKfMHyf+B6IuQc/rjDB1n++aM=
Received: by 10.216.13.210 with SMTP id b60mr1367941web.97.1246065445062; Fri, 
	26 Jun 2009 18:17:25 -0700 (PDT)
In-Reply-To: <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122347>

Starting afresh with -T/-t/-b is transversing the branches and tags
once, rather that over and over starting from r1.

Here is the starting afresh config:

--------------------------
[svn-remote "svn"]
	url = svn://anonsvn.mono-project.com/source
	fetch = trunk/mono:refs/remotes/trunk
	branches = branches/*/mono/:refs/remotes/*
	tags = tags/*/mono/:refs/remotes/tags/*
--------------------------

Here is my attempt at contiuation/changing my mind after getting at trunk only:
--------------------------
[svn-remote "svn"]
#	url = svn://anonsvn.mono-project.com/source/trunk/mono
#	fetch = :refs/remotes/git-svn
  url = svn://anonsvn.mono-project.com/source
  tags = tags/*/mono:refs/remotes/mono/tags/*
  branches = branches/*/mono:refs/remotes/mono/branches/*
  trunk = trunk/mono:refs/remotes/git-svn
-------------------------
the tags, branches, url entries are effectively the same, I think - so
the main difference is using trunk instead of fetch.
Why does it make any difference? The example at the bottom of
git-svn's man page uses the trunk notation. Maybe it should be
changed?
