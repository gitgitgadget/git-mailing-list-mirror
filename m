From: =?UTF-8?B?TGF1cmVudCBDaGFycmnDqHJl?= <lcharriere@promptu.com>
Subject: git-p4 and initial import
Date: Thu, 10 Jul 2014 15:45:16 +0200
Message-ID: <53BE98EC.9000200@promptu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 08:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Ujf-0005f1-7D
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 08:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaGKGzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 02:55:04 -0400
Received: from moat.promptu.com ([209.234.175.58]:37211 "EHLO
	pacman.mp.promptu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbaGKGzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 02:55:03 -0400
X-Greylist: delayed 61784 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jul 2014 02:55:03 EDT
Received: from [0.0.0.0] (frogger.mp.promptu.com [192.168.0.101])
	by pacman.mp.promptu.com (Postfix) with ESMTP id 99B1C202DF
	for <git@vger.kernel.org>; Thu, 10 Jul 2014 06:45:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253252>

I've used git-p4 for several years now and it's generally working well 
for me.

The only thing that bugs me at this time is having to re-clone 
regularly. Here is how this happens:

* Say my p4 client maps //foo/bar/... to /home/jdoe/perforce/foo/bar/... 
(I don't want to clone the entire repo, because it's too big).
* I do git p4 clone --use-client-spec //foo /home/jdoe/git/foo, work 
with it, all goes well.
* Meanwhile, at some point somebody else adds //foo/baz.
* Eventually I need //foo/baz. I add it to my p4 client.
* Naturally, git-p4 won't pick up the changes, because they happened 
before I added //foo/baz to my client.
* So I git reset --hard to the first commit, delete even that using git 
update-ref -d HEAD, then again I do git p4 clone //foo 
/home/jdoe/git/foo. When the repo gets big, this takes a lot of time.

So, I have a few questions:
1. Am I doing this wrong? Is there another way I could proceed?
2. It occurred to me that when I re-clone a repository using 
--use-client-spec, I already have everything I need in my local copy of 
the p4 client. Why does git-p4 need to redownload everything from the 
repository? Could we find a way to tell it to p4 sync, then fetch the 
files from the local copy? Or is there a way I can copy everything over 
from my local client and pretend this is the initial import?
