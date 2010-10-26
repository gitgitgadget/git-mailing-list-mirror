From: fREW Schmidt <frioux@gmail.com>
Subject: Fixing SVN import merges
Date: Tue, 26 Oct 2010 14:50:28 -0500
Message-ID: <AANLkTikO3fnBapx_=H3172bL+J9ux-LC3f5Bdi1R9-sq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 21:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PApXx-0000mY-K5
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 21:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab0JZTuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 15:50:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46419 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab0JZTux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 15:50:53 -0400
Received: by bwz11 with SMTP id 11so3709760bwz.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Be5emSH2TG3n9FEUsSEXqJQjAYg1D4KLaCksLxG2XiI=;
        b=qKBttfjMFjCX2n0IYGdEb2+Z7b8qm3W5FbCWNSF6gvrC52zruv9T8YgSisfVopEbms
         UC/8T2Ebi7afQvrhHBZuONRrfgf9R8/Zlg+pfa/IF/Osbl0aL5v2UYicoOLjJyuH78g0
         XzaJvSjHzVi5qgzEn0LGRD6NFySWDBt8CP7tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Pp9dF6x8ikCymWCDLAhU0p9N1wBh2eb/VoqIapTRcUDg+XBdR1H6k/ggVGm64q8oLO
         GtwBk+sezr/ZqdQq5kHVWwnkjPyVNTvINrwpqtQfi2X63vtYHYWzRmXGNxUJ4GBZQhYW
         NaDl/jIi07YX+ZyTwyR6cgvJ4bYg/+55Ph9h4=
Received: by 10.204.113.195 with SMTP id b3mr5697057bkq.210.1288122651609;
 Tue, 26 Oct 2010 12:50:51 -0700 (PDT)
Received: by 10.204.100.144 with HTTP; Tue, 26 Oct 2010 12:50:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160005>

Hey guys,

We are doing a fairly extensive import from an svn (with svk
sometimes) repo, and I wanted to fix the merge messages that svk
generates.

I thought I could use filter-branch with --msg-filter and do something
along the lines of:

 #!/usr/bin/perl
 my @parents = split / /, `git log -1 --pretty=%P HEAD`;
 print '', <> if @parents == 1;
 my @names = map `git name-rev --name-only $_`, @parents;
 print "Merged '$names[0]' into '$names[1]'";

But that doesn't seem to work.  I think I need to tell it to do a
no-op tree-filter for the above to work.

Also, it seems like git sometimes includes branches being merged into,
sometimes doesn't.  Sometimes quotes branch names, and sometimes
doesn't.  Anyone know what the rules are there?

Lastly, any other comments are very welcome.

--
fREW Schmidt
http://blog.afoolishmanifesto.com
