From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: How to merge branches except for one commit
Date: Wed, 28 May 2008 19:32:36 -0700
Message-ID: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 04:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1XxR-0001SJ-38
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 04:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbYE2Cci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 22:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYE2Cci
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 22:32:38 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:39283 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYE2Cch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 22:32:37 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2139583ywe.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=VRWumZupxzsirQVqYoR2OIjMmjFgX2lTMto65aoIKb8=;
        b=i/L7HOSdbm/xVwW5riDC0kWwhvu1RhmdOmXj8XnwjXEj+g8G8ea2WYgZ+UMYO85jOspaG4R0b48yJ7l5NtBm9GnIoWo4NI3FmRF3tEJjXa3t9e+NMr8X9X7EiDmXnavwLZCjD4F7m4ycr4YQaa+1O7QBTUY6BCz1ydXK7NjxDMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oDItEelVLZKVta/te3lZrY6Nr+v1pJZ9Ea4FZfP7pZj7EVKcOr3GQzDXcVq8CojgRigIM9wujBQT+6aoLyG8sfnZyJ1qdSiPACVzP99ZrHfEBaIUQXcqRM88ZgR4wjva3BoteNhV4t63AuiQP3Sk444j9XDLzIXOTSuGS9vW6pE=
Received: by 10.150.68.2 with SMTP id q2mr5172546yba.89.1212028356335;
        Wed, 28 May 2008 19:32:36 -0700 (PDT)
Received: by 10.151.154.16 with HTTP; Wed, 28 May 2008 19:32:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83165>

Hi helpful git users!

I have a pattern for work (which may be flawed--feel free to jab it)
that leads me to a difficult maintenance story:

Work on master..., tracked source code set to v1.0
Create branch v1.0.... tag v1.0.0
On master, increment version of library in source code to v2.0
More work on master...
Cherry-pick most of the commits on master to the v1.0 branch, leaving
off the commit that changed master's version number to v2.0
Tag v1.1.
Work on master continues toward v2.0...
Branch off v2.0...
(and the pattern continues, with some commits in master getting
back-ported to maintenance branches.

At some point, most or all the commits on master since branching off
v1.0 I want to include in the v1.1 release.  When I want to include
all the commits from master in the v1.0 branch I just do:
git checkout v1.0
git merge master
...and life is good because gitk history makes the merge easy to see
and individual commits can be easily identified as belonging to both
master and v1.0.
But as soon as I branch off v1.0 I want my master branch to start
building as v2.0, which means the first commit after branching should
never be included in the v1.0 branch.  As I understand it, that rules
out ever using "git merge".  I believe the only option that leaves me
is cherry picking individual commits, which is a maintenance pain
because each commit then appears as many times as branches it belongs
to, and it's difficult given just one commit to tell which branches it
has been ported to.

Am I doing something wrong, un-knowledgeable of how to properly do
merges/cherry-picks, or is this just life as we know it?

Thanks.
--
Andrew Arnott
