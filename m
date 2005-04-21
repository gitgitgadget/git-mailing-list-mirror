From: Mike Taht <mike.taht@timesys.com>
Subject: Re: Performance of various compressors
Date: Wed, 20 Apr 2005 22:14:23 -0700
Message-ID: <426736AF.7000900@timesys.com>
References: <426734DE.3040606@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 07:12:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOTyy-0002Ys-92
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 07:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDUFQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 01:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVDUFQ0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 01:16:26 -0400
Received: from mail.timesys.com ([65.117.135.102]:46218 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261221AbVDUFQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 01:16:09 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Apr 2005 01:09:54 -0400
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <426734DE.3040606@timesys.com>
X-OriginalArrivalTime: 21 Apr 2005 05:09:54.0687 (UTC) FILETIME=[5ADF10F0:01C54630]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just to clarify this was a git add of the linux-2.6.11.7 sources (sorry, 
untimed) , and timing the git commit.

Mo betta data latah.

Mike Taht wrote:
> I started rolling a tool to measure various aspects of git performance. 
> I will start looking at merge next, and at workloads different from the 
> kernel (gcc4 anyone?) ...
> 
> The only data points worth sharing a this point are:
> 
> That doing the compression at a level of 3, rather than the max of 9, 
> cuts the cpu time required for a big git commit by over half, and that 
> that actually translates into a win on the I/O to disk. (these tests 
> were performed on a dual opteron 842)
> 
> The benefits of compression aren't very much for git right now.
> 
> And: A big git commit is I/O bound. But we knew that. Maybe it's 
> possible to make it less I/O bound.
> 
> Git branch: 7a4c67965de68ae7bc7aa1fde33f8eb9d8114697
> Tree: 2.6.11.7 source tree
> Branch: N/a
> Merge File: N/a
> HW: dual opteron 242
> Mem: 1GB
> Disk: seagate barracuda
> Filesystem: Reiser3
> Git add: N/a
> Cache: Hot
> Git Commit: 44.97user 5.94system 1:45.24elapsed 48%CPU
> Git Merge:
> Options:
> Feature: Test of compression=9 (std git)
> 
> du -s .git/objects  110106  # du is probably not the right thing
> du -s --apparent-size .git/objects 58979
> 
> Git branch: 9e272677621c91784cf2533123a41745178f0701
> Tree: 2.6.11.7 source tree
> Branch: N/a
> Merge File: N/a
> HW: dual opteron 242
> Mem: 1GB
> Disk: seagate barracuda
> Disk mode: udma5
> Filesystem: Reiser3
> Git add: N/a
> Cache: Hot
> Git Commit: 16.79user 6.15system 1:21.92elapsed 28%CPU
> Git Merge:
> Options:
> Feature: Test of compression=3 (std git)
> 
> du -s .git/objects  115218
> du -s --apparent-size .git/objects 64274
> 
> There's some variety in the best/worst case timings for I/O for the 
> compressor=3 case...
> 
> 16.79user 6.15system 1:21.92elapsed 28%CPU
> 16.68user 5.71system 1:13.19elapsed 30%CPU


-- 

Mike Taht


   "The chief contribution of Protestantism to human thought is its 
massive proof
that God is a bore.
	-- H.L. Mencken, "The Aesthetic Recoil," American Mercury, July, 1931."
