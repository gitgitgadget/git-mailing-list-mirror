From: Martin Fick <mfick@codeaurora.org>
Subject: Re: 66 patches and counting
Date: Thu, 6 Oct 2011 16:16:39 -0600
Organization: CAF
Message-ID: <201110061616.39381.mfick@codeaurora.org>
References: <4E8CCC55.9070408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 07 00:16:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBwFD-0003pP-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 00:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277Ab1JFWQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 18:16:42 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:42894 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935887Ab1JFWQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 18:16:41 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6491"; a="125304834"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 06 Oct 2011 15:16:41 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 017F010004C2;
	Thu,  6 Oct 2011 15:16:41 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4E8CCC55.9070408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183045>

On Wednesday, October 05, 2011 03:29:57 pm Michael Haggerty 
wrote:
> My renovation of refs.c [1] is currently at 66 patches
> and counting. What can I say?: (1) I like to make
> changes in the smallest irreducible steps and (2) there
> is a lot that needed to be done in refs.c.
> 
> When I'm done, is it OK to dump a patch series like that
> on the git mailing list?  Is it pointless because nobody
> will review them anyway? Is a big pile of changes like
> this welcome in any form?  Would it be better to convey
> the changes via git itself (e.g., github) rather than
> via emails?
> 
> Michael
> 
> [1] hierarchical-refs at git://github.com/mhagger/git.git

Michael,

I downloaded your patch series and tested it on my repos.

Here are some of the timings I saw with your branch as is:

 * git clone                               2:50m  (same)
 * full fetch changes                  (> 1 hour) (bad!)
 * git branch (unpacked, ungced)            .7s   (good!)
 * git branch (packed, gced)                .18s  (~>same)
 * git checkout (unpacked, ungced)          10.5s (~>same)
 * git checkout (packed, gced)               9.5  (~>same)
 * noop fetch changes (unpacked, ungced)    14s   (~>same)
 * noop fetch changes (packed, gced)        12s   (same)

For the full fetch, I estimated, things were scrolling by 
slow enough that after about 15 min I interrupted it. I 
suspect it might be at least 6 times longer (if rate stayed 
the same).


Here are the best timings for all the good patches that 
others have submitted to fix many of the previous problems I 
brought up:

 * git clone                               2:50m
 * full fetch changes                      4:50m   
 * git branch (unpacked, ungced)              9s
 * git branch (packed, gced)                  .05s
 * git checkout (unpacked, ungced)            9s
 * git checkout (packed, gced)                8s
 * noop fetch changes (unpacked, ungced)     12s
 * noop fetch changes (packed, gced)         12s

(my internal patches bring full fetch down to 2:50m)

It would be nice if you could rebase your work on top of 
some of the other patches also so that I could see those 
results. I might give that a try if I have the time and it 
is easy (or I might rebase those patches on yours).

Thanks,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
