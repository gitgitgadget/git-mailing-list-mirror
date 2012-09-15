From: David Chanters <david.chanters@googlemail.com>
Subject: Using git-replace in place of grafts -- and publishing
 .git/refs/replace between repos?
Date: Sat, 15 Sep 2012 13:02:44 +0100
Message-ID: <CACffvTp4qnHc3RHKDotEfvshVDqGtTX6eh6Fr-bmJSMUvTFN6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 14:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCr5d-0003IB-F3
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 14:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab2IOMDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 08:03:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45554 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2IOMCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 08:02:47 -0400
Received: by obbuo13 with SMTP id uo13so7404339obb.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6G7Ay4C6OZOn5DW3RaYri/gpgmwRaTeAYFucHmZfM/0=;
        b=CyYy9b/9c96kERPMEmYCSMR5FvliFVcwyhPBIa14CxI/byyU9JvOl6jr+IFAxTXyaG
         ukwTBCfe9j8UBnWnf0PjRHTS+rCjrsD+pOiXS5l7a+PPEiPUKW/VYoknmbFxTluEB/gC
         Ipg5OsjVpNg3UqsISlNpsBFGLIIXz7USYmHOuPCJ58G8b9n7SADPpzjXYLpV6sYfe5EC
         I6CFuwFkyUD0wIvFhkdXeub7SsViWkALVNTlBVUsot+50EKmYM24hq58QxC99eCtrQPd
         JfkPoR3wdJLsey6znxxSyF54uBlqR570PsBjl9e6G5jamuoDsjz5feo9amSjLfkQLF2d
         1byQ==
Received: by 10.182.193.7 with SMTP id hk7mr7148201obc.30.1347710564832; Sat,
 15 Sep 2012 05:02:44 -0700 (PDT)
Received: by 10.76.85.170 with HTTP; Sat, 15 Sep 2012 05:02:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205555>

Hi,

Earlier this month I asked how best to handle two branches without a
common ancestor to sync changes from one branch to another.  Initially
I did this via the grafts mechanism, but this wasn't a "shared"
solution, in that the graft was local to my checkout of the repository
and no one else's.

I read on StackOverflow that git-replace can be used instead.  Having read this:

http://stackoverflow.com/questions/3810348/setting-git-parent-pointer-to-a-different-parent

I followed the instructions to use git-replace.  Have successfully
done that, I was then able to merge the two branches which didn't have
a common ancestor and have the correct commits on the branch I was
hoping for.  AFAIAC, this worked fine.

But now I have some questions:

1.  I thought the replace data in .git/refs/replace was published when
I did "git push" so that others could use this information as a
base-point, yet it seems not to be the case.  How do I publish this?
2.  If I do publish it, are there any caveats with that?  i.e.,
because the replace data will likely point to a repo which in my
working checkout I added with "git-remote", is that going to be a
problem?  I assume I can instruct people who care, to "git remote add
foo ...." and then treat master and foo/master as intended?  i.e.,
foo/master will see commits on it over time which "master" won't have,
so "git checkout master && git merge foo/master" can always happen?
3.  If it is possible to publish this replace data, is there anything
which needs to happen in .git/config either on the bare repo or local
checkouts?

What I'm aiming for now, in publishing this merge, is that if I can
publish the replace data, that people besides me, can clone the repo,
and the remote repo in place, and merge the branches as outlined in
question 2.   What I also am unsure of is whether or not I have to
keep updating the replace refs each time I merge the branch?

TIA!

David
