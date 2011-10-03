From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 3 Oct 2011 12:12:13 -0600
Organization: CAF
Message-ID: <201110031212.13900.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org>
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
X-From: git-owner@vger.kernel.org Mon Oct 03 20:12:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAn00-0005Gd-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319Ab1JCSMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 14:12:16 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:2893 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab1JCSMP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:12:15 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6488"; a="124245807"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 03 Oct 2011 11:12:14 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 75DBC10004C2;
	Mon,  3 Oct 2011 11:12:14 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109301606.31748.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182680>

On Friday, September 30, 2011 04:06:31 pm Martin Fick wrote:
> 
> OK, I narrowed it down I believe.  If I comment out the
> invalidate_cached_refs() line in write_ref_sha1(), it
> speeds through this section.
> 
> I guess this makes sense, we invalidate the cache and
> have to rebuild it after every new ref is added? 
> Perhaps a simple fix would be to move the invalidation
> right after all the refs are updated?  Maybe
> write_ref_sha1 could take in a flag to tell it to not
> invalidate the cache so that during iterative updates it
> could be disabled and then run manually after the
> update?

Would this solution be acceptable if I submitted a patch to 
do it?  My test shows that this will make a full fetch of 
~80K changes go from 4:50min to 1:50min,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
