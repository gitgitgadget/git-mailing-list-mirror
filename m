From: Henning Moll <newsScott@gmx.de>
Subject: Re: flatten-merge history
Date: Sun, 26 Oct 2014 15:36:50 +0100
Message-ID: <544D0702.1050907@gmx.de>
References: <544B9839.7000302@gmx.de> <CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 26 15:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiOwm-0006cK-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 15:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaJZOgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 10:36:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:64205 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbaJZOgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 10:36:53 -0400
Received: from [192.168.178.33] ([88.217.115.1]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MhiTL-1XVYmm11t5-00Mw4k; Sun, 26 Oct 2014 15:36:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>
X-Provags-ID: V03:K0:gqHQKweXWPZwaCIYc2w8o9dbnFWid40BlGBGC9yQh0HfTzYuqOI
 0qOWuGfyZfTwpD49ewOKgFDCdojXxInq/PJfuXk2Oaesk2S6rFTiexBxLlGaI3dZI2+8gkO
 J6C8Uydf9G06clE2I8JGCj7xezwjSqEnOAT43/INTX1+bN0G3Ob2RnzLSvomEsnlZeI52qm
 h8iHKKXvlChNkh+R1yavw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2014 um 06:46 schrieb Christian Couder:
> Hi,Could you tell us why interactive rebase did not work?

First of all i have to admit that i did not i-rebase-merge, but 
i-rebase-cherrypick. Now i tried it with i-rebase-merge and it didn't 
work either.
Here's my workflow, which i repeated for all commits of 'extern' (in 
chronological order'). For simplicity let's assume that there is a 
parent commit for 'A'

1. For P, A is the nearest prior commit on 'master'
2. on master: git rebase -i A^
3. change A from pick to edit. save. quit
4. git merge P
5. git rebase --continue

 From the perspective of 'master' this worked. But as all of the commits 
have been rewritten, the branches b1 and b2 no longer refer to 'master'. 
Branch b2, for example, still branches off at B and not B'. So after 
this action, my history looks like this:


     P - - - Q - - - - - R       <-extern
       \
A'- m - B'- - - C'- D'- - - E'  <-master

A - - - B - - - C - D
          \           \
           M ...       \         <-b1
                        \
                         W ...   <-b2

A and A' are nearly the same: they only differ in the new 
GIT_COMITTER_DATE.
Now this is what i try to get (after only applying P):



     P - - - Q - - - - - R       <-extern
     \
A'- m - B'- - - C'- D'- - - E'  <-master
          \           \
           M'...       \         <-b1
                        \
                         W'...   <-b2

Regards
Henning
