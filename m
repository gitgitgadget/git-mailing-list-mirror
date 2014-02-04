From: chris <jugg@hotmail.com>
Subject: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 02:20:30 +0000 (UTC)
Message-ID: <loom.20140204T030158-758@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 03:21:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAVdE-00025d-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 03:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbaBDCU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 21:20:57 -0500
Received: from plane.gmane.org ([80.91.229.3]:44117 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600AbaBDCU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 21:20:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAVd8-00022k-JU
	for git@vger.kernel.org; Tue, 04 Feb 2014 03:20:55 +0100
Received: from 1-165-180-147.dynamic.hinet.net ([1.165.180.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 03:20:54 +0100
Received: from jugg by 1-165-180-147.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 03:20:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 1.165.180.147 (Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241508>

Hi,

I have garbage collection disabled globally with gc.auto = 0.  Today while
pushing a branch remotely, I saw a message "Auto packing the repository for
optimum performance." which I've never noticed before.  Searching for that
phrase shows me that common knowledge is that 'gc.auto = 0' should disable
such from occurring.  Looking at .git/objects/pack/ in the repository show a
new pack file created at the time.  However, all loose objects still exist
in the repository, which is what I want, so it is good that no apparent data
loss occurred.

Here is the relevant command and its output:

$ git push origin next 
Counting objects: 56, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (9/9), done.
Writing objects: 100% (9/9), 895 bytes | 0 bytes/s, done.
Total 9 (delta 8), reused 0 (delta 0)
Auto packing the repository for optimum performance.
To ssh://git@my.server.com/my_project
   3560275..f508080  next -> next
$ git config gc.auto
0
$ git config gc.autopacklimit
0
$ git --version
git version 1.8.5.3

So my question is, should gc.auto = 0 disable auto-packing from occurring on
git push and other non-gc commands?

Thanks,

Chris
