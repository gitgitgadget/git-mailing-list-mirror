From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 13:26:03 -0600
Organization: CAF
Message-ID: <201109301326.03711.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109262056.04279.chriscool@tuxfamily.org> <201109301041.13848.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 21:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9iip-0002xW-W9
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 21:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702Ab1I3T0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 15:26:07 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:8867 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab1I3T0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 15:26:06 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6485"; a="123732823"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 30 Sep 2011 12:26:05 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 4868810004BE;
	Fri, 30 Sep 2011 12:26:05 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109301041.13848.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182505>

On Friday, September 30, 2011 10:41:13 am Martin Fick wrote:
> I dug into this a bit further.  I took a non gced and non
> packed refs repo and this time instead of gcing it to get
> packedrefs, I only ran the above git pack-refs --all so
> that objects did not get gced.  With this, the noop
> fetch was also only around 12s.  This confirmed that the
> non gced objects are not interfering with the noop
> fetch, the problem really is just the unpacked refs. 
> Just to confirm that the FS is not horribly slow, I did
> a "find .git/refs" and it only takes about .4s for about
> 80Kresults!

Is there a way I can for refs to always be packed?  I didn't 
see a config option for this.  I would like to try a fetch 
this way even if I have to make a small code tweak.  

I tried simulating on the fly ref packing every now and then 
by running the pack from another repo during the fetch, it 
actually slowed things down (by more than the time it took 
to do the packs).


-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
