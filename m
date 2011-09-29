From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 14:44:32 -0600
Organization: CAF
Message-ID: <201109291444.33076.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 22:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9NTH-0003hk-C0
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab1I2Uof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 16:44:35 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:4958 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab1I2Uoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:44:34 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6484"; a="123416987"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 29 Sep 2011 13:44:34 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2156B10004BE;
	Thu, 29 Sep 2011 13:44:34 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182433>

On Thursday, September 29, 2011 01:10:06 pm Junio C Hamano 
wrote:
> Also we would probably want to drop "next" field from
> "struct ref_list" (i.e. making it not a linear list),
> introduce a new "struct ref_array" that is a
> ALLOC_GROW() managed array of pointers to "struct
> ref_list", make get_packed_refs() and get_loose_refs()
> return a pointer to "struct ref_array" after sorting the
> array contents by "name". Then resolve_ref() can do a
> bisection search in the packed refs array when it does
> not find a loose ref.

That would be nice, and I suspect it would shave a bit more 
of the orphan check and possibly even a fetch.  If I 
understood all that, I might try.  But I might need some 
hand holding, my C is pretty rusty... Is there a bisection 
search library in git already to use?  Is there a git 
sorting library for the array also?

-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
