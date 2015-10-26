From: Sivakumar Selvam <gerritcode@gmail.com>
Subject: git repack command on larger pack file
Date: Mon, 26 Oct 2015 05:57:36 +0000 (UTC)
Message-ID: <loom.20151026T065553-934@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 07:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqapS-0000SF-6f
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 07:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbJZGAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 02:00:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:58963 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbJZGAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 02:00:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Zqap9-0000FS-RW
	for git@vger.kernel.org; Mon, 26 Oct 2015 07:00:07 +0100
Received: from 124.215.201.5 ([124.215.201.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 07:00:03 +0100
Received: from gerritcode by 124.215.201.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 07:00:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.215.201.5 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280180>

Hi,
   I ran git repack on a single larger repository abc.git where the pack
file size 34 GB. Generally it used to take 20-25 minutes in my server to
complete the repacking. During repacking I noticed, disk usage was more, So
I thought of splitting the pack file into 4 GB chunks. I used the following
command to do repacking.
   git repack -A -b -d -q --depth=50 --window=10 abc.git

   After adding --max-pack-size=4g to the above command again I ran to split
pack files..
   git repack -A -b -d -q --depth=50 --window=10 --max-pack-size=4g abc.git
 
   When I finished running, I found 12 pack files with each 4 GB and the
size is 48 GB. Now my disk usage has increased by 14 GB. Again, I ran to
check the performance, but the size (48 GB) and time to repacking takes
another 35 minutes more. Why this issue? If we split a larger pack file,
repacking takes more time with more disk usage for storing pack files. Any
thoughts on this why this happens?

Thanks,
Sivakumar Selvam.
