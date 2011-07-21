From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Thu, 21 Jul 2011 11:35:44 -0400
Message-ID: <4E284750.4040104@cisco.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com> <1311095876-3098-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 17:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjvI0-00049w-Dp
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 17:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1GUPfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 11:35:47 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:64418 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab1GUPfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 11:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1286; q=dns/txt;
  s=iport; t=1311262546; x=1312472146;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=i/rs7bcb2clnp+LryEBsdpsqhQlJ2/sSyX2PjfdKYX0=;
  b=ITbMK3d6IFuukzc3cZQI9mEqZMruJBkKmJWTQ+2BrMfFSDHIpuLmizn6
   YMPni6Jyd+t3DoG3NmZkiarzq1xs/ntj3dYBjcvem3q+FTODKsfnVNIWp
   n/H70Ses7EVUTwfjZpQYw1AfY1xtTV5PnbMII/ZfaYib070wkY9sNeK21
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAB1GKE6tJV2a/2dsb2JhbABUp0B3plueKYY+BJJuhQeDKYhJ
X-IronPort-AV: E=Sophos;i="4.67,240,1309737600"; 
   d="scan'208";a="5144689"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-6.cisco.com with ESMTP; 21 Jul 2011 15:35:45 +0000
Received: from [64.100.104.94] (dhcp-64-100-104-94.cisco.com [64.100.104.94])
	by rcdn-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p6LFZimn009712;
	Thu, 21 Jul 2011 15:35:45 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <1311095876-3098-2-git-send-email-artagnon@gmail.com>
X-TagToolbar-Keys: D20110721113544821
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/19/2011 01:17 PM, Ramkumar Ramachandra wrote:
> Enable future callers to report a conflict and not die immediately by
> introducing a new function called error_resolve_conflict.
> Re-implement die_resolve_conflict as a call to error_resolve_conflict
> followed by a call to die.  Consequently, the message printed by
> die_resolve_conflict changes from
>
> fatal: 'commit' is not possible because you have unmerged files.
>         Please, fix them up in the work tree ...
>         ...
>
> to
>
> error: 'commit' is not possible because you have unmerged files.
> hint: Please, fix them up in the work tree ...
> hint: ...
> fatal: Exiting because of an unresolved conflict.

This is a tiny grammar nit, but "Please," sounds superfluous now that 
it's preceded by "hint:".  "Hint" sounds like I'm doing you a favor by 
telling you something to do.  "Please" sounds like you're doing me a 
favor by doing something.  Together they just sound like a typo.

In either case, the comma after "Please" is wrong.  (There are other 
messages in the git code which make this same mistake, but there are 
more which use "Please <imperative-verb>..." correctly.)

Note: I see this repeated in patch 06/18 in this series, and there are 
probably others.

Phil
