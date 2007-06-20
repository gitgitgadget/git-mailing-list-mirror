From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-svn strangeness with tags and Squirrelmail repo
Date: Wed, 20 Jun 2007 17:05:29 +1200
Message-ID: <46a038f90706192205y71a77f5al5ca199b3ac382d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 07:05:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0sNo-0007Aj-9M
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 07:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbXFTFFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 01:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbXFTFFa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 01:05:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:45758 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbXFTFFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 01:05:30 -0400
Received: by wx-out-0506.google.com with SMTP id t15so68980wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 22:05:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jAk0Colpa530oolsZrXPd59kbIMK7fjDozAH+XXvBUViPD4v7V8RugAILRZstkcFHXv3XgoV2XJ9amwrFxFAkqpeVs8vk3NlZNgLo+UMXkPXozoJWlR/VBpO3ueUllupLww6WVqyMkBF8kihQ19pqEkgTaIM/pDCIEgh5SQHHwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tQm4hFmc+S1Kxrb+34E9ZQidpFSCO72perz8T2ARRdggs0si8sD0uAWIDVmj3aF6GNOPDB5dUnVBBvgnqJNO28yk1RAIG2axMUxD/Oa1V7SYj5yjc2bxKh1W70Qw3UBxLzO7xOSaMvoEVcWpCX0bcy/xdcWuDNO4d3HOGbqIgAI=
Received: by 10.90.105.19 with SMTP id d19mr38364agc.1182315929235;
        Tue, 19 Jun 2007 22:05:29 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 22:05:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50531>

First -- kudos to Eric Wong and company: git-svn can deal with the odd
errors and invalid chunks of XML or UTF-8 that SVN spits at me every
once in a while. And it "just works" in 99% of the situation. Great
stuff.

Now... on to my 1% where it doesn't "just work"... I am trying to get
a working svn to git gateway for Squirrelmail, and getting in trouble
with the tags setting...

  git --version
  git version 1.5.2.2.238.g7cbf2f2

For starters - it "just works" if I run
  git svn init  -T trunk -t tags -b branches \
   http://squirrelmail.svn.sourceforge.net/svnroot/squirrelmail
 git svn fetch

However, every tree (for tags, branches and trunk) is prefixed with
"squirrelmail" and commits to the toplevel "plugins" directory get in
the way. Also, I want the branches and tags to appear in more natural
places, so after init, and before fetch, I change .git/config to say:

   [svn-remote "svn"]
        url = http://squirrelmail.svn.sourceforge.net/svnroot/squirrelmail
        fetch = trunk/squirrelmail:refs/heads/svn/trunk
        branches = branches/*/squirrelmail:refs/heads/svn/*
        tags = tags/*/squirrelmail:refs/tags/svn/*

and when I do that -- trunk and branches do what I want, but tags
aren't imported anymore. :-/

cheers,


martin
