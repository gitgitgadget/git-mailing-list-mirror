From: Tony Luck <tony.luck@gmail.com>
Subject: git fetch --tags doesn't quite do what I expect
Date: Fri, 18 Nov 2005 11:14:16 -0800
Message-ID: <12c511ca0511181114jf4ca3c0p195a128fa541b8f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Nov 18 20:14:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBgl-0007gW-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVKRTOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKRTOU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:14:20 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:4214 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750766AbVKRTOT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:14:19 -0500
Received: by wproxy.gmail.com with SMTP id i23so22603wra
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:14:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iHgAWmCNaJMRiijAHLahIUoTM6O4h2xeH5/4clYB8YF0A+VEpDzQN1UfQTUgkKOG/mK0KJLjpT7lli7Haol5Xs/ju4pWt5zZhqiZH39FL0bPYpSVeolY83OeuUOedzPW+zuQ+8UYd4MJ99dbeA6pjaDy/5JBF0woO0WZ8Kbmxbo=
Received: by 10.65.240.5 with SMTP id s5mr122910qbr;
        Fri, 18 Nov 2005 11:14:17 -0800 (PST)
Received: by 10.65.194.8 with HTTP; Fri, 18 Nov 2005 11:14:16 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12249>

I've been doing some updating on my git scripts to make use of the features
that you have been working hard to put in (thank you).  My script to update
my local "linus" branch from Linus' master branch at kernel.org had a simple
"git fetch linus" (with the appropriate[1] URL and Pull lines in
.git/refs/remotes/linus)
followed by an unholy piece of script that parsed the output from
"git-ls-remote --tags linus" to see if I had all the latest tags, and
get them if
I didn't.

Looking at the manual, I thought that I could just change the "git
fetch linus" to
be "git fetch --tags linus" and drop the script.  But it appears that
with the "--tags"
argument the "fetch" will not fetch anything beyond the tagged commits (i.e.
at the moment v2.6.15-rc1) ... so I need both:
      git fetch --tags linus
and
      git fetch linus

one to get any new tags, and the other to fetch all the way up to "master".

Is this intended behaivour?  If so, the "--tags" entry on the git-fetch(1) man
page needs a little extra text to say that --tags limits the fetch to only
commits reachable from the tags.


-Tony

[1] Contents:
URL: master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Pull: master:linus
